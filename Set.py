#Sets are used to store multiple items in a single variable.
#A set is a collection which is both unordered and unindexed.
#Sets are written with curly brackets.
tripler_set = {"apple", "banana", "cherry"}
print(tripler_set)
#output:{'apple', 'cherry', 'banana'}
#Note: Sets are unordered, so you cannot be sure in which order the items will appear
#Set Items
#Set items are unordered, unchangeable, and do not allow duplicate values.
#Access Items
#You cannot access items in a set by referring to an index or a key.
#But you can loop through the set items using a for loop, or ask if a specified value is present in a set, by using the in keyword.
tripler_set = {"apple", "banana", "cherry"}
for x in tripler_set:
  print(x)
'''output:cherry
          apple
          banana'''
#Change Items
#Once a set is created, you cannot change its items, but you can add new items.
#Add Items
#Once a set is created, you cannot change its items, but you can add new items.
#To add one item to a set use the add() method.
tripler_set = {"apple", "banana", "cherry"}
tripler_set.add("orange")
print(tripler_set)
#output:{'banana', 'cherry', 'apple', 'orange'}
#Add Sets
#To add items from another set into the current set, use the update() method.
tripler_set = {"apple", "banana", "cherry"}
tropical = {"pineapple", "mango", "papaya"}
tripler_set.update(tropical)
print(tripler_set)
#output:{'apple', 'mango', 'cherry', 'pineapple', 'banana', 'papaya'}
#Add Any Iterable
#The object in the update() method does not have to be a set, it can be any iterable object (tuples, lists, dictionaries etc.).
tripler_set = {"apple", "banana", "cherry"}
mylist = ["kiwi", "orange"]
tripler_set.update(mylist)
print(tripler_set)
#output:{'banana', 'cherry', 'apple', 'orange', 'kiwi'}
#Remove Item
#To remove an item in a set, use the remove(), or the discard() method.
tripler_set = {"apple", "banana", "cherry"}
tripler_set.remove("banana")
print(tripler_set)
#output:{'cherry', 'apple'}
#Note: If the item to remove does not exist, remove() will raise an error.
tripler_set = {"apple", "banana", "cherry"}
tripler_set.discard("banana")
print(tripler_set)
#output:{'cherry', 'apple'}
#Note: If the item to remove does not exist, discard() will NOT raise an error.
#You can also use the pop() method to remove an item, but this method will remove the last item. Remember that sets are unordered, so you will not know what item that gets removed.
#The return value of the pop() method is the removed item.
tripler_set = {"apple", "banana", "cherry"}
x = tripler_set.pop()
print(x) #removed item
print(tripler_set) #the set after removal
'''output:banana
          {'apple', 'cherry'}'''
#The clear() method empties the set
tripler_set = {"apple", "banana", "cherry"}
tripler_set.clear()
print(tripler_set)
#output:set()
#The del keyword will delete the set completely
tripler_set = {"apple", "banana", "cherry"}
del tripler_set
print(tripler_set)
#output:NameError: name 'tripler_set' is not defined
#Loop Items
#You can loop through the set items by using a for loop:
tripler_set = {"apple", "banana", "cherry"}
for x in tripler_set:
  print(x)
'''output:banana
          cherry
          apple'''
#Join Two Sets
#There are several ways to join two or more sets in Python.
#You can use the union() method that returns a new set containing all items from both sets, or the update() method that inserts all the items from one set into another:
#The union() method returns a new set with all items from both sets
set1 = {"a", "b" , "c"}
set2 = {1, 2, 3}
set3 = set1.union(set2)
print(set3)
#output:{'b', 3, 2, 'c', 'a', 1}
#The update() method inserts the items in set2 into set1
set1 = {"a", "b" , "c"}
set2 = {1, 2, 3}
set1.update(set2)
print(set1)
#output:{3, 2, 1, 'a', 'c', 'b'}
#Note: Both union() and update() will exclude any duplicate items.
#Keep ONLY the Duplicates
#The intersection_update() method will keep only the items that are present in both sets
x = {"apple", "banana", "cherry"}
y = {"google", "microsoft", "apple"}
x.intersection_update(y)
print(x)
#output:{'apple'}
#The intersection() method will return a new set, that only contains the items that are present in both sets
#Keep All, But NOT the Duplicates
#The symmetric_difference_update() method will keep only the elements that are NOT present in both sets.
x = {"apple", "banana", "cherry"}
y = {"google", "microsoft", "apple"}
x.symmetric_difference_update(y)
print(x)
#output:{'google', 'banana', 'microsoft', 'cherry'}
#Set Methods
#Method	Description
#add()	                        Adds an element to the set
#clear()	                    Removes all the elements from the set
#copy()	                        Returns a copy of the set
#difference()	                Returns a set containing the difference between two or more sets
#difference_update()	        Removes the items in this set that are also included in another, specified set
#discard()	                    Remove the specified item
#intersection()	                Returns a set, that is the intersection of two other sets
#intersection_update()	        Removes the items in this set that are not present in other, specified set(s)
#isdisjoint()	                Returns whether two sets have a intersection or not
#issubset()	                    Returns whether another set contains this set or not
#issuperset()	                Returns whether this set contains another set or not
#pop()	                        Removes an element from the set
#remove()	                    Removes the specified element
#symmetric_difference()	        Returns a set with the symmetric differences of two sets
#symmetric_difference_update()	inserts the symmetric differences from this set and another
#union()	                    Return a set containing the union of sets
#update()	                    Update the set with the union of this set and others