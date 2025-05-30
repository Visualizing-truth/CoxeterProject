import networkx as nx

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

def articulation_points(CM):

    CG = CM.coxeter_graph()

    nxG = CG.networkx_graph()
    return list(nx.articulation_points(nxG))

    
