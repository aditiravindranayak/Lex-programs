int main(int argc, char *argv[]) {
    if (argc > 1 && (yyin = fopen(argv[1], "r"))) {
        yylex();
        fclose(yyin);
    } else {
        perror("Usage: ./a.out filename");
    }
    return 0;
}
