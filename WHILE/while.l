%{
#include "y.tab.h"
%}

alpha [A-Za-z]
digit [0-9]

%%

"while"                  return WHILE;
{digit}+                 { return NUM; }
{alpha}({alpha}|{digit})* { return ID; }
"("                      return '(';
")"                      return ')';
"{"                      return '{';
"}"                      return '}';
[ \t\n]                  ;  // Ignore spaces and newlines
.                        return yytext[0];  // Return any other character

%%
