def unids(unid, txt):       #ingresar opción
    imprim(txt)                 #imprimir unidades disponibles
    unid = ''                   #de momento la opción no es válida
    while not validarInt(unid):
                                #mientras no sea válida
        print("Elegir entre opciones disponibles")
        print("\tOpción: ", end="")
        unid = input()              #leer opción
        if validarInt(unid) and (int(unid) < 1 or int(unid) > 4):
                                    #si es entero pero es menor a 1 o mayor a 4
            unid = ''               #invalidar opción
    
    return int(unid)            #regresar opción como entero

def imprim(buff):   #imprimir opciones disponibles
    print("\nSeleccionar unidad ",buff,":",end="\n",sep="")
    print("\t1. °C (grados Celsius)")
    print("\t2. °F (grados Fahrenheit")
    print("\t3.  K (Kelvin)")
    print("\t4.  R (Rankine)")
    return

def asign(unidad):  #asignar nombre de unidad a la opción ingresada #
    if(unidad == 1):
        unidad = "°C"
    elif(unidad == 2):
        unidad = "°F"
    elif(unidad == 3):
        unidad = "K"
    else:
        unidad = "R"
    return unidad

def validarInt(num): #validar entero #
    try:
        int(num)
        return True
    except ValueError:
        return False

def validarFloat(num):  #validar número #
    try:
        float(num)
        return True
    except ValueError:
        print("Solo  números")
    return False
	
def entrada(temp):
	while not validarFloat(temp):          #mientras no sea válido #
		print("\nIngresar temperatura: ",end="")
		temp = input()                #ingresar temperatura 1}
		
	return float(temp)

print("CONVERSOR DE UNIDADES DE TEMPERATURA")
t1 = ''                  #valor de entrada, no es número de momento
t2 = 0.0                    #valor de salida

while True:
	t1 = entrada('')
	if t1 < -459.67:
		print("\nNinguna escala acepta valores inferiores a -459.67")
	else:
		break

ui = 0                  #unidad inicial no es válida de momento
uf = 0                  #unidad final no es válida de momento
while ui == uf:             #mientras se escojan las mismas opciones
    ui = unids(ui,"inicial")    #leer opción de unidad inicial
    if (t1 < 0 and (ui == 3 or ui == 4) ) or (t1 < -273.15 and ui == 1) or (t1 < -459.67 and ui == 2):    #si menor al cero absoluto
        print("No se permiten valores menores al cero absoluto")
        uf = ui
        continue
    uf = unids(uf,"final")      #leer opción de unidad final
    if ui == uf:
        print("\nSeleccionar diferentes unidades")

#operaciones de conversión
if(ui == 1):    #de °C
    if(uf == 2):    #a °F
        t2 = ( (9/5)*t1 ) + 32
    elif(uf == 3):  #a K
        t2 = t1 + 273.15
    else:           # a R
        t2 = ( (9*t1)/5 ) + 491.67
elif(ui == 2):          #de °F
    t2 = (5/9)*(t1 - 32)    #a °C
    if(uf == 3):            #a K
        t2 += 273.15
    elif(uf == 4):          #a R
        t2 = t1 + 459.67
elif(ui == 3):      #de K
    if uf == 1:         #a °C
        t2 = t1 - 273.15
    if(uf == 2):        #a °F
        t2 = ( (9/5)*(t1 - 273.15) ) + 32
    elif(uf == 4):      #a R
        t2 = (9 * t1) / 5
else:               #de R
    if(ui == 1):        #a °C
        t2 = (5* (t1 - 491.67) ) / 9
    elif(uf == 2):      #a °F
        t2 = t1 - 459.67
    elif(uf == 3):      #a K
        t2 = (5 * t1 ) / 9
        
if (t2 < 0 and (uf == 3 or uf == 4) ) or (t2 < -273.15 and uf == 1) or (t2 < -459.67 and uf == 2):    #si menor al cero absoluto
    print("\nNo se permiten valores menores al cero absoluto")
    exit()
    
t2 = round(t2,2)            #redondear resultado a 2 decimales #
ui = asign(ui)              #asignar unidad inicial
uf = asign(uf)              #asignar unidad final
print("\n",t1,ui,"=",t2,uf) #imprimir igualdad
