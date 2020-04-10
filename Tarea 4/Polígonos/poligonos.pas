program Poligonos;
uses crt;
var
	lados, i : integer;
	medida1, medida2, medida3 : real;
	poligono : string;

procedure triangulo();
begin
	writeln('Ingresar medida del primer lado: ');
	readln(medida1);
	writeln('Ingresar medida del segundo lado: ');
	readln(medida2);
	writeln('Ingresar medida del tercer lado: ');
	readln(medida3);

	if not ((medida1 + medida2 > medida3) and (medida2 + medida3 > medida1) and (medida1 + medida3 > medida2)) then
	begin
		writeln('El triangulo no existe.');
		exit;
	end;


	if (medida1 = medida2) and (medida2 = medida3) then 
		writeln('El triangulo es equilatero.')
	else if (medida1 <> medida2) and (medida1 <> medida3) and (medida2 <> medida3) then
		writeln('El triangulo es escaleno.')
	else
		writeln('El triangulo es isosceles.');
end;

begin
	repeat
		writeln('Ingresar numero de lados: ');
		readln(lados);
		if lados < 3 then
			writeln('Un poligono debe tener al menos 3 lados.')
		else if lados > 12 then
			writeln('Maximo 12 lados.')
		else
			break;
	until false;

	case (lados) of
		3: begin
			triangulo();
			readkey;
			exit;
		end;
		4: poligono := 'cuadrilatero';
		5: poligono := 'pentagono';
		6: poligono := 'hexagono';
		7: poligono := 'heptagono';
		8: poligono := 'octagono';
		9: poligono := 'nonagono';
		10: poligono := 'decagono';
		11: poligono := 'undecagono';
		12: poligono := 'dodecagono';
	end;
	writeln('Ingresar medida de un lado: ');
	readln(medida1);
	lados := lados - 1;

	for i := 1 to lados do
	begin
		writeln('Ingresar medida de otro lado: ');
		readln(medida2);
		if (medida1 <> medida2) then
		begin
			writeln('El ',poligono,' es irregular.');
			break;
		end;
	end;
	if (medida1 = medida2) then
		writeln('El ',poligono,' es regular.');
	readkey;
end.