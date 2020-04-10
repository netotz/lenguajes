var i, cantidad,
	div2 = document.getElementsByClassName("div2"),
	numeros = [];
 
function validar(valor){
	if(isNaN(valor) == true){
		alert("Solo números enteros positivos");
		return 0;
	}
	else{
		if(valor != parseInt(valor) ){
			alert("Solo números enteros positivos");
			return 0;
		}
	}
	
	return 1;
}

function repetido(numero){
	for(i in numeros){
		if(numeros[i] == numero)
			return 1;
	}
	
	return 0;
}
	
function leerCantidad(){
	cantidad = document.getElementById("cantidad").value;
	if(validar(cantidad) == 1){
		if(cantidad < 2){
			alert("Se requieren al menos dos números");
			return;
		}
	}
	else
		return;
	document.getElementById("mcm").innerHTML = "";
	document.getElementById("numeros").innerHTML = "";
	numeros = [];
	document.getElementById("inputcant").style.display = "none";
	document.getElementById("agregar").style.display = "block";
	document.getElementById("result").style.display = "block";
	
	return;
}

function agregarNum(){
	var num = document.getElementById("num").value;
	if(validar(num) == 0)
		return;
	else{
		if(num <= 0){
			alert("Solo números positivos mayores que cero");
			return;
		}
		else if(num == 1){
			alert("Número omitido");
			return;
		}
	}
	
	if(repetido(num) == 0){
		numeros.push(num);
		document.getElementById("numeros").innerHTML = numeros;
		document.getElementById("num").value = "";
		cantidad--;
	}
	else{
		alert("No repetir números");
	}
	
	if(cantidad == 0){
		calcular();
		document.getElementById("agregar").style.display = "none";
		document.getElementById("boton").style.display = "block";
	}
	
	return;
}

function calcular(){
	var max = Math.max(...numeros);
	
	var esMcm = false;
	for(var mcm = max; esMcm == false; mcm++){
		esMcm = true;
		for(i = 0; i < numeros.length; i++){
			if(mcm % numeros[i] != 0){
				esMcm = false;
				break;
			}
		}
		if(esMcm == true)
			break;
	}
	
	document.getElementById("mcm").innerHTML = mcm;
	
	return;
}

function reinicio(){
	document.getElementById("inputcant").style.display = "block";
	document.getElementById("agregar").style.display = "none";
	document.getElementById("result").style.display = "none";
	document.getElementById("boton").style.display = "none";
	
	return;
}