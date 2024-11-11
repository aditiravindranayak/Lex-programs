%{
#include "y.tab.h"
%}

alpha [A-Za-z]
digit [0-9]

%%

"if"                      return IF;
"then"                    return THEN;
"else"                    return ELSE;
{digit}+                 { return NUM; }
{alpha}({alpha}|{digit})* { return ID; }
"("                      return '(';
")"                      return ')';
"{"                      return '{';
"}"                      return '}';
[ \t\n]                  ;  // Ignore spaces and newlines
.                        return yytext[0];  // Return any other character

%%
