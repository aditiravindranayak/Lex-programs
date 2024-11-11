%{
    #include <stdio.h>
    FILE *output;
%}

%%
[A-Z]   { fputc(yytext[0] + 32, output); }  // Convert uppercase to lowercase
[a-z]   { fputc(yytext[0] - 32, output); }  // Convert lowercase to uppercase
.       { fputc(yytext[0], output); }       // Copy non-alphabetic characters as is
\n      { fputc('\n', output); }            // Copy newlines as is
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *input = fopen(argv[1], "r");
    output = fopen("output.txt", "w");
    yyin = input;

    yylex();

    fclose(input);
    fclose(output);
    printf("Case conversion completed. Check output.txt\n");
    return 0;
}
