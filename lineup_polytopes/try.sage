from itertools import permutations
def get_lineup_polytope(p):
    
    nb_vertices = len(p)

    P = Polyhedron(vertices=p)

    plot_obj = P.plot(fill='lightblue', color='blue')
    plot_obj.save(f'p{nb_vertices}.png')


    w = list(range(1, nb_vertices + 1))
    w = [wi / sum(w) for wi in w]

    vertices = []

    for perm in permutations(w):
        current_vertex = [0,0]
        for i in range(nb_vertices):
            current_vertex[0] += perm[i]*p[i][0]
            current_vertex[1] += perm[i]*p[i][1]

        vertices.append([current_vertex[0],current_vertex[1]])

    P = Polyhedron(vertices=vertices)

    plot_obj = P.plot(fill='lightblue', color='blue') + list_plot(vertices, color='red', size=30)
    plot_obj.save(f'{nb_vertices}-lineup_polytope.png')

p4 = [[1,3],[2,1],[4,2],[3,4]]
get_lineup_polytope(p4)

p6 = [[0,1], [0,2], [1,0], [1,3], [2,1], [2,2]]
get_lineup_polytope(p6)

