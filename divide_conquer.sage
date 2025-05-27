import random 
from itertools import combinations

def is_level_0(CM):
    """
    input: CM : Coxeter matrix
    output: bool

    Takes as input a Coxeter matrix representing a coxeter graph and returns True if the graph is level 0, False otherwise.

    Check if the bilinear form has no negative eigenvalues 
    """
    return CM.is_finite() or CM.is_affine() #or is_repr_affine(CM)


def delete_bridge(CM):
    """
    Input: Coxeter matrix
    output: list of submatrices of the initial Coxeter matrix 

    Takes a matrix and returns a list of matrices (representing coxeter graphs) obtained after removing all possible bridges.
    """
    n = Matrix(CM).nrows()

    CG = CM.coxeter_graph()
    bridges = CG.bridges()
    