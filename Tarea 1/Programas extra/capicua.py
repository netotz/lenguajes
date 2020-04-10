print("Ingresar string:")
buff = input()                  #entrada de string
buff = buff.lower()             #hacer todo minúsculas
buff = buff.replace(" ", "")    #quitar espacios

largo = len(buff)       #obtener el largo de string
if(largo <= 0):         #si son 0 o menos caracteres
    print("Se requiere string")
    exit()                  #fin
elif(largo == 1):       #si solo es 1 caracter
    print("Se requiere más de una letra")
    exit()                  #fin
else:                   #si son más de 1 caracter
    igual = 1               #de momento el string lo forma el mismo caracter
    m = buff[0]             #guardar primer caracter
    for n in buff:          #checar si es el mismo caracter
        if(n != m):             #si un caracter es diferente al primero
            igual = 0               #no es el mismo caracter
            break                   #romper for
    if(igual == 1):         #si es el mismo caracter
        print("Se requieren distintas letras")
        exit()                  #fin

mitad = int(largo/2)    #guardar la mitad del largo
capicua = 1             #de momento sí es capicúa

y = largo-1             #recorrerá el string de atrás para adelante
for x in range(largo):  #recorrer string desde el inicio
    if(x == y):             #si 'x' y 'y' están en la misma posición
        break                   #romper for
    if(buff[x] != buff[y]): #si el caracter en 'x' es diferente al de 'y'
        capicua = 0             #no es capicúa
        print("No es capicúa")
        exit()                  #salir
    y -= 1;                 #decremento de 'y'
    
if(capicua == 1):       #si sí es capicúa
    print("CAPICÚA")
