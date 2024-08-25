%{
#include "calc.tab.h" // Incluir el archivo de encabezado generado por Bison
void yyerror(const char *s); // Declarar la función de error
%}

%%

[0-9]+(\.[0-9]+)?   { yylval.fval = atof(yytext); return NUMBER; } // Captura números enteros o decimales y los convierte a float

[ \t]+              { /* Ignorar espacios */ } // Ignora espacios en blanco y tabulaciones

\n                  { return EOL; } // Retorna EOL al encontrar un salto de línea

[-+*/()]            { return yytext[0]; } // Retorna operadores aritméticos y paréntesis

[a-zA-Z]+           { yyerror("Error: Solo se aceptan valores numéricos en este programa."); } // Captura letras y muestra error si no son números

.                   { yyerror("Error: Carácter no reconocido."); } // Captura cualquier carácter no reconocido y muestra error

%%

int yywrap() {
    return 1; // Función que indica el final de la entrada
}
