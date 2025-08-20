
load("posetClass.py")
load("coxeter_graphs.sage")
load("poset_algorithms.sage")
import time

def order(p1, p2):
    # Strict order: never return True for equal elements
    if p1 == p2:
        return False
    r1 = p1.rank
    r2 = p2.rank
    
    g1 = p1.coxeter_graph
    g2 = p2.coxeter_graph

    m1 = p1.coxeter_matrix
    m2 = p2.coxeter_matrix
    if initial_checks(g1, g2):
        return relation_exists(m1, m2)
    return initial_checks(g1, g2)

def initial_checks(g1, g2):
    """
    This function performs initial checks. It assumes that get_rank(g2) is larger than get_rank(g1)
    If False then we know that the relation doesn't exist.
    if True then we know then we can move forward with 
    relation_exists.
    """
    
    if max(g1.edge_labels()) > max(g2.edge_labels()):
        return False

    diff_vert=len(g2.vertices())-len(g1.vertices())
    if diff_vert < 0:
        return False
    return True

def relation_exists(m1, m2):
    """
    Checks whether a Coxeter matrix `m1` dominates another matrix `m2` 
    under a poset-like deletion order.

    This function assumes that the rank of m2 is greater than rank of m1 and that
    m2 has more nodes than m1 because otherwise relation doesn't exist. (All
    this should be taken care by the initial_checks function)
    Which can be interpretated as a sum of all the edge labels in the upper
    matrix leaving the diagnol.

    Parameters:
        m1 (Matrix): A Sage matrix representing a Coxeter matrix with more or equal nodes.
        m2 (Matrix): A smaller or equal-size Coxeter matrix.

    Returns:
        bool: True if a submatrix of m1 is greater than or equal to m2 entrywise; False otherwise.

    Example:
        sage: a4 = CoxeterType(['A', 4]).coxeter_matrix()._matrix_()
        sage: d5 = CoxeterType(['D', 5]).coxeter_matrix()._matrix_()
        sage: relation_exists(d5, a4)
        True
    """
    diff_nodes = m2.ncols()-m1.ncols()
    n1 = m1.ncols()
    M1 = CoxeterMatrix(m1)
    M2 = CoxeterMatrix(m2)
    leq=False
    done=False

    potential_matrices=delete_nodes(M2, diff_nodes)
    while not leq and not done:
        try:
            P = next(potential_matrices)
            contradiction=False
            p = P._matrix_()
            for i in range(n1):# itertools combinations
                for j in range(i, n1):
                    if m1[i, j] > p[i, j]:
                        contradiction=True
                        break
                if contradiction:
                    break
            if not contradiction:
                # This means that the both loops ended successfully
                leq=True
        except StopIteration:
            # Stop iterating, ran out of delete_nodes
            done=True
    return leq


a2 = CoxeterType(['A', 2])
root = poset_graph(a2.coxeter_graph(), coxeter_matrix_from_graph(a2.coxeter_graph()))

def get_vertices(root, rank):
    """
    [root] is of rank 1. rank has to be greater than or equal to 1
    """
    prev_rank = [root]
    vertices=rank_1
    for i in range(rank):
        rank_i = make_unique(get_next_gen(prev_rank))
        prev_rank=rank_i

def filter_min_level(ls, lvl):
    """
    ls --> list
    lvl --> integer
    Given a list of poset_graphs, this function filters the list so that
    only the poset_graphs with level == lvl and they are the minimal graphs
    of that level (i.e the level of their parents is less than their level). 
    """
    for g in ls:
        if level(CoxeterMatrix(g.coxeter_matrix))==lvl:
            if any(level(CoxeterMatrix(p.coxeter_matrix))<lvl for p in g.parents):
                    yield g

def filter_level(ls, lvl):
    """
    Given a list of poset_graphs, this function filters the list so that
    only the poset_graphs with level == lvl are remaining.
    """
    for g in ls:
        G = CoxeterMatrix(g.coxeter_matrix)
        if level(G)==lvl:
            yield g
def filter_level_leq(ls, lvl, strict):
    """
    Given a list of poset_graphs, this function filters the list so that
    only the poset_graphs with level <= lvl are remaining.
    """
    for g in ls:
        G = CoxeterMatrix(g.coxeter_matrix)
        lvl_g = level(G)
        if strict: 
            if lvl_g<lvl:
                yield g
        else:
            if lvl_g<=lvl:
                yield g
def create_graphs(ls_of_poset_graphs):   
    graphs = []
    for p in ls_of_poset_graphs:
        graphs.append(p.coxeter_graph)
    return graphs

def get_subgraphs(p):
    """
    Given a poset_graph generate its subgraphs.
    By decreasing labels or by deleting a single node.
    When you delete a node make sure the subgraph you obtain is
    connected.
    """
    g=p.coxeter_graph
    m=p.coxeter_matrix

    for k in remove_isomorphic_graphs(remove_vertices(g, 1)):
        if k.is_connected():
            rank_k = get_rank(k)
            if rank_k == p.rank-1:
                m1 = coxeter_matrix_from_graph(k)
                m = poset_graph(k,m1)
                yield m
    for l in decrease_labels(g):
        n1 = coxeter_matrix_from_graph(l)
        n = poset_graph(l, n1)
        yield n
rank_2 = get_next_gen([root])
rank_3 = make_unique(get_next_gen(rank_2))
rank_4 = make_unique(get_next_gen(rank_3))


def create_svg(graph_string):
    with open("poset.dot", "w") as f:
        f.write(graph_string)

def main():
    create_svg(p.graphviz_string())


def get_all_level(first_generators, start_rank, max_rank, minimal, lvl=1):
    """
        Works well for level 1 and 2. first_generators only has
        CG of level < lvl. All CG in first_generators
        have the same rank. 
        For full classifcation try to find the maximum dimension of CG
        of a certain level, that'll be its max_rank.
        let minimal be True when generating for minimal classification. Note
        that this does not generate all the minimal graphs. To generate all the minimal
        graphs take this and also 
    """

    rank=start_rank
    generators = first_generators
    st = time.time()
    while rank <= max_rank:
        print("generating new rank!")
        next_gen = make_unique(get_next_gen(generators))
        print(f"{rank} rank generated!")
        for g in filter_level(next_gen, lvl):
            yield g
        if rank != max_rank:
            generators = filter_level_leq(next_gen, lvl, minimal)
        rank+=1
    tt = time.time() - st
    print(f"Total time taken: {tt}")

def filter_nodes(ls_of_graphs, num_nodes):
    for p in ls_of_graphs:
        if len(p.coxeter_graph.vertices()) >= num_nodes:
            yield p

def filter_minimal(ls_of_lvl, lvl=1):
    for g in ls_of_lvl:
        contradiction = False
        for p in get_subgraphs(g):
            if level(CoxeterMatrix(p.coxeter_matrix)) >= lvl:
                contradiction = True
        if not contradiction:
            yield g
        
def better_filter_minimal(ls_of_lvl, lvl):
    """
        This funciton assumes that ls_of_lvl has all the graphs of the specifield `lvl`
    """
    for g in ls_of_lvl:
        contradiction = False
        print("Entering the lower covers loop")
        for p in g.parents:
            if level(CoxeterMatrix(p.coxeter_matrix)) >= lvl:
                contradiction = True
        print("lower covers loop ended")
        if not contradiction:
            yield g
def filter_proposition(ls_of_lvl, lvl=2):
    for g in ls_of_lvl:
        if all(level(CoxeterMatrix(p.coxeter_matrix))<1 for p in g.parents):
            yield g



        
        




            



