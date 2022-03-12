#Lists are used to store multiple items in a single variable
#List items are ordered, changeable, and allow duplicate values
#List items are indexed, the first item has index [0], the second item has index [1] etc
#1.Access Items
#List items are indexed and you can access them by referring to the index number:
thislist = ["apple", "banana", "cherry"]
print(thislist[1])
#output:banana
#Note: The first item has index 0
#Negative Indexing
#Negative indexing means start from the end
#-1 refers to the last item, -2 refers to the second last item etc.
thislist = ["apple", "banana", "cherry"]
print(thislist[-1])
#output:cherry
#Range of Indexes
#You can specify a range of indexes by specifying where to start and where to end the range.
#When specifying a range, the return value will be a new list with the specified items.
thislist = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]
print(thislist[2:5])
#output:['cherry', 'orange', 'kiwi']
#Note: The search will start at index 2 (included) and end at index 5 (not included)
#By leaving out the start value, the range will start at the first item:
thislist = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]
print(thislist[:4])
#output:['apple', 'banana', 'cherry', 'orange']
#By leaving out the end value, the range will go on to the end of the list:
thislist = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]
print(thislist[2:])
#output:['cherry', 'orange', 'kiwi', 'melon', 'mango']
#2.Change Item Value
#To change the value of a specific item, refer to the index number:
thislist = ["apple", "banana", "cherry"]
thislist[1] = "blackcurrant"
print(thislist)
#output:['apple', 'blackcurrant', 'cherry']
#Change a Range of Item Values
#To change the value of items within a specific range, define a list with the new values, and refer to the range of index numbers where you want to insert the new values:
thislist = ["apple", "banana", "cherry", "orange", "kiwi", "mango"]
thislist[1:3] = ["blackcurrant", "watermelon"]
print(thislist)
#output:['apple', 'blackcurrant', 'watermelon', 'orange', 'kiwi', 'mango']
#2a.Insert Items
#To insert a new list item, without replacing any of the existing values, we can use the insert() method.
#The insert() method inserts an item at the specified index:
thislist = ["apple", "banana", "cherry"]
thislist.insert(2, "watermelon")
print(thislist)
#output:['apple', 'banana', 'watermelon', 'cherry']
#3.Append Items
#To add an item to the end of the list, use the append() method:
thislist = ["apple", "banana", "cherry"]
thislist.append("orange")
print(thislist)
#output:['apple', 'banana', 'cherry', 'orange']
#Extend List
#To append elements from another list to the current list, use the extend() method.
thislist = ["apple", "banana", "cherry"]
tropical = ["mango", "pineapple", "papaya"]
thislist.extend(tropical)
print(thislist)
#output:['apple', 'banana', 'cherry', 'mango', 'pineapple', 'papaya']
#Add Any Iterable
#The extend() method does not have to append lists, you can add any iterable object (tuples, sets, dictionaries etc.).
thislist = ["apple", "banana", "cherry"]
thistuple = ("kiwi", "orange")
thislist.extend(thistuple)
print(thislist)
#output:['apple', 'banana', 'cherry', 'kiwi', 'orange']
#4.Remove Specified Item
#The remove() method removes the specified item.
thislist = ["apple", "banana", "cherry"]
thislist.remove("banana")
print(thislist)
#output:['apple', 'cherry']
#Remove Specified Index
#The pop() method removes the specified index
thislist = ["apple", "banana", "cherry"]
thislist.pop(1)
print(thislist)
#output:['apple', 'cherry']
#If you do not specify the index, the pop() method removes the last item.
thislist = ["apple", "banana", "cherry"]
thislist.pop()
print(thislist)
#output:['apple', 'banana']
#The del keyword also removes the specified index:
thislist = ["apple", "banana", "cherry"]
del thislist[0]
print(thislist)
#output:['banana', 'cherry']
#The del keyword can also delete the list completely.
thislist = ["apple", "banana", "cherry"]
del thislist
#output:NameError: name 'thislist' is not defined
#Clear the List
#The clear() method empties the list.
#The list still remains, but it has no content.
thislist = ["apple", "banana", "cherry"]
thislist.clear()
print(thislist)
#output:[]
#5.Loop Through a List
#You can loop through the list items by using a for loop:
thislist = ["apple", "banana", "cherry"]

------------------------
for x in thislist:
  print(x)
'''output:apple
          banana
          cherry'''
#Sort List Alphanumerically
#List objects have a sort() method that will sort the list alphanumerically, ascending, by default
thislist = ["orange", "mango", "kiwi", "pineapple", "banana"]
thislist.sort()
print(thislist)
#output:['banana', 'kiwi', 'mango', 'orange', 'pineapple']
thislist = [100, 50, 65, 82, 23]
thislist.sort()
print(thislist)
#output:[23, 50, 65, 82, 100]
#6.Sort Descending
#To sort descending, use the keyword argument reverse = True:
thislist = ["orange", "mango", "kiwi", "pineapple", "banana"]
thislist.sort(reverse = True)
print(thislist)
#output:['pineapple', 'orange', 'mango', 'kiwi', 'banana']
#7.Copy a List
#You cannot copy a list simply by typing list2 = list1, because: list2 will only be a reference to list1, and changes made in list1 will automatically also be made in list2.
#There are ways to make a copy, one way is to use the built-in List method copy().
thislist = ["apple", "banana", "cherry"]
mylist = thislist.copy()
print(mylist)
#output:['apple', 'banana', 'cherry']
#Another way to make a copy is to use the built-in method list().
thislist = ["apple", "banana", "cherry"]
mylist = list(thislist)
print(mylist)
#output:['apple', 'banana', 'cherry']
#8.Join Two Lists
#There are several ways to join, or concatenate, two or more lists in Python.
#One of the easiest ways are by using the + operator.
list1 = ["a", "b", "c"]
list2 = [1, 2, 3]

list3 = list1 + list2
print(list3)
#output:['a', 'b', 'c', 1, 2, 3]
#Another way to join two lists is by appending all the items from list2 into list1, one by one:
list1 = ["a", "b" , "c"]
list2 = [1, 2, 3]
for x in list2:
  list1.append(x)
print(list1)
#output:['a', 'b', 'c', 1, 2, 3]
#Or you can use the extend() method, which purpose is to add elements from one list to another list:
list1 = ["a", "b" , "c"]
list2 = [1, 2, 3]
list1.extend(list2)
print(list1)
#output:['a', 'b', 'c', 1, 2, 3]
#List Comprehension
#List comprehension offers a shorter syntax when you want to create a new list based on the values of an existing list.
#Without list comprehension you will have to write a for statement with a conditional test inside:
fruits = ["apple", "banana", "cherry", "kiwi", "mango"]
newlist = []
for x in fruits:
  if "a" in x:
    newlist.append(x)
print(newlist)
#output:['apple', 'banana', 'mango']
#With list comprehension you can do all that with only one line of code:
fruits = ["apple", "banana", "cherry", "kiwi", "mango"]
newlist = [x for x in fruits if "a" in x]
print(newlist)
#output:['apple', 'banana', 'mango']
#Syntax
#newlist = [expression for item in iterable if condition == True]
#The return value is a new list, leaving the old list unchanged.
#Condition
#The condition is like a filter that only accepts the items that valuate to True
fruits = ["apple", "banana", "cherry", "kiwi", "mango"]
newlist = [x for x in fruits if x != "apple"]
print(newlist)

Assignment 1 - how to acheive it via for loop

#output:['banana', 'cherry', 'kiwi', 'mango']
#The condition if x != "apple"  will return True for all elements other than "apple", making the new list contain all fruits except "apple".
#The condition is optional and can be omitted:
fruits = ["apple", "banana", "cherry", "kiwi", "mango"]
newlist = [x for x in fruits]
print(newlist)
Assignment : how to achieve via for loop 

#output:['apple', 'banana', 'cherry', 'kiwi', 'mango']
#List Methods:
#Method	Description
#append()	Adds an element at the end of the list
#clear()	Removes all the elements from the list
#copy()	    Returns a copy of the list
#count()	Returns the number of elements with the specified value
#extend()	Add the elements of a list (or any iterable), to the end of the current list
#index()	Returns the index of the first element with the specified value
#insert()	Adds an element at the specified position
#pop()	    Removes the element at the specified position
#remove()	Removes the item with the specified value
#reverse()	Reverses the order of the list
#sort()	    Sorts the list
List.py
Displaying List.py.