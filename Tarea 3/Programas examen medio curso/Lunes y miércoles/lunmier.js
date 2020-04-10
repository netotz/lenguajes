function isLeap(year){
	return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

function mesesDias(year){
	var meses = [];
	var bool = true;
	for(var i = 0; i < 12; i++){
		if(i == 1){
			isLeap(year) ? meses.push(29) : meses.push(28);
		}
		else{
			if(i == 7)
				bool = !bool;

			bool ? meses.push(31) : meses.push(30);
		}

		bool = !bool;
	}

	return meses;
}

function contarDias(fecha){
	var dias = 0;
	for(var year = fecha[0] - 1; year > 0; year--){
		isLeap(year) ? dias += 366 : dias += 365;
	}

	var meses = mesesDias(fecha[0]);

	for(var mes = 0; mes < fecha[1] - 1; mes++)
		dias += meses[mes];

	dias += fecha[2];

	return dias;
}

function validNum(buff){
	return !isNaN( parseFloat(buff) ) && isFinite(buff);
}

function validPosInt(n){
	if(validNum(n)) return parseInt(n) == n;
	else return false;
}

function pedirFecha(txt){
	var fecha = [];
	var num;
	while(true){
		num = prompt("Ingresar año " + txt);
		if(validPosInt(num) && parseInt(num) > 0)
			break
		alert("Solo años de la era común (después de Cristo).")
	}
	var year = parseInt(num);
	fecha.push(year);
	var meses = mesesDias(year);

	while(true){
		num = prompt("Ingresar número de mes " + txt);
		if(validPosInt(num) && parseInt(num) > 0 && parseInt(num) < 13)
			break
		alert("Mes no válido.")
	}
	var mes = parseInt(num);
	fecha.push(mes);

	while(true){
		num = prompt("Ingresar día de mes " + txt);
		if(validPosInt(num) && parseInt(num) > 0){
			if(parseInt(num) <= meses[mes - 1])
				break
			else alert("El mes ingresado solo tiene " + meses[mes - 1] + " días.");
		}
		else alert("Día no válido.")
	}
	fecha.push( parseInt(num) );

	return fecha;
}

function main(){
	while(true){
		var ini = pedirFecha("de nacimiento");
		var fin = pedirFecha("actual");

		if(ini[0] > fin[0]){
			alert("Fechas inválidas");
			continue;
		}

		var diaSem = prompt("Ingresar día de la semana actual (0 es lunes, 1 es martes ... 6 es domingo)");

		var dias = (contarDias(fin) - contarDias(ini) ) + 1;

		if(dias <= 0){
			alert("Fechas inválidas");
			continue;
		}
		else break;
	}

	calcular(dias, parseInt(diaSem) );

	return;
}

function calcular(diasv, diasem){
	var lun = 0;
	var mier = 0;
	for(var i = diasv, j = diasem; i > 0; i--){
		if(j == 0)
			lun++;
		else if(j == 2)
			mier++;

		j == 0 ? j = 6 : j--;
	}

	alert("Ha vivido " + lun + " lunes y " + mier + " miércoles");

	return;
}