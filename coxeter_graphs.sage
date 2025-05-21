

def is_level_0(CM):
    return CM.is_finite() or CM.is_affine()


def countHeavyEdges(CM):
    """
    Not used in current implementation
    """
    count = 0
    n = len(CM.index_set())
    for i in range(0, n-1):
        for j in range(i+1, n):
            if CM[i][j] >=4:
                count += 1

    return count

def delete_nodes(CM, a):
    """
    Input: square matrix (symmetric matrix with diagnol values 1), int
    output: list

    Takes a matrix and a>0 as input and returns a list of matrices (representing coxeter graphs) obtained after removing all possible combination of a nodes.
    """
    n = Matrix(CM).nrows()
    C = Combinations(range(n), a)
    ls = []
    for comb in C.list():
        actual = list(range(n))
        for i in comb:
            actual.remove(i)
        submat = Matrix(CM)[actual, actual]
        ls.append(CoxeterMatrix(submat))
    return ls
    

def check_level(CM):
    """
    input: G:square matrix (symmetric matrix with diagnol values 1)
    output: int

    Takes as input a matrix representing a coxeter graph and returns the levl of that coxeter graph.

    """
    n = len(CM.index_set())
    curLvl = 0
    if is_level_0(CM):
        print(CM, " Is level 0 ")
        return curLvl
    else:
        print("CM is not level 0")
        for i in range(1, n-1):
            # Now we remove curLvl nodes
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
    
    print("Level of the graph : ", check_level(M1))


main()