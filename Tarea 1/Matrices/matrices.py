import numpy

def validar(num, op):           #validar entrada de números
    if(num == ""):                  #si no se introdujo nada
        print("\tIngresar números")
        return "null"
    copia = num                     #crear copia
    if copia[0] == "-":             #si el primer caracter es un signo de menos
        copia = copia.replace("-","",1) #omitir el signo
    if op == "cel":                 #si se está validando que sea float
        copia = copia.replace(".","",1) #omitir un punto
            
    if not copia.isdigit():       #si no es un número
        if op == "fc":             #si se quiere float
            print("Solo números enteros positivos")
        elif op == "cel":
            print("Solo números")
        elif op == "op":                           #si se quiere int
            print("Solo opciones disponibles")
            
        return "null"                    #regresar que no es número
    else:                           #si sí es número
        if op == "op" or op == "fc":    #si se quiere int
            return int(num)               #regresar string convertido a int
        elif op == "cel":               #si se quiere float
            return float(num)                 #regresar strng convertido a 

def matdim(letra):           #definir dimensiones de matriz
    print("\nIngresar dimensiones de matriz ",letra,":", sep = "")
    matfc = ["null","null"]
    while matfc[0] == "null" or matfc[0] < 0:#mientras las filas sean inválidas o menores que 0
        print("\tFilas: ",end = "")
        matfc[0] = input()                      #leer cantidad de filas
        matfc[0] = validar(matfc[0],"fc")       #validar entrada
        
    while matfc[1] == "null" or matfc[1] < 0:#mientras las columnas sean inválidas o menors que 0
        print("\tColumnas: ",end = "")
        matfc[1] = input()                      #leer cantidad de columnas
        matfc[1] = validar(matfc[1],"fc")       #validar entrada
        
    return matfc                        #regresar dimensiones

def llenar(matriz, matfc, letra):   #llenar celdas de matriz
    print("Llenar matriz",letra,"en posición:")
    for i in range(matfc[0]):           #recorrer filas
        for j in range(matfc[1]):           #recorrer columnas
            matriz[i][j] = "null"               #de momento la celda no es válida
            while matriz[i][j] == "null":       #mientras la celda no sea válida
                print("\t[",i,"][",j,"] = ", sep = "", end = "")
                matriz[i][j] = input()              #leer celda
                matriz[i][j] = validar(matriz[i][j], "cel") #validar entrada
    return matriz                   #regresar matriz llena

def suma(matR,matA,matB):             #sumar matrices
    for i in range(Afc[0]):     #recorrer filas
        for j in range(Afc[1]):     #recorrer columnas
            matR[i][j] = matA[i][j] + matB[i][j]    #sumar celdas
    return matR             #regresar matriz resultante

def producto(matR, matA, matB):         #multiplicar matrices
    for a in range(Afc[0]):     #recorrer filas
        for b in range(Bfc[1]):     #recorer columnas
            suma = 0    
            i = a                       #la fila de A es la fila de C
            l = b                       #la columna de B es la columna de C
            for j,k in zip( range(Afc[1]), range(Bfc[0]) ): #recorrer columnas de A y filas de B
                suma += matA[i][j] * matB[k][l]             #sumar el producto de las celdas
            matR[a][b] = suma                   #celda de C es igual a la suma
    return matR             #regresar matriz resultante

def validMat(letra, Mfc):
    valid = 0
    while valid == 0:
        Mfc = matdim(letra)
        if Mfc[0] <= 1 and Mfc[1] <= 1 or (Mfc[0] == 0 or Mfc[1] == 0):
            print("'",letra,"' no es una matriz",sep="")
            valid = 0
        else:
            valid = 1

    return Mfc

def crearMat(Xfc, letra):
    matX = [["null" for j in range(Xfc[1])] for i in range(Xfc[0])]
        #crear matriz

    matX = llenar(matX, Xfc, letra)   #llenar matriz A

    return matX

Afc = ["",""]   #filas y columnas de A
Bfc = ["",""]   #filas y columnas de B

print("OPERACIONES CON MATRICES")

print("\nSeleccionar operación:")
print("\t1. Suma\t\t(A + B)")
print("\t2. Producto\t(A * B)")
print("\tOpción: ",end = "")
op = "null"
while True:   #mientras la opción no sea válida
    op = input()            #leer opción
    op = validar(op, "op")  #validar entrada
    if op == "null":
        continue
    else:
        if op != 1 and op != 2:
            print("Solo opciones disponibles")
            continue
        else:
            break

check = 0
while check == 0:
    Afc = validMat("A",Afc)
    Bfc = validMat("B",Bfc)
    if op == 1:         #si la opción es 1 (suma)
        matC = [["null" for j in range(Afc[1])] for i in range(Afc[0])]
                            #crear matriz B
        if Afc[0] != Bfc[0] or Afc[1] != Bfc[1]:    #si A y B son de diferentes dimensiones
            print("Se requieren matrices de dimensiones iguales")
        else:               #si A y B son de dimensiones iguales
            matA = crearMat(Afc,"A")
            matB = crearMat(Bfc,"B")
            print("\nA + B = ")
            matC = suma(matC,matA,matB)           #C = A+B
            print(numpy.matrix(matC))   #imprimir matriz C
            check = 1
    else:               #si la opción es 2 (producto)
        matC = [["null" for j in range(Bfc[1])] for i in range(Afc[0])]
                            #crear matriz C
        if Afc[1] != Bfc[0]:    #si las filas de A son diferentes a las columnas de B
            print("La cantidad de filas de una matriz debe coincidir con la de las columnas de la otra")
        else:                   #si las filas de A coinciden con las columnas de B
            matA = crearMat(Afc,"A")
            matB = crearMat(Bfc,"B")
            print("\nA * B = ")
            matC = producto(matC, matA, matB)       #C = A*B
            print(numpy.matrix(matC))   #imprimir matriz C
            check = 1
