def entrada():              #leer números y guardarlos en el arreglo
    n = 1                       #el número a guardar
    print("Ingresar los números deseados uno por uno (0 para terminar)")
    while n != 0:               #mientras no se ingrese 0
        n = input()             #leer número
        if n == "":            #si no se introdujo nada
            continue                #volver a leer
        if not n.isdigit():   #si no es un número
            print("Solo números enteros positivos")
            continue
        else:                   #si sí es número
            n = int(n)              #convertir entrada a entero
            if n == 0:              #si se ingresa 0
                continue                #repetir ciclo
            elif n == 1:
                print("Número omitido")
                continue

            if not repetido(n):    #si no está repetido
                nums.append(n)          #agregar número al arreglo
            else:                   #si está repetido
                print("No repetir números")
    return

def repetido(nuevo):    #checar si el número ya se había introducido
    for num in nums:        #recorrer cada número del arreglo
        if num == nuevo:        #si hay coincidencia
            return True                #regresar 1 (sí está repetido)
    return False                #regresar 0 (no está repetido)

nums = []               #arreglo para guardar números
print("Calculadora del mínimo común múltiplo")
largo = 0               #tamaño del arreglo, de momento es 0 
while largo < 2:        #mientras el tamaño sea menor de 2
    print("Se requieren al menos dos números")
    entrada()               #leer números y guardarlos en arreglo
    largo = len(nums)       #obtener largo del arreglo

#imprimir 'mcm(a, b, c...) ='
print("mcm(", end="")
for x in nums:
    print(x,", ", end="", sep="")
print("\b\b  \b\b", end="")
print(") = ", end="")

mcm = max(nums)     #obtener el número mayor del arreglo
esMcm = 0           #de momento no es mcm
while esMcm == 0:   #mientras no sea mcm
    esMcm = 1           #de momento sí es mcm
    for x in nums:      #recorrer cada número del arreglo
        if(mcm % x != 0):   #si el residuo entre el supuesto mcm y el número es diferente de 0
            esMcm = 0           #no es mcm
            break
    if(esMcm == 1):     #si sí es mcm
        break
    mcm += 1            #incremento de mcm

print(mcm)
