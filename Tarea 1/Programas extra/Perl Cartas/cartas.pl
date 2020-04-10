use Term::ReadKey;

sub agregar{						#agregar carta aleatoria al mazo
	my ($id) = @_;						#argumentos de la función
	my $randpalo = int(rand 4);			#obtener palo aleatorio
	my $randfig = int(rand 13);			#obtener figura o número aleatorio
	my $randcarta = "$figuras[$randfig]"."$palos[$randpalo]";
										#juntar figura y palo y obtener carta aleatoria
	$rep = buscar($randcarta);			#buscar si la carta ya se guardó en el mazo
	if($rep == -1){						#si la carta no se ha guardado
		$mazo[$id] = $randcarta;			#guardarla en el mazo
	}
	
	return $rep;						#regresar si está repetida o no
}

sub buscar{							#buscar carta en el mazo
	my ($str) = @_;						#argumento de la función
	for(my $pos = 0; $pos < 52; $pos++){#recorrer cartas del mazo
		if($mazo[$pos] eq $str){			#si ya se había guardado
			return $pos;						#regresar posición de la carta (repetido)
		}
	}
	
	return -1;							#regresar -1 (no se ha guardado)
}

sub sacar{									#sacar carta
	my $randcard = $mazo[int(rand $cantidad)];	#obtener carta al azar del mazo aleatorio
	my $nextcard = "";							#declarar carta sucesora
	splice @mazo, buscar($randcard), 1;			#borrar carta sacada del mazo aleatorio
	$cantidad--;								#actualizar la cantidad actual de cartas en el mazo aleatorio

	for($i = 0; $i < 4; $i++){					#recorrer palos
		for($j = 0; $j < 13; $j++){					#recorrer números y figuras
			if($baraja[$i][$j] eq $randcard){			#cuando se encuentre la carta sacada en una baraja ordenada
				if($j == 12){								#si la carta sacada es un 'K' (rey)
					$j = -1;									#ir al inicio del arreglo
				}
				$nextcard = $baraja[$i][$j+1];				#obtener carta sucesora
				last;										#romper for
			}
		}
	}

	print "\n\nTu carta es $randcard";
	if(buscar($nextcard) == -1){				#si la carta sucesora ya se había sacado
		print "\nLa siguiente carta, $nextcard, ya no esta en el mazo!";
													#la probabilidad es 0
	}
	else{										#si la carta sucesora sigue en el mazo
		printf("\nLa probabilidad de sacar $nextcard es de %.5f\n",1/$cantidad);
													#mostrar probabilidad de sacarla
	}
	print "\n\tPresione cualquier tecla para sacar otra carta...";
	ReadMode 3;
	my $tecla = getc;
	ReadMode 1;
	return;
}
#arreglo 'palos' para guardar letras de los palos
$palos[0] = "C";	#corazones
$palos[1] = "D";	#diamantes
$palos[2] = "T";	#tréboles
$palos[3] = "P";	#picas
for($i = 0; $i < 13; $i++){	#recorrer figuras y números para guardarlos en orden
	if($i == 0){
		$figuras[$i] = "A";
	}
	elsif($i == 10){
		$figuras[$i] = "J";
	}
	elsif($i == 11){
		$figuras[$i] = "Q";
	}
	elsif($i == 12){
		$figuras[$i] = "K";
	}
	else{
		$figuras[$i] = $i+1;
	}
}

for($i = 0; $i < 4; $i++){			#recorrer filas para asginar palo
	for($j = 0; $j < 13; $j++){			#recorrer columnas para asignar figura o número
		$baraja[$i][$j] = "$figuras[$j]"."$palos[$i]"	#asignar figura y palo a la celda
	}
}

for($i = 0; $i < 52; $i++){	#recorrer las 52 cartas en el mazo aleatorio
	if(agregar($i) != -1){		#si ya está repetida la carta
		$i--;						#decrementar índice
	}
}

$cantidad = 52;		#cantidad de cartas iniciales en el mazo aleatorio
do{						#hacer
	sacar();				#sacar carta
}
while($cantidad > 0);	#mientras haya al menos una carta