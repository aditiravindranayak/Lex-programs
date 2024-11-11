%{
    #include <stdio.h>
    int uppercase_count = 0;
    int lowercase_count = 0;
%}

%%
[A-Z]   { uppercase_count++; }  // Count uppercase letters
[a-z]   { lowercase_count++; }  // Count lowercase letters
.       ;                       // Ignore other characters
\n      ;                       // Ignore newlines
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    yyin = fp;
    yylex();

    printf("Uppercase characters: %d\n", uppercase_count);
    printf("Lowercase characters: %d\n", lowercase_count);

    fclose(fp);
    return 0;
}
