%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;   // Temporary variable counter for IC
int stackTop = 0;    // Stack pointer for expression evaluation
char temp[3] = "t";  // Template for temporary variable names
char stack[100][10]; // Stack to store variables or temporary results

void yyerror(const char *s);
int yylex(void);

void codegen();            // Generate code for binary operations
void codegen_umin();       // Generate code for unary minus
void codegen_assign();     // Generate code for assignments
void push(char *str);      // Push variables or temporary results onto the stack
char *new_temp();          // Generate a new temporary variable
%}

%token ID NUM
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

program:
    program statement
    | /* empty */
    ;

statement:
    ID '=' expression   { codegen_assign(); }
    | expression        { /* Expression evaluation */ }
    ;

expression:
    expression '+' expression { codegen(); }
    | expression '-' expression { codegen(); }
    | expression '*' expression { codegen(); }
    | expression '/' expression { codegen(); }
    | '-' expression %prec UMINUS { codegen_umin(); }
    | '(' expression ')'   { /* Parenthesized expression */ }
    | NUM { push($1); }
    | ID  { push($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

void push(char *str) {
    strcpy(stack[stackTop++], str);
}

char *new_temp() {
    sprintf(temp, "t%d", tempCount++);
    return strdup(temp);
}

void codegen() {
    char op1[10], op2[10], result[10];
    strcpy(op2, stack[--stackTop]);
    strcpy(op1, stack[--stackTop]);
    strcpy(result, new_temp());
    printf("%s = %s %s %s\n", result, op1, yytext, op2); // Emit intermediate code
    push(result);
}

void codegen_umin() {
    char op[10], result[10];
    strcpy(op, stack[--stackTop]);
    strcpy(result, new_temp());
    printf("%s = -%s\n", result, op);  // Emit intermediate code for unary minus
    push(result);
}

void codegen_assign() {
    char op[10], result[10];
    strcpy(op, stack[--stackTop]);
    strcpy(result, stack[--stackTop]);
    printf("%s = %s\n", result, op);  // Emit intermediate code for assignment
}

int main() {
    printf("Enter an expression:\n");
    return yyparse();
}
