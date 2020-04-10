use Scalar::Util qw(looks_like_number);
use Data::Types qw(is_int);

sub asignar{
	my ($unidad) = @_;
	if($unidad == 1){
		$unidad = chr(248)."C";
	}
	elsif($unidad == 2){
		$unidad = chr(248)."F";
	}
	elsif($unidad == 3){
		$unidad = "K";
	}
	else{
		$unidad = "R";
	}
	
	return $unidad;
}

sub leerUnids{
	my ($op) = $_[0];
	my ($str) = $_[1];
	imprimirUnids($str);
	do{
		$op = <>;
	}
	while(validarOp($op));
	
	return $op;
}

sub imprimirUnids{
	my ($str) = @_;
	print "\nSeleccionar unidad $str:\n";
	print <<EOF;
		1. Grados Celsius (°C)
		2. Grados Fahrenheit (°F)
		3. Kelvin (K)
		4. Rankine (R)
EOF
	print "\tOpcion: ";
}

sub validarNum{
	my ($num) = @_;
	if(looks_like_number($num)){
		return 0;
	}
	else{
		print "Solo numeros\n";
		return 1;
	}
}

sub validarOp{
	my ($op) = @_;
	if( looks_like_number($op) ){
		if( is_int($op) ){
			if($op >= 1 and $op <= 4){
				return 0;
			}
		}
	}
	print "Solo opciones disponibles";
	return 1;
}

print "CONVERSOR DE TEMPERATURAS\n";
my $t1 = 0;
do{
	if($t1 < -459.67){
		print "Ninguna escala acepta valores inferiores a -459.67\n";
	}
	print "Ingresar temperatura inicial: ";
	$t1 = <>;
}
while(validarNum($t1) or $t1 < -459.67);
	
do{{
	$ui = leerUnids($ui,"inicial");
	if( ($t1 < 0 and ($ui == 3 or $ui == 4) ) or ($t1 < -273.15 and $ui == 1) or ($t1 < -459.67 and $ui == 2) ){
		print "No se permiten valores menores al cero absoluto\n";
		$uf = $ui;
		next;
	}
	
	$uf = leerUnids($uf,"final");
	if($ui == $uf){
		print "Seleccionar unidades diferentes";
	}
}}
while($ui == $uf);

if($ui == 1){
	$t2 = (9/5)*$t1;
	if($uf == 2){
		$t2 += 32;
	}
	elsif($uf == 3){
		$t2 = $t1 + 273.15;
	}
	else{
		$t2 += 491.67;
	}
}
elsif($ui == 2){
	$t2 = (5/9)*($t1 - 32);
	if($uf == 3){
		$t2 += 273.15;
	}
	elsif($uf == 4){
		$t2 = $t1 + 459.67;
	}
}
elsif($ui == 3){
	if($uf == 1){
		$t2 = $t1 - 273.15;
	}
	elsif($uf == 2){
		$t2 = ( (9/5)*($t1 - 273.15) ) + 32;
	}
	elsif($uf == 4){
		$t2 = (9 * $t1) / 5;
	}
}
elsif($ui == 4){
	if($uf == 1){
		$t2 = (5 * ($t1 - 491.67) ) / 9;
	}
	elsif($uf == 2){
		$t2 = $t1 - 459.67;
	}
	elsif($uf == 3){
		$t2 = (5 * $t1 ) / 9;
	}
}
if( ($t2 < 0 and ($uf == 3 or $uf == 4) ) or ($t2 < -273.15 and $uf == 1) or ($t2 < -459.67 and $uf == 2) ){
	print "No se permiten valores menores al cero absoluto\n";
	exit 0;
}

$ui = asignar($ui);
$uf = asignar($uf);
chomp $t1;
print "\n$t1 $ui = $t2 $uf";