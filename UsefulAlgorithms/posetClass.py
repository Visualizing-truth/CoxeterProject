from sage.all import *
import uuid

load("coxeter_graphs.sage")
load("poset_algorithms.sage")

class poset_graph:
    def __init__(self, coxeter_graph, parents=None, children=None):
        self.coxeter_graph = coxeter_graph
        self.id = uuid.uuid4().hex
        self.parents = parents if parents is not None else []
        self.rank = get_rank(self.coxeter_graph)
        self.children = children if children is not None else []
    
    def __str__(self):
          showGraph(self.coxeter_graph, self.id)
          return self.coxeter_graph.edges().__str__()
    
    def __eq__(self, other):
        return self.coxeter_graph.is_isomorphic(other.coxeter_graph, edge_labels=True)

    def __hash__(self):
        return hash(self.id)

    def add_parent(self, parent):
        self.parents.append(parent)

    def set_rank(self):
        self.rank = get_rank(self.coxeter_graph)
    
    def create_children(self):
        child_graphs = remove_isomorphic_graphs(generate_graphs(self.coxeter_graph))

        self.children = []
        # Instantiate all children
        for g in child_graphs:
            new_poset_graph = poset_graph(g)
            new_poset_graph.add_parent(self)
            new_poset_graph.rank = self.rank + 1
            self.children.append(new_poset_graph)
        print(len(new_poset_graph.parents))
    
    def save_image(self):
        showGraph(self.coxeter_graph, self.id)
        return f"graphs/graphImage_{self.id}.svg"



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


a2=CoxeterType(['A', 2])
root = poset_graph(a2.coxeter_graph())
print(len(root.parents))

# Rank 2 generation
rank_2 = get_next_gen([root])
# Rank 3 generation
rank_3 = make_unique(get_next_gen(rank_2))

rank_4 = make_unique(get_next_gen(rank_3))


print(len(root.parents))

vertices = [root] + rank_2 + rank_3 + rank_4

edges = []
for v in vertices:
    if len(v.parents) > 0:
        for p in v.parents:
            
            edges.append((p, v))
print(edges)

G = DiGraph(edges)




# Customize the graphviz string to use custom labels
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

graph_string = custom_graphviz_string(G)
print(graph_string)
with open("graph.dot", "w") as f:
    f.write(graph_string)






          

