from classifcation import(
    level_bound,
    coxeter_matrix_from_graph,
    get_graph_key
)

def check_level(g):
    if not level_bound(coxeter_matrix_from_graph(g), -1, 5):
        return get_graph_key(g)
    return None