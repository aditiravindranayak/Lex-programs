%{
    #include <stdio.h>
    int tokens = 0;
%}

%%
.          { tokens++; }       // Match any single character and count it as a token
\n         { tokens++; }       // Count newline as a token
[ \t]      ;                  // Ignore spaces and tabs
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    yyin = fp;
    yylex();

    printf("Total Tokens: %d\n", tokens);

    fclose(fp);
    return 0;
}
