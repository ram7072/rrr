

a='r,a,j'
l=[x for x in a if x!=',']
print(l)
new_a = "".join(l)
print(new_a)

accum = sc.accumulator(0)
rdd = sc.parallelize([1, 2, 3, 4,5,6])
rdd.first()
def f(x):
global accum 
accum += x
rdd.foreach(f)
accum.value
