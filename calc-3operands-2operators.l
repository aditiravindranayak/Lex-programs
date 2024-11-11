%{
#include <stdio.h>
float a, b, c, result;
char op1, op2;
%}

digit   [0-9]+(\.[0-9]+)?

%%

^{digit}       { a = atof(yytext); }    // Read first operand
[\+\-\*/]      { op1 = yytext[0]; }     // Read first operator
{digit}        { b = atof(yytext); }    // Read second operand
[\+\-\*/]      { op2 = yytext[0]; }     // Read second operator
{digit}        { c = atof(yytext);      // Read third operand

                // Evaluate based on operators
                result = (op1 == '+' ? a + b : op1 == '-' ? a - b : op1 == '*' ? a * b : a / b);
                result = (op2 == '+' ? result + c : op2 == '-' ? result - c : op2 == '*' ? result * c : result / c);
                printf("Result: %f\n", result);
              }

\n             { /* Ignore newline */ }

%%

int main() {
    printf("Enter an expression (e.g., 3 + 5 * 2):\n");
    yylex();
    return 0;
}

int yywrap() { return 1; }
