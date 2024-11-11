%{
    #include <stdio.h>
    int word_count = 0;
    char target_word[] = "word";  // Replace "word" with the target word
%}

%%
{target_word}   { word_count++; }  // Match target word and increment word count
.               ;                 // Ignore any other character
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    yyin = fp;
    yylex();

    printf("Frequency of word '%s': %d\n", target_word, word_count);

    fclose(fp);
    return 0;
}
