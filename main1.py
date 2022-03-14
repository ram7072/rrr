a = "Raja Raman is working in LNT INFOTECH"
b=a.lower()
c=b.split(',')
print (c)
vw={'a','e','i','o','u'}
#vw= ['aeiou']
occ={}
def word_freq():
  for i in c:
    if i in vw:
      vw[i]+=1
      occ.append(i)
    else:
      vw[i]=1
  return vw

word_freq()


