import random

cases = []
labels = [3, 4, 5, 6, 7]
# Weights for each label: higher weights for 3,4,5
weights = [0.3, 0.35, 0.25, 0.05, 0.05]  # Probabilities sum to 1

def getAllGraphs(n):
    count = 0
    for nodes in range(2, 6):
        for g in graphs.nauty_geng(f"{nodes} -c"):
            m = CoxeterMatrix(g)._matrix_()
            yield g
            count+=1
            edges = {}
            for i in range(len(m.rows())):
                for j in range(i+1, len(m.rows())):
                    if m[i][j] >= 3:
                        edges[(i, j)] = m[i][j]
            for i in range(n):
                new_matrix = copy(m)
                for (v1, v2) in edges.keys():
                    # Choose a random number with weighted probabilities
                    newEdgeLabel = random.choices(labels, weights=weights, k=1)[0]
                    # Update both (v1,v2) and (v2,v1) since the matrix is symmetric
                    new_matrix[v1,v2] = newEdgeLabel
                    new_matrix[v2,v1] = newEdgeLabel 
                new_graph = CoxeterMatrix(new_matrix).coxeter_graph()
                yield new_graph
                count+=1
    print(count)

def remove_isomorphic_graphs(all_cases):
    unique_graphs = []
    for g in all_cases:
        if len(unique_graphs) == 0:
            unique_graphs.append(g)
        else:
            if not any(g.is_isomorphic(prevGraph, edge_labels=True) for prevGraph in unique_graphs):
                unique_graphs.append(g)
    return unique_graphs
            



    

