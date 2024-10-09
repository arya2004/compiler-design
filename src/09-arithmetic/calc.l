%{
#include "y.tab.h"
%}

// Token definitions
%%
[ \t\n]+               ;               // Ignore whitespaces and newlines
[a-zA-Z_][a-zA-Z0-9_]* { return VAR; }  // Variables (identifiers)
[0-9]+                 { yylval = atoi(yytext); return NUM; } // Numbers
"="                    { return EQUALS; } // Assignment operator
";"                    { return SEMICOLON; } // Semicolon
"+"                    { return PLUS; } // Addition
"-"                    { return MINUS; } // Subtraction
"*"                    { return MULT; }  // Multiplication
"/"                    { return DIV; }   // Division
":"                    { return SEMICOLON; } // Handling both ; and : as delimiters
.                      { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
