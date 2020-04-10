import re

def buscar(part):       #buscar si k-mero está repetido
    for key in particulas:  #recorrer IDs del diccionario
        if key == part:         #si sí está repetido
            return 1                #regresar 1 (true)
    return 0                #regresar 0 (false) si no está repetido

def validBin(string):       #validar si es binario
    return re.search(r"^[01]+$",string)

def contar(string, part):   #contar ocurrencias del kmero en el string
    ocurrencias = 0
    inicio = 0
    while True:
        inicio = string.find(part, inicio) + 1
        if inicio > 0:
            ocurrencias += 1
        else:
            return ocurrencias
    
print("Calcular k-meros más frecuentes")
largo = 0
while largo < 2 or largo > 20:           #mientras el string tenga más de 20 caracteres
    print("Ingresar un número binario (máximo 20 caracteres): ",end = "")
    entrada = input()           #leer string
    largo = len(entrada)        #guardar tamaño de string
    if not validBin(entrada):           #si no es binario
        print("\tSolo números binarios")
        largo = 0
        continue
    if largo < 2:            #si tiene 1 caracter o menos
        print("\tSe requieren al menos 2 caracteres")
    elif largo > 20:
        print("\tMáximo 20 caracteres")

particulas = {}         #diccionario para guardar todos k-meros

kmero = ["" for i in range(largo)]  #lista para guardar temporalmente cada k-mero
for size in range(1,largo+1):         #tamaño de k-meros
    for pos in range(largo - (size-1) ):#posición del string donde se comenzará a guardar el k-mero
        for x,y in zip( range(pos, pos+size),range(size) ):
                #recorrer desde posición enviada hasta el tamaño del k-mero más la posición para el string
                #recorrer tamaño del k-mero
            kmero[y] = entrada[x]          #agregar caracter del string al k-mero
        
        buff = ''.join(kmero)           #convertir k-mero en string
        
        repetido = buscar(buff)         #buscar si k-mero está repetido
        if repetido == 0:               #si no está repetido
            contador = contar(entrada,buff)      #contar cúantas veces está el k-mero en el string
            particulas[buff] = contador * size  #guardar k-mero como IDs en diccionario y su frecuencia como su valor

mayor = 0               #de momento la mayor frecuencia es 0
for key in particulas:      #recorrer IDs del diccionario
    if particulas[key] > mayor: #si el valor actual es mayor al anterior
        mayor = particulas[key]     #guardar nueva frecuencia mayor

for key,val in particulas.items():  #recorrer registros del diccionario
    print("\t'",key,"': ",val, sep="")  #imprimir registro

print("\nk-meros más frecuentes:")
for key,val in particulas.items():  #recorrer registros del diccionario
    if particulas[key] == mayor:        #si el valor es igual a la frecuencia mayor
        print("\t'",key,"': ",val, sep="")  #imprimir registro
