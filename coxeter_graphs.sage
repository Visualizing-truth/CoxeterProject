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

    #Get the adjacency matrix
    adjacency_matrix = G.adjacency_matrix()
    
    # Initialize the Cartan matrix
    cartan_matrix = Matrix(ZZ, n, n)
    
    # Fill the Cartan matrix based on the edges of the graph
    for i in range(n):
        for j in range(n):
            if i == j:
                cartan_matrix[i, j] = 2
            elif adjacency_matrix[i, j] != 0:
                cartan_matrix[i, j] = -adjacency_matrix[i, j]
            # else:
            #     cartan_matrix[i, j] = 0
    
    print(cartan_matrix)
    
    return cartan_matrix

def node_with_max_weighted_degree(G):
    weighted_degrees = G.degree(weighted=True)
    max_node = max(weighted_degrees, key=lambda x: x[1])[0]
    return max_node

def check_level(G, current_level):
    
    A = create_cartan_matrix(G)

    print(A.determinant())

    if A.determinant() == 0:
        print("The graph is a level 0 Coxeter graph and is affine")
        return current_level
    elif A.determinant() > 0:
        print("The graph is a level 0 Coxeter graph and is finite")
        return current_level
    elif A.determinant() < 0:
        print("The graph is not a level 0 Coxeter graph")
        current_level += 1

    G1 = G.copy()
    G1.delete_vertex(node_with_max_weighted_degree(G))

    subgraphs = G1.connected_components_subgraphs()
    for subgraph in subgraphs:
        check_level(subgraph, current_level)

    return current_level

def main():

    current_level = 0
    # Example usage
    G = Graph(Matrix([
        [0, 4, 2, 2],
        [4, 0, 3, 2],
        [2, 3, 0, 4],
        [2, 2, 4, 0]
    ]))

    current_level = check_level(G, current_level)

    print("Current level:", current_level)


main()

    



