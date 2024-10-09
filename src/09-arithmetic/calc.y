%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *);

// Symbol table for storing variables
typedef struct {
    char* name;
    int value;
} Variable;

Variable variables[100];
int var_count = 0;

int get_variable_value(const char* var_name);
void set_variable_value(const char* var_name, int value);

%}

%union {
    int num;
    char* var_name;
}

// Token definitions
%token NUM VAR
%token EQUALS SEMICOLON
%token PLUS MINUS MULT DIV
%type <num> expr assignment

%%

// Grammar rules
input:
    assignments
    {
        // Finished parsing all assignments
        printf("x = %d\n", get_variable_value("x")); // Print the value of 'x' as required
    }
;

assignments:
    assignment SEMICOLON assignments
    |
    assignment SEMICOLON
;

assignment:
    VAR EQUALS expr
    {
        set_variable_value($1, $3);
    }
;

expr:
    expr PLUS expr
    {
        $$ = $1 + $3;
    }
    | expr MINUS expr
    {
        $$ = $1 - $3;
    }
    | expr MULT expr
    {
        $$ = $1 * $3;
    }
    | expr DIV expr
    {
        if ($3 == 0) {
            yyerror("Division by zero!");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | NUM
    {
        $$ = $1;
    }
    | VAR
    {
        $$ = get_variable_value($1);
    }
;

%%

int main(void) {
    printf("Enter your assignments and expression:\n");
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

// Functions to manage the symbol table
int get_variable_value(const char* var_name) {
    for (int i = 0; i < var_count; ++i) {
        if (strcmp(variables[i].name, var_name) == 0) {
            return variables[i].value;
        }
    }
    fprintf(stderr, "Error: Undefined variable '%s'\n", var_name);
    exit(1);
}

void set_variable_value(const char* var_name, int value) {
    for (int i = 0; i < var_count; ++i) {
        if (strcmp(variables[i].name, var_name) == 0) {
            variables[i].value = value;
            return;
        }
    }
    variables[var_count].name = strdup(var_name);
    variables[var_count].value = value;
    var_count++;
}
