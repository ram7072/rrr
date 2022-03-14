with open("C:/Users/10638056/Documents/exercise.txt","r") as f:
     b=str(f.read)
     print(b)
     #e = " ".join(b.splitlines())
     #c=e.replace(" ",",")
     #print(c)
#     print(type(c))
# # how to read a file in python
# a= open("C:/Users/10638056/Documents/exercise.txt","r")
# b=a.read()
# # print(b)
# # print(type(b)) ## it will show string
# e = " ".join(b.splitlines())
# # Replacing the separators spaces as comma
# c=e.replace(" ",",")
# print(c)
# print(type(c))
# d=c.split(',')  # using Split method  we are converting string to list
# print(d)
# print(type(d))
# rr={} # Creating  a dictionary in
# for i in d:
#     if i in rr:
#         rr[i]+=1
#     else:
#         rr[i]=1
# print(rr)
#
#
#
# # b=(a.readlines())
# # print(b)
# #c=','.join(i for i in b).split('')
# #c=b.replace('',',')
# #print(c)
# list2 = ['a','b','c','d','e','f',1,2,3,4,5,6,7,8,9,0]
# x=[1,2,3]
# y=[]
# for i in list2:
#     if isinstance(x,int):
#         print("yes")
#         y.append(x)
# print(y)
# def search(arr, n, x):
#
#     for i in range(0, n):
#         if (arr[i] == x):
#             print(i)
#             return i
#     return -1
# arr = [2, 3, 4, 10, 40]
# x = 10
# n = len(arr)
# search(arr, n, x)

def search(arr, search_Element):
    left = 0
    length = len(arr)
    position = -1
    right = length - 1

    # Run loop from 0 to right
    for left in range(0, right, 1):

        # If search_element is found with
        # left variable
        if (arr[left] == search_Element):
            position = left
            print("Element found in Array at ", position +
                  1, " Position with ", left + 1, " Attempt")
            break

        # If search_element is found with
        # right variable
        if (arr[right] == search_Element):
            position = right
            print("Element found in Array at ", position + 1,
                  " Position with ", length - right, " Attempt")
            break
        left += 1
        right -= 1

    # If element not found
    if (position == -1):
        print("Not found in Array with ", left, " Attempt")

# Driver code
arr = [1, 2, 3, 4, 5]
search_element = 5
search(arr, 1)










