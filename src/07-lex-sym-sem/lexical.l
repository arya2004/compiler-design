%{
#include "y.tab.h"  // Include the tokens defined by Bison
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *token_file;  // File pointer for the token file

%}

%%

"int"                   { fprintf(token_file, "INT: %s\n", yytext); return INT; }
"void"                  { fprintf(token_file, "VOID: %s\n", yytext); return VOID; }
"float"                 { fprintf(token_file, "FLOAT: %s\n", yytext); return FLOAT; }
"char"                  { fprintf(token_file, "CHAR: %s\n", yytext); return CHAR; }
"double"                { fprintf(token_file, "DOUBLE: %s\n", yytext); return DOUBLE; }
"return"                { fprintf(token_file, "RETURN: %s\n", yytext); return RETURN; }
"printf"                { fprintf(token_file, "PRINTF: %s\n", yytext); return PRINTF; }
"#include"              { fprintf(token_file, "INCLUDE: %s\n", yytext); return INCLUDE; }
"<stdio.h>"             { fprintf(token_file, "HEADER: %s\n", yytext); return HEADER; }
"main"                  { fprintf(token_file, "MAIN: %s\n", yytext); return MAIN; }
[0-9]+                  { fprintf(token_file, "NUMBER: %s\n", yytext); yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { fprintf(token_file, "IDENTIFIER: %s\n", yytext); yylval.sval = strdup(yytext); return IDENTIFIER; }
"{"                     { fprintf(token_file, "LBRACE: %s\n", yytext); return LBRACE; }
"}"                     { fprintf(token_file, "RBRACE: %s\n", yytext); return RBRACE; }
"("                     { fprintf(token_file, "LPAREN: %s\n", yytext); return LPAREN; }
")"                     { fprintf(token_file, "RPAREN: %s\n", yytext); return RPAREN; }
";"                     { fprintf(token_file, "SEMICOLON: %s\n", yytext); return SEMICOLON; }
","                     { fprintf(token_file, "COMMA: %s\n", yytext); return COMMA; }
"="                     { fprintf(token_file, "ASSIGN: %s\n", yytext); return ASSIGN; }
"+"                     { fprintf(token_file, "PLUS: %s\n", yytext); return PLUS; }
"-"                     { fprintf(token_file, "MINUS: %s\n", yytext); return MINUS; }
"*"                     { fprintf(token_file, "MUL: %s\n", yytext); return MUL; }
"/"                     { fprintf(token_file, "DIV: %s\n", yytext); return DIV; }
\"[^\"]*\"              { fprintf(token_file, "STRING: %s\n", yytext); yylval.sval = strdup(yytext); return STRING; }
[ \t]+                  ;  // Ignore whitespace
\n                      ;  // Ignore newline
.                       { fprintf(token_file, "UNKNOWN: %s\n", yytext); return yytext[0]; }  // Return any unrecognized character

%%

int yywrap() {
    return 1;
}

int main() {
    token_file = fopen("tokens.txt", "w");  // Open the file for writing
    if (!token_file) {
        perror("Failed to open file");
        exit(1);
    }

    yylex();  // Start lexical analysis

    fclose(token_file);  // Close the file after analysis
    return 0;
}
