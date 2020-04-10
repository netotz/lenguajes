import numpy

def validar(num, op):           #validar entrada de números
    if(num == ""):                  #si no se introdujo nada
        print("\tIngresar números")
        return "null"                   #regresar "null"
    copia = num                     #crear copia
    if copia[0] == "-":             #si el primer caracter es un signo de menos
        copia = copia.replace("-","",1) #omitir el signo
    if op == "cel":                 #si se está validando que sea float
        copia = copia.replace(".","",1) #omitir un punto
            
    if copia.isdigit() == 0:       #si no es un número
        if op == "int":             #si se quiere int
            print("Solo números enteros positivos")
        elif op == "cel":           #se se quiere float
            print("Solo números")
            
        return "null"                    #regresar que no es número
    else:                           #si sí es número
        if op == "int":    #si se quiere int
            return int(num)               #regresar string convertido a int
        elif op == "cel":               #si se quiere float
            return float(num)                 #regresar strng convertido a 

S = ["null","null"]         #filas y columnas de la matriz del sistema
print("Resolución de sistemas de ecuaciones lineales")
while S[0] == "null":       #mientras las filas no sean válidas
    print("\nIngresar cantidad de variables del sistema (máximo 5): ", end = "")
    S[0] = input()              #leer filas
    S[0] = validar(S[0],"int")  #validar entrada
    if S[0] == "null":
        continue
    
    if S[0] <= 0:                #si las filas son menores a 1
        print("Sistema sin variables")
        S[0] = "null"
    elif S[0] > 5:
        print("Máximo 5 variables")
        S[0] = "null"
    else:                       #si las filas son mayores o igual a 1
        S[1] = S[0] + 1             #las columnas serán filas+1
    
sistem = [["null" for j in range(S[1])] for i in range(S[0])]   #crear matriz
print("Cada fila es una ecuación. Cada columna es un coeficiente de una variable, excepto la última, que es la igualdad.")
print("Llenar sistema en posición:")
for i in range(S[0]):               #recorrer filas
    for j in range(S[1]):               #recorrer columnas
        sistem[i][j] = "null"           #de momento la celda no es válida
        while sistem[i][j] == "null":   #mientras la celda no sea válida
            print("\t[",i,"][",j,"] = ", sep = "", end = "")
            sistem[i][j] = input()          #leer celda
            sistem[i][j] = validar(sistem[i][j], "cel")#validar celda
print("Sistema original:")
print(numpy.matrix(sistem))     #imprimir matriz
print("\nSistema resuelto:")

pivant = 1      #pivote anterior
pivact = 0      #pivote actual
iterador = 0
trans = [["null" for j in range(S[1])] for i in range(S[0])]    #crear matriz
while iterador < S[0]:      #mientras iterador sea menor al número de filas
    pivact = sistem[iterador][iterador] #pivote actual es el primer elemento del sistema
    for j in range(S[1]):       #recorrer columnas
        trans[iterador][j] = sistem[iterador][j] #copiar fila
    for i in range(S[0]):       #recorrer filas
        if i != iterador:           #si es diferente al iterador
            trans[i][iterador] = 0.0    #hacer 0 a los elementos de la columna por debajo del pivote
        else:                       #si son iguales
            trans[i][i] = pivact        #copiar pivote actual
    for i in range(S[0]):       #recorrer filas
        if i != iterador:           #si es diferente al iterador
            for j in range(S[1]):       #recorrer columnas
                if j != iterador:           #si es diferente al iterador
                    trans[i][j] = ((sistem[i][j] * pivact) - (sistem[iterador][j] * sistem[i][iterador])) / pivant
                                                #definir celda
    for i in range(S[0]):       #recorrer filas
        for j in range(S[1]):       #recorrer columnas
            sistem[i][j] = trans[i][j]  #copiar matriz
    pivant = pivact             #pivote 'anterior' ahora es el pivote 'actual'
    if pivant == 0:             #si el pivote es 0
        print("No existe solución")
        exit()                      #salir
    iterador += 1
for i in range(S[0]):       #recorrer filas
    for j in range(S[1]):       #recorrer columnas
        sistem[i][j] = sistem[i][j] / pivact    #dividir celda entre pivote actual
        if sistem[i][j] == -0:
            sistem[i][j] = 0

print(numpy.matrix(sistem))
