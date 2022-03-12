
import pyspark
import itertools
from itertools import permutations,combinations

import json
with open("C:/Users/10638056/Documents/nag.json","r") as f:
    b=json.load(f)
    print(b)
    c=json.dumps(b,sort_keys=True)
    print(c)
for i in b:
    print(b['Nikhil'])
a= ['ind','Aus','pak']
tmp=[]
for i in range(len(a)):
    oc=combinations(a,i+1)
    for c in oc:
        tmp.append(list(c))

#print(tmp)
for i in range(1,len(a)+1):
    print(list(itertools.combinations(a, i)))

def get(dict,k,v):
    v=dict[k]
    for i in dict:
        print(i)
        if dict[i]==k:
            dict[i]=v
            return dict
a=get({'a':3,'b':2,'c':'a','d':'d'},"a",3)
print(a)

#
#
#
