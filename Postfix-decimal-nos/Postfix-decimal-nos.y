%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <assert.h>

    #define STACK_SIZE 100
    double stack[STACK_SIZE];
    int i = -1;

    void push(double val);
    double pop();
    double top();
    void yyerror(const char *s);
%}

%token NUM
%left '+' '-'
%left '*' '/'
%right UMINUS

%union {
    double val;
}

%type <val> E

%%

S   : E { printf("Result: %.2f\n", top()); }
    ;

E   : E E '+' { push(pop() + pop()); }
    | E E '-' { double temp = pop(); push(pop() - temp); }
    | E E '*' { push(pop() * pop()); }
    | E E '/' { double temp = pop(); if (temp != 0) push(pop() / temp); else yyerror("Division by zero"); }
    | NUM { push(yylval.val); }
    ;

%%

void push(double val) {
    assert(i < STACK_SIZE - 1);
    stack[++i] = val;
}

double pop() {
    assert(i > -1);
    return stack[i--];
}

double top() {
    assert(i > -1);
    return stack[i];
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter a postfix expression:\n");
    yyparse();
    return 0;
}
