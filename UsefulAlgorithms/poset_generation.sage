
load("posetClass.py")
load("coxeter_graphs.sage")
load("poset_algorithms.sage")


def order(p1, p2):
    # Strict order: never return True for equal elements
    if p1 == p2:
        return False
    r1 = p1.rank
    r2 = p2.rank
    
    g1 = p1.coxeter_graph
    g2 = p2.coxeter_graph

    m1 = p1.coxeter_matrix
    m2 = p2.coxeter_matrix
    if initial_checks(g1, g2):
        return relation_exists(m1, m2)
    return initial_checks(g1, g2)

def initial_checks(g1, g2):
    """
    This function performs initial checks. It assumes that get_rank(g2) is larger than get_rank(g1)
    If False then we know that the relation doesn't exist.
    if True then we know then we can move forward with 
    relation_exists function.
    """
    
    if max(g1.edge_labels()) > max(g2.edge_labels()):
        return False

    diff_vert=len(g2.vertices())-len(g1.vertices())
    if diff_vert < 0:
        return False
    return True


def relation_exists(m1, m2):
    """
    Checks whether a Coxeter matrix `m1` dominates another matrix `m2` 
    under a poset-like deletion order.

    This function assumes that the rank of m2 is greater than rank of m1 and that
    m2 has more nodes than m2 because otherwise relation doesn't exist. (All
    this should be taken care by the initial_checks function)
    Which can be interpretated as a sum of all the edge labels in the upper
    matrix leaving the diagnol.

    Parameters:
        m1 (Matrix): A Sage matrix representing a Coxeter matrix with more or equal nodes.
        m2 (Matrix): A smaller or equal-size Coxeter matrix.

    Returns:
        bool: True if a submatrix of m1 is greater than or equal to m2 entrywise; False otherwise.

    Example:
        sage: a4 = CoxeterType(['A', 4]).coxeter_matrix()._matrix_()
        sage: d5 = CoxeterType(['D', 5]).coxeter_matrix()._matrix_()
        sage: relation_exists(d5, a4)
        True
    """
    diff_nodes = m2.ncols()-m1.ncols()
    n1 = m1.ncols()
    M1 = CoxeterMatrix(m1)
    M2 = CoxeterMatrix(m2)
    leq=False
    done=False

    potential_matrices=delete_nodes(M2, diff_nodes)
    while not leq and not done:
        try:
            P = next(potential_matrices)
            contradiction=False
            p = P._matrix_()
            for i in range(n1):
                for j in range(i, n1):
                    if m1[i, j] > p[i, j]:
                        contradiction=True
                        break
                if contradiction:
                    break
            if not contradiction:
                # This means that the both loops ended successfully
                leq=True
        except StopIteration:
            # Stop iterating, ran out of delete_nodes
            done=True
    return leq


a2 = CoxeterType(['A', 2])
root = poset_graph(a2.coxeter_graph(), coxeter_matrix_from_graph(a2.coxeter_graph()))
rank_2 = get_next_gen([root])
rank_3 = make_unique(get_next_gen(rank_2))
vertices = [root] + rank_2 + rank_3


p = Poset((vertices, order))

