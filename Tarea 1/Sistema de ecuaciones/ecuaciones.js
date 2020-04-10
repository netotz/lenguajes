var nuevo, i, j, newdiv, filas, buff, buff2, x, y,
	S = [1,1],
	sistema;
	
function matrix(rows){		//crear sistema
	var array = [];				//arreglo para generar sistema

	for(i = 0; i < rows; i++)
		array[i] = [];				//a cada espacio del arreglo hacerlo arreglo

	return array;				//regresar sistema
}

function crear(fc){	//crear inputs
	x = document.getElementById("sis");					//obtener elemento '"sis"' por id
	if(fc == 0){										//si son columnas
		S[1] += 1;											//incrementar la cantidad de columnas
		filas = x.getElementsByTagName("DIV");				//obtener todos los divs del sistema
	}
	else{												//si son filas
		if(S[0] >= 5){
			alert("Máxima cantidad de ecuaciones alcanzada");
			return;
		}
		else
			S[0] += 1;											//incrementar la cantidad de filas
		
		newdiv = document.createElement("DIV");				//crear div
		x.appendChild(newdiv);								//agregar al sistema
	}	
	
	for(i = 0, j = 0; i < S[fc]; i++, j++){			//recorrer la cantidad de filas o columnas
		nuevo = document.createElement("INPUT");			//crear input
		nuevo.name = "celdas";							//asignar nombre de celda
		nuevo.size = "3";									//asignar tamaño
		nuevo.value = "";
		nuevo.maxlength = "10";
		
		if(fc == 1)										//si son filas
			newdiv.appendChild(nuevo);							//agregar input al nuevo div
		else												//si son columnas
			filas[j].appendChild(nuevo);						//agregar input al div de la fila
	}
	
	if(fc == 1)
		crear(0);
	
	return;
}

function borrar(fc){//borrar elemento
	x = document.getElementById("sis");			//obtener id de '"sis"'
	filas = x.getElementsByTagName("DIV");		//obtener todos los divs del '"sis"'
	if(fc == 0){								//si son columnas
		if( (S[0] <= 1 && S[1] <= 2) || S[1] <= 1){
			alert("No es posible eliminar más columnas");
			return;
		}
		else
			S[1] -= 1;
		
		for(i = 0; i < S[fc]; i++){
			y = filas[i].getElementsByTagName("input");
			filas[i].removeChild(y[y.length-1]);
		}
	}
	else{
		if( (S[1] <= 1 && S[0] <= 2) || S[0] <= 1){
			alert("No es posible eliminar más filas");
			return;
		}
		else
			S[0] -= 1;
		y = filas[filas.length-1].getElementsByTagName("input");
		for(i = S[fc]-1; i >= 0; i--){
			filas[filas.length-1].removeChild(y[i]);
		}
		x.removeChild(filas[filas.length-1]);
	}
	
	if(fc == 1)
		borrar(0);
	
	return;
}

function guardar(){				//guardar valores de las celdas
	sistema = matrix(S[0]);							//crear sistema
	
	x = document.getElementsByName("celdas");				//obtener los inputs de las celdas
	for(i = 0; i < x.length; i++){						//recorrer inputs
		if(x[i].value == "" || !(/\S/.test(x[i].value)) ){	//si la celda está vacía o contiene puros espacios
			alert("Rellenar todas las celdas");	
			return 0;											//terminar función
		}
		for(j = 0; j < x[i].value.length; j++){				//recorrer cada caracter de la celda
			if(isNaN(x[i].value[j]) == true){					//si no es un número
				if(x[i].value[j] == "-" || x[i].value[j] == "."){	//si es un guión o punto
					if(isNaN(x[i].value[j+1]) == false || (x[i].value[j] == "-" && x[i].value[j+1] == ".") )
																		//si el siguiente caracter es un número, o si es guión y el siguiente un punto
						continue;											//siguiente iteración
				}
				alert("Ingresar solo números");
		
				return 0;												//terminar función si no es un número
			}
		}
		Number(x[i].value);
	}
	
	for(i = 0, k = 0; i < S[0]; i++){		//recorrer filas del sistema
		for(j = 0; j < S[1]; j++, k++)		//recorrer columnas del sistema
			sistema[i][j] = x[k].value;						//guardar valores
	}
	
	return 1;
}

function resolv(){
	y = document.getElementById("result");
	y.innerHTML = "";

	y.style.display = "block";
	y.rows = ""+S[0];
	y.cols = ""+( S[1]*10 );

	var isnum = guardar();
	if(isnum == 0)
		return;

	var pivant = 1, pivact, next = 0,
		trans = matrix(S[0]);
	while(next < S[0]){
		pivact = sistema[next][next];
		for(j = 0; j < S[1]; j++)
			trans[next][j] = sistema[next][j];
		
		for(i = 0; i < S[0]; i++){
			if(i != next)
				trans[i][next] = 0.0;
			else
				trans[i][i] = pivact;
		}
		for(i = 0; i < S[0]; i++){
			if(i != next) {
				for(j = 0; j < S[1]; j++){
					if(j != next)
						trans[i][j] = ((sistema[i][j] * pivact) - (sistema[next][j] * sistema[i][next])) / pivant;
				}
			}
		}
		for(i = 0; i < S[0]; i++){
			for(j = 0; j < S[1]; j++)
				sistema[i][j] = trans[i][j];
		}
		pivant = pivact;
		if(pivant == 0){
			alert("No existe solución");
			return;
		}
		next += 1;
	}
	for(i = 0; i < S[0]; i++){
		for(j = 0; j < S[1]; j++)
			sistema[i][j] = sistema[i][j] / pivact;
	}

	for(i = 0; i < S[0]; i++){
		for(j = 0; j < S[1]; j++)
			y.innerHTML += Math.round(sistema[i][j] * 10000 + Number.EPSILON)/10000 +  "		";
		y.innerHTML += "\n";
	}

	return;
}