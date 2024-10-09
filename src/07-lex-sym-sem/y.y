%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
int sym[26]; // Simple symbol table for variables a-z
%}

%union {
    int ival;
    char *sval;
}

%token INT VOID FLOAT CHAR DOUBLE RETURN PRINTF MAIN INCLUDE HEADER
%token IDENTIFIER NUMBER STRING
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON COMMA ASSIGN PLUS MINUS MUL DIV

%start program

%%

program:
    headers function_definition
    ;

headers:
    INCLUDE HEADER
    ;

function_definition:
    VOID MAIN LPAREN RPAREN LBRACE statements RBRACE
    ;

statements:
    statements statement
    | statement
    ;

statement:
    variable_declaration SEMICOLON
    | function_call SEMICOLON
    | assignment_statement SEMICOLON
    ;

variable_declaration:
    INT IDENTIFIER
    | INT IDENTIFIER ASSIGN NUMBER
    ;

assignment_statement:
    IDENTIFIER ASSIGN expression
    ;

expression:
    expression PLUS term
    | expression MINUS term
    | term
    ;

term:
    term MUL factor
    | term DIV factor
    | factor
    ;

factor:
    NUMBER
    | IDENTIFIER
    ;

function_call:
    PRINTF LPAREN STRING RPAREN
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Starting syntax and semantic analysis...\n");
    if (yyparse() == 0) {
        printf("Parsing completed successfully!\n");
    } else {
        printf("Parsing failed!\n");
    }
    return 0;
}
