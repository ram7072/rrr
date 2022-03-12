import sys
import logging
import pyspark
from pyspark.sql import SparkSession
import json

spark = SparkSession.builder.getOrCreate()
source_path="C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt"
df = spark.read.options(sep=",", header="true").csv(source_path)
print(df.columns)
    # df = rename_columns(df, target_column_headers)
target_path= "C:/Users/10638056/Desktop/RRR Training/data/renamed1.tsv"
def rename_columns(df,columns):
    for old_name,new_name in columns.items():
        df= df.withColumnRenamed(old_name,new_name)
    return df
# new_column_name_list = list(map(lambda x: x.replace(" ", ""), df.columns))
# df = df.toDF(*new_column_name_list)
print(df.columns)
columns={"age": "age_test"}
#rename_columns(df,columns).write.csv(target_path)
lc=list(columns.values())
print(lc)
#print('written')
#df1= df.withColumnRenamed('age_test','age')
#df.select('workclass').show()