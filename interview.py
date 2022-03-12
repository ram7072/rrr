url = "C:/Users/10638056/Downloads/emp"
from pyspark import SparkFiles
sc.addFile(url)
sqlContext = SQLContext(sc)
df = sqlContext.read.csv(SparkFiles.get("emp"), header=True, inferSchema= True)
