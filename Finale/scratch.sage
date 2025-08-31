import itertools


# Fuck you lists

def smart_label_covers(cg, edges, lvl):
    u_g = {}
    new_edges = list(edges)
    edges = list(edges)
    for edge in edges:
        u, v = edge
        h = copy(cg)
        if cg.has_edge(u, v):
            h.set_edge_label(u, v, cg.edge_label(u, v)+1)
        else:
            h.add_edge(u, v, 3) # label=3
        # if graph of higher level then remove the edge
        if not level_bound(coxeter_matrix_from_graph(h), lvl, -1):
            new_edges.remove(edge)
        else:
        # if not seen before and not of higher level. (this automatically implies level is as desired)
            key = get_graph_key(h)
            u_g[key]=tuple([h, new_edges])
    return u_g.values()

def all_level(minimal_graphs, lvl):
    collector={}
    for m in minimal_graphs:
        key = get_graph_key(m)
        colelctor[key]=m

    l_1 = {}
    for m in minimal_graphs:
        edges = Combinations(m.vertices(), 2).list()
        for g in smart_label_covers(m, edges, lvl):
            key=get_graph_key(g[0])
            l_1[key]=g
            collector[key]=g[0]

    l_i = l_1
    while len(l_i)!=0:
        l_ii = {}
        for p in l_i:
            for g in smart_label_covers(p[0], p[1], lvl):
                key=get_graph_key(g[0])
                l_ii[key]=g
                collector[key]=g[0]
        l_i = l_ii
    return collector

    

def together(A, lvl):
    """
    A: is a set of the form: {(g_1, edges_1), ... , (g_n, edges_n)}
    Returns a set of the same form as above.
    """
    new_A=[]
    for a in A:
        A_i = smart_label_covers(a[0], a[1], lvl)
        new_A += A_i
    return new_A

def chain(m, lvl):
    edges = Combinations(m.vertices(), 2)
    A = [(m, edges.tuple())]
    collector={get_graph_key(m): m}
    while len(A)!=0:
        new_A = together(A, lvl)
        for a in new_A:
            key = get_graph_key(a[0])
            collector[key]=a[0]
        A = new_A
    return collector
    
def level_classification(minimal_graphs, lvl):
    all = {}
    for m in minimal_graphs:
        for g in chain(m, lvl).values():
            key = get_graph_key(g)
            all[key]=g
    return all

            
    






                
        





            
            

        

