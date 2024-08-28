%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
    double val;
}

%token <val> NUMBER
%token ADD SUB MUL DIV EXP EOL

%left ADD SUB
%left MUL DIV
%right EXP  // Exponentiation has higher precedence
%right UMINUS

%type <val> expr

%%

calculo:
    expr EOL           { printf("Resultado: %.2f\n", $1); }
    | calculo expr EOL { printf("Resultado: %.2f\n", $2); }
    ;

expr:
    NUMBER          { $$ = $1; }
    | expr ADD expr { $$ = $1 + $3; }
    | expr SUB expr { $$ = $1 - $3; }
    | expr MUL expr { $$ = $1 * $3; }
    | expr DIV expr {
        if ($3 == 0) {
            yyerror("Error: División por cero");
            YYABORT;  // Abort parsing on error
        } else {
            $$ = $1 / $3;
        }
    }
    | expr EXP expr { $$ = pow($1, $3); }
    | SUB expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'  { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Ingrese una expresión matemática:\n");
    return yyparse();
}
