sub validBin{
	my ($bin) = @_;
	my ($otro) = 0;
	$otro = () = $bin =~ /^[01]+$/;
	if($otro == 0){
		print "Solo numeros binarios\n";
		return 0;
	}
	else{
		return 1;
	}
}

sub contar{
	my ($string) = $_[0];
	my ($sub) = $_[1];
	my ($inicio) = 0;
	my ($ocurrencias) = 0;
	while(1){
		$inicio = index($string, $sub, $inicio) + 1;
		if($inicio > 0){
			$ocurrencias++;
		}
		else{
			return $ocurrencias;
		}
	}
}

print "Calcular k-meros mas frecuentes\n";
do{{
	print "\nIngresar un numero binario (maximo 20 caracteres): ";
	$entrada = <>;
	chomp $entrada;
	$largo = length $entrada;
	if($largo < 2){
		print "Se requieren al menos 2 caracteres\n";
		redo;
	}
	elsif($largo > 20){
		print "El maximo es de 20 caracteres\n";
		redo;
	}
}}
while( validBin($entrada) == 0);

%particles;
@arrkmero;
@arrinp = split //,$entrada;
for($size = 1; $size < ($largo+1); $size++){
	for($pos = 0; $pos < ($largo - ($size-1)); $pos++){
		for($x = $pos, $y = 0; $x < ($pos+$size) and $y < $size; $x++, $y++){
			$arrkmero[$y] = $arrinp[$x];
		}
		
		$strkmero = join("",@arrkmero);
		chomp $strkmero;
		$repetido = 0;
		foreach $key (keys %particles){
			if($key eq $strkmero){
				$repetido = 1;
			}
		}
		
		if($repetido == 0){
			$count = contar($entrada,$strkmero);
			$particles{"$strkmero"} = $count * $size;
		}
	}
}

$max = 0;
foreach $key (keys %particles){
	if($particles{"$key"} > $max){
		$max = $particles{"$key"};
	}
}

keys %particles;
values %particles;
while( ($key,$val) = each %particles){
	print "\t'"."$key"."': "."$val\n";
}
print "\nK-meros mas frecuentes:\n";
while( ($key,$val) = each %particles){
	if($particles{"$key"} == $max){
		print "\t'"."$key"."': "."$val\n";
	
	}
}