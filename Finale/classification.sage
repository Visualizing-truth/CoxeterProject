import time
import itertools

# **** Functions for Coxeter Matrix ****
def is_level_0(CM):
    """
    Returns whether the coxeter graph represented by ``self`` is level 0.

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
    Yields the combinations of submatrices made by deleting ``a`` nodes from the coxeter graph represented by ``self``.

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
    Returns the level of the coxeter graph represented by ``self``.
    
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

def level_eq(CM, lvl):
    """
    Returns whether the given `lvl` is the level of the Coxeter Graph given by `CM`.
    If true then level(CM) = lvl otherwise, level(CM) != lvl
    """
    n = len(CM.index_set())
    leq = False
    geq = False
    if lvl == 0:
        return is_level_0(CM)
    sugraphs = delete_nodes(CM, lvl)
    leq = all(is_level_0(coxeter_matrix) for coxeter_matrix in subgraphs)
    print(leq)
    new_subgraphs = delete_nodes(CM, lvl-1)
    if any(not(is_level_0(cm)) for cm in new_subgraphs):
        geq = True
    return leq and geq

def level_bound(CM, leq_num, geq_num):
    """
    For any Coxeter graph, G,  with Coxeter matrix, `CM`, returns whether leq_num <= L(G) < geq_num.
    Here, `leq_num` is non-strict whereas `geq_num` is strict.
    """
    
    n = len(CM.index_set())

    leq=False
    geq=False


    if leq_num > 0:
        leq_subgraphs = delete_nodes(CM, leq_num)
        leq = all(is_level_0(coxeter_matrix) for coxeter_matrix in leq_subgraphs)
    if leq_num < 0:
        leq = True

    if geq_num > 0:
        geq_subgraphs = delete_nodes(CM, geq_num)
        if any(not(is_level_0(cm)) for cm in geq_subgraphs):
            geq=True
    elif geq_num == 0:
        geq = not(is_level_0(CM))
    else:
        geq = True
    return leq and geq

def signature(CM):
    b = CM.bilinear_form()
    pos=0
    neg=0
    zeros=0
    roots = b.charpoly().roots(AA)
    for root in roots:
        if root[0]>0:
            pos+=root[1]
        elif root[0]<0:
            neg+=root[1]
        else:
            zeros+=root[1]
    return ((pos, zeros, neg))

def is_lorentzian(CM): 
    return signature(CM)[2]== 1 and signature(CM)[0]==matrix(CM).nrows()-1

# **** Functions for Coxeter Graph ****
def showGraph(g, words):
    """
    input: coxeter graph, string
    output: Null

    Takes a coxeter graph and saves its image in the current folder with num in the name of the png file.
    """
    plot = g.plot(edge_labels=True,layout='spring', figsize=(3, 3))
    plot.save(f"graphs/graphImage_{words}.svg")

def remove_vertices(g, a):
    """
        Returns an iterator of different coxeter graphs
        obtained after removing `a` vertices from g (for 
        all different ways).
    """
    C = Combinations(g.vertices(), a)
    if len(C)==0:
        yield 
    for comb in C: 
        h=copy(g)
        h.delete_vertices(comb)
        yield h

def get_rank(g):
    """
        Takes a coxeter graph and returns its rank
        Returns the order with respect to the following convention: 
        A1: 0
        A2: 1
    """
    count=len(g.edges())
    for label in g.edge_labels():
        if label>3:
            count += label-3
    return count

def decrease_labels(g):
    subgraphs=[]
    for comb in Combinations(g.vertices(), 2):
        u, v = comb
        h = copy(g)
        
        if g.has_edge(u,v):
            # this implies that the edge label is more than or equal to 3
            if g.edge_label(u, v) == 3:
                h.delete_edge(u, v)
                if h.is_connected():
                    subgraphs.append(h)
            else:
                h.set_edge_label(u, v, g.edge_label(u, v) -1)
                subgraphs.append(h)
        
    return remove_isomorphic_graphs(subgraphs)

def generate_graphs(cg):
    """
        Input: A coxeter graph
        Output: a generator of coxeter graphs

        Given a coxeter graph as input, returns a generator of graphs 
        one "order" higher than the input graph (not upto ismorphism).

        The "higher order" or the partial order is defined as follows: 
        

        Examples::
    """
    for comb in Combinations(cg.vertices(), 2):
        u, v = comb
        h = copy(cg)
        if cg.has_edge(u, v):
            h.set_edge_label(u, v, cg.edge_label(u, v)+1)
        else:
            h.add_edge(u, v, 3) # label=3
        yield h

    h = copy(cg)
    new_vertex = h.add_vertex()
    for vertex in cg.vertices():
        i = copy(h)
        i.add_edge(new_vertex, vertex, 3) # label=3
        yield i

def get_subgraphs(cg):
    """
    Given a coxeter graph generate its subgraphs.
    By decreasing labels or by deleting a single node.
    When you delete a node make sure the subgraph you obtain is
    connected.
    """
    for k in remove_isomorphic_graphs(remove_vertices(cg, 1)):
        if k.is_connected():
            rank_k = get_rank(k)
            if rank_k == get_rank(cg)-1:
                yield k
    for l in decrease_labels(cg):
        yield l

def is_minimal(cg, lvl):
    return all(level_bound(coxeter_matrix_from_graph(p), lvl-1, -1) for p in get_subgraphs(cg))

def coxeter_matrix_from_graph(cg):
    """
        Construct a Coxeter Matrix (of type Coxeter Matrix) from a coxeter graph.
        
        Example:
            sage: a2 = CoxeterType(['A', 2]).coxeter_graph()
            sage: m = coxeter_matrix_from_graph(a2)
            sage: m
            [1 3]
            [3 1]
    """
    n = len(cg.vertices())
    m = Matrix(n)
    vertices = cg.vertices()
    for i in range(n):
        for j in range(i, n):
            if i == j:
                m[i, j]=1
            elif cg.has_edge(vertices[i], vertices[j]):
                m[i, j]=m[j, i]=cg.edge_label(vertices[i], vertices[j])
            else:
                m[i, j]=m[j, i]=2
    return CoxeterMatrix(m)

def get_graph_key(cg):
    g_canon=cg.canonical_label(edge_labels=True)
    edge_data = tuple(sorted(g_canon.edges(labels=True)))
    return edge_data

def get_graph_from_key(key):
    edges = list(key)
    g = Graph(edges)
    return g

# **** Functions for Generator/list of coxeter graphs ****
def remove_isomorphic_graphs(gen_graphs):
    """
        Returns a list of unique coxeter graphs upto isomorphism by removing
        the duplicates from the input list of coxeter grphs: "all_cases".

        EXAMPLES::
    """
    seen=set()
    st = time.time()
    for g in gen_graphs:
        key=g.canonical_label(edge_labels=True).graph6_string()
        if key not in seen:
            seen.add(key)
            yield g
    tt = time.time() - st

def remove_isomorphic_graphs_2(gen_graphs):
    unique_graphs = []
    st = time.time()
    for g in gen_graphs:
        if len(unique_graphs) == 0:
            unique_graphs.append(g)
        else: 
            if not any(g.is_isomorphic(prevGraph, edge_labels=True) for prevGraph in unique_graphs): 
                unique_graphs.append(g) 
    tt = time.time()-st
    return unique_graphs


def get_next_rank(gen_graphs):
    """
        Given a list of coxeter graph all of a certain rank. The following function gives the 
        list of next rank.
    """
    seen={}
    for g in gen_graphs:
        upper_covers = generate_graphs(g)
        for child in upper_covers:
            key = get_graph_key(child)
            if key not in seen:
                seen[key]=child
    return seen.values()

def filter_level(rank_graphs, leq, geq):
    for g in rank_graphs:
        if level_bound(coxeter_matrix_from_graph(g), leq, geq):
            yield g

def filter_lorentzian(rank_graphs):
    for g in rank_graphs:
        cm = coxeter_matrix_from_graph(g)
        print(cm)
        if is_lorentzian(cm):
            yield g

def filter_nodes(gen_graphs, geq):
    for g in gen_graphs:
        if len(g.vertices())>=geq:
            yield g
def filter_minimal(gen_graphs, lvl):
    for g in gen_graphs:
        if all(level_bound(coxeter_matrix_from_graph(p), lvl-1, -1) for p in get_subgraphs(g)):
            yield g

# **** Scripting automation functions ****
def get_all_level(start_rank_graphs, start_rank, end_rank, lvl):
    rank=start_rank
    generators = start_rank_graphs
    tt_start = time.time()
    while rank < end_rank:
        print(f"Getting rank: {rank+1}...")
        st1 = time.time()
        next_rank = get_next_rank(generators)
        tt1 = time.time()-st1
        print(f"Time taken to get rank {rank+1}: {tt1}. Processing started...")
        st2=time.time()
        for g in filter_level(next_rank, lvl, lvl-1):
            yield g
        if rank != end_rank:
            generators = filter_level(next_rank, lvl, -1)
        tt2=time.time()-st2
        print(f"Time taken to process rank {rank+1}: {tt2}")
        rank+=1
    tt = time.time()-tt_start
    print(f"Total time taken: {tt}!!!!")

def better_get_all_level(prev_level_graphs, lvl, min_nodes):
    st = time.time()
    first_generators = prev_level_graphs
    next_rank = get_next_rank(prev_level_graphs)
    first_lvl = filter_level(next_rank, lvl, lvl-1)
    tmp_generators = filter_nodes(first_lvl, min_nodes)

    seen={}
    generator_dict={}
    for g in tmp_generators:
        key=get_graph_key(g)
        generator_dict[key]=g
    generators = generator_dict.values()
    print(f"1 Iteration of level {lvl} graphs are: {len(generators)}")
    done = False
    count = 1

    while not done:
        for g in generators:
            key = get_graph_key(g)
            seen[key]=g
                
        next_rank = get_next_rank(generators)
        print(len(next_rank))
        tmp_generators = filter_level(next_rank, lvl, lvl-1)
        generator_dict={}
        for g in tmp_generators:
            key = get_graph_key(g)
            if key not in seen:
                generator_dict[key]=g
        if len(generator_dict.values()) == 0:
            done = True
        generators = generator_dict.values()
        count+=1
        print(f"{count} Iteration of level {lvl} graphs are: {len(generators)}") 
    
    tt = time.time()-st
    print(f"Total time taken: {tt}s !!!!")
    return seen.values()