var nuevo, i, j, divi, filas, buff, buff2, x, y,
	A = [1,1],		//filas y columnas de A
	B = [1,1],		//filas y columnas de B
	C = [0,0],
	matA, matB, matC;
	
function matrix(rows){		//crear matriz
	var array = [];				//arreglo para generar matriz

	for(i = 0; i < rows; i++){
		array[i] = [];				//a cada espacio del arreglo hacerlo arreglo
	}

	return array;				//regresar matriz
}

function crear(lado, matriz, letra, parte, val){	//crear inputs
	buff = "fil"+letra;									//definir nombre de fila
	x = document.getElementById(lado);					//obtener elemento 'lado' por id
	if(parte == 0){										//si son columnas
		matriz[1] += 1;										//incrementar la cantidad de columnas
		filas = x.getElementsByTagName("DIV");				//obtener todos los divs del 'lado'
	}
	else{												//si son filas
		matriz[0] += 1;										//incrementar la cantidad de filas
		
		divi = document.createElement("div");				//crear div
		divi.setAttribute = ("class",buff);					//asginar nombre
		divi.id = letra+"f"+matriz[0];						//asginar id
		x.appendChild(divi);								//agregar al div 'lado'
	}	
	
	for(i = 0, j = 0; i < matriz[parte]; i++, j++){			//recorrer la cantidad de filas o columnas
		nuevo = document.createElement("input");			//crear input
		nuevo.name = "cel"+letra;							//asignar nombre de celda
		nuevo.size = "3";									//asignar tamaño
		nuevo.value = val;
		
		if(parte == 1)										//si son filas
			divi.appendChild(nuevo);							//agregar input al nuevo div
		else												//si son columnas
			filas[j].appendChild(nuevo);						//agregar input al div de la fila
	}
	
	return;
}

function borrar(lado, matriz, letra, parte){//borrar elemento
	x = document.getElementById(lado);			//obtener id de 'lado'
	filas = x.getElementsByTagName("DIV");		//obtener todos los divs del 'lado'
	if(parte == 0){								//si son columnas
		if( (matriz[0] <= 1 && matriz[1] <= 2) || matriz[1] <= 1){
			alert("No es posible eliminar más columnas");
			return;
		}
		else
			matriz[1] -= 1;
		
		for(i = 0; i < matriz[parte]; i++){
			y = filas[i].getElementsByTagName("input");
			filas[i].removeChild(y[y.length-1]);
		}
	}
	else{
		if( (matriz[1] <= 1 && matriz[0] <= 2) || matriz[0] <= 1){
			alert("No es posible eliminar más filas");
			return;
		}
		else
			matriz[0] -= 1;
		y = filas[filas.length-1].getElementsByTagName("input");
		for(i = matriz[parte]-1; i >= 0; i--){
			filas[filas.length-1].removeChild(y[i]);
		}
		x.removeChild(filas[filas.length-1]);
	}
	
	return;
}

function guardar(matriz, letra, mat){				//guardar valores de las celdas
	mat = matrix(matriz[0]);							//crear matriz
	buff = "cel"+letra;									//definir nombre de celdas
	
	x = document.getElementsByName(buff);				//obtener los inputs de las celdas
	for(i = 0; i < x.length; i++){						//recorrer inputs
		if(x[i].value == "" || !(/\S/.test(x[i].value)) ){	//si la celda está vacía o contiene puros espacios
			alert("Rellenar todas las celdas");	
			return;											//terminar función
		}
		for(j = 0; j < x[i].value.length; j++){				//recorrer cada caracter de la celda
			if(isNaN(x[i].value[j]) == true){					//si no es un número
				if(x[i].value[j] == "-" || x[i].value[j] == "."){	//si es un guión o punto
					if(isNaN(x[i].value[j+1]) == false || (x[i].value[j] == "-" && x[i].value[j+1] == ".") )
																		//si el siguiente caracter es un número, o si es guión y el siguiente un punto
						continue;											//siguiente iteración
				}
				alert("Ingresar solo números");
				
				return;												//terminar función si no es un número
			}
		}
		Number(x[i].value);
	}
	
	for(i = 0, k = 0; i < matriz[0]; i++){	//recorrer filas de la matriz
		for(j = 0; j < matriz[1]; j++, k++)		//recorrer columnas de la matriz
			mat[i][j] = x[k].value;					//guardar valores
	}
	
	if(letra == "A")
		matA = mat;								//asignar valores a matriz
	else
		matB = mat;
	
	return;
}

function suma(){
	y = document.getElementById("matres");
	y.innerHTML = "";
	
	if(A[0] != B[0] || A[1] != B[1]){
		alert("Se requieren matrices de dimensiones iguales");
		return;
	}
	
	y.style.display = "block";
	y.rows = ""+A[0];
	y.cols = ""+( A[1]*10 );
	
	guardar(A, "A", matA);
	guardar(B, "B", matB);
	
	C[0] = A[0];
	C[1] = A[1];
	matC = matA;
	for(i = 0; i < C[0]; i++){
		for(j = 0; j < C[1]; j++)
			matC[i][j] = matC[i][j]*1 + matB[i][j]*1;
	}
	
	document.getElementById("txt").innerHTML = "A + B =";
	
	for(i = 0; i < C[0]; i++){
		for(j = 0; j < C[1]; j++)
			document.getElementById("matres").innerHTML += Math.round(matC[i][j] * 100 + Number.EPSILON)/100 + "		";
		document.getElementById("matres").innerHTML += "\n";
	}
	
	return;
}

function producto(){
	var suma, a, b, k, l;
	
	y = document.getElementById("matres");
	y.innerHTML = "";
	
	if(A[1] != B[0]){
		alert("La cantidad de filas de una matriz debe coincidir con la de las columnas de la otra");
		return;
	}
	
	guardar(A, "A", matA);
	guardar(B, "B", matB);
	
	C[0] = A[0];
	C[1] = B[1];
	
	y.style.display = "block";
	y.rows = ""+C[0];
	y.cols = ""+( C[1]*10 );
	
	matC = matrix(A[0]);
	
	for(a = 0; a < C[0]; a++){
		for(b = 0; b < C[1]; b++){
			suma = 0;
			for(i = a, j = 0, k = 0, l = b; j < A[1] && k < B[0]; j++, k++)
				suma += matA[i][j] * matB[k][l];
			matC[a][b] = suma*1;
		}
	}
	
	document.getElementById("txt").innerHTML = "A * B =";
	
	for(i = 0; i < C[0]; i++){
		for(j = 0; j < C[1]; j++)
			y.innerHTML += Math.round(matC[i][j] * 100 + Number.EPSILON)/100 + "		";
		y.innerHTML += "\n";
	}
	
	return;
}