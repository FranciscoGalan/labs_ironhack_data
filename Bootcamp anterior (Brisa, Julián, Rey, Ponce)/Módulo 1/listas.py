#empty list
[]
list()

[1,2,3]
[x+5 for x in [2,3,4]]
list((1,3,5,7,9))
list('hola')

a = [1,2,1,3]
a.append(13)
a

a.count(1)

a.extend([5,7])
a

a.index(13)

a.insert(0, 17)

a
a.pop()
a
a.pop(3)
a
a.remove(17)

a
a.reverse()
a
a.clear()

new_list = [expression for_loop_one_or_more conditions]

numbers = [1, 2, 3, 4]
squares = []

for n in numbers:
  squares.append(n**2)

print(squares)
#Finding squares using list comprehensions:
numbers = [1, 2, 3, 4]
squares = [n**2 for n in numbers]

print(squares)

#Using conditions in list comprehensions
list_a = [1, 2, 3, 4]
list_b = [2, 3, 4, 5]

common_num = []

for a in list_a:
    for b in list_b:
        if a == b:
            common_num.append(a)

print(common_num)  # Output [2, 3, 4]

#Find common numbers from two list using list comprehension:
list_a = [1, 2, 3, 4]
list_b = [2, 3, 4, 5]

common_num = [a for a in list_a for b in list_b if a == b]

print(common_num) # Output: [2, 3, 4]


#Return numbers from the list which are not equal as a tuple:

list_a = [1, 2, 3]
list_b = [2, 7]

different_num = [(a, b) for a in list_a for b in list_b if a != b]

print(different_num) # Output: [(1, 2), (1, 7), (2, 7), (3, 2), (3, 7)]

#over string

list_a = ["Hello", "World", "In", "Python"]

small_list_a = [str.lower() for str in list_a]

print(small_list_a) # Output: ['hello', 'world', 'in', 'python']

#list comprehensions can be used to produce a list of a list, as shown below
list_a = [1, 2, 3]

square_cube_list = [ [a**2, a**3] for a in list_a]

print(square_cube_list) # Output: [[1, 1], [4, 8], [9, 27]]

