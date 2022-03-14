import pyspark
from pyspark.sql import *
from pyspark.sql.types import *
from pyspark.sql.functions import col
from pyspark.sql import functions as F
from pyspark.sql.types import StructType, IntegerType, DateType
from pyspark.sql.functions import *
from pyspark.sql.session import SparkSession
from pyspark import SparkContext, SparkConf
from pyspark.sql.types import StructType,IntegerType,StringType
#from pyspark import SparkContext, SparkConf,SQLContext
conf = SparkConf()
# create the context
sc = pyspark.SparkContext(conf=conf)
spark = SparkSession.builder.getOrCreate()
schema_anime = StructType([StructField("anime_id", IntegerType(),True),StructField("name", StringType(),True),StructField("genre", StringType(),True),StructField("type", StringType(),True),StructField("episodes", IntegerType(),True),StructField("rating", IntegerType(),True),StructField("members", IntegerType(),False)])
anime = spark.read.option("sep", "\t").csv("C:/Users/10638056/anime.csv",header=False,schema=schema_anime)