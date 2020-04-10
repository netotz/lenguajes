use Scalar::Util qw(looks_like_number);
use Data::Types qw(is_int);

sub llenarMat{
	my ($letra, @Mfc, @matX) = @_;
	print "Llenar matriz '$letra' en posicion:\n";
	for($i = 0; $i < $Mfc[0]; $i++){
		for($j = 0; $j < $Mfc[1]; $j++){
			do{
				print "\t[$i][$j] = ";
				$matX[$i][$j] = <>;
			}
			while( validNum($matX[$i][$j]) );
		}
	}
	
	return @matX;
}

sub validNum{
	my ($num) = @_;
	if( looks_like_number($num) ){
		return 0;
	}
	print "\tSolo numeros\n";
	return 1;
}

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

sub dims{
	my ($letra) = @_;
	my @Mfc;
	print "\nIngresar dimensiones de matriz $letra:\n";
	do{
		print "\tFilas: ";
		$Mfc[0] = <>;
	}
	while(validPosInt($Mfc[0]));
	
	do{
		print "\tColumnas: ";
		$Mfc[1] = <>;
	}
	while(validPosInt($Mfc[1]));
	
	return @Mfc;
}

sub validMat{
	my ($letra, @Mfc) = @_;
	my $valid = 0;
	do{
		@Mfc = dims($letra);
		if($Mfc[0] <= 1 and $Mfc[1] <=1 or ($Mfc[0] == 0 or $Mfc[1] == 0) ){
			print "\n'$letra' no es una matriz\n";
			$valid = 0;
		}
		else{
			$valid = 1;
		}
	}
	while($valid == 0);
	
	return @Mfc;
}

sub printMat{
	my ($Mfc, $matX) = @_;
	for($i = 0; $i < @$Mfc[0]; $i++){
		print chr(124)." ";
		for($j = 0; $j < @$Mfc[1]; $j++){
			chomp $$matX[$i][$j];
			print "$$matX[$i][$j]\t";
		}
		print chr(124)."\n";
	}
	print "\n";
	return;
}

sub printOps{
	print <<EOF;
Seleccionar operacion:
	1. Suma     (A+B)
	2. Producto (A*B)
EOF
}

sub suma{
	my @matX = @_;
	for($i = 0; $i < $Afc[0]; $i++){
		for($j = 0; $j < $Afc[1]; $j++){
			$matX[$i][$j] = $matA[$i][$j] + $matB[$i][$j];
		}
	}
	return @matX;
}

sub producto{
	my @matX = @_;
	for($a = 0; $a < $Afc[0]; $a++){
		for($b = 0; $b < $Bfc[1]; $b++){
			$sum = 0;
			for($i = $a, $j = 0, $k = 0, $l = $b; $j < $Afc[1] and $k < $Bfc[0]; $j++, $k++){
				$sum += $matA[$i][$j] * $matB[$k][$l];
			}
			$matX[$a][$b] = $sum;
		}
	}
	
	return @matX;
}

sub crearMats{
	@matA = llenarMat("A",@Afc,@matA);
	@matB = llenarMat("B",@Bfc,@matB);
	
	return;
}

print "\nOperaciones con matrices\n";
printOps();
$op = 1;
do{
	if($op < 1 or $op > 2){
		print "\tSolo opciones disponibles\n";
	}
	print "\tOpcion: ";
	$op = <>;
}
while(validPosInt($op) or $op < 1 or $op > 2);

do{{
	@Afc = validMat("A",@Afc);
	@Bfc = validMat("B",@Bfc);
	if($op == 1){
		if($Afc[0] != $Bfc[0] or $Afc[1] != $Bfc[1]){
			print "Se requieren matrices de dimensiones iguales\n";
			$check = 0;
			next;
		}
		else{
			crearMats();
			print "\nA + B =\n";
			@matR = suma(@matR);
			printMat(\@Afc, \@matR);
			$check = 1;
		}
	}
	elsif($op == 2){
		if($Afc[1] != $Bfc[0]){
			print "Las filas de una matriz deben coincidir con las columnas de la otra\n";
			$check = 0;
			next;
		}
		else{
			crearMats();
			print "\nA * B =\n";
			@Rfc;
			$Rfc[0] = $Afc[0];
			$Rfc[1] = $Bfc[1];
			@matR = producto(@matR);
			printMat(\@Rfc, \@matR);
			$check = 1;
		}
	}
}}
while(!$check);