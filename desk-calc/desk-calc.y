%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char* s);
int yylex(void);  // Lex function to get tokens

%}

%token NUM
%left '+' '-'
%left '*' '/'
%right UMINUS  // Unary minus

%%

/* Grammar rules and actions */

S: E { printf("Result = %d\n", $1); }  // Print the result of the expression
;

E: E '+' E { $$ = $1 + $3; }  // Addition
  | E '-' E { $$ = $1 - $3; }  // Subtraction
  | E '*' E { $$ = $1 * $3; }  // Multiplication
  | E '/' E { if ($3 == 0) { yyerror("Division by zero"); } else { $$ = $1 / $3; } }  // Division
  | '-' E %prec UMINUS { $$ = -$2; }  // Unary minus
  | '(' E ')' { $$ = $2; }  // Parentheses: (expression)
  | NUM { $$ = $1; }  // Numbers
;

%%

/* Error handler */
void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an arithmetic expression:\n");
    return yyparse();  // Start parsing
}
