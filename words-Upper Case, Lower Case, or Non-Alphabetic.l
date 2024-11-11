%{
    #include <stdio.h>
%}

%%
[A-Z]       { printf("%c is an uppercase character\n", yytext[0]); }
[a-z]       { printf("%c is a lowercase character\n", yytext[0]); }
[^a-zA-Z]   { printf("%c is a non-alphabetic character\n", yytext[0]); }
\n          ;  // Ignore newlines
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
