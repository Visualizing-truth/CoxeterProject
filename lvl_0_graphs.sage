# A-type graphs : Graphs of the form A_n where n>= 1

A2 = Graph(Matrix([
    [0, 1],
    [1,0]
]))
A3 = Graph(Matrix([
    [0, 1, 0],
    [1, 0, 1],
    [0, 1, 0]
]))
A4 = Graph(Matrix([
    [0, 1, 0, 0],
    [1, 0, 1, 0],
    [0, 1, 0, 1],
    [0, 0, 1, 0]
]))

# B-type graphs : Graphs of the form B_n where n>= 2
B2 = Graph(Matrix([
    [0, 4],
    [4, 0]
]))

B3 = Graph(Matrix([
    [0, 4, 0],
    [4, 0, 1],
    [0, 1, 0]
]))

B4 = Graph(Matrix([
    [0, 4, 0, 0],
    [4, 0, 1, 0],
    [0, 1, 0, 1],
    [0, 0, 1, 0]
]))

# D-type graphs : Graphs of the form D_n where n>= 4

D4 = Graph(Matrix([
    [0, 1, 0, 0],
    [1, 0, 1, 1],
    [0, 1, 0, 0], 
    [0, 1, 0, 0]
]))

D5 = Graph(Matrix([
    [0, 1, 0, 0, 0],
    [1, 0, 1, 1, 0],
    [0, 1, 0, 0, 0],
    [0, 1, 0, 0, 1],
    [0, 0, 0, 1, 0]
]))

# E-Type graphs : Graphs of the form E_6,7,8

E6 = Graph(Matrix([
    [0, 1, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 0],
    [0, 1, 0, 1, 1, 0],
    [0, 0, 1, 0, 0, 0],
    [0, 0, 1, 0, 0, 1],
    [0, 0, 0, 0, 1, 0]
]))

E7 = Graph(Matrix([
    [0, 1, 0, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 1, 1, 0, 0],
    [0, 0, 1, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 1, 0],
    [0, 0, 0, 0, 1, 0, 1],
    [0, 0, 0, 0, 0, 1, 0]
]))

E8 = Graph(Matrix([
    [0, 1, 0, 0, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 0, 0, 0],
    [0, 1, 0, 1, 1, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 1, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 0, 1],
    [0, 0, 0, 0, 0, 0, 1, 0],
]))

# F-Type graphs : Graphs of the form F_4

F4 = Graph(Matrix([
    [0, 1, 0, 0],
    [1, 0, 4, 0],
    [0, 4, 0, 1],
    [0, 0, 1, 0]
]))

# H-Type graphs : Graphs of the form H_3,4

H3 = Graph(Matrix([
    [0, 5, 0],
    [5, 0, 1],
    [0, 1, 0]
]))

H4 = Graph(Matrix([
    [0, 5, 0, 0],
    [5, 0, 1, 0],
    [0, 1, 0, 1],
    [0, 0, 1, 0]
]))

# I-Type graphs : Graphs of the form I_2(m)
I2_3 = Graph(Matrix([
    [0, 3],
    [3, 0]
]))

I2_4 = Graph(Matrix([
    [0, 4],
    [4, 0]
]))

I2_5 = Graph(Matrix([
    [0, 5],
    [5, 0]
]))
