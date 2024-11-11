%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *s);
int yylex(void);
void codegen();
void codegen_assign();
void codegen_umin();
void generate_if();
void generate_while();
void push();
void printnum(int);

char st[100][25];  // Stack for intermediate variables
int top = -1;      // Stack pointer
int tint = 0;      // Temporary variable counter
int tintar[100];   // Store temporary variable values for IC generation
int label = 0;     // Label counter for control flow (if, while)
%}

%token ID NUM
%left '+' '-'
%left '*' '/'
%left UMINUS
%right '='
%left '<' '>'  // Relational operators for condition checking

%%

S : ID '=' E { push(); codegen_assign(); }
  | 'if' '(' E ')' '{' S '}' { generate_if(); }
  | 'while' '(' E ')' '{' S '}' { generate_while(); }
  ;

E : E '+' T { push(); codegen(); }
  | E '-' T { push(); codegen(); }
  | T
  ;

T : T '*' F { push(); codegen(); }
  | T '/' F { push(); codegen(); }
  | F
  ;

F : '(' E ')' { push(); }
  | '-' F %prec UMINUS { push(); codegen_umin(); }
  | ID { push(); }
  | NUM { push(); }
  ;

%%

#include "lex.yy.c"  // Include lexer generated code

void push() {
    strcpy(st[++top], yytext);
}

void codegen() {
    printf("t%d = %s %s %s\n", tint, st[top - 2], st[top - 1], st[top]);
    top -= 2;
    strcpy(st[top], "t");
    tintar[top] = tint++;
}

void codegen_umin() {
    printf("t%d = -%s\n", tint, st[top]);
    top--;
    strcpy(st[top], "t");
    tintar[top] = tint++;
}

void codegen_assign() {
    printf("%s = %s\n", st[top - 2], st[top]);
    top -= 2;
}

void generate_if() {
    int temp_label = label++;
    printf("if %s goto L%d\n", st[top], temp_label);
    top--;
    printf("L%d:\n", temp_label);
}

void generate_while() {
    int start_label = label++;
    int end_label = label++;
    printf("L%d:\n", start_label);
    printf("if %s goto L%d\n", st[top], end_label);
    top--;
    printf("goto L%d\n", start_label);
    printf("L%d:\n", end_label);
}

void printnum(int n) {
    if (strcmp(st[top - n], "t") == 0) {
        printf("t%d", tintar[top - n]);
    }
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expression or program: ");
    yyparse();
    return 0;
}
