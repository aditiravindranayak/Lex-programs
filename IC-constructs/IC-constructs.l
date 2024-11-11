%{
#include "y.tab.h"
%}

ALPHA [A-Za-z]
DIGIT [0-9]

%%

" "                         ;  // Ignore spaces
{ALPHA}({ALPHA}|{DIGIT})*    { return ID; }  // Identifiers (variables)
{DIGIT}+                    { yylval = atoi(yytext); return NUM; }  // Numbers
"if"                         { return IF; }  // 'if' keyword
"while"                      { return WHILE; }  // 'while' keyword
"("                          { return '('; }  // Left parenthesis
")"                          { return ')'; }  // Right parenthesis
"+"                          { return '+'; }  // Plus operator
"-"                          { return '-'; }  // Minus operator
"*"                          { return '*'; }  // Multiplication operator
"/"                          { return '/'; }  // Division operator
"="                          { return '='; }  // Assignment operator
"<"                          { return '<'; }  // Less than operator
">"                          { return '>'; }  // Greater than operator
[ \t\n]                      ;  // Ignore whitespace and newline
.                            { return yytext[0]; }  // Return any other character as a token

%%