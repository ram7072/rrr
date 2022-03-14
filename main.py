import requests
import time
import csv
from pyspark.sql.functions import from_json
print("raja")
import pyspark
from pyspark.sql import SparkSession
from pyspark import SparkConf, SparkContext
sc = SparkContext(conf=SparkConf().set("spark.files.overwrite", "true"))
from pyspark.sql.types import *
spark = SparkSession \
    .builder \
    .appName("how to read csv file") \
    .getOrCreate()
#sc.addPyFile("C:/Users/10638056/Downloads/jar_files/spark-csv_2.10-1.5.0")
#sc,addpyFile("C:/Users/10638056/Downloads/jar_files/commons-csv-1.1")
#df = spark.read.csv('C:/Users/10638056/Downloads/demo.csv',header='true')
df= spark.read.format("csv").option("header", "true").option("delimiter",",").load(r"C:/Users/10638056/Downloads/emp.csv")
#C:\Users\10638056\Downloads
#df.select($"itemid",flatten($"content")).show(false)
#df=spark.textFile("C:/Users/10638056/Downloads/demo.csv").map(lambda line: line.split(",")).toDF
#df.show(100,False)
#a=df.drop("itemid")
#a.show(2, False)
#print(type(a))
df.show(5,False)
df.printSchema()
ndf = df.drop('Full Name')
filepath="C:/Users/10638056/Downloads/output6.csv"
filep=r"C:\Users\10638056\PycharmProjects\pythonProject\op"
path=r"C:\tmp\hive\test32"
ndf.printSchema()
ndf.coalesce(1).write.parquet(path).mode("overwrite")
#df.coalesce(1).write.format("csv").option("header","true").option("sep",",").mode("overwrite").save("C:/Users/10638056/Downloads/output.csv")
print('done')





