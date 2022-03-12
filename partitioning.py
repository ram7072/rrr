import sys
from pyspark.sql.functions import year, month, dayofmonth, hour, minute, col
from pyspark.context import SparkContext
from awsglue.transforms import ResolveChoice, DropNullFields
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from awsglue.dynamicframe import DynamicFrame
from pyspark.sql import functions as F

# Configure required parameters
params = [
    'JOB_NAME',
    'output_database',
    'tmp_table',
    'output_table',
    'output_path'
]
args = getResolvedOptions(sys.argv, params)
output_database = args['output_database']
tmp_table = args['tmp_table']
output_table = args['output_table']
output_path = args['output_path']

# getOrCreate allows this to run as a job or in a notebook.
glue_context = GlueContext(SparkContext.getOrCreate())
spark = glue_context.spark_session
job = Job(glue_context)
job.init(args['JOB_NAME'], args)

# Create DynamicFrame from Data Catalog
dyf = glue_context.create_dynamic_frame.from_catalog(
    database=output_database,
    table_name=tmp_table,
    transformation_ctx='dyf'
)
df = dyf.toDF()
df2 = df.withColumn("curr_date", F.lit(datetime.now().strftime("%Y-%m-%d")))
dyf1 = DynamicFrame.fromDF(df2, glue_context)


# Write DynamicFrame to S3 in glueparquet format
sink = glue_context.getSink(
    connection_type="s3",
    path=output_path,
    enableUpdateCatalog=True,
    
)
sink.setFormat("glueparquet")
sink.setCatalogInfo(
    catalogDatabase=output_database,
    catalogTableName=output_table
)
sink.writeFrame(dyf1)
job.commit()