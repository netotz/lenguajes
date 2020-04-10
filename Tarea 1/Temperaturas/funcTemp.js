var t1, t2, unidades, ui, uf;

function deshabilitar(buff, unit){
	var ops, i;
	
	ops = document.getElementById(buff).getElementsByTagName("option");
	for(i = 0; i < ops.length; i++){
		ops[i].disabled = false;
	}
	
	ops = document.getElementById(buff).getElementsByTagName("option");
	for(i = 0; i < ops.length; i++){
		if(ops[i].value == unit){
			ops[i].disabled = true;
			break;
		}
	}
	
	return;
}

function calcular(){
	unidades = document.getElementById("temp1");
	ui = unidades.options[unidades.selectedIndex].value;
	
	unidades = document.getElementById("temp2");
	uf = unidades.options[unidades.selectedIndex].value;
	
	deshabilitar("temp1",uf);
	deshabilitar("temp2",ui);
	
	t1 = document.getElementById("entrada").value;
	
	if(t1 == "" || !(/\S/.test(t1)) ){
		document.getElementById("entrada").value = "";
		document.getElementById("res").value = "";
		t1 = 0;
		t2 = 0;
		return;
	}
	else if(isNaN(t1) == true){
		document.getElementById("res").value = "";
		t2 = 0;
		if(t1 == "-" || t1 == "." || t1 == "-.")
			return;
		
		document.getElementById("entrada").value = "";
		t1 = 0;
		alert("Ingresar solo números");
		
		return;
	}
	else
		Number(t1);
	
	if(ui == "C"){
		if(t1 < -273.15){
			alert("No se permiten valores menores al cero absoluto");
			document.getElementById("entrada").value = "";
			document.getElementById("res").value = "";
			t1 = 0;
			t2 = 0;
			return;
		}
		if(uf == "F")
			t2 = ( (9/5) * t1 ) + 32;
		else if(uf == "K")
			t2 = t1*1 + 273.15;
		else
			t2 = ( (9*t1) / 5) + 491.67;
	}
	else if(ui == "F"){
		if(t1 < -459.67){
			alert("No se permiten valores menores al cero absoluto");
			document.getElementById("entrada").value = "";
			document.getElementById("res").value = "";
			t1 = 0;
			t2 = 0;
			return;
		}
		t2 = (5/9) * (t1*1 - 32);
		if(uf == "K")
			t2 += 273.15;
		else if(uf == "R")
			t2 = t1*1 + 459.67;
	}
	else if(ui == "K"){
		if(t1 < 0){
			alert("No se permiten valores menores al cero absoluto");
			document.getElementById("entrada").value = "";
			document.getElementById("res").value = "";
			t1 = 0;
			t2 = 0;
			return;
		}

		if(uf == "C")
			t2 = t1*1 - 273.15;
		else if(uf == "F")
			t2 = ( 9*(t1*1 - 273.15) / 5) + 32;
		else
			t2 = (9 * t1) / 5;
	}
	else{
		if(t1 < 0){
			alert("No se permiten valores menores al cero absoluto");
			document.getElementById("entrada").value = "";
			document.getElementById("res").value = "";
			t1 = 0;
			t2 = 0;
			return;
		}
		if(uf == "C")
			t2 = ( 5*(t1*1 - 491.67) ) / 9;
		else if(uf == "F")
			t2 = t1*1 - 459.67;
		else if(uf == "K")
			t2 = (5 * t1 ) / 9;
	}
	
	if( (t2 < 0 && (uf == "K" || uf == "R") ) || (t2 < -273.15 && uf == "C") || (t2 < -459.67 && uf == "F") ){
		alert("No se permiten valores menores al cero absoluto");
		document.getElementById("entrada").value = "";
		document.getElementById("res").value = "";
		t1 = 0;
		t2 = 0;
		return;
	}
	
	document.getElementById("res").value = Math.round(t2 * 1000)/1000;
	
	return;
}

function voltear(){
	document.getElementById("entrada").value = Math.round(t2 * 1000)/1000;
	document.getElementById("temp1").value = uf;
	document.getElementById("temp2").value = ui;
	
	calcular();
	
	return;
}