import pandas as pd
from pyspark.python.pyspark.shell import sqlContext
from pyspark.sql import SparkSession
from pyspark.sql import SQLContext, Row
from pyspark.sql.functions import rank, col
from pyspark.sql.functions import col, when
from pyspark.sql.functions import map_values
from pyspark.sql.window import Window

spark = SparkSession \
    .builder \
    .appName("how to read csv file") \
    .getOrCreate()
# ith open("C:/Users/10638056/Documents/exercise.txt","r")
# df = spark.read.csv("C:/Users/10638056/Desktop/exercise/emp.csv")

df = spark.read.option("header", "True").option("multiline", True).csv(
    r"C://Users/10638056/Desktop/exercise/salary1.csv")
pdf = pd.read_csv(r"C://Users/10638056/Desktop/exercise/salary1.csv")
pdf.show()
#df.show()
#df1=df.fillna("")
rcols=df.columns
#print(rcols)
df2=df1.select([when(col(a)== "",0).otherwise(col(a)).alias(a) for a in rcols])
#df2.show()
#df.na.fill(value=0,subset=["salary"]).show()
# df2 = df.select(df.columns[0:1]).fillvalue(0).show()
#rcols=["project","salary"]
#rcols=[list(row) for row in df.collect()]
# df.createOrReplaceTempView("stable")
# sqlContext.sql("select * from stable ").show()
# w=Window().partitionBy(col('project').orderBy('salary')
# df.select("empid","project", max("salary").over(w).alias("Salarymax")).show()
def ctoNull(df1):
    for i in df1.columns:
        dfa = df1.withColumn(i, when(col(i) == "",0).otherwise(col(i)))
    return dfa
#ctoNull(df1).show()

#df1 = ctoNull(df)
#df1.show()

# df.na.replace(df.columns,map_values(" ","0")).show()
# ctoNull(df).show()
# df.fillna(#0).show()#

a= 4
b='8.678'
c=-5
str1='{0:.4f}{2}{1}'.format(a,b,c)
print(str1)

