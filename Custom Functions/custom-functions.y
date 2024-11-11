%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char*);
int yylex(void);
%}

%token ID NUM FUNC

%%

S      : FUNC ID '(' ARGUMENTS ')' '{' BODY '}'
       ;

ARGUMENTS : ARGUMENTS ',' ID
          | ID
          | /* empty */
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
    printf("Enter a function expression:\n");
    yyparse();
    return 0;
}

void yyerror(char* errorText) {
    printf("[ERROR]: %s\n", errorText);
}
