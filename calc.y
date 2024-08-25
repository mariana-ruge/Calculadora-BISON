%{
#include <stdio.h> //Biblioteca estandar para la entrada/salida.
#include <stdlib.h> //Utilidades de gestion de memoria.

void yyerror(const char *s); //Declaracion de la funcion de manejo de errores que se usara para reportar errores de sintaxis
int yylex(); //Funcion de analisis lexico que se usara para obtener tokens por medio del parser
%}

%union {
    float fval; //Definicion de una variable para almacenar los variables de los token, usando NUMBER como flotante (float)
}

%token <fval> NUMBER //Definicion del token NUMBER, que se usa para almacenar un dato de tipo float
%left '+' '-' //Definicion  de la precedencia de los operadores '+' y '-'  con asociacion en la izquierda
%left '*' '/' //Definicion  de la precedencia de los operadores '*' y '/'  con asociacion en la izquierda
%token EOL //End of Line -> Final de la entrada

%type <fval> expression //Indica el valor asociado con la regla 'expression' es float.

%%
//Funcion para hacer el calculo
calculation:
    /* vacío */                     //Regla que permite que calculation sea opcional
    | calculation expression EOL   { printf("Resultado: %f\n", $2); } //Se maneja la entrada de una expresion seguida de un EOL, imprime el resultado.
    | calculation error EOL        { yyerror("Error de sintaxis. Se ignoró la entrada incorrecta."); yyerrok; } //Regla que maneja errores de sintaxis, ignora la entrada incorrecta.
    ;

//Reglas de la expresion y de la entrada
expression:
    NUMBER                         { $$ = $1; } // Regla para un número simple.
    //Regal de la suma
    | expression '+' expression    { $$ = $1 + $3; } //Asignar el valor del numero a la variable resultado, operacion de la suma.
    //Regla de la resta
    | expression '-' expression    { $$ = $1 - $3; } //Asignar el valor del numero a la variable resultado, operacion de la resta.
    //Regla de la multiplicacion
    | expression '*' expression    { $$ = $1 * $3; } //Asignar el valor del numero a la variable resultado, operacion de la multiplicacion.
    //Regla de la division
    | expression '/' expression    { 
        //Levantar la excepcion de la division por cero.
        if ($3 == 0) {
            //Mostrar el error en la consola
            yyerror("Error: División por cero.");
            $$ = 0.0; // Puedes definir un valor por defecto o manejarlo de otra manera
        } else {
            //Realizar la division, puesto no hay en el denominador
            $$ = $1 / $3;
        }
    }
    //Manejar las expresiones de consola con parentesis
    | '(' expression ')'           { $$ = $2; } //Devolver el resultado de la expresion en los parentesis
    ;

%%
//Funcion de manejo de errores
//Alzar un error en consola
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s); //Imprimir un mensaje de error en la salida, error estandar
}

//Funcion principal, main.
int main() {
    printf("Calculadora simple\n"); //Imprime un mensaje indicando el nombre del programa, una calculadora simple
    yyparse(); //Se llama a yyparse para iniciar el analisis sintactico
    return 0; //Retornar 0 para mostrar que el programa termino correctamente
}
