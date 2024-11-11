%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char*);
int yylex(void);
%}

%token IF THEN ELSE ID NUM

%%

S      : IF '(' E ')' THEN BODY ELSE BODY
       ;

BODY   : BODY E ';'
       | /* empty */
       ;

E      : ID '=' NUM
       | E '+' E
       | E '-' E
       | E '*' E
       | E '/' E
       | ID
       | NUM
       ;

%%

#include "lex.yy.c"

int main() {
    printf("Enter an if-then-else expression:\n");
    yyparse();
    return 0;
}

void yyerror(char* errorText) {
    printf("[ERROR]: %s\n", errorText);
}
