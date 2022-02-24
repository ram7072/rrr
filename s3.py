import findspark
findspark.init()
import pyspark
import boto3
from pyspark import SparkContext
from pyspark.sql import SparkSession
from pyspark.conf import SparkConf
from pyspark.sql import functions as F
awsAccessKey = 'AKIA33FHJCLOIOEKG2F7'
awsSecretKey = '10PZ0C4TQrrtFhefz7e5b4NGllu7TD8raEMXfHUV'
conf = (
    SparkConf()
        .setAppName("PySpark S3 Integration Example")
       .set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.2')
        .set("spark.hadoop.fs.s3a.access.key", awsAccessKey)
        .set("spark.hadoop.fs.s3a.secret.key", awsSecretKey)
        .set("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
        .set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")

)
spark = SparkSession.builder.config(conf=conf).getOrCreate()
df=spark.read.options(sep=",", header="true").csv("s3a://tripelr/blueprintip/csvfiles/data.txt")
df2 = df.withColumn("Curr_date", F.current_date())
print(type(df2))
#df2.write.options("header",True).csv('s3a://tripelr/blueprintip/csvfiles')

#df2.write.mode(SaveMode.Overwrite).csv("s3a://sparkbyexamples/csv/zipcodes")
#path=r'C:\Users\10638056\project_folder\abc'
path='s3a://tripelr/blueprintip/csvfiles'
#df2.write.mode("append").format("csv").save(path)
