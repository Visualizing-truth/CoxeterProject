import csv
from itertools import product


load("coxeter_graphs.sage")
load("cm_utils.sage")


def generate_labeled_graphs(n, label_range):
    seen = set()
    results = []

    for G0 in graphs.nauty_geng(f"{n}"):
        print(f"Processing graph with {n} nodes: {G0}")
        edges = G0.edges(labels=False)
        for labels in product(label_range, repeat=len(edges)):
            G = Graph()
            G.add_vertices(G0.vertices())
            for (u, v), l in zip(edges, labels):
                G.add_edge(u, v, label=l)

            canon = tuple(sorted((min(u, v), max(u, v), G.edge_label(u, v)) for u, v in G.edges(labels=False)))
            if canon not in seen:
                seen.add(canon)
                results.append(G)

    return results




labels = tuple(3,4,5,6,7)
it = cartesian_product([labels]*6)


nodes = 4
csv_filename = "coxeter_matrices.csv"




with open(csv_filename, mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["ID", "NumNodes", "Level", "Matrix"])

    count = 0
    graph = 0

    for i in range(2, nodes + 1):
        for graph in generate_labeled_graphs(i, label_values):
            count += 1
            CM = CoxeterMatrix(graph)
            level = get_level(CM)
            writer.writerow([count, nodes, level] + get_matrix(CM).rows())

    print(f"{count} matrices with {nodes} nodes generated and saved to {csv_filename}.")