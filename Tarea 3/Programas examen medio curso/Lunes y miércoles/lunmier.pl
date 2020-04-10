use Scalar::Util qw(looks_like_number);
use Data::Types qw(is_int);

sub isLeap{
	my ($year) = @_;
	if( $year % 4 == 0 and ( $year % 100 != 0 or $year % 400 == 0) ){
		return 1;
	}
	else{
		return 0;
	}
}

sub mesesDias{
	my ($year) = @_;
	my @meses;
	my $bool = 1;
	for(my $i = 0; $i < 12; $i++){
		if($i == 1){
			(push @meses, 29) if isLeap($year);
			(push @meses, 28) if not isLeap($year);
		}
		else{
			if($i == 7){
				$bool = not $bool;
			}

			(push @meses, 31) if $bool;
			(push @meses, 30) if not $bool;
		}

		$bool = not $bool;
	}

	return @meses;
}

sub contarDias{
	my (@fecha) = @{$_[0]};
	my $dias = 0;
	for(my $year = $fecha[0] - 1; $year > 0; $year--){
		if( isLeap($year) ){
			$dias += 366;
		}
		else{
			$dias += 365;
		}
	}

	my @meses = mesesDias($fecha[0]);

	for(my $mes = 0; $mes < $fecha[1] - 1; $mes++){
		$dias += $meses[$mes];
	}

	$dias += $fecha[2];
	
	return $dias;
}

sub validPosInt{
	my ($num) = @_;
	if(looks_like_number($num)){
		if(is_int($num)){
			if($num > 0){
				return 1;
			}
		}
	}
	print "\tEntrada no valida.\n";
	return 0;
}

sub pedirFecha{
	my ($txt) = @_;
	my @fecha;
	my $num;
	while(1){
		print "\nIngresar año $txt: ";
		$num = <>;
		chomp $num;
		if(validPosInt($num)){
			last;
		}
		print "\tSolo años de la era comun (despues de Cristo).\n"
	}
	push @fecha, $num;
	my @meses = mesesDias($num);

	while(1){
		print "Ingresar número de mes $txt: ";
		$num = <>;
		chomp $num;
		if(validPosInt($num) and $num < 13){
			last;
		}
		print "\tMes no valido.\n";
	}
	push @fecha, $num;
	$mes = $num;

	while(1){
		print "Ingresar dia de mes $txt: ";
		$num = <>;
		chomp $num;
		if(validPosInt($num) and $num <= $meses[$mes - 1]){
			last;
		}
		print "\tEntrada no valida.\n";
	}
	push @fecha, $num;

	return @fecha;
}

sub main{
	my $diaSem;
	my $dias;
	while(1){
		my @ini = pedirFecha("de nacimiento");
		my @fin = pedirFecha("actual");

		if($ini[2] > $fin[2]){
			print "Fechas invalidas\n";
			next;
		}

		print "Ingresar dia de la semana actual (0 es lunes, 1 es martes ... 6 es domingo): ";
		$diaSem = <>;
		chomp $diaSem;

		$dias = (contarDias(\@fin) - contarDias(\@ini) ) + 1;

		if($dias <= 0){
			print "Fechas invalidas\n";
			next;
		}
		else{
			last;
		}
	}
	
	calcular($dias, $diaSem);

	return;
}

sub calcular{
	my ($diasv) = $_[0];
	my ($diasem) = $_[1];

	my $lun = 0;
	my $mier = 0;
	for(my $i = $diasv, $j = $diasem; $i > 1; $i--){
		if($j == 0){
			$lun++;
		}
		elsif($j == 2){
			$mier++;
		}

		if($j == 0){
			$j = 6;
		}
		else{
			$j--;
		}
	}

	print "\n\tHa vivido $lun lunes";
	print " y $mier miercoles\n";

	return;
}

main();