%{
#include "y.tab.h"
%}

alpha [A-Za-z]
digit [0-9]

%%

"switch"                 return SWITCH;
"case"                   return CASE;
"default"                return DEFAULT;
"break"                  return BREAK;
{digit}+                 { return NUM; }
{alpha}({alpha}|{digit})* { return ID; }
"("                      return '(';
")"                      return ')';
"{"                      return '{';
"}"                      return '}';
":"                      return ':';
[ \t\n]                  ;  // Ignore spaces and newlines
.                        return yytext[0];  // Return any other character

%%
