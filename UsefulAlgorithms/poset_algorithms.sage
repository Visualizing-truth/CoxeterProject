load("coxeter_graphs.sage")


def remove_isomorphic_graphs(all_cases):
    unique_graphs = []
    for g in all_cases:
        if len(unique_graphs) == 0:
            unique_graphs.append(g)
        else:
            if not any(g.is_isomorphic(prevGraph, edge_labels=True) for prevGraph in unique_graphs):
                unique_graphs.append(g)
    return unique_graphs
    
def increase_labels(g):
    """
        Input: Coxeter matrix
        output: iterator of coxeter matrices

        Given a coxeter graph creates other coxeter graphs 
        one order higher than the input one. 
        By either increasing an edge label or by creating
        a new edge.
    """
    for comb in Combinations(g.vertices(), 2):
        u, v = comb
        h = copy(g)
        if g.has_edge(u, v):
            h.set_edge_label(u, v, g.edge_label(u, v)+1)
        else:
            h.add_edge(u, v, 3) # label=3
        yield h

def add_node(g):
    h = copy(g)
    new_vertex = h.add_vertex()
    for vertex in g.vertices():
        i = copy(h)
        i.add_edge(new_vertex, vertex, 3) # label=3
        yield i

def create_higher_order_graphs(g):
    for comb in Combinations(g.vertices(), 2):
        u, v = comb
        h = copy(g)
        if g.has_edge(u, v):
            h.set_edge_label(u, v, g.edge_label(u, v)+1)
        else:
            h.add_edge(u, v, 3) # label=3
        yield h

    h = copy(g)
    new_vertex = h.add_vertex()
    for vertex in g.vertices():
        i = copy(h)
        i.add_edge(new_vertex, vertex, 3) # label=3
        yield i

def get_next_order(prev_order):
    for graph in prev_order:
        for g in create_higher_order_graphs(graph):
            yield g
def showGraphs(ls_of_graphs):
    count=1
    for graph in ls_of_graphs:
        showGraph(graph, count)
        count+=1

def get_final_order(order, A2):
    starting = [A2]
    orders=[]
    for i in range(order):
        if i==0:
            next_order=[graph for graph in remove_isomorphic_graphs(get_next_order(starting))]
            orders.append(next_order)
        else:
            next_order=[graph for graph in remove_isomorphic_graphs(get_next_order(orders[-1]))]
            orders.append(next_order)

    return orders[-1]



def main():
    A4 = CoxeterMatrix([
        [1, 3, 2, 2],
        [3, 1, 3, 2],
        [2, 3, 1, 3],
        [2, 2, 3, 1]
    ])
    A2 = CoxeterMatrix([
        [1, 3],
        [3, 1]
    ])

    ls=[A2.coxeter_graph()]
    count=1
    order3=[]
    for graph in remove_isomorphic_graphs(get_next_order(ls)):
        order3.append(graph)

    order4=[]
    for graph in remove_isomorphic_graphs(get_next_order(order3)):
        order4.append(graph)
    
    order5=[]
    for graph in remove_isomorphic_graphs(get_next_order(order4)):
        order5.append(graph)
    
    showGraphs(order5)

    order6=[]
    for graph in remove_isomorphic_graphs(get_next_order(order5)):
        order6.append(graph)
    showGraphs(order6)
        

main()