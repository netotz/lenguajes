use Scalar::Util qw(looks_like_number);
use Data::Types qw(is_int);
use List::Util qw(max);

sub input{
	print "Ingresar numeros deseados uno por uno (0 para terminar): ";
	while($cantidad != 0){
		$cantidad = <>;
		if(looks_like_number($cantidad)){
			if(is_int($cantidad)){
				if($cantidad == 0){
					last;
				}
				elsif($cantidad > 0){
					if(repetido($cantidad) == 1){
						print "No repetir numeros\n";
					}
					elsif($cantidad == 1){
						print "Numero omitido\n";
					}
					else{
						push(@numeros, $cantidad);
					}
					
					redo;
				}
			}
		}
		print "Solo numeros enteros positivos\n";
		$cantidad = 1;
	}
}

sub repetido{
	my ($num) = @_;
	foreach my $val (@numeros){
		if($val == $num){
			return 1;
		}
	}
	
	return 0;
}

$cantidad = 1;
print "Calculadora del minimo comun multiplo de 'n' numeros\n";
$len = 3;
do{
	print "Se requieren al menos dos numeros\n\n";
	input();
	$len = @numeros;
}
while($len < 2);

print "mcm(";
foreach $num (@numeros){
	chomp $num;
	print "$num, ";
}
print "\b\b  \b\b) = ";

$mcm = max @numeros;
$mcm--;
do{
	$mcm++;
	$esMcm = 1;
	foreach $num (@numeros){
		if($mcm % $num != 0){
			$esMcm = 0;
			last;
		}
	}
}
while($esMcm == 0);

print "$mcm";