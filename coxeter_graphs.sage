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