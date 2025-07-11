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

    for comb in C:
        actual = [i for i in range(n) if i not in comb] # look at filter
        submat = Matrix(CM)[actual, actual]
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
    

def check_level(CM):
    """
    input: G:square matrix (symmetric matrix with diagnol values 1)
    output: int

    Takes as input a matrix representing a coxeter graph and returns the levl of that coxeter graph.

    Explain in which case we go in the loop    
    """
    CM = CM.coxeter_matrix()
    n = len(CM.index_set())
    if is_level_0(CM):
        return 0
    else:
        for i in range(1, n):
            subgraphs = delete_nodes(CM, i)
            if all(is_level_0(coxeter_matrix) for coxeter_matrix in subgraphs):
                return i

