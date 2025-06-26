import time
import os


def is_repr_affine(CM):
    bilinear_form = CM.bilinear_form()
    eigenvalues = bilinear_form.eigenvalues()



def is_level_0(CM):
    """
    input: CM : Coxeter matrix
    output: bool

    Takes as input a Coxeter matrix representing a coxeter graph and returns True if the graph is level 0, False otherwise.

    Check if the bilinear form has no negative eigenvalues 
    """
    return CM.is_finite() or CM.is_affine() #or is_repr_affine(CM)



def delete_nodes(CM, a):
    """
    Input: Coxeter matrix
    output: list of submatrices of the intital Coxeter matrices 

    Takes a matrix and a>0 as input and returns a list of matrices (representing coxeter graphs) obtained after removing all possible combination of a nodes.
    """
    
    n = Matrix(CM).nrows()
    C = Combinations(range(n), a)
    m = CM._matrix_()

    for comb in C:
        actual = [i for i in range(n) if i not in comb] # look at filter
        submat = m[actual, actual]
        yield CoxeterMatrix(submat)

# def delete_node_with_max_weighted_degree(CM):
#     n = len(CM.index_set())
#     M = Matrix(CM)
#     max_row_sum = -1
#     node_to_remove = -1
#     for i in range(n):
#         row_sum = sum(M[i, j] for j in range(n))
#         if row_sum > max_row_sum:
#             max_row_sum = row_sum
#             node_to_remove = i
#     actual = [k for k in range(n) if k != node_to_remove]
#     submat = M[actual, actual]
#     return CoxeterMatrix(submat)


# def get_level(CM):
#     """
#     input: Coxeter matrix
#     output: int

#     Takes as input a Coxeter matrix and returns the level of the coxeter graph represented by that matrix.
#     """
#     n = len(CM.index_set())
#     if is_level_0(CM):
#         return 0
#     else:
#         current_CM = CM
#         for i in range(1, n-1):
#             current_CM = delete_node_with_max_weighted_degree(current_CM)
#             if is_level_0(current_CM):
#                 return i
#     return n-1
    

def level(CM):
    """
    input: G:square matrix (symmetric matrix with diagnol values 1)
    output: int

    Takes as input a matrix representing a coxeter graph and returns the levl of that coxeter graph.

    Explain in which case we go in the loop

    
    """
    n = len(CM.index_set())
    if is_level_0(CM):
        return 0
    else:
        for i in range(1, n):
            subgraphs = delete_nodes(CM, i)
            if all(is_level_0(coxeter_matrix) for coxeter_matrix in subgraphs):
                return i

def is_strict(CM):
    """
    input: Coxeter Matrix and integer
    output: bool
    Takes as input the coxeter matrix, it calculates the level of the graph and then finally returns whether it is strict or not.
    Remark: this is a mroe general verison of .is_finite() method.
    """
    if CM.is_finite():
        return True
    if CM.is_affine():
        return False
    level = level(CM)
    subgraphs = delete_nodes(CM, level)
    if all(graph.is_finite() for graph in subgraphs):
        return True
    return False

def showGraph(g, num):
    """
    input: coxeter graph, integer
    output: Null

    Takes a coxeter graph and saves its image in the current folder with num in the name of the png file.
    """
    plot = g.plot(edge_labels=True)
    plot.save(f"graph{num}.png")

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

#     M3 = CoxeterMatrix([
#     [1, 3, 3, 3, 3, 3],
#     [3, 1, 3, 3, 3, 3],
#     [3, 3, 1, 3, 3, 3],
#     [3, 3, 3, 1, 3, 3],
#     [3, 3, 3, 3, 1, 3],
#     [3, 3, 3, 3, 3, 1]
# ])
    InfiniteGraph = CoxeterMatrix([
        [1, -2, 2, 2, 2],
        [-2, 1, 3, 2, 2],
        [2 , 3, 1 ,3 ,2],
        [2, 2, 3, 1 , -2],
        [2, 2, 2, -2, 1]
    ])

    load("test_case.sage")
    load("divide_conquer.sage")

    test = M3

    print("__________________________________")
    start = time.time()
    level1 = level(test)
    delta1 = time.time() - start
    print("Level of the graph with level : ", level1, " Time taken: ", delta1)

    print("__________________________________")
    start = time.time()
    level2 = get_level(test)
    delta2 = time.time() - start
    print("Level of the graph with get_level : ", level2, " Time taken: ", delta2)



    os.makedirs("graphs_image", exist_ok=True)
    test.coxeter_graph().plot().save(f"./graphs_image/{test.name}.png")


main()
