def is_finite_lvl0(G):
    """
    Check if the graph G is a level 0 Coxeter graph.
    """
    # Check if the graph is connected
    if not G.is_connected():
        return False
    
    for name, graph in globals().items():
        if isinstance(graph, Graph):
            if G.is_isomorphic(graph):
                print(f"The graph is isomorphic to {name}")
                return True
    return False


def create_cartan_matrix(G):
    """
    Create a Cartan Matrix (n x n) from a graph G.
    """
    # Get the number of vertices
    n = G.num_verts()
    
    # Initialize the Cartan matrix
    cartan_matrix = Matrix(ZZ, n, n)
    
    # Fill the Cartan matrix based on the edges of the graph
    for i in range(n):
        for j in range(n):
            if G.has_edge(i, j):
                cartan_matrix[i, j] = 2
            else:
                cartan_matrix[i, j] = 0
    
    return cartan_matrix