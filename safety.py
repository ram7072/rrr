import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import SQLContext, Row
from pyspark.sql.functions import rank, col
from pyspark.sql.window import Window
spark = SparkSession \
    .builder \
    .appName("how to read csv file") \
    .getOrCreate()
#ith open("C:/Users/10638056/Documents/exercise.txt","r")
#df = spark.read.csv("C:/Users/10638056/Desktop/exercise/emp.csv")

# mgrdf=spark.read.option("header","True").option("multiline",True).csv(r"C://Users/10638056/Desktop/exercise/emp1.csv")
# empdf=spark.read.option("header","True").option("multiline",True).csv(r"C://Users/10638056/Desktop/exercise/salary1.csv")
# w = Window.partitionBy("project").orderBy("Salary")
# otdf= empdf.join(mgrdf,empdf.empid == mgrdf.empid,"inner")
# #rankDf = otdf.withColumn("local_rank",rank().over(w)).where(col("local_rank")==1).select("fullname","managerid","DOJ","project","salary")
# rankDf = otdf.withColumn("local_rank",rank().over(w)).where(col("local_rank")==1)
# a=rankDf.distinct()
# mgrdf.createOrReplaceTempView("mgrvw")
# sqlContext.sql("select * from mgrvw").show()
# empdf.createOrReplaceTempView("empvw")
# sqlContext.sql("select * from empvw ").show()
#
# sqlContext.sql("select distinct fullname from mgrvw  inner join empvw on mgrvw.mgrid=empvw.empid").show()
#
