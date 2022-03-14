#Tuples are used to store multiple items in a single variable.
#A tuple is a collection which is ordered and unchangeable.
#Tuples are written with round brackets
tripler_tuple = ("apple", "banana", "cherry")
print(tripler_tuple)
#output:('apple', 'banana', 'cherry')
#Tuple Items
#Tuple items are ordered, unchangeable, and allow duplicate values.
#Tuple items are indexed, the first item has index [0], the second item has index [1] etc.
#Access Tuple Items
#You can access tuple items by referring to the index number, inside square brackets:
tripler_tuple = ("apple", "banana", "cherry")
print(tripler_tuple[1])
#output:banana
#Negative Indexing
#Negative indexing means start from the end.
#-1 refers to the last item, -2 refers to the second last item etc.
tripler_tuple = ("apple", "banana", "cherry")
print(tripler_tuple[-1])
#output:cherry
#Range of Indexes
#You can specify a range of indexes by specifying where to start and where to end the range.
#When specifying a range, the return value will be a new tuple with the specified items.
tripler_tuple = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
print(tripler_tuple[2:5])
#output:('cherry', 'orange', 'kiwi')
tripler_tuple = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
print(tripler_tuple[:4])
#output:('apple', 'banana', 'cherry', 'orange')
tripler_tuple = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
print(tripler_tuple[2:])
#output:('cherry', 'orange', 'kiwi', 'melon', 'mango')
#Change Tuple Values
#Once a tuple is created, you cannot change its values. Tuples are unchangeable, or immutable as it also is called.
#But there is a workaround. You can convert the tuple into a list, change the list, and convert the list back into a tuple.
x = ("apple", "banana", "cherry")
y = list(x)
y[1] = "kiwi"
x = tuple(y)
print(x)
#output:("apple", "kiwi", "cherry")
#Add Items
#Since tuples are immutable, they do not have a build-in append() method, but there are other ways to add items to a tuple.
#1.Convert into a list: Just like the workaround for changing a tuple, you can convert it into a list, add your item(s), and convert it back into a tuple
tripler_tuple = ("apple", "banana", "cherry")
y = list(tripler_tuple)
y.append("orange")
tripler_tuple = tuple(y)
#output:('apple', 'banana', 'cherry', 'orange')
#2.Add tuple to a tuple. You are allowed to add tuples to tuples, so if you want to add one item, (or many), create a new tuple with the item(s), and add it to the existing tuple:
tripler_tuple = ("apple", "banana", "cherry")
y = ("orange",)
tripler_tuple += y
print(tripler_tuple)
#output:('apple', 'banana', 'cherry', 'orange')
#Note: When creating a tuple with only one item, remember to include a comma after the item, otherwise it will not be identified as a tuple.
#Unpacking a Tuple
#When we create a tuple, we normally assign values to it. This is called "packing" a tuple:
#But, in Python, we are also allowed to extract the values back into variables. This is called "unpacking":
fruits = ("apple", "banana", "cherry")
(green, yellow, red) = fruits
print(green)
print(yellow)
print(red)
'''output:apple
          banana
          cherry'''
#Note: The number of variables must match the number of values in the tuple, if not, you must use an asterisk to collect the remaining values as a list.
#Using Asterisk*
#If the number of variables is less than the number of values, you can add an * to the variable name and the values will be assigned to the variable as a list:
fruits = ("apple", "banana", "cherry", "strawberry", "raspberry")
(green, yellow, *red) = fruits
print(green)
print(yellow)
print(red)
'''output:apple
          banana
          ['cherry', 'strawberry', 'raspberry']'''
#If the asterisk is added to another variable name than the last, Python will assign values to the variable until the number of values left matches the number of variables left.
fruits = ("apple", "mango", "papaya", "pineapple", "cherry")
(green, *tropic, red) = fruits
print(green)
print(tropic)
print(red)
'''output:apple
          ['mango', 'papaya', 'pineapple']
          cherry'''
#Loop Through a Tuple
#You can loop through the tuple items by using a for loop.
tripler_tuple = ("apple", "banana", "cherry")
for x in tripler_tuple:
  print(x)
'''output:apple
          banana
          cherry'''
#Join Two Tuples
#To join two or more tuples you can use the + operator:
tuple1 = ("a", "b" , "c")
tuple2 = (1, 2, 3)
tuple3 = tuple1 + tuple2
print(tuple3)
#output:('a', 'b', 'c', 1, 2, 3)
#Multiply Tuples
#If you want to multiply the content of a tuple a given number of times, you can use the * operator:
fruits = ("apple", "banana", "cherry")
mytuple = fruits * 2
print(mytuple)
#output:('apple', 'banana', 'cherry', 'apple', 'banana', 'cherry')
#Tuple Methods
#Method	Description
#count()	Returns the number of times a specified value occurs in a tuple
#index()	Searches the tuple for a specified value and returns the position of where it was found
