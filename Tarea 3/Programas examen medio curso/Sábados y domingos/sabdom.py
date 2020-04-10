def isLeap(year):
	return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

def mesesDias(year):
	meses = list()
	bul = True
	for i in range(12):
		if i == 1:
			meses.append(29) if isLeap(year) else meses.append(28)
		else:
			if i == 7:
				bul = not bul
			meses.append(31) if bul else meses.append(30)

		bul = not bul

	return meses

def contarDias(fecha):
	dias = 0
	for year in range(fecha[0] - 1, 0, -1):
		if isLeap(year):
			dias += 366
		else:
			dias += 365

	meses = mesesDias(fecha[0])

	for mes in range(fecha[1] - 1):
		dias += meses[mes]

	dias += fecha[2]

	return dias

def validPosInt(buff):
	try:
		int(buff)
		return True
	except ValueError:
		return False

def pedirFecha(txt):
	fecha = list()
	print('')
	while True:
		print("Ingresar año ",txt,": ", sep='', end='')
		num = input()
		if validPosInt(num) and int(num) > 0:
			break
		print("\tSolo años de la era común (después de Cristo).")
	fecha.append( int(num) )
	meses = mesesDias( int(num) )

	while True:
		print("Ingresar número de mes ",txt,": ", sep='', end='')
		num = input()
		if validPosInt(num) and int(num) > 0 and int(num) < 13:
			break
		print("\tMes no válido.")
	fecha.append( int(num) )
	mes = int(num)

	while True:
		print("Ingresar día del mes ",txt,": ", sep='', end='')
		num = input()
		if validPosInt(num) and int(num) > 0:
			if int(num) <= meses[mes - 1]:
				break
			else:
				print("\tEl mes ingresado solo tiene",meses[mes - 1],"días.")
		else:
			print("\tEntrada no válida.")
	fecha.append( int(num) )

	return fecha

def main():
	while True:
		ini = pedirFecha("de nacimiento")
		fin = pedirFecha("actual")

		if ini[0] > fin[0]:
			print("\tLas fechas no concuerdan.")
			continue

		diaSem = input("Ingresar día de la semana actual (0 es lunes, 1 es martes ... 6 es domingo): ")
		dias = (contarDias(fin) - contarDias(ini) ) + 1

		if dias <= 0:
			print("\tLas fechas no concuerdan.")
			continue
		else: break

	calcular(dias, int(diaSem) )

	return

def calcular(diasv, diasem):
	sab = 0
	dom = 0
	for i in range(diasv, 0, -1):
		if diasem == 5:
			sab += 1
		elif diasem == 6:
			dom += 1

		if diasem == 0:
			diasem = 6
		else:
			diasem -= 1

	print("\n\tHa vivido",sab,"sábado", end='')
	print("s", end='') if sab != 1 else None
	print(" y",dom,"domingo", end='')
	print("s\n", end='') if dom != 1 else None

	return

main()