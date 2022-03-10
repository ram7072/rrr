import functools
import itertools
import shutil
import time
from mongo_grouping import l2_buckt_path,l2_buckt_path1,l2_buckt_path2,file_ext,src_file_name, l2_file_prefix, l2_file_prefix1,\
                    l2_file_prefix2,l1_file_prefix, l2_u_prefix,l2_u_prefix1,l2_u_prefix2,root_path, g2_upper_limit, \
                    g2_lower_limit, g1_upper_limit,g1_lower_limit,l2_grouping,l2_grouping1, l1_grouping,bucket_grp
import os
from time import perf_counter
from datetime import datetime
import pyspark
from pyspark.sql import Window
#from pyspark.sql.functions import lit
from pyspark.sql.functions import *
from pyspark.sql import functions as Func, Window
from pyspark import SparkContext, SparkConf, SQLContext
from pyspark.sql.session import SparkSession
from pyspark.sql.types import StructType, StructField, StringType
from multiprocessing import Pool
from multiprocessing.pool import ThreadPool
from itertools import chain

conf = (
    SparkConf()
        .setAppName("S3 with Redshift")
        .setMaster("local[10]")

)
sc = SparkContext(conf=conf).getOrCreate()
sqlContext = SQLContext(sc)

# spark = SparkSession.builder.getOrCreate()

bucket_grp = 'l'
l1_grouping = l1_grouping
l2_grouping = eval(l2_grouping)
l2_grouping1 = eval(l2_grouping1)
# l2_grouping1 = eval(l2_grouping1)
g1_lower_limit = g1_lower_limit
g1_upper_limit = g1_upper_limit
g2_lower_limit = g2_lower_limit
g2_upper_limit = g2_upper_limit
root_path = root_path
l2_buckt_path = l2_buckt_path
l2_buckt_path1 = l2_buckt_path1
l2_buckt_path2 = l2_buckt_path2
l1_file_prefix = l1_file_prefix
l2_file_prefix = l2_file_prefix
l2_file_prefix1 = l2_file_prefix1
l2_file_prefix2 = l2_file_prefix2
l2_u_prefix = l2_u_prefix
l2_u_prefix1 = l2_u_prefix1
l2_u_prefix2 = l2_u_prefix2
src_file_name = 'source/l/*.csv'
file_ext = '.csv'
# final_columns = 'bucket_id', 'group_number_new', 'last_nm_cnt', 'source', 'record_id', 'first_name', 'Middle_Name','last_name',\
#                'Date_of_Birth', 'Email', 'Phone_Number', 'Personal_Address', 'Professional_Address' \
#                , 'org_name', 'Field_of_Interest'

# print(l2_grouping1)

def l2_file_read(path, file_prefix):
    df = sqlContext.read.csv(root_path + bucket_grp + '/' + path + '*' + file_ext, header=True,
                                      inferSchema=True)
    sum = df.count()
    print('L2 total buck cnt', sum)
    csvName = file_prefix + bucket_grp + "_" + str(sum) + '_' + datetime.now().strftime("%d%m%Y-%H%M%S")
    file_write(df, csvName)

    # os.remove('D:/grouping/' + bucket_grp + '/temp/G2_2_999/')
    # os.rmdir('D:/grouping/' + bucket_grp + '/temp/G2_2_999')

def file_write(df, csvName):

    # df_states.withColumn('states_Name_new', lpad(df_states.state_name, 14, '#'))
    # df_fnl = df.withColumnRenamed('group_number', 'bucket_id'). \
    df_fnl = df.withColumnRenamed('group_number_new', 'bucket_id'). \
        select('bucket_id','source', 'record_id', 'first_name', 'Middle_Name',
               'last_name','Date_of_Birth', 'Email', 'Phone_Number', 'Personal_Address', 'Professional_Address'
               , 'org_name', 'Field_of_Interest','last_nm_cnt')
    df_fnl.toPandas().to_csv(root_path + bucket_grp + '/' + csvName + file_ext , header=True, index=False)

def main():
    global newdf,csvName

    t_start = time.time()
    #################################### Reading the source file ########################################
    # source_df = sqlContext.read.csv('D:/grouping/last_name_' + bucket_grp + '.csv', header=True, inferSchema=True)
    source_df = sqlContext.read.csv(root_path + src_file_name, header=True, inferSchema=False)

    mod_source_df1 = source_df.withColumnRenamed('con_id', 'record_id')\
        .withColumn('last_name', trim(source_df.Last_Name)) \
        .withColumn('first_name', trim(source_df.First_Name))

    mod_source_df = mod_source_df1.withColumn("record_id",col("record_id").cast(StringType()))

    print('count of data before L1 grouping', mod_source_df.count())

    # First Level of Grouping
    ordered_df = Window.orderBy(l1_grouping)
    partioned_df = Window.partitionBy(l1_grouping)
    level1_group_df = mod_source_df.withColumn("group_number", dense_rank().over(ordered_df)) \
        .withColumn("group_count", count('*').over(partioned_df))


    t_end1 = time.time()
    # print('count of data after L1 grouping', level1_group_df.count())

    # To Fetch Groups For Each Bucket after First Level of Grouping
    # List of Groups between Lower_Limit and Upper_Limit
    group_list = level1_group_df \
                    .filter((Func.col("group_count") >= g1_lower_limit) & (Func.col("group_count") < g1_upper_limit)) \
                    .select(['*'])
    # print('count of data in L1 bucket', group_list.count())

    # List of Groups Greater than or Equal to Upper Limit
    l1_upper_lmt_group_df = level1_group_df.filter(Func.col("group_count") >= g1_upper_limit).select(['*'])
    l1_upper_lmt_group_list = l1_upper_lmt_group_df.select("group_number").distinct().collect()
    # print('count of groups in L2',len(l1_upper_lmt_group_list))
    # print('count of data in L2 bucket', l1_upper_lmt_group_df.count())

    # List of Groups Lower than Lower Limit
    l1_lowr_lmt_group_list = level1_group_df.filter(Func.col("group_count") < g1_lower_limit).select(['*'])
    # print('count of data in L2_U bucket', l1_lowr_lmt_group_list.count())

    # processing records between lower_limit and upper_limit after level 1 grouping
    t1_start = time.time()
    sum_l1 = 0
    if (group_list.count()) > 0:

        df_final = group_list\
            .withColumn("group_number_new", concat_ws("_", lit("L1"), lit(level1_group_df['group_number'])))\
            .withColumn('last_nm_cnt', concat_ws("_", level1_group_df['group_count'], level1_group_df[l1_grouping]))

        sum_l1 = df_final.count()
        csvName = l1_file_prefix + bucket_grp + "_" + str(sum_l1) + '_' + datetime.now().strftime("%d%m%Y_%H%M%S")
        print('count of final data before creating file', sum_l1)
        file_write(df_final, csvName)

    t1_end = time.time()
    ################################# Level 1 10000+ ###################################
    sum_l21 = 0
    sum_l22 = 0
    sum_l23 = 0

    # # processing records greater than upper_limit after level 1 grouping
    if len(l1_upper_lmt_group_list) > 0:

        for item in l1_upper_lmt_group_list:

            ####Querying on l1_upper_lmt_group_df to create subbucket & assign group no & group count by first letter of First name and last_name

            # Second Level of Grouping

            l2_grouping_df = l1_upper_lmt_group_df.where(
                l1_upper_lmt_group_df.group_number == str(item['group_number'])) \
                .withColumn("group_number", Func.dense_rank().over(
                Window.orderBy((l2_grouping), (l2_grouping1)))) \
                .withColumn("group_count", Func.count('*').over(
                Window.partitionBy((l2_grouping), (l2_grouping1))))

            mod_l2_grouping_df = l2_grouping_df.withColumn("group_number",
                                                            concat_ws("-", Func.lit(str(item['group_number'])),
                                                                      Func.lit("s"),
                                                                      l2_grouping_df['group_number']))
            print("2nd level grouping completed")
            ################################# Get Distinct group numbers for each bucket ###################################

            # Records between Lower_Limit and Upper_Limit after 2nd level of grouping
            l2_group_df = mod_l2_grouping_df.\
                filter((Func.col("group_count") >= g2_lower_limit) & (Func.col("group_count") < g2_upper_limit)) \
                .select(['*'])

            # Records greater than or equal to Upper_Limit after 2nd level of grouping
            l2_group_upper_lmt_df = mod_l2_grouping_df.filter(Func.col("group_count") >= g2_upper_limit) \
                .select(['*'])

            # Records less than Lower_Limit after 2nd level of grouping
            l2_group_lower_lmt_df = mod_l2_grouping_df.filter(Func.col("group_count") < g2_lower_limit) \
                .select(['*'])
            print("distinct rec collected for 1000")
            ################################# Level 2 10000+ ###################################
            ########################### records between 2-9999 ############################

            # Processing Records between Lower_Limit and Upper_Limit after 2nd level of grouping
            if (l2_group_df.count()) > 0:

                df_final_sub = l2_group_df.withColumn("group_number_new", concat_ws("_", lit("L2"), lit(mod_l2_grouping_df['group_number'])))

                l_name_cnt = df_final_sub.withColumn('last_nm_cnt', concat_ws("_", df_final_sub['group_count'],
                                                                              (l2_grouping),(l2_grouping1)))
                sum_l21 = sum_l21 + l_name_cnt.count()
                # Writing the Result to csv files
                csvName = l2_buckt_path + str(item['group_number']) + '_' + str(sum_l21) + '_' + datetime.now().strftime("%d%m%Y-%H%M%S")
                file_write(l_name_cnt, csvName)

            ################################## Level 2 10000+ ###################################
            ############################ records > 10000 #######################################
            # Processing Records greater than or equal to Upper_Limit after 2nd level of grouping
            if (l2_group_upper_lmt_df.count()) > 0:

                df_fin_sub = l2_group_upper_lmt_df.withColumn("group_number_new", concat_ws("_", lit("L2"), lit(mod_l2_grouping_df['group_number'])))
                l_name_cnt = df_fin_sub.withColumn('last_nm_cnt', concat_ws("_", df_fin_sub['group_count'],
                                                                               (l2_grouping),(l2_grouping1)))

                sum_l22 = sum_l22 + l_name_cnt.count()

                csvName = l2_buckt_path1 + str(item['group_number']) + '_' + str(sum_l22) + '_' + datetime.now().strftime("%d%m%Y-%H%M%S")

                file_write(l_name_cnt, csvName)
                ################################### level 2 1000+ ###################################
                ############################# records < 2 #######################################

            # Processing Records less than Lower_Limit after 2nd level of grouping
            if (l2_group_lower_lmt_df.count()) > 0:

                df_sub = l2_group_lower_lmt_df.withColumn("group_number_new", concat_ws("_", lit("L2"), lit(mod_l2_grouping_df['group_number'])))
                l_name_cnt = df_sub.withColumn('last_nm_cnt', concat_ws("_", df_sub['group_count'],
                                                                        (l2_grouping), (l2_grouping1)))

                sum_l23 = sum_l23 + l_name_cnt.count()

                csvName = l2_buckt_path2 + str(item['group_number']) + '_' + str(sum_l23) + '_' + datetime.now().strftime(
                    "%d%m%Y-%H%M%S")

                file_write(l_name_cnt, csvName)

                print("file created", str(item['group_number']))

        print('Before reading all files')

        fol_1 = len(os.listdir(root_path + bucket_grp + '/' + l2_buckt_path))
        fol_2 = len(os.listdir(root_path + bucket_grp + '/' + l2_buckt_path1))
        fol_3 = len(os.listdir(root_path + bucket_grp + '/' + l2_buckt_path2))

        print("count of files in G2 folder", fol_1, fol_2, fol_3)

        sum_l211 = 0
        sum_l221 = 0
        sum_l231 = 0
        if (fol_1 >= 1):

            l2_file_read(l2_buckt_path, l2_file_prefix)

        if (fol_2 >= 1):

            l2_file_read(l2_buckt_path1, l2_file_prefix1)

        if (fol_3 >= 1):

            l2_file_read(l2_buckt_path2, l2_file_prefix2)

    t2_end = time.time()
    print("time to process L2 bucket", t2_end - t1_end)
    # shutil.rmtree('D:/grouping/' + bucket_grp + '/temp/', ignore_errors=True)

    sum_lu21 = 0
    sum_lu22 = 0
    sum_lu23 = 0

    # # processing records lower than lower_limit after level 1 grouping
    if l1_lowr_lmt_group_list.count() > 0:
        print("in unique block")
        ################################# Level 1 ######### Unique records ##########################
        # Creating Dataframe from the level1_group_df with all unique records
        # Querying on l1_lowr_lmt_group_list to assign group no & group count by first letter of First name and last_name

        # Second Level of Grouping for unique records
        df_bucket_unique = l1_lowr_lmt_group_list \
            .withColumn("group_number", Func.dense_rank().over(
            Window.orderBy((l2_grouping), (l2_grouping1)))) \
            .withColumn("group_count", Func.count('*').over(
            Window.partitionBy((l2_grouping), (l2_grouping1))))

        # Records between Lower_Limit and Upper_Limit after 2nd level of grouping of unique records
        unique_num_list_2_999 = df_bucket_unique.\
            filter((Func.col("group_count") >= g2_lower_limit) & (Func.col("group_count") < g2_upper_limit)) \
            .select(['*'])

        # Records greater than Upper_Limit after 2nd level of grouping of unique records
        unique_num_list_1000 = df_bucket_unique.filter((Func.col("group_count") >= g2_upper_limit)).select(['*'])

        # Records less than Lower_Limit after 2nd level of grouping of unique records
        unique_num_list_2 = df_bucket_unique.filter((Func.col("group_count") < g2_lower_limit)) \
            .select(['*'])
        # Processing Records between Lower_Limit and Upper_Limit after 2nd level of grouping of unique records
        if unique_num_list_2_999.count() > 0:
        ################################ Level 2 Unique ###################################
        ########################## records between 2-999 ############################

            df_unique_fnl = unique_num_list_2_999.withColumn("group_number_new",
                                                          concat_ws("_", lit("L2-U"), lit(df_bucket_unique['group_number'])))

            l_name_cnt = df_unique_fnl.withColumn('last_nm_cnt', concat_ws("_", df_unique_fnl['group_count'],
                                                                           (l2_grouping),(l2_grouping1)))

            sum_lu21 = l_name_cnt.count()
            csvName = l2_u_prefix +  bucket_grp + "_" + str(sum_lu21) + '_' + datetime.now().strftime("%d%m%Y-%H%M%S")

            file_write(l_name_cnt, csvName)

        # Records greater than Upper_Limit after 2nd level of grouping of unique records
        if unique_num_list_1000.count() > 0:
            ################################## level 2 unique ###################################
            # ############################ records > 1000 #######################################

            df_unique_finl1 = unique_num_list_1000.withColumn("group_number_new",
                                                          concat_ws("-", lit("L2-U"), lit(df_bucket_unique['group_number'])))

            l_name_cnt1 = df_unique_finl1.withColumn('last_nm_cnt', concat_ws("_", df_unique_finl1['group_count'],
                                                                              (l2_grouping), (l2_grouping1)))
            sum_lu22 = l_name_cnt1.count()

            csvName = l2_u_prefix1 +  bucket_grp + "_" + str(sum_lu22) + '_' + datetime.now().strftime("%d%m%Y-%H%M%S")

            file_write(l_name_cnt1, csvName)

        # Records less than Lower_Limit after 2nd level of grouping of unique records
        if unique_num_list_2.count() > 0:
            # ################################### level 2 unique ###################################
            # # ############################# records < 2 #######################################

                df_unique_fnl2 = unique_num_list_2.withColumn("group_number_new",
                                                              concat_ws("-", lit("L2-U"), lit(df_bucket_unique['group_number'])))

                l_name_cnt2 = df_unique_fnl2.withColumn('last_nm_cnt', concat_ws("_", df_unique_fnl2['group_count'],
                                                                                (l2_grouping),(l2_grouping1)))

                sum_lu23 = l_name_cnt2.count()

                csvName = l2_u_prefix2 + bucket_grp + "_" +  str(sum_lu23) + '_' + datetime.now().strftime("%d%m%Y-%H%M%S")
                # Writing the Result to csv files
                file_write(l_name_cnt2, csvName)

    t_end = time.time()
    print("count of records in L1", sum_l1)
    print("count of records in L2 2-999", sum_l21)
    print("count of records in L2 1k+", sum_l22)
    print("count of records in L2 unique", sum_l23)
    print("count of records in L2-U 2-999", sum_lu21)
    print("count of records in L2-U 1k+", sum_lu22)
    print("count of records in L2-U unique", sum_lu23)
    print("sum of records in all buckets ", sum_l1 + sum_l21 + sum_l22 + sum_l23 + sum_lu21 + sum_lu22 + sum_lu23)

    print("time to process l1 grouping", t_end1 - t_start)
    print("time to process L1 bucket", t1_end - t1_start)
    print("time to process L2 bucket", t2_end - t1_end)
    print("time to process L2-U", t_end - t2_end)
    print("time to complete process", t_end - t_start)

if __name__ == "__main__":
    main()