import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.window import Window
from pyspark.sql.functions import *
# #export PYSPARK_PYTHON=python 3.7
spark = SparkSession.builder.appName('SparkByExamples.com').getOrCreate()