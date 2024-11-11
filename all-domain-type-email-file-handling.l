%{
    int flag = 0;
%}

%%
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in|org|net|edu|gov)  { flag = 1; }
%%

int main() {
    yylex();
    if (flag == 1)
        printf("Accepted\n");
    else
        printf("Not Accepted\n");
    return 0;
}
This code matches email addresses with various top-level domains.

2. LEX Program for Checking All Domain Types of Email Addresses Using File Handling
This version reads email addresses from a file and checks each one.

lex
Copy code
%{
    int flag = 0;
%}

%%
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in|org|net|edu|gov) { flag = 1; }
\n { 
    if (flag == 1) 
        printf("Accepted\n");
    else 
        printf("Not Accepted\n");
    flag = 0;  // Reset flag for the next email
}
%%

int main(int argc, char *argv[]) {
    if (argc > 1 && (yyin = fopen(argv[1], "r"))) {
        yylex();
        fclose(yyin);
    } else {
        perror("Usage: ./a.out filename");
    }
    return 0;
}
