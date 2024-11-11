%{
#include "y.tab.h"
%}

%%

[0-9]+(\.[0-9]+)? { yylval.val = atof(yytext); return NUM; }
[ \t\n]+          ;  // Ignore whitespace
"+"               { return '+'; }
"-"               { return '-'; }
"*"               { return '*'; }
"/"               { return '/'; }
"("               { return '('; }
")"               { return ')'; }

.                 { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
