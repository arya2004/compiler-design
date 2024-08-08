%{
#include <stdio.h>
%}

%%
[0-9]+      { printf("Number: %s\n", yytext); }
[0-9]+"."[0-9]+ { printf("Decimal Number: %s\n", yytext); }
[ \t\n]+    ;  // Ignore whitespace
.           { printf("Unknown character: %s\n", yytext); }
%%

int main(void) {
    yylex();
    return 0;
}

int yywrap(void) {
    return 1;
}
