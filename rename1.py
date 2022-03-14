from rename import load_run_configs
import pyspark
from pyspark.sql import SparkSession
import json
spark = SparkSession.builder.getOrCreate()
configs=load_run_configs()
count=1
total_iterations = len(configs)
for conf in configs:
    print("Executing configuration ({} of {}) \r".format(count, total_iterations))
    df = spark.read.options(sep=",", header="true").csv(conf["target_path"])
    s3_source='C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt'
    dfa= spark.read.options(sep=",", header="true").csv(s3_source)
    mismatched_columns=[]
    if len(df.columns) == len(dfa.columns):
        print('number of columns {}: '.format(len(df.columns)))
        for i in df.columns:
            if i in dfa.columns:
                print('Source and Target Columns are matching Successfully  or {} iterations\r'.format(count))
            else:
                print('Source and Target Columns are failed in matching for {} iterations\r'.format(count))
                mismatched_columns.append(str(i))
                print("Mismatched columns of iterations {} are : {}\r".format(count , mismatched_columns))
    count=count+1


