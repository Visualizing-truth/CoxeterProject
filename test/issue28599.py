from sage.all import *


n = 5
p = polytopes.regular_polygon(n, exact = True)
print(p.vertices())