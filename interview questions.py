##### Finding Average #####
#
# n=int(input("Enter the number of elements to be inserted: "))
# a=[]
# for i in range(0,n):
#     elem=int(input("Enter element: "))
# a.append(elem)
# avg=sum(a)/n
# print("Average of elements in the list",round(avg,2))
## Reversing a number ###
# n=int(input("Enter number: "))
# rev=0
# while(n>0):
#     dig=n%10
#     print(dig)
#     rev=rev*10+dig
#     n=n//10
#     print(n)
# print("The reverse of the number:",rev)
#####Sum of a number ###
# n=int(input("Enter a number:"))
# tot=0
# while(n>0):
#     dig=n%10
#     tot=tot+dig
#     n=n//10
# print("The total sum of digits is:",tot)
## list in to a string ###
# weekdays = ['sun','mon','tue','wed','thu','fri','sat']
# listAsString = ' '.join(weekdays)
# print(listAsString)
###palindrome or not #####
# n=int(input("Enter number:"))
# temp=n
# rev=0
# while(n>0):
#     dig=n%10
#     rev=rev*10+dig
#     n=n//10
# if(temp==rev):
#     print("The number is a palindrome!")
# else:
#     print("The number isn't a palindrome!")
########
##count of a number ###
# n=int(input("Enter number:"))
# count=0
# while(n>0):
#     count=count+1
#     n=n//10
# print("The number of digits in the number is:",count)
#########################
# ##Prime number##
# a=int(input("Enter number: "))
# k=0
# for i in range(2,a//2+1):
#     print(i)
#     if(a%i==0):
#         k=k+1
#         print(k)
#     if(k<=0):
#         print("Number is prime")
# else:
#     print("Number isn't prime")
### second largest element ##
# a=[]
# n=int(input("Enter number of elements:"))
# for i in range(1,n+1):
#     b=int(input("Enter element:"))
#     a.append(b)
# a.sort()
# print(a)
# print("Second largest element is:",a[n-2])
###
# a=3423
# #print(str(a)[::-1])
# print(str(a)[::-1])
#####
###Python Program to Swap the First and Last Value of a List:

# a=[]
# n= int(input("Enter the number of elements in list:"))
# for x in range(0,n):
#     element=int(input("Enter element" + str(x+1) + ":"))
# a.append(element)
# temp=a[0]
# a[0]=a[n-1]
# a[n-1]=temp
# print("New list is:")
# print(a)

#######
# string=raw_input("Enter string:")
# if(string==string[::-1]):
#     print("The string is a palindrome")
# else:
#     print("The string isn't a palindrome")
##

#Python Program to Check Common Letters in Two Input Strings:

# s1=input(str("Enter first string:"))
# s2=input(str("Enter second string:"))
# a=list(set(s1)&set(s2))
# print("The common letters are:")
# for i in a:
#     print(i)


####
# x={1:'HBO MAX',2:'Netflix',3:'Prime Video',4:'Hotstar'+'Disney',5:'Hulu TV'}
# try:
#     for i in range(1,10):
#         if (i%2==0):
#             print(x[i])
# except:
#     print('keyout')
#     print('available')
####
#stock={'axis':7,'bharati':5,'coal':10}
sent = 'Now a days big data analytics is more useful'
print(sent)
words = sent.split(',')
print(words)
print(len(words))

# large_word_length = len(words[0])
# print(large_word_length)
# for i in words:
#     word_length = len(i)
#     if word_length > large_word_length:
#         large_word_length = word_length
#         currentstring = i
# print(currentstring)
# print(large_word_length)


import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import functions
from pyspark.sql.functions import *
import pyspark.sql.functions as F
from pyspark.sql.types import StructType, StructField, StringType
spark = SparkSession.builder.getOrCreate()
from pyspark.sql.functions import split, explode
filename='C:/Users/10638056/Desktop/sample.txt'
schema1= StructType([StructField("name", StringType(), True), StructField("age", StringType(), True),StructField("organization", StringType(), True)]
#df.withColumn('col4',explode(split('col4',' '))).show()
df_email = spark.read.csv(filename, header=True, inferSchema=True)


















