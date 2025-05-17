load("lvl_0_graphs.sage")
load("coxeter_graphs.sage")

    
#Test matrices to verify the isomorphism  :
ATest = Graph(Matrix([
    [0, 0, 1, 0],
    [0, 0, 1, 1],
    [1, 1, 0, 0],
    [0, 1, 0, 0]
]))

BTest = Graph(Matrix([
    [0, 1, 0, 0],
    [1, 0, 1, 0],
    [0, 1, 0, 4],
    [0, 0, 4, 0]
]))

DTest = Graph(Matrix([
    [0, 1, 0, 0, 0],
    [1, 0, 1, 0, 0],
    [0, 1, 0, 1, 1],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0]
]))

ETest = Graph(Matrix([
    [0, 1, 0, 0, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 0, 1],
    [0, 0, 0, 0, 0, 0, 1, 0],
]))

HTest = Graph(Matrix([
    [0, 1, 0, 0],
    [1, 0, 1, 0],
    [0, 1, 0, 5],
    [0, 0, 5, 0]
]))
ITest = Graph(Matrix([
    [0, 5],
    [5, 0]
]))


is_finite_lvl0(ATest)
is_finite_lvl0(BTest)
is_finite_lvl0(DTest)
is_finite_lvl0(ETest)
is_finite_lvl0(HTest)
is_finite_lvl0(ITest)
