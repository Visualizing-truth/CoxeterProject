def relation_exists(m1, m2):
    """
    Checks whether a Coxeter matrix `m1` dominates another matrix `m2` 
    under a poset-like deletion order.

    This function assumes that `m1` has more or equal nodes than `m2`, and
    determines if `m2` is less than or equal to some submatrix of `m1`
    (up to node deletion) entry-wise.

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
    n1 = m1.ncols()
    n2 = m2.ncols()
    diff_nodes = n1-n2
    if diff_nodes<0:
        # Switch m1 and m2
        tmp = m1
        m1 = m2
        m2 = tmp
    M1 = CoxeterMatrix(m1)
    M2 = CoxeterMatrix(m2)
    leq=False
    done=False

    potential_matrices=delete_nodes(M1, diff_nodes)
    while not leq and not done:
        try:
            P = next(potential_matrices)
            contradiction=False
            p = P._matrix_()
            for i in range(n2):
                for j in range(i, n2):
                    if m2[i, j] > p[i, j]:
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




