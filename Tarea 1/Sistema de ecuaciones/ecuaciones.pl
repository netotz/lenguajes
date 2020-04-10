use Scalar::Util qw(looks_like_number);
use Data::Types qw(is_int);
use Math::Round qw(nearest);

sub validPosInt{
	my ($num) = @_;
	if( looks_like_number($num) ){
		if( is_int($num) ){
			if($num >= 0){
				return 0;
			}
		}
	}
	print "\tSolo numeros enteros positivos\n";
	return 1;
}

sub llenarSis{
	for($i = 0; $i < $Sfc[0]; $i++){
		for($j = 0; $j < $Sfc[1]; $j++){
			do{
				print "\t[$i][$j] = ";
				$sistem[$i][$j] = <>;
			}
			while( validNum($sistem[$i][$j]) );
		}
	}
	
	return;
}

sub validNum{
	my ($num) = @_;
	if( looks_like_number($num) ){
		return 0;
	}
	print "\tSolo numeros\n";
	return 1;
}

sub printSis{
	for($i = 0; $i < $Sfc[0]; $i++){
		print chr(124)." ";
		for($j = 0; $j < $Sfc[1]; $j++){
			chomp $sistem[$i][$j];
			print nearest(.001, $sistem[$i][$j])."\t";
		}
		print chr(124)."\n";
	}
	print "\n";
	return;
}

sub resolver{
	my $pivant = 1;
	my $pivact;
	my $iter = 0;
	my @trans;
	while($iter < $Sfc[0]){
		$pivact = $sistem[$iter][$iter];
		for($j = 0; $j < $Sfc[1]; $j++){
			$trans[$iter][$j] = $sistem[$iter][$j];
		}
		
		for($i = 0; $i < $Sfc[0]; $i++){
			if($i != $iter){
				$trans[$i][$iter] = 0.0;
			}
			else{
				$trans[$i][$i] = $pivact;
			}
		}
		for($i = 0; $i < $Sfc[0]; $i++){
			if($i != $iter) {
				for($j = 0; $j < $Sfc[1]; $j++){
					if($j != $iter){
						$trans[$i][$j] = (($sistem[$i][$j] * $pivact) - ($sistem[$iter][$j] * $sistem[$i][$iter])) / $pivant;
					}
				}
			}
		}
		for($i = 0; $i < $Sfc[0]; $i++){
			for($j = 0; $j < $Sfc[1]; $j++){
				$sistem[$i][$j] = $trans[$i][$j];
			}
		}
		$pivant = $pivact;
		if($pivant == 0){
			print "\n\tNo existe solucion";
			exit 0;
		}
		$iter++;
	}
	for($i = 0; $i < $Sfc[0]; $i++){
		for($j = 0; $j < $Sfc[1]; $j++){
			$sistem[$i][$j] = $sistem[$i][$j] / $pivact;
		}
	}
	
	return;
}

@Sfc;

print "\nResolver sistema de ecuaciones lineales\n";
$Sfc[0] = -1;
do{{
	if($Sfc[0] > 5){
		print "\tMaximo 5 variables\n";
	}
	elsif($Sfc[0] == 0){
		print "\tSistema sin variables\n";
	}
	print "Cantidad de variables en el sistema (maximo 5): ";
	$Sfc[0] = <>;
}}
while(validPosInt($Sfc[0]) or $Sfc[0] == 0 or $Sfc[0] > 5);

$Sfc[1] = $Sfc[0] + 1;

print "\nLos valores de la ultima columna son las igualdades de cada ecuacion, que es cada fila\n";
print "Cada fila es una ecuacion. Cada columna es un coeficiente de la variable, excepto la ultima, que es la igualdad.\n";
print "Llenar sistema en posicion:\n";
@sistem;
llenarSis();

print "\nSistema original:\n";
printSis();
print "Sistema resuelto:\n";
resolver();
printSis();