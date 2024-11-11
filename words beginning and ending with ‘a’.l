%{
    #include <stdio.h>
    int count = 0;  // Counter for words that start and end with 'a'
%}

%%
[aA][a-zA-Z]*[aA]   { count++; printf("Matched word: %s\n", yytext); }  // Match words starting and ending with 'a' or 'A'
.                    ;  // Ignore other characters
\n                   ;  // Ignore newlines
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    yyin = fp;
    yylex();

    printf("Total words beginning and ending with 'a': %d\n", count);

    fclose(fp);
    return 0;
}
