import time
import os

def is_repr_affine(CM):
    """
    Return whether the coxeter graph represented by ``self`` is affine.
    A coxeter graph is affine if the bilinear form associated with the coxeter matrix has no negative eigenvalues.

    EXAMPLES::
        sage: CoxeterMatrix([[1, 2], [2, 1]]).is_repr_affine()
        True
        sage: CoxeterMatrix([[1, 2, 2], [2, 1, 3], [2, 3, 1]]).is_repr_affine()
        False
    """
    bilinear_form = CM.bilinear_form()
    eigenvalues = bilinear_form.eigenvalues()
    return all(eigenvalue >= 0 for eigenvalue in eigenvalues)


def is_level_0(CM):
    """
    Return whether the coxeter graph represented by ``self`` is level 0.

    A coxeter graph is level 0 if it is finite or affine, which means that the bilinear form associated with the coxeter matrix has no negative eigenvalues.

    EXAMPLES::
        sage: CoxeterMatrix([[1, 2], [2, 1]]).is_level_0()
        True
        sage: CoxeterMatrix([[1, 2, 2], [2, 1, 3], [2, 3, 1]]).is_level_0()
        False

    """
    return CM.is_finite() or CM.is_affine() #or (is_repr_affine(CM)) valid only if there is no cycle



def delete_nodes(CM, a):
    """
    Yield the combinations of submatrices made by deleting ``a`` nodes from the coxeter graph represented by ``self``.

    INPUT:
    - ``a`` -- number of nodes to delete from the coxeter matrix

    OUTPUT:
    - All combinations of submatrices obtained by deleting ``a`` nodes from the coxeter graph represented by ``self``.
    
    EXAMPLES::
        sage: M = CoxeterMatrix([[1, 2, 3], [2, 1, 4], [3, 4, 1]])
        sage: subgraphs = list(delete_nodes(M, 1))
        [1, 2]  [1, 3]  [1, 4]
        [2, 1], [3, 1], [4, 1] 
    """
    
    n = Matrix(CM).nrows()
    C = Combinations(range(n), a)
    m = CM._matrix_()

    for comb in C:
        actual = [i for i in range(n) if i not in comb] # look at filter
        submat = m[actual, actual]
        yield CoxeterMatrix(submat)

    

def level(CM):
    """
    Return the level of the coxeter graph represented by ``self``.
    
    If the level of the current coxeter graph is 0, the function returns 0. 
    Otherwise, it removes a node from the graph until all possible subgraphs are level 0, and returns the number of nodes removed.


    EXAMPLES::
        sage: M = CoxeterMatrix([[1, 2, 3], [2, 1, 4], [3, 4, 1]])
        sage: get_level(M)
        1
        sage: M2 = CoxeterMatrix([[1, 2, 3, 4], [2, 1, 5, 6], [3, 5, 1, 7], [4, 6, 7, 1]])
        sage: get_level(M2)
        2
    
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
    level = check_level(CM)
    subgraphs = delete_nodes(CM, level)
    if all(graph.is_finite() for graph in subgraphs):
        return True
    return False

def showGraph(g, words):
    """
    input: coxeter graph, string
    output: Null

    Takes a coxeter graph and saves its image in the current folder with num in the name of the png file.
    """
    plot = g.plot(edge_labels=True)
    plot.save(f"graphImage_{words}.png")
