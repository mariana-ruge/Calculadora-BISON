%{
#include "calc.tab.h"
#include <stdlib.h>
#include <ctype.h>
%}

%%

[0-9]+\.[0-9]+    { yylval.val = atof(yytext); return NUMBER; }
[0-9]+            { yylval.val = atof(yytext); return NUMBER; }
"+"                { return ADD; }
"-"                { return SUB; }
"*"                { return MUL; }
"/"                { return DIV; }
"^"                { return EXP; }
"\n"               { return EOL; }
[ \t]              { /* Ignore whitespace */ }
.                  { /* Ignore other characters */ }

%%

int yywrap(void) {
    return 1;
}
