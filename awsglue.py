import boto3
import csv
import io
import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql import functions
from pyspark.sql.functions import *
import pyspark.sql.functions as F
# spark = SparkSession.builder.getOrCreate()
session = boto3.Session(
    aws_access_key_id='AKIA33FHJCLOIOEKG2F7',
   aws_secret_access_key='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'
)
s3 = session.resource('s3')
bucket = s3.Bucket('tripelr')
# prefix_df = []
#
# for obj in bucket.objects.filter(Prefix='blueprintip/csvfiles'):
#     key = obj.key
#     body = obj.get()['Body']
#     temp = pd.DataFrame(body)
#     print(temp)
#     prefix_df.append(temp)
# print(prefix_df)
#     # df = spark.read.csv(body, header=True, inferSchema=True)
#     # df.show()
def read_prefix_to_df(prefix):
    bucket = s3.Bucket('tripelr')
    prefix_objs = bucket.objects.filter(Prefix=prefix)
    prefix_df = []
    for obj in prefix_objs:
        key = obj.key
        body = obj.get()['Body']
        temp = pd.read_csv(io.BytesIO(body), encoding='utf8')
        prefix_df.append(temp)
        print(prefix_df)

read_prefix_to_df('blueprintip/csvfiles')