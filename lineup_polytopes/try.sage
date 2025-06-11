from itertools import permutations
def get_lineup_polytope(p):

    sum = 0
    for i in range(1, len(p) + 1):
        sum += i
    
    nb_vertices = len(p)

    P = Polyhedron(vertices=p)

    plot_obj = P.plot(fill='lightblue', color='blue')
    plot_obj.save(f'p{nb_vertices}.png')


    w = list(range(1, nb_vertices + 1))

    vertices = []
    vert = [0,0]

    for perm in permutations(w):
        current_vertex = [0,0]
        for i in range(4):
            current_vertex[0] += perm[i]*p[i][0]
            current_vertex[1] += perm[i]*p[i][1]

        vert = [1/sum * current_vertex[0], 1/sum * current_vertex[1]]
        vertices.append(vert)

    P = Polyhedron(vertices=vertices)

    plot_obj = P.plot(fill='lightblue', color='blue') + list_plot(vertices, color='red', size=30)
    plot_obj.save(f'{nb_vertices}-lineup_polytope.png')

p4 = [[1,3],[2,1],[4,2],[3,4]]
get_lineup_polytope(p4)

p6 = [[0,1], [0,2], [1,0], [1,3], [2,1], [2,2]]
get_lineup_polytope(p6)

