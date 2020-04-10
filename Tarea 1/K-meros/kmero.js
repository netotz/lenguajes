var string, lar, size, pos, i, x, y, rep, mayor, result,
	kmero = [],
	particulas = [];
	
document.getElementById("string").addEventListener("keyup",
	function(event){
		event.preventDefault();
		if(event.keyCode === 13)
			validar();
	}
);

function validar(){
	result1 = document.getElementById("kmeroslist");
	result1.innerHTML = "";
	result2 = document.getElementById("kmerosfrec");
	result2.innerHTML = "";
	
	string = document.getElementById("string").value;
	

	if( /^[01]+$/.test(string) == false){
		alert("Solo números binarios");
		return;
	}
	
	lar = string.length;
	if(lar < 2){
		alert("Se requieren al menos 2 caracteres");
		return;
	}
	else if(lar > 20){
		alert("20 caracteres como máximo");
		return;
	}
	
	guardar();
	
	return;
}

function contar(string, sub){
	var inicio = 0;
	var ocurrencias = 0;
	while(true){
		inicio = string.indexOf(sub, inicio) + 1;
		if(inicio > 0)
			ocurrencias++;
		else
			return ocurrencias;
	}
}

function guardar(){
	kmero = [];
	particulas = [];
	
	fila = 0;
	for(size = 1; size < lar+1; size++){
		for(pos = 0; pos < (lar - (size-1) ); pos++){
			for(y = 0, x = pos; y < size && x < (pos+size); y++, x++)
				kmero[y] = string[x];
			buff = kmero.join('');
			
			rep = 0;
			for(i = 0; i < fila; i++){
				if(particulas[i][0] == buff)
					rep = 1;
			}
			if(rep == 0){
				particulas[fila] = [];
				particulas[fila][0] = buff;
				particulas[fila][1] = contar(string,buff) * size;
				fila++;
			}
		}
	}

	mayor = 0;
	for(i = 0; i < fila; i++){
		Number(particulas[i][1]);
		if(particulas[i][1] > mayor)
			mayor = particulas[i][1];
	}
	
	imprimir();
	
	return;
}

function imprimir(){
	var rows1 = 0,
		rows2 = 0;
	for(i = 0; i < fila; i++){
		result1.innerHTML += "'" + particulas[i][0] + "': " + particulas[i][1] + "\n";
		rows1++;
	}
	
	document.getElementById("txt").innerHTML = "k-meros más frecuentes:";
	for(i = 0; i < fila; i++){
		if(particulas[i][1] == mayor){
			result2.innerHTML += "'" + particulas[i][0] + "': " + particulas[i][1] + "\n";
			rows2++;
		}
	}
	result1.rows = ""+rows1;
	result1.cols = ""+(lar*4);
	result1.style.display = "block";
	
	result2.rows = ""+rows2;
	result2.cols = ""+(lar*4);
	result2.style.display = "block";
	
	return;
}