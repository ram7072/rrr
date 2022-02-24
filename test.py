#Write a python program to print the square of all numbers from 0 to 10.

#for i in range (0,11):
#    print(i*i)
#Write a program which repeatedly reads positive numbers until the user enters -1. Once -1 is entered,
#print out both the maximum and minimum of the numbers.

#If n is odd, print Weird
#If n is even and in the inclusive range of 2 to 5  , print Not Weird
#If n is even and in the inclusive range of  6 to 20, print Weird
#If n is even and greater than , print Not Weird
#raw_input= 3
##if __name__ == '__main__':
 ##   n = 3
  ##  n=24
   ## for n in range(2,5):
    ##    if n%2 != 0:
      ##      print('Weird')
       ## else :
        ##    print('Not Weird')

#n=3
#for i in range(0,n):
#    print(i*i)

with open("C:/Users/10638056/Documents/exercise.txt","r") as f:
    b=str(f.read())
    print(b)
    e=" ".join(b.splitlines())
    print(e)
    c = e.replace(" ",",")
    print(c,'raja')
    print(type(c))
    d=c.split(',')
    print(type(d))
    print(d)
    em={}
    for i in d:
        if i in em:
            em[i]+=1
        else:
            em[i]=1
    print(em)

    a=['raja','raman','ashok','raja','ashok']
    e={}
    for i in a:
        if i in e:
            e[i]+=1
        else:
            e[i]=1
    print(e)









