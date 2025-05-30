
nodes = 5
count = 0
for g in graphs.nauty_geng(f"{nodes} -c"):
     count += 1
     g.plot().save(f"./graphs_image/{nodes}nodes_graph/graph_{count}.png")

print(f"{count} graphs with {nodes} nodes generated.")

