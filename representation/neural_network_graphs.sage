import csv
from itertools import product


load("coxeter_graphs.sage")
load("cm_utils.sage")


label_values = [4, 5, 6, 7]
nodes = 4
csv_filename = "coxeter_matrices.csv"


with open(csv_filename, mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["ID", "NumNodes", "Level", "Matrix"])

    count = 0
    graph = 0

    for i in range(2, nodes + 1):
        for g in graphs.nauty_geng(f"{i} -c"):
            graph += 1
            CM = CoxeterMatrix(g)
            origin_matrix = get_matrix(CM)
            count += 1
            writer.writerow([count, i, get_level(CM)] + list(origin_matrix))
            positions = [(j, k) for j in range(i) for k in range(j+1, i) if origin_matrix[j][k] == 3]

            for label_comb in product(label_values, repeat=len(positions)):
                new_matrix = [row[:] for row in origin_matrix]

                for(j, k), value in zip(positions, label_comb):
                    new_matrix[j][k] = new_matrix[k][j] =value

                try: 
                    new_CM = CoxeterMatrix(new_matrix)
                    level = get_level(new_CM)
                    count += 1

                    writer.writerow([count, i, level] + new_matrix)

                except Exception:
                    continue

    print(f"{count} matrices with {nodes} nodes generated and saved to {csv_filename}.")