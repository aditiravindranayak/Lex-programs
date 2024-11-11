%{
#include "y.tab.h"
%}

%%

[0-9]+(\.[0-9]+)?     { yylval.num = atof(yytext); return NUMBER; }  /* Numbers */
[\t ]                 { /* Ignore whitespace */ }
\n                    { return '\n'; }
"+"                   { return '+'; }
"-"                   { return '-'; }
"*"                   { return '*'; }
"/"                   { return '/'; }
"("                   { return '('; }
")"                   { return ')'; }

.                     { yyerror("Invalid character"); }

%%

int yywrap() {
    return 1;
}
