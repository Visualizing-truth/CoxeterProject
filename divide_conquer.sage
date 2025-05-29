import random
import networkx as nx

load ("test_case.sage")

def copy(CM):
    return CoxeterMatrix(CM)

def len(CM):
    return CM._matrix.nrows()

def get_matrix(CM):
    return CM._matrix

def to_coxeter_matrix(CG):
    n = CG.order()

    mat = Matrix(IntegerRing(), n, n)

    for i in range(n):
        for j in range(i + 1, n):
            if i == j:
                mat[i, j] = 1
            else: 
                mat[i, j] = CG.edge_weight(i, j)
                mat[j, i] = CG.edge_weight(i, j)

    return CoxeterMatrix(mat)


def is_level_0(CM):
    """
    input: CM : Coxeter matrix
    output: bool

    Takes as input a Coxeter matrix representing a coxeter graph and returns True if the graph is level 0, False otherwise.

    Check if the bilinear form has no negative eigenvalues 
    """
    return CM.is_finite() or CM.is_affine() #or is_repr_affine(CM)



def articulation_points(CM):

    CG = CM.coxeter_graph()

    nxG = CG.networkx_graph()
    return list(nx.articulation_points(nxG))

def delete_node(CM, articulation_points):

    if not articulation_points:
        print("No articulation points found.")
        return [CM]

    node = random.choice(articulation_points)

    indices = [i for i in range(len(CM)) if i != node]

    copy = copy(CM)
    submatrix = get_matrix(copy)[indices, indices]

    G = submatrix.coxeter_graph()
    connected_components = G.connected_components()

    result = []

    for component in connected_components:
        component = sorted(component)
        submat = M.submatrix(component,component)
        result.append(CoxeterMatrix(submat))
    
    return result


def divide(CM):
    return delete_node(CM, articulation_points(CM))


def get_level(CM):

    if is_level_0(CM):
        return 0
    
    subgraphs = divide(CM)

    level = [get_level(subgraph) for subgraph in subgraphs]

    return 1 + max(level)
    
    



def main():
    CM = CoxeterMatrix([
    [1, 3, 3, 2 ,2 ,2 ,2,2],
    [3, 1, 2, 2, 2, 3, 2,3],
    [3, 2, 1, 3, 2, 2, 3,3],
    [2, 2, 3, 1, 3, 2, 2,2],
    [2, 2, 2, 3, 1, 2, 2,2],
    [2, 3, 2, 2, 2, 1, 3,3],
    [2, 2, 3, 2, 2, 3, 1,3],
    [2, 3, 3, 2, 2, 3, 3, 1]
])

    print(delete_node(CM))


main()    

    
