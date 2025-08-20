from sage.all import *
import uuid

load("coxeter_graphs.sage")
load("poset_algorithms.sage")

class poset_graph:
    def __init__(self, coxeter_graph, coxeter_matrix, parents=None, children=None):
        self.coxeter_graph = coxeter_graph
        self.parents = parents if parents is not None else []
        self.rank = get_rank(self.coxeter_graph)
        self.children = children if children is not None else []
        self.coxeter_matrix = coxeter_matrix
    
    def signature():
        m = CoxeterMatrix(self.coxeter_matrix)
        
        b = m.bilinear_form()
        b.eigenvalues()
    def __str__(self):
        n = self.coxeter_matrix.ncols()
        rep = []
        for i in range(n):
            for j in range(i+1, n):
                rep.append(self.coxeter_matrix[i, j])
                
        m = CoxeterMatrix(self.coxeter_matrix)
        
                
                
        return rep.__str__() + f", {level(CoxeterMatrix(self.coxeter_matrix))}"
    
    def __eq__(self, other):
        # Two poset_graphs are equal if their coxeter_graphs are isomorphic (with edge labels)
        if not isinstance(other, poset_graph):
            return False
        return self.coxeter_graph.is_isomorphic(other.coxeter_graph, edge_labels=True)

    def __hash__(self):
        # Hash based on canonical label of the coxeter_graph (with edge labels)
        # Use canonical_label with edge_labels=True for a unique, hashable representation
        # The sorted tuple of edges (with labels) is a good hashable proxy
        edges = self.coxeter_graph.edges(labels=True)
        # Each edge is (u, v, label), sort for consistency
        canonical = tuple(sorted((min(u, v), max(u, v), l) for u, v, l in edges))
        return hash(canonical)

    def add_parent(self, parent):
        self.parents.append(parent)

    def set_rank(self):
        self.rank = get_rank(self.coxeter_graph)
    
    def create_children(self):
        child_graphs = remove_isomorphic_graphs(generate_graphs(self.coxeter_graph))

        self.children = []
        # Instantiate all children
        for g in child_graphs:
            new_poset_graph = poset_graph(g, coxeter_matrix_from_graph(g))
            new_poset_graph.add_parent(self)
            new_poset_graph.rank = self.rank + 1
            self.children.append(new_poset_graph)

    def save_image(self):
        showGraph(self.coxeter_graph, id(self))
        return f"graphs/graphImage_{id(self)}.svg"

def get_next_gen(ls_prev_gen):
    next_gen = []
    for p in ls_prev_gen:
        p.create_children()
        for child in p.children:
            next_gen.append(child)
    return next_gen

def make_unique(ls):
    """
            Given a list of poset_graph objects this function 
            returns a unique list of poset_graph objects by
            removing the duplicate poset_graphs (having the 
            same coxeter_graph)
    """
    uniques = []
    for j in ls:
        if len(uniques) == 0:
                uniques.append(j)
        else:
            for prevGraph in uniques:
                if j.__eq__(prevGraph):
                    prevGraph.parents += j.parents
                    break
            else:
                uniques.append(j)

    return uniques


# a2=CoxeterType(['A', 2])
# root = poset_graph(a2.coxeter_graph())
# print(len(root.parents))

# # Rank 2 generation
# rank_2 = get_next_gen([root])
# # Rank 3 generation
# rank_3 = make_unique(get_next_gen(rank_2))

# rank_4 = make_unique(get_next_gen(rank_3))


# print(len(root.parents))

# vertices = [root] + rank_2 + rank_3 + rank_4

# edges = []
# for v in vertices:
#     if len(v.parents) > 0:
#         for p in v.parents:
            
#             edges.append((p, v))
# print(edges)

# G = DiGraph(edges)



def custom_graphviz_string(G):
    lines = ['digraph { \n node [shape=box, width=1.5, height=1.5, fixedsize=true, imagescale=true];']
    
    # Add nodes with custom labels and images
    for v in G.vertices():
        # Save the Coxeter graph as an image file
        image_filename = v.save_image()
        
        # Use the image in the node label
        lines.append(f'  node_{id(v)} [label="", image="{image_filename}", shape="none"];')
    
    # Add edges
    for u, v, l in G.edges():
        lines.append(f'  node_{id(u)} -> node_{id(v)};')
    
    lines.append('}')
    return '\n'.join(lines)

# graph_string = custom_graphviz_string(G)
# print(graph_string)
# with open("graph.dot", "w") as f:
#     f.write(graph_string)


a2 = CoxeterType(['A', 2])
root = poset_graph(a2.coxeter_graph(), coxeter_matrix_from_graph(a2.coxeter_graph()))

rank_2 = get_next_gen([root])





          

