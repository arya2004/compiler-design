%{
#include <stdio.h>
%}

%%
[a-zA-Z]    { printf("Character: %s\n", yytext); }
[a-zA-Z]+   { printf("String: %s\n", yytext); }
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
