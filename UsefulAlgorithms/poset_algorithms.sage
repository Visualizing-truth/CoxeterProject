load("coxeter_graphs.sage")


def remove_isomorphic_graphs(all_cases):
    """
        Returns a list of unique coxeter graphs upto isomorphism by removing
        the duplicates from the input list of coxeter grphs: "all_cases".


        EXAMPLES::

    """
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
        This function is not used in the main implementation.

        Input: Coxeter matrix
        output: iterator of coxeter matrices

        Given a coxeter graph creates other coxeter graphs 
        one order higher than the input by just increasing the labels 
        or equivalently (in some cases) adding an edge.

        EXAMPLES::
    """
    for comb in Combinations(g.vertices(), 2):
        u, v = comb
        h = copy(g)
        if g.has_edge(u, v):
            h.set_edge_label(u, v, g.edge_label(u, v)+1)
        else:
            h.add_edge(u, v, 3) # label=3
        yield h
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

def add_node(g):
    """
        This function is not used in the main implementation.
    """
    h = copy(g)
    new_vertex = h.add_vertex()
    for vertex in g.vertices():
        i = copy(h)
        i.add_edge(new_vertex, vertex, 3) # label=3
        yield i

def generate_graphs(g):
    """
        Input: A coxeter graph
        Output: a generator of coxeter graphs

        Given a coxeter graph as input, returns a generator of graphs 
        one "order" higher than the input graph (not upto ismorphism).

        The "higher order" or the partial order is defined as follows: 
        

        Examples::
        
    """
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


def showOneCanvas(ls_of_graphs, name):
    """
        Saves as png the plot of multiple graphs (with name of the png as 
        specified by "name") and graphs specified by "ls_of_graphs".
    """
    ls_of_plots=[]
    for graph in ls_of_graphs:
        plot = graph.plot(edge_labels=True)
        ls_of_plots.append(plot)
    combined_canvas=graphics_array(ls_of_plots, 2)
    combined_canvas.save(f'graphImages_{name}.pdf')


def showGraphs(ls_of_graphs):
    """
        This function is really scrapy right now.
    """
    count=1
    for graph in ls_of_graphs:
        showGraph(graph, count)
        count+=1

def get_next_order(prev_order):
    """
        This function is really scrapy right now
    """
    for graph in prev_order:
        for g in generate_graphs(graph): 
            yield g

def get_final_order(order, A2):
    """
        This function is really scrapy right now
    """
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

def same_nodes(g1, g2):
    """
        This function assumes same nodes
    """

    if get_rank(graph)>=get_rank(g2):
        diff_edges=len(graph.edges())-len(g2.edges())
        if diff_edges==0:
            if graph.is_isomorphic(g2):
                return True
            else:
                return False
            if diff_edges>0:
                for edge in graph.edges():
                    graph_h = copy(g)
                    graph_h.delete_edge(edge)



def exists_relation(g1, g2):

    if get_rank(g1) < get_rank(g2):
        tmp=g1
        g1=g2
        g2=tmp


    if max(g1.edge_labels()) < max(g2.edge_labels()):
        return False

    diff_vert=len(g1.vertices())-len(g2.vertices())
    
    if diff_vert < 0:
        return False

    deletion_graphs=remove_vertices(g1, diff_vert)

    for graph in remove_isomorphic_graphs(deletion_graphs):
        if get_rank(graph)>=get_rank(g2):
            diff_edges=len(graph.edges())-len(g2.edges())
            if diff_edges==0:  
                if graph.is_isomorphic(g2):
                    return True
                else:
                    return False
    return False

def main():
    a3 = CoxeterType(['A', 3]).coxeter_graph()
    a2 = CoxeterType(['A', 2]).coxeter_graph()
    i4 = CoxeterType(['I', 4]).coxeter_graph()


main()