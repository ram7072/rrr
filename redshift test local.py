import functools
from pyspark.sql.functions import lit
from pyspark.sql.functions import *
from pyspark.sql import functions as F
from pyspark import SparkContext, SparkConf, SQLContext
from pyspark.sql.session import SparkSession
from pyspark.sql.types import StructType, StructField, StringType
from multiprocessing import Pool
from multiprocessing.pool import ThreadPool

spark = SparkSession \
    .builder \
    .appName("how to read csv file") \
    .getOrCreate()

config = {
    'redshift_user': 'ashishsi',
    'redshift_pass': 'FRkIUoAtHnp2',
    'redshift_port': 5439,
    'redshift_db': 'qedw',
    'redshift_host': 'qa-rsdw20.c7xnpctseavf.us-east-1'
}


def main():
    global newdf
    # schema = 'edwownr.contact_bkp_20210526_before_anmy
    table = 'contact_bkp_20210526_before_anmy'

    jdbcURL = "jdbc:redshift://qa-rsdw20.c7xnpctseavf.us-east-1.redshift.amazonaws.com:5439/qedw?user=ashishsi" \
              "&password=FRkIUoAtHnp2"
    df_siebel = spark.read \
        .format("jdbc") \
        .option("url", jdbcURL) \
        .option("query", """Select con_first_nm as first_name,con_last_nm as last_name,con_email_addr_txt as email,'siebel' as Source_name
        from edwownr.contact_bkp_20210526_before_anmy con left outer join
        edwownr.contact_emp_bkp_20210526_before_anmy emp on emp.con_emplymnt_con_id = con.con_id
        and emp.con_emplymnt_most_cur_flag = 'Y' and emp.row_dml_flag <> 'D' where con.con_stat_desc = 'Active'
        and con.con_cur_rec_flag = 'Y' and con.con_ieee_gr_desc <> 'Designation'""") \
        .load()
    print(count(df_siebel))

main()