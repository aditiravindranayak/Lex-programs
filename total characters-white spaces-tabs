%{
    #include <stdio.h>
    int characters = 0, whitespaces = 0, tabs = 0;
%}

%%
.          { characters++; }       // Match any character and increment character count
[ \n]      { whitespaces++; }      // Match spaces or newlines and increment whitespace count
\t         { tabs++; }             // Match tabs and increment tab count
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    yyin = fp;
    yylex();

    printf("Total Characters: %d\n", characters);
    printf("Total Whitespaces: %d\n", whitespaces);
    printf("Total Tabs: %d\n", tabs);

    fclose(fp);
    return 0;
}
