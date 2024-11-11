%{
    // Flex program to convert decimal to binary
    #include<stdio.h>
    #include<stdlib.h>
    extern FILE *yyin;
    int num, r, count = 0, pcount = 0, i;
    char binary[50];
%}

DIGIT [0-9]

%%
{DIGIT}+ {
    num = atoi(yytext);
    count = 0;

    while(num != 0) {
        r = num % 2;
        binary[count++] = '0' + r;
        num = num / 2;
    }

    // Print the binary number in reverse
    for(i = count - 1; i >= pcount; --i) 
        printf("%c", binary[i]);
    
    printf("\n");
    pcount = count;
}

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    yyin = fp;
    yylex();
    fclose(fp);
    return 0;
}

