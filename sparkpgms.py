from pyspark.sql.functions import lower

import pyspark
import time
import csv
import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql import functions
from pyspark.sql.functions import *
import pyspark.sql.functions as F
spark = SparkSession.builder.getOrCreate()
start1 = time.time()
input_file_path = ""
filename= r'C:/Users/10638056/Desktop/authortest.txt'
df_email = spark.read.csv(filename, header=True, inferSchema=True)
print("count of source data 1", df_email.count())
df2 = df_email.withColumn("emails", functions.regexp_replace(lower(df_email[1]), "[^a-zA-Z0-9@\._\-| ]", ""))
df2.show(truncate=False)
extract_expr = expr("regexp_extract(emails, '(\\\w+([\\\.-]?\\\w+)*@\\[A-Za-z\-\.]+([\\\.-]?\\\w+)*(\\\.\\\w{2,3})+)', 0)")
join_expr = expr("array_join(extract, '|')")
dfe = df2.withColumn("extract", extract_expr)
dfe.show(truncate=False)
