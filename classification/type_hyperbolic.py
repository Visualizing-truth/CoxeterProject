


"""
Hyperbolic Coxeter matrices for hyperbolic Coxeter types.
These matrices are defined by there position in the humphreys book. The first number in the parenthesis is the
page, the second number is the column and the third number is the row.
"""
hyperbolic_coxeter_matrices = {
    (1, 1, 1): CoxeterMatrix([
                [1,4,2,2],
                [4,1,3,2],
                [2,3,1,5],
                [2,2,5,1]
            ]), 
    (1, 1, 2): CoxeterMatrix([
                [1,3,2,2],
                [3,1,5,2],
                [2,5,1,3],
                [2,2,3,1]
            ]),
    (1, 1, 3): CoxeterMatrix([
                [1,5,2,2],
                [5,1,3,2],
                [2,3,1,5],
                [2,2,5,1]
            ]),
    (1, 1, 4): CoxeterMatrix([
                [1,5,2,2],
                [5,1,3,3],
                [2,3,1,2],
                [2,3,2,1]
            ]),
    (1, 2, 1): CoxeterMatrix([
                [1,3,3,2],
                [3,1,2,4],
                [3,2,1,3],
                [2,4,3,1]
            ]),
    (1, 2, 2): CoxeterMatrix([
                [1,3,4,2],
                [3,1,2,4],
                [4,2,1,3],
                [2,4,3,1]
            ]),
    (1, 2, 3): CoxeterMatrix([
                [1,3,5,2],
                [3,1,2,4],
                [5,2,1,3],
                [2,4,3,1]
            ]),
    (1, 2, 4): CoxeterMatrix([
                [1,3,3,2],
                [3,1,2,5],
                [3,2,1,3],
                [2,5,3,1]
            ]),
    (1, 2, 5): CoxeterMatrix([
                [1,3,5,2],
                [3,1,2,5],
                [5,2,1,3],
                [2,5,3,1]
            ]),
    (1, 3, 1): CoxeterMatrix([
                [1,4,2,2,2],
                [4,1,3,2,2],
                [2,3,1,3,2],
                [2,2,3,1,5],
                [2,2,2,5,1]
            ]),
    (1, 3, 2): CoxeterMatrix([
                [1,3,2,2,2],
                [3,1,3,2,2],
                [2,3,1,3,2],
                [2,2,3,1,5],
                [2,2,2,5,1]
            ]),
    (1, 3, 3): CoxeterMatrix([
                [1,5,2,2,2],
                [5,1,3,2,2],
                [2,3,1,3,2],
                [2,2,3,1,5],
                [2,2,2,5,1]
            ]),
    (1, 3, 4): CoxeterMatrix([
                [1,5,2,2,2],
                [5,1,3,2,2],
                [2,3,1,3,3],
                [2,2,3,1,2],
                [2,2,3,2,1]
            ]),
    (1, 3, 5): CoxeterMatrix([
                [1,3,3,2,2],
                [3,1,2,4,2],
                [3,2,1,2,3],
                [2,4,2,1,3],
                [2,2,3,3,1]
            ]),
    (2, 1, 1): CoxeterMatrix([
                [1,4,3,2],
                [4,1,2,4],
                [3,2,1,3],
                [2,4,3,1]
            ]),
    (2, 1, 2): CoxeterMatrix([
                [1,4,3,2],
                [4,1,2,4],
                [3,2,1,4],
                [2,4,4,1]
            ]),
    (2, 1, 3): CoxeterMatrix([
                [1,4,4,2],
                [4,1,2,4],
                [4,2,1,4],
                [2,4,4,1]
            ]),
    (2, 1, 4): CoxeterMatrix([
                [1,3,3,2],
                [3,1,2,6],
                [3,2,1,3],
                [2,6,3,1]
            ]),
    (2, 1, 5): CoxeterMatrix([
                [1,3,6,2],
                [3,1,2,4],
                [6,2,1,3],
                [2,4,3,1]
            ]),
    (2, 1, 6): CoxeterMatrix([
                [1,3,6,2],
                [3,1,2,5],
                [6,2,1,3],
                [2,5,3,1]
            ]),
    (2, 1, 7): CoxeterMatrix([
                [1,3,6,2],
                [3,1,2,6],
                [6,2,1,3],
                [2,6,3,1]
            ]),
    (2, 1, 8): CoxeterMatrix([
                [1,3,3,2],
                [3,1,3,3],
                [3,3,1,3],
                [2,3,3,1]
            ]),
    (2, 1, 9): CoxeterMatrix([
                [1,3,2,2],
                [3,1,3,3],
                [2,3,1,3],
                [2,3,3,1]
            ]),
    (2, 1, 10): CoxeterMatrix([
                [1,4,2,2],
                [4,1,3,3],
                [2,3,1,3],
                [2,3,3,1]
            ]),
    (2, 1, 11): CoxeterMatrix([
                [1,5,2,2],
                [5,1,3,3],
                [2,3,1,3],
                [2,3,3,1]
            ]),
    (2, 1, 12): CoxeterMatrix([
                [1,6,2,2],
                [6,1,3,3],
                [2,3,1,3],
                [2,3,3,1]
            ]),
    (2, 2, 1): CoxeterMatrix([
                [1,4,2,2],
                [4,1,4,2],
                [2,4,1,3],
                [2,2,3,1]
            ]),
    (2, 2, 2): CoxeterMatrix([
                [1,4,2,2],
                [4,1,4,2],
                [2,4,1,4],
                [2,2,4,1]
            ]),
    (2, 2, 3): CoxeterMatrix([
                [1,4,2,2],
                [4,1,3,2],
                [2,3,1,6],
                [2,2,6,1]
            ]),
    (2, 2, 4): CoxeterMatrix([
                [1,5,2,2],
                [5,1,3,2],
                [2,3,1,6],
                [2,2,6,1]
            ]),
    (2, 2, 5): CoxeterMatrix([
                [1,3,2,2],
                [3,1,3,2],
                [2,3,1,6],
                [2,2,6,1]
            ]),
    (2, 2, 6): CoxeterMatrix([
                [1,3,2,2],
                [3,1,6,2],
                [2,6,1,3],
                [2,2,3,1]
            ]),
    (2, 2, 7): CoxeterMatrix([
                [1,6,2,2],
                [6,1,3,2],
                [2,3,1,6],
                [2,2,6,1]
            ]),
    (2, 2, 8): CoxeterMatrix([
                [1,6,2,2],
                [6,1,3,3],
                [2,3,1,2],
                [2,3,2,1]
            ]),
    (2, 2, 9): CoxeterMatrix([
                [1,3,2,2],
                [3,1,4,4],
                [2,4,1,2],
                [2,4,2,1]
            ]),
    (2, 2, 10): CoxeterMatrix([
                [1,4,2,2],
                [4,1,4,4],
                [2,4,1,2],
                [2,4,2,1]
            ]),
    (2, 2, 11): CoxeterMatrix([
                [1,3,3,3],
                [3,1,3,3],
                [3,3,1,3],
                [3,3,3,1]
            ]),
    (2, 3, 1): CoxeterMatrix([
                [1,3,2,2,2],
                [3,1,4,2,2],
                [2,4,1,3,2],
                [2,2,3,1,4],
                [2,2,2,4,1]
            ]),
    (2, 3, 2): CoxeterMatrix([
                [1,3,2,2,2],
                [3,1,3,2,2],
                [2,3,1,4,3],
                [2,2,4,1,2],
                [2,2,3,2,1]       
            ]),
    (2, 3, 3): CoxeterMatrix([
                [1,3,2,2,2],
                [3,1,4,2,2],
                [2,4,1,3,3],
                [2,2,3,1,2],
                [2,2,3,2,1]       
            ]),
    (2, 3, 4): CoxeterMatrix([
                [1,4,2,2,2],
                [4,1,3,2,2],
                [2,3,1,4,3],
                [2,2,4,1,2],
                [2,2,3,2,1]       
            ]),
    (2, 3, 5): CoxeterMatrix([
                [1,3,2,2,2],
                [3,1,3,3,2],
                [2,3,1,2,3],
                [2,3,2,1,3],
                [2,2,3,3,1]
            ]),
    (2, 3, 6): CoxeterMatrix([
                [1,4,2,2,2],
                [4,1,3,3,2],
                [2,3,1,2,3],
                [2,3,2,1,3],
                [2,2,3,3,1]
            ]),
    (2, 3, 7): CoxeterMatrix([
                [1,2,4,2,2],
                [2,1,3,2,2],
                [4,3,1,3,3],
                [2,2,3,1,2],
                [2,2,3,2,1]
            ]),
    (2, 3, 8): CoxeterMatrix([
                [1,3,2,3,2],
                [3,1,3,2,3],
                [2,3,1,3,2],
                [3,2,3,1,3],
                [2,3,2,3,1]
            ]),
    (2, 3, 9): CoxeterMatrix([
                [1,4,3,2,2],
                [4,1,2,3,2],
                [3,2,1,2,3],
                [2,3,2,1,4],
                [2,2,3,4,1]
            ]),
    
}

class CoxeterType_Hyperbolic(CoxeterType):
    r"""
    Coxeter type hyperbolic.

    """

    def __init__(self, accronym, position):
        """
        EXAMPLES::

            sage: C = CoxeterType(["Hyp", (2, 1, 3)])
        """
        self._acronym = accronym
        self._position = position
        super().__init__()

    def __repr__(self):
        return f"Coxeter type of ['{self._acronym}', ({self._position[0]}, {self._position[1]}, {self._position[2]})]"
    

    def rank(self):
        return hyperbolic_coxeter_matrices[self._position].rank()
    
    def coxeter_matrix(self):
        """
        Return the Coxeter matrix of the hyperbolic Coxeter type.

        EXAMPLES::

            sage: ct = CartanType(["Hyp", 2, 1, 3])
            sage: ct.coxeter_matrix()
            [[1,4,4,2], [4,1,2,4], [4,2,1,4], [2,4,4,1]]
        """
        return hyperbolic_coxeter_matrices[self._position]
    
    def humphreys_reference(self):

        return f"Page : {140 + self._position[0]}, Column : {self._position[1]}, Row : {self._position[2]}"
    
    def bilinear_form(self):

        return self.coxeter_matrix().bilinear_form()
    
    def coxeter_graph(self):
        return self.coxeter_matrix().coxeter_graph()
    
    def is_hyperbolic(self):
        return True