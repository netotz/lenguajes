siguio(victoria, guerrero).
siguio(guerrero, bocanegra).
siguio(bocanegra, velez).
siguio(velez, bustamante).
siguio(bustamante, muzquiz).
siguio(muzquiz, pedraza).
siguio(pedraza, farias).
siguio(farias, santa).
siguio(santa, barragan).
siguio(barragan, corro).
siguio(corro, 'Anastasio Bustamante').
siguio('Anastasio Bustamante', santa).
siguio(santa, bravo).
siguio(bravo, 'Anastasio Bustamante').
siguio('Anastasio Bustamante', javier). 
siguio(javier, santa).
siguio(santa, rueda).
siguio(rueda, santa).
siguio(santa, canalizo).
siguio(canalizo, santa).
siguio(santa, herrera).
siguio(herrera, canalizo).
siguio(canalizo, herrera).
siguio(herrera, paredes).
siguio(paredes, bravo).
siguio(bravo, salas).
siguio(salas, gomez).
siguio(gomez, santa).
siguio(santa, anaya).
siguio(anaya, pena).
siguio(pena, herrera).
siguio(herrera, arista).
siguio(arista, ceballos).
siguio(ceballos, lombardini).
siguio(lombardini, santa).
siguio(santa, carrera).
siguio(carrera, vega).
siguio(vega, benitez).
siguio(benitez, comonfort).
siguio(comonfort, habsburgo).
siguio(habsburgo, benito).
siguio(benito, tejada).
siguio(tejada, iglesias).
siguio(iglesias, mendez).
siguio(mendez, diaz).
siguio(diaz, gonzalez).
siguio(gonzalez, diaz).
siguio(diaz, leon).
siguio(leon, madero).
siguio(madero, lascurain).
siguio(lascurain, 'Huerta Ortega').
siguio('Huerta Ortega', carvajal).
siguio(carvajal, gutierrez).
siguio(gutierrez, 'Venustiano Carranza').
siguio('Venustiano Carranza', garza).
siguio(garza, chazaro).
siguio(chazaro, carranza).
siguio(carranza, huerta).
siguio(huerta, obregon).
siguio(obregon, calles).
siguio(calles, portes).
siguio(portes, ortiz).
siguio(ortiz, rodriguez).
siguio(rodriguez, cardenas).
siguio(cardenas, avila).
siguio(avila, aleman).
siguio(aleman, 'Cortines').
siguio('Cortines', 'Mateos').
siguio('Mateos', 'Ordaz').
siguio('Ordaz', 'Echeverria').
siguio('Echeverria', 'Portillo').
siguio('Portillo', 'Madrid').
siguio('Madrid', 'Gortari').
siguio('Gortari', 'Zedillo').
siguio('Zedillo', 'Fox').
siguio('Fox', 'Calderon').
siguio('Calderon', 'Nieto').
siguio('Nieto', 'Obrador').

predecesor(X,Y) :- siguio(X,Y).
predecesor(X,Z) :- siguio(Y,Z), predecesor(X,Y).

sucesor(A,B) :- siguio(B,A).
sucesor(A,C) :- siguio(B,A), sucesor(B,C).

consulta(X) :-
	predecesor(A,X),
	write("Predecesor: "), write(A), nl,
	sucesor(B,X),
	write("Sucesor: "), write(B), nl, !.