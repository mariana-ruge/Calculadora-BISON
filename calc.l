%{
#include "calc.tab.h" // Incluye el archivo de encabezado generado por Yacc, que contiene definiciones de tokens y tipos de datos.
#include <stdlib.h>   // Incluye la librería estándar para funciones de gestión de memoria y conversión de tipos.
#include <ctype.h>    // Incluye la librería para funciones de manejo de caracteres, como isdigit().
%}

%%

[0-9]+\.[0-9]+    { yylval.val = atof(yytext); return NUMBER; } // Coincide con números flotantes. Converte el texto coincidente en un valor de tipo double usando atof() y lo asigna a yylval.val. Luego devuelve el token NUMBER.
[0-9]+            { yylval.val = atof(yytext); return NUMBER; } // Coincide con números enteros. Converte el texto coincidente en un valor de tipo double usando atof() y lo asigna a yylval.val. Luego devuelve el token NUMBER.
"+"                { return ADD; } // Coincide con el signo de adición y devuelve el token ADD.
"-"                { return SUB; } // Coincide con el signo de sustracción y devuelve el token SUB.
"*"                { return MUL; } // Coincide con el signo de multiplicación y devuelve el token MUL.
"/"                { return DIV; } // Coincide con el signo de división y devuelve el token DIV.
"^"                { return EXP; } // Coincide con el símbolo de exponentiación (potencia) y devuelve el token EXP.
"\n"               { return EOL; } // Coincide con un salto de línea y devuelve el token EOL.
"|"                { return ABS; } // Coincide con el símbolo de valor absoluto y devuelve el token ABS.
[ \t]              { /* Ignorar espacios en blanco */ } // Coincide con espacios y tabulaciones y los ignora (no devuelve ningún token).
.                  { /* Ignorar otros caracteres no permitidos */ } // Coincide con cualquier otro carácter no definido en las reglas anteriores y lo ignora.

%%

int yywrap(void) {
    return 1; // Función que indica si el archivo de entrada ha terminado. Devuelve 1 para indicar que no hay más archivos para procesar.
}

