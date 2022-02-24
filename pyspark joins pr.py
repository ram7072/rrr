import pyspark
import time
import csv
import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql import functions
from pyspark.sql.functions import Column as col

spark = SparkSession.builder.getOrCreate()
emp = [(1,"Smith",1,"2018","10","M",3000), \
    (2,"Rose",1,"2010","20","M",4000), \
    (3,"Williams",1,"2010","10","M",1000), \
    (4,"Jones",2,"2005","10","F",2000), \
    (5,"Brown",2,"2010","40","",-1), \
      (6,"Brown",2,"2010","50","",-1) \
  ]
schema = StructType([StructField("emp_id",IntegerType(),True),
    StructField("name",StringType(),True), \
    StructField("superior_emp_id",IntegerType(),True), \
    StructField("year_joined", IntegerType(), True), \
    StructField("emp_dept_id", IntegerType(), True), \
    StructField("gender", StringType(), True), \
    StructField("salary", IntegerType(), True)
  ])
# empColumns = ["emp_id","name","superior_emp_id","year_joined", \
#        "emp_dept_id","gender","salary"]
path= r'C:\Users\10638056\Desktop\RRR Training\data\emp.txt'
empdf=spark.read.csv(path,schema)
empdf.show()
#empDF = spark.createDataFrame(data=emp, schema = empColumns)
empdf.printSchema()
#empdf.show()
#empdf.show(truncate=False)

# dept = [("Finance",10), \
#     ("Marketing",20), \
#     ("Sales",30), \
#     ("IT",40) \
#   ]
# deptColumns = ["dept_name","dept_id"]
schema1 = StructType([StructField("dept_name",StringType(),True)
                         ,
    StructField("dept_id",IntegerType(),True)])
path1= r'C:\Users\10638056\Desktop\RRR Training\data\dep.txt'
depdf=spark.read.csv(path1,schema1)
depdf.show()
# ###Inner join###
empdf.join(depdf,empdf.emp_dept_id == depdf.dept_id,"inner") \
     .show(truncate=False)
print ('##### Inner join executed successfully ####')
#
# # # deptDF = spark.createDataFrame(data=dept, schema = deptColumns)
# # depdf.printSchema()
# # depdf.show(truncate=False)
#
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"right") \
   .show(truncate=False)
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"rightouter") \
   .show(truncate=False)
print ('##### Right and Right outer  join executed successfully ####')
# ## Full outer join ##
#
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"outer") \
    .show(truncate=False)
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"full") \
    .show(truncate=False)
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"fullouter") \
    .show(truncate=False)
print('### outer- full-Full outer join executed successfully')

# ## Left outer join ##

empdf.join(depdf,empdf.emp_dept_id == depdf.dept_id,"left")\
    .show(truncate=False)
empdf.join(depdf,empdf.emp_dept_id == depdf.dept_id,"leftouter")\
    .show(truncate=False)
print('### Left outer join executed successfully')
#
# ## Right  outer join ##
#
# empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"right")\
#     .show(truncate=False)
# empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"rightouter")\
#     .show(truncate=False)
# print('### Right outer join executed successfully')
#
## Left Semi join##
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"leftsemi")\
    .show(truncate=False)

print('Left semi join executed Successfully')
#
# ## Left Anti join #
#
empdf.join(depdf,empdf.emp_dept_id ==  depdf.dept_id,"leftanti")\
    .show(truncate=False)
print('Left Anti join executed Successfully')
# # ## Self Join#
# #
# # # empdf.as('j1').join(empdf.as('j2')),$"j1.superior_emp_id"  $"j2.emp2.emp_id").show()
# # #     # .select(col("emp1.emp_id"),col("emp1.name"), \
# # #     #   col("emp2.emp_id").alias("superior_emp_id"), \
# # #     #   col("emp2.name").alias("superior_emp_name")) \
# # #    # .show(truncate=False)
# # # empdf.alias('l').join(empdf.alias('r'),$''l.superior_emp_id''=== $''r.emp_id'').show()
# #
# #
# # # empdf.alias("emp1").join(empdf.alias("emp2"), \
# # #     col("emp1.superior_emp_id") == col("emp2.emp_id"),"inner") \
# # #     .select(col("emp1.emp_id"),col("emp1.name"), \
# # #       col("emp2.emp_id").alias("superior_emp_id"), \
# # #       col("emp2.name").alias("superior_emp_name")) \
# # #    .show(truncate=False)
# #
# # df_as1 = empdf.alias("df_as1")
# # df_as2 = empdf.alias("df_as2")
# # df2 = df_as1.join(df_as2, df_as1.emp_id == df_as2.superior_emp_id,'inner')
# #     # .select(col("df_as2.emp_id").alias("superior_emp_id"),
# #     #         col("df_as2.name").alias("superior_emp_name"))
# # df2.show()
# #
# # #empdf.alias("df1").join(empdf.alias("df2"),"df1.superior_emp_id" == "df2.emp_id", "inner").show()
# #
# # print('self join executed Successfuly ')