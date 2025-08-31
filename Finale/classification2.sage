load("classification.sage")

def label_upper_covers(cg):
    for comb in Combinations(cg.vertices(), 2):
            u, v = comb
            h = copy(cg)
            if cg.has_edge(u, v):
                h.set_edge_label(u, v, cg.edge_label(u, v)+1)
            else:
                h.add_edge(u, v, 3) # label=3
            yield h

def remove_duplicates_dict(dict_graphs):
    seen={}
    for g in dict_graphs:
        key=get_graph_key(g)


def label_upper_chain(cg, lvl):
    """
    This function assumes that lvl(cg)>lvl-1
    """
    chain={get_graph_key(cg): cg}
    current=chain
    combinations = Combinations(cg.vertices(), 2).list()
    # Iterate through a copy of combinations because it is going to get altered
    for comb in list(combinations):
        u, v = comb
        for g in tuple(current.values()):
        
            h = copy(cg)
            if cg.has_edge(u, v):
                h.set_edge_label(u, v, cg.edge_label(u, v)+1)
            else:
                h.add_edge(u, v, 3) # label=3
            key = get_graph_key(h)
            CM = coxeter_matrix_from_graph(h)
            # If there's an isomorphic graph already or the level is larger then remove
            # that combination from the list
            if key in current or not level_bound(CM, lvl, -1):
                combinations.remove(comb)
            # If the new graph is not isomorphic to a pre-existing one and the level is 
            # the desired one then add it to the chain
            #if key not in current and level_bound(CM, lvl, -1):
                # keep this combination
                #chain[key]=
    
            
def smart_chain(m, lvl):
    """
    The keys of the dictionary contain the combinations of vertices whose edge
    status was changed in order to create them.
    """
    combinations = Combinations(m.vertices(), 2).list()

    generators = {get_graph_key(m): m}
    


                



    


def node_upper_covers(cg):
    h = copy(cg)
    new_vertex = h.add_vertex()
    for vertex in cg.vertices():
        i = copy(h)
        i.add_edge(new_vertex, vertex, 3) # label=3
        yield i

def get_next_label_rank(gen_graphs):
    seen={}
    for g in gen_graphs:
        upper_covers=label_upper_covers(g)
        for child in upper_covers:
            key=get_graph_key(child)
            if key not in seen:
                seen[key]=child
            
    return seen.values()



def get_next_in_chain(generators, lvl):
    next_rank={}
    for g in generators.values():
        u_covers=remove_isomorphic_graphs(filter_level(label_upper_covers(g), lvl, -1))

        for p in u_covers:  
            key=get_graph_key(p)
            if key not in next_rank:
                next_rank[key]=p
    return next_rank

    return next_rank.values()

def label_chain(m, lvl):
    generators={get_graph_key(m):m}
    # I could make chain an iterator as well, since dictionary is not really required!!
    chain = generators
    while len(generators)!=0:
        next_rank=get_next_in_chain(generators, lvl)
        for child in next_rank.values():
            # Since every child in next_rank would be of a higher rank we don't need to check for duplicates
            # Also every next_rank is already rid of duplicates because of get_next_in_chain's implementation
            chain[get_graph_key(child)]= child
        generators=next_rank
    return chain

def get_level_final(minimal_graphs, lvl):
    count=0
    tt_st=time.time()
    for m in minimal_graphs:
        count+=1
        it_st=time.time()
        chain = label_chain(m, lvl).values()
        for child in chain:
            yield child
        it_tt=time.time()-it_st
        print(f"length of chain: {len(chain)}! Time taken: {it_tt}s")
    tt = time.time()-tt_st
    print(f"Total time taken: {tt}s")

def get_all_level_final2(minimal_graphs, lvl, min_nodes):
    st = time.time()

    generators={}
    seen={}
    
    for g in filter_nodes(minimal_graphs, min_nodes):
        key=get_graph_key(g)
        generators[key]=g
        seen[key]=g

    count=0
    while len(generators)!=0:
        count+=1
        next_rank=get_next_label_rank(generators.values())
        print(f"{count} next_rank length is: {len(next_rank)}")
        generators={}
        for g in filter_level(next_rank, lvl, -1):
            key = get_graph_key(g)
            if key not in seen:
                generators[key]=g
        for g in generators.values():
            key = get_graph_key(g)
            seen[key]=g
        print(f"{count} generators length is: {len(generators)}")
        print(f"{count} seen length is: {len(seen)}")
    
    tt = time.time()-st
    print(f"Total time taken: {tt}!!!!")
    return seen.values()








