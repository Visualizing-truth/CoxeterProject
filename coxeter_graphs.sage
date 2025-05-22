import time



def is_level_0(CM):
    """
    input: CM : Coxeter matrix
    output: bool

    Takes as input a Coxeter matrix representing a coxeter graph and returns True if the graph is level 0, False otherwise.
    """
    return CM.is_finite() or CM.is_affine()



def delete_nodes(CM, a):
    """
    Input: Coxeter matrix
    output: list of submatrices of the intital Coxeter matrices 

    Takes a matrix and a>0 as input and returns a list of matrices (representing coxeter graphs) obtained after removing all possible combination of a nodes.
    """
    n = Matrix(CM).nrows()
    C = Combinations(range(n), a)
    ls = []
    for comb in C.list():
        actual = [i for i in range(n) if i not in comb]
        submat = Matrix(CM)[actual, actual]
        ls.append(CoxeterMatrix(submat))
    return ls

def delete_node_with_max_weighted_degree(CM):
    n = len(CM.index_set())
    M = Matrix(CM)
    max_row_sum = -1
    node_to_remove = -1
    for i in range(n):
        row_sum = sum(M[i, j] for j in range(n))
        if row_sum > max_row_sum:
            max_row_sum = row_sum
            node_to_remove = i
    actual = [k for k in range(n) if k != node_to_remove]
    submat = M[actual, actual]
    return CoxeterMatrix(submat)


def get_level(CM):
    """
    input: Coxeter matrix
    output: int

    Takes as input a Coxeter matrix and returns the level of the coxeter graph represented by that matrix.
    """
    n = len(CM.index_set())
    if is_level_0(CM):
        return 0
    else:
        current_CM = CM
        for i in range(1, n-1):
            current_CM = delete_node_with_max_weighted_degree(current_CM)
            if is_level_0(current_CM):
                return i
    return n-1
    

def check_level(CM):
    """
    input: G:square matrix (symmetric matrix with diagnol values 1)
    output: int

    Takes as input a matrix representing a coxeter graph and returns the levl of that coxeter graph.

    """
    n = len(CM.index_set())
    if is_level_0(CM):
        return 0
    else:
        for i in range(1, n-1):
            list = delete_nodes(CM, i)
            if all(is_level_0(coxeter_matrix) for coxeter_matrix in list):
                return i

def main():

    G1 = CoxeterType(['A', 4])
    A1 = G1.coxeter_matrix()

    G2 = CoxeterType(['A', 4, 1])
    A2 = G2.coxeter_matrix()

    M = CoxeterMatrix([
    [1, 6, 2, 2],
    [6, 1, 3, 2],
    [2, 3, 1, 4],
    [2, 2, 4, 1],
])

    K = CoxeterMatrix( [
    [1, 6, 2],
    [6, 1, 3],
    [2, 3, 1],
   
])
    
    M1 = CoxeterMatrix([ 
        [1, 4, 2, 2, 4],
        [4, 1, 3, 2, 2],
        [2, 3, 1, 2, 2],
        [2, 2, 2, 1, 4],
        [4, 2, 2, 4, 1]
    ])

    M3 = CoxeterMatrix([
    [1, 3, 3, 3, 3, 3],
    [3, 1, 3, 3, 3, 3],
    [3, 3, 1, 3, 3, 3],
    [3, 3, 3, 1, 3, 3],
    [3, 3, 3, 3, 1, 3],
    [3, 3, 3, 3, 3, 1]
])
    print("__________________________________")
    start = time.time()
    level1 = check_level(M3)
    delta1 = time.time() - start
    print("Level of the graph with check_level : ", level1, " Time taken: ", delta1)
    start = time.time()
    level2 = get_level(M3)
    delta2 = time.time() - start
    print("Level of the graph with get level : ", level2, " Time taken: ", delta2)
    print("The fastest method is: ", "check_level" if delta1 < delta2 else "get_level")
    print("__________________________________")


main()