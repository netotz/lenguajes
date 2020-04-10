var num1, num2, mod, i;

function enter(X){
	X.addEventListener("keyup",function(event){
	event.preventDefault();
	if(event.keyCode === 13)
		residuo();
	});
}

enter(document.getElementById("n1"));
enter(document.getElementById("n2"));

function residuo(){
	num1 = document.getElementById("n1").value;			//leer primer número
	num2 = document.getElementById("n2").value;			//leer segundo número
	
	if(num1 == "" || num2 == "" || !(/\S/.test(num1)) || !(/\S/.test(num2))){
		document.getElementById("result").innerHTML = "";
		return;
	}
	else if(isNaN(num1) == true || isNaN(num2) == true){
		document.getElementById("result").innerHTML = "";
		alert("Ingresar solo números");
		
		return;
	}
	else{
		if(num1 < 0 || num2 < 0){
			alert("Solo números positivos");
			return;
		}
		Number(num1);
		Number(num2);
		mod = num1 % num2;		//calcular residuo
	}

	if(isNaN(mod) == true){		//si el residuo no es un número
		document.getElementById("result").innerHTML = "<i>indefinido</i>"; //imprimir indefinido
		return;
	}
	  
	document.getElementById("result").innerHTML =			//imprimir la operación y resultado
	num1 + " mod " + num2 + " = " + "<font size='6'>" + Math.round(mod*1000000)/1000000 + "</font>";
	
	document.getElementById("n1").focus();
	
	return;
}