%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char*);
int yylex(void);
%}

%token ID NUM WHILE
%left '+' '-'
%left '*' '/'

%%

S      : WHILE '(' E ')' '{' BODY '}'
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
    printf("Enter a while loop:\n");
    yyparse();
    return 0;
}

void yyerror(char* errorText) {
    printf("[ERROR]: %s\n", errorText);
}
