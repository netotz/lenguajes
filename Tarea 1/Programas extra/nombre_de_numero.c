#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>

#define and &&
#define or ||

const char *nombres[4][10] = {
	{"","uno" ,"dos ","tres ","cuatro ","cinco ","seis ","siete ","ocho ","nueve "},
	{"","dieci","veinti","treinta ","cuarenta ","cincuenta ","sesenta ","setenta ","ochenta ","noventa "},
	{"","ciento ","doscientos ","trescientos ","cuatrocientos ","quinientos ","seiscientos ","setecientos ","ochocientos ","novecientos "},
	{"","once ","doce ","trece ","catorce ","quince "}
};

void imprimir(int pos, int *arreglo){
	int i, j;
	for(i = 2, j = pos; j < pos+3; i--, j++){	//imprimir nombres
		printf("%s",nombres[i][arreglo[j]]);
		
		if(j == pos){										//si va en las centenas
			if(arreglo[pos] == 1)								//si la centena es 1
				if(arreglo[pos+1] == 0 and arreglo[pos+2] == 0){	//si no tiene decena ni unidad
					printf("\b\b\b  ");									//borrar "to" en "cien-to"
					break;
				}
		}

		else if(j == pos+1){								//si va en las decenas
			if(arreglo[pos+1] == 1){					//si la decena es de 10
				if(arreglo[pos+2] > 0 and arreglo[pos+2] < 6){//si las unidades son entre 1 y 5
					printf("\b\b\b\b\b     \b\b\b\b\b");		//borrar "dieci"
					printf("%s",nombres[3][arreglo[pos+2]]);		//imprimir nombre del número (11-15)
					break;
				}
				else if(arreglo[pos+2] == 0){				//si no tiene unidad
					printf("\b\b  \b\b");					//borrar "ci" en "die-ci"
					printf("z ");
					break;
				}
			}
			else if(arreglo[pos+1] == 2){				//si la decena es de 20
				if(arreglo[pos+2] == 0){					//si no tiene unidad
					printf("\b \b");							//borrar "i" en "veint-i"
					printf("e ");
					break;
				}
			}
			else if(arreglo[pos+1] != 0)				//si la decena es diferente de 0
				printf("y ");
		}
		
		else if(j == pos+2){						//si va en las unidades
			if(arreglo[pos+2] == 1 and pos != 7)		//si la unidad es 1 y no está imprimiendo las últimas 3 cifras
				printf("\b ");								//borrar "o" en "un-o"
		}
		
		if(j == pos+2 and arreglo[pos+2] == 0 and arreglo[pos+1] != 0)	//si no tiene unidad ni decena
			printf("\b\b ");												//borrar " y "
	}
	
	return;
}

void loop(void){
	int n,			//número ingresado
		n1,			//copia del número original
		i,
		cifras[10],	//arreglo para guardar cada cifra
		exp,		//exponente de diez
		diexp,		// = 10 ^ exp
		car;		//validar si tiene caracteres, o si todas las cifras son 0
		
	bool kilo = true,		//tiene miles
		mega = true,		//tiene millones
		giga = true;		//tiene miles de millones
		
	char str[256];		//string para guardar número en alfanumérico
	
	do{
		printf("Ingresar numero entre 1 y 1 000 000 000 (0 para salir) (sin espacios ni comas): ");
		scanf(" %[^\n]s",str);

		car = 0;								//son puros números y todos son 0 (de momento)
		for(i = 0; str[i] != '\0'; i++){		//revisar cada caracter del string
			if( !isdigit(str[i]) or str[i] == ' '){					//si el caracter no es un número
				printf("\tSolo numeros enteros positivos\n\n");
				car = -1;								//tiene caracteres no numéricos
				break;									//romper for
			}
			else{									//si sí es número
				if(str[i] != '0')						//si la cifra no es 0
					car = 1;								//no todas las cifras son 0
			}
		}
		
		if(car == 1){							//si no tiene caracteres no numéricos
			if(strlen(str) <= 10){					//si tiene 10 o menos cifras
				if(strlen(str) == 10 and str[0] != '1'){//si tiene 10 cifras y la primera no es 1
					printf("\tLimite superado\n\n");
					car  = true;							//indicar que tiene caracteres solo para repetir ciclo
				}
				else{									//si tiene 10 o menos cifras
					n = atoi(str);							//convertir el string a un número
					if(n > 1000000000)						//si el número es mayor a mil millones
						printf("\tLimite superado\n\n");
				}
			}
			else{									//si tiene más de 10 cifras
				printf("\tLimite superado\n\n");
				car = -1;
			}
		}
		else if(car == 0){
			printf("\ncero");
			return;
		}
	}
	while(n > 1000000000 or car == -1);	//repetir si es mayor a mil millones o si tiene caracteres no numéricos
	
	n1 = n;
	for(i = 0, exp = 9; i < 10; i++, exp--){	//guardar cifras
		diexp = pow(10,exp);
		cifras[i] = n1 / diexp;
		n1 = fmod(n1,diexp);
	}
	if(cifras[4] == 0 and cifras[5] == 0 and cifras[6] == 0)	//si no tiene miles
		kilo = false;
	if(cifras[1] == 0 and cifras[2] == 0 and cifras[3] == 0)	//si no tiene millones
		mega = false;
	if(cifras[0] == 0)											//si no tiene miles de millones
		giga = false;
	
	printf("\n");
	
	if(giga == true)
		printf("mil millones ");
	
	imprimir(1,cifras);												//imprimir nombres de millares
	if(mega == true){
		if(cifras[1] == 0 and cifras[2] == 0 and cifras[3] == 1)	//si no tiene centenas ni decenas pero unidad es 1 (de millar)
			printf("\b millon ");										//borrar "o" en "un-o"
		else printf("millones ");
	}
	
	imprimir(4,cifras);												//imprimir nombres de miles
	if(kilo == true){
		if(cifras[4] == 0 and cifras[5] == 0 and cifras[6] == 1)		//si no tiene centenas ni decenas pero unidad es 1 (de mil)
			printf("\b\b\b\bmil ");											//borrar "uno"
		else printf("mil ");
	}
	imprimir(7,cifras);												//imprimir centeas, decenas y unidades
	
	printf("\n\n");
	loop();
	
	return;
}

int main(int argi, char **argc){
	printf("\tMostrador del nombre de un numero\n\n");
	
	loop();
	
	return 0;
}
