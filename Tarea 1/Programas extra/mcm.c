#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

#define or ||
#define and &&

int validar(const char *str){		//validar si contiene caracteres no num�ricos	
	int k;
	bool zero = true;
	for(k = 0; str[k] != '\0'; k++){	//revisar cada cifra
		if(k == 0 and str[0] == '-')		//si el primer caracter es un gui�n de menos
			continue;							//siguiente iteraci�n
			
		if(!isdigit(str[k])){				//si un caracter no es num�rico
			printf("Solo numeros enteros\n\n");
			return -1;
		}
		else{								//s� es un n�mero
			if(str[k] != '0')					//si la cifra no es 0
				zero = false;						//no todas las cifras son 0
		}
	}
	
	if(zero == true)
		return 0;						//todos los n�meros son 0
	else
		return 1;
}

int main(int argi, char **argc){
	printf("Calculadora de minimo comun multiplo (mcm)\n\n");
	
	int cantidad,	//cantidad de n�meros
		i, j,
		max,		//mayor n�mero ingresado
		ch;			//chequeo de caracteres no num�ricos
	char buff[256];	//string para guardar dato introducido
	double mcm;		//m�nimo com�n m�ltiplo
	bool check;		//chequeo si es mcm
	
	do{
		printf("Cantidad de numeros a ingresar (0 para salir): ");
		scanf(" %[^\n]s",buff);
		
		ch = validar(buff);

		if(ch == 1){									//si son solo n�meros en el string
			if(strlen(buff) <= 6){								//si son 6 o menos cifras
				cantidad = atoi(buff);								//convertir string a n�mero
				if(cantidad < 0)									//si es menor a 0
					printf("Solo numeros positivos\n\n");
				else if(cantidad == 1)
					printf("Se necesitan al menos 2 numeros\n\n");
				else if(cantidad > 100000)							//si excede el tama�o de arreglo
					printf("Arreglo demasiado grande\n\n");
			}
			else{											//si son m�s de 6 cifras
				printf("Arreglo demasiado grande\n\n");
				ch = -1;										//validar que tiene caracteres (solo para repetir ciclo)
			}
		}
		else if(ch == 0)
			return 0;
	}
	while(ch == -1 or cantidad < 2 or cantidad > 100000);//repetir mientras tenga caracteres no num�ricos o la cantidad sea menor a 0
	
	int num[cantidad];
	
	for(i = 0; i < cantidad; i++){					//guardar n�meros
		printf("\tIngresar %d%c numero: ",i+1,167);
		scanf(" %[^\n]s",buff);

		ch = validar(buff);
		
		if(ch == 1){									//si son solo n�meros en el string
			if(strlen(buff) <= 9)							//si tiene 9 o menos cifras
				num[i] = atoi(buff);							//convertir string a n�mero
			else{											//si tiene m�s de 9 cifras
				printf("Desbordamiento de variable\n\n");
				i--;
			}
		}
		else if(ch == 0){								//si el n�mero es 0
			printf("Calcular el mcm de 0 y otros numeros resulta indefinido\n\n");
			i--;											//retroceso de indicador
		}
		else											//si tiene caracteres no num�ricos
			i--;
	}
	
	printf("\nmcm(");
	for(i = 0; i < cantidad; i++)				//imprimir cada n�mero
		printf("%d, ",num[i]);
	printf("\b\b) = ");
	
	
	max = 0;									//inicialmente el valor m�ximo es 0
	for(i = 0; i < cantidad; i++){				//hacer todos los n�meros positivos para obtener el mayor
		if(num[i] < 0)								//si es menor a 0
			num[i] *= (-1);								//multiplicarlo por -1
		if(num[i] > max)							//si es mayor que el mayor
			max = num[i];								//sobreescribir n�mero mayor
	}
	
	check = false;									//inicialmente el mayor no es el mcm
	for(mcm = (double)max; check == false; mcm++){	//calcular mcm
		check = true;									//inicialmente el n�mero s� es el mcm
		for(i = 0; i < cantidad; i++){
			if(fmod(mcm,num[i]) != 0){					//si el m�dulo entre el supuesto mcm y el n�mero ingresado no es 0
				check = false;									//no es el mcm
				break;
			}
		}
		if(check == true)								//si el n�mero s� es el mcm
			break;										//terminar ciclo
	}
	
	printf("%.0lf",mcm);
	
	return 0;
}
