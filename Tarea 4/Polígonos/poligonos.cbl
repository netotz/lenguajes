	identification division.
	program-id. poligonos.

	environment division.
	data division.
	working-storage section.
	77 lados pic 9(10).
	77 medida1 pic 9(10).
	77 medida2 pic 9(10).
	77 medida3 pic 9(10).
	77 poligono pic x(12).

	procedure division.
	MAIN.
		move 1 to lados
		perform PEDIR until lados > 2
		evaluate true
			when lados = 3
				go to TRIAN
			when lados = 4
				move "cuadrilatero" to poligono
			when lados = 5
				move "pentagono" to poligono
			when lados = 6
				move "hexagono" to poligono
			when lados = 7
				move "heptagono" to poligono
			when lados = 8
				move "octagono" to poligono
			when lados = 9
				move "nonagono" to poligono
			when lados = 10
				move "decagono" to poligono
			when lados = 11
				move "undecagono" to poligono
			when lados = 12
				move "dodecagono" to poligono
			when other
				display "Maximo 12 lados."
				go to MAIN
		end-evaluate.

		display "Ingresar medida de un lado: "
		accept medida1
		compute lados = lados - 1

		perform LOOP lados times
		display "El " poligono " es regular."
		stop run.

	PEDIR.
		display "Ingresar cantidad de lados del poligono: "
		accept lados
		if lados < 3 then
			display "Un poligono debe tener 3 lados o mas.".

	LOOP.
		display "Ingresar medida de otro lado: "
		accept medida2
		if not medida2 = medida1 then
			display "El " poligono " es irregular."
			stop run.

	TRIAN.
		display "Ingresar medida del primer lado: "
		accept medida1
		display "Ingresar medida del segundo lado: "
		accept medida2
		display "Ingresar medida del tercer lado: "
		accept medida3

		if medida1 = medida2 and medida2 = medida3 then
			display "El triangulo es equilatero."
			stop run
		end-if
		if not medida1 = medida2 and not medida1 = medida3 then
			if not medida2 = medida3 then
				display "El triangulo es escaleno."
				stop run
			end-if
		end-if

		display "El triangulo es isosceles."
		stop run.