import random
import numpy as np
import csv

load("CoxeterProperties.sage")
load("misc.sage")

def generateType(kind, startIndex, finite):
    '''
        kind: string
        startIndex: int
        finite: boolean
        
        HardCoded: 6
    '''
    ls = []
    if finite: 
        for i in range(startIndex, 6):
            CM = CoxeterType([kind, i]).coxeter_matrix()
            ls.append(CM)

    else: 
        for i in range(startIndex, 6):
            CM = CoxeterType([kind, i, 1]).coxeter_matrix()
            ls.append(CM)

    return ls

def generateCM(n):
    lsOfCM = []
    for i in range(1, n+1):
        CM = CoxeterType(['A', i]).coxeter_matrix()
        lsOfCM.append(CM)

    for j in range(2, n+1):
        CM = CoxeterType(['B', j]).coxeter_matrix()
        lsOfCM.append(CM)

    return lsOfCM

def I2():
    ls = []
    
    for i in range(3, 10):
        CM = CoxeterType(['I', i]).coxeter_matrix()
        ls.append(CM)
    return ls


ls = [CoxeterType.samples(finite=True)[i].coxeter_matrix() for i in range(6, 15)]

finite = ls+generateCM(5)+I2()



count = 1


ls2 = generateType('A', 1, False) + generateType('B', 3, False) + generateType('C', 2, False) + generateType('D', 4, False)

affine = [CoxeterType.samples(finite=False)[i].coxeter_matrix() for i in range(4, 9)] + ls2



def arrayForCSV(ls):
    arrayLs = []
    for c in ls:
        c = CoxeterMatrix(c)
        arrayC = []
        arrayC.append(f"{check_level(c)}")
        m = c._matrix_()
        for i in range(len(m.rows())):
            for j in range(len(m.rows())):
                arrayC.append(m[i,j])
        for i in range(len(arrayC), 9**2+1):
            arrayC.append(0)
        arrayLs.append(arrayC)
    return arrayLs


final_data = arrayForCSV(finite)+arrayForCSV(affine)+arrayForCSV(remove_isomorphic_graphs(getAllGraphs(50)))


print(len(finite))
print(len(affine))
print(len(final_data))

header = ["label"] + [f"value{i+1}" for i in range(9**2)] 



with open('training.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(header)
    writer.writerows(final_data)





