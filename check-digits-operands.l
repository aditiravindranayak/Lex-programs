%{
#include <stdio.h>
%}

digit      [0-9]+
operator   [\+\-\*/\^]

%%

{digit}       { printf("Found a digit: %s\n", yytext); }
{operator}    { printf("Found an operator: %s\n", yytext); }
\n            { /* Ignore newline */ }
.             { printf("Invalid character: %s\n", yytext); }

%%

int main() {
    printf("Enter an expression:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
