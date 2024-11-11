%{
    #include <stdio.h>
    #include <string.h>

    #define MAX 100
    char postfix[MAX][MAX];  // Store postfix result
    int top = -1;

    void push_postfix(const char* val);
    void yyerror(const char *s);
%}

%token ID NUM
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '(' ')'

%union {
    char str[MAX];
}

%type <str> E

%%

S   : E { printf("Postfix Expression: ");
           for (int j = 0; j <= top; j++) printf("%s ", postfix[j]);
           printf("\n"); }
    ;

E   : E '+' E { push_postfix("+"); }
    | E '-' E { push_postfix("-"); }
    | E '*' E { push_postfix("*"); }
    | E '/' E { push_postfix("/"); }
    | '(' E ')' { /* Handle parenthesis */ }
    | '-' E %prec UMINUS { push_postfix("-"); }
    | NUM { push_postfix(yytext); }
    | ID  { push_postfix(yytext); }
    ;

%%

void push_postfix(const char* val) {
    if (top < MAX - 1) strcpy(postfix[++top], val);
}

void yyerror(const char* s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter an infix expression:\n");
    yyparse();
    return 0;
}
