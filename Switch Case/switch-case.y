%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char*);
int yylex(void);
%}

%token ID NUM SWITCH CASE DEFAULT BREAK

%%

S      : SWITCH '(' E ')' '{' CASE NUM ':' BODY DEFAULT ':' BODY '}' 
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
    printf("Enter a switch case expression:\n");
    yyparse();
    return 0;
}

void yyerror(char* errorText) {
    printf("[ERROR]: %s\n", errorText);
}
