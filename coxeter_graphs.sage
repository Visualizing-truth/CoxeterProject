
def is_lvl0(A):
    """
    Input:  square matrix (symmetric matrix with diagnol values 1)
    Output: bool

    Takes in a square matrix representing a coxeter graph returns whether the level of graph is 0 or not.

    Test Cases:
    
    G1 = CoxeterType(['A', 4])
    A1 = G1.coxeter_matrix()
    is_lvl0(A1) --> True

    G2 = CoxeterType(['A', 4, 1])
    A2 = G2.coxeter_matrix()
    is_lvl0(A2) --> True

    """
    CG = CoxeterGroup(A)
    if CG.is_finite():
        return True
    A = CG.coxeter_matrix()
    B = A.bilinear_form()
    # For numeric answers
    B_cc = B.change_ring(CC)
    eigenvalues = B_cc.eigenvalues()
    
    is_affine = any(g==0 for g in eigenvalues) and all(g>=0 for g in eigenvalues)
    return is_affine




def countHeavyEdges(A):
    """
    Not used in current implementation
    """
    count = 0
    n = A.nrows
    for i in range(0, n-1):
        for j in range(i+1, n):
            if A[i][j] >=4:
                count += 1

    return count

def delete_nodes(G, a):
    """
    Input: square matrix (symmetric matrix with diagnol values 1), int
    output: list

    Takes a matrix and a>0 as input and returns a list of matrices (representing coxeter graphs) obtained after removing all possible combination of a nodes.
    """
    C = Combinations(range(n), a)
    n = G.nrows
    ls = []
    print(C.list())

    for comb in C.list():
        actual = list(range(n))

        for i in comb:
            actual.remove(i)

        ls.append(G[ actual, actual])
    print(len(ls))
    return ls
    

def check_level(G):
    """
    input: G:square matrix (symmetric matrix with diagnol values 1)
    output: int

    Takes as input a matrix representing a coxeter graph and returns the levl of that coxeter graph.

    """
    n = G.nrows
    curLvl = 0
    if is_lvl0(G):
        return curLvl
    else:
        while True:
            curLvl += 1
            # Now we remove curLvl nodes
            subgraphs = delete_nodes(G, curLvl, n)
            if all(is_lvl0(graph) for graph in subgraphs):
                return curLvl

def main():

    G1 = CoxeterType(['A', 4])
    A1 = G1.coxeter_matrix()

    G2 = CoxeterType(['A', 4, 1])
    A2 = G2.coxeter_matrix()

    M = matrix(ZZ, [
    [1, 6, 2, 2],
    [6, 1, 3, 2],
    [2, 3, 1, 4],
    [2, 2, 4, 1],
])

    K = matrix(ZZ, [
    [1, 6, 2],
    [6, 1, 3],
    [2, 3, 1],
   
])
    print(check_level(K))


main()
