%{
#include <stdio.h>
#include <string.h>

int keyword_count = 0;
int identifier_count = 0;
int number_count = 0;
int operator_count = 0;
int punctuation_count = 0;
int total_tokens = 0;

void count_token() {
    total_tokens++;
}
%}

/* Define keywords in C */
KEYWORD "int"|"float"|"double"|"char"|"return"|"if"|"else"|"while"|"for"|"void"

/* Define operators in C */
OPERATOR "+"|"-"|"*"|"/"|"="|"<"|">"|"=="|"<="|">="|"!="|"&&"|"||"|"!"|"&"|"|"|"%"

/* Define punctuations */
PUNCTUATION ";"|","|"{"|"}"|"("|")"

/* Define identifiers */
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*

/* Define numbers */
NUMBER [0-9]+

%%

{KEYWORD}       { printf("Keyword: %s\n", yytext); keyword_count++; count_token(); }
{IDENTIFIER}    { printf("Identifier: %s\n", yytext); identifier_count++; count_token(); }
{NUMBER}        { printf("Number: %s\n", yytext); number_count++; count_token(); }
{OPERATOR}      { printf("Operator: %s\n", yytext); operator_count++; count_token(); }
{PUNCTUATION}   { printf("Punctuation: %s\n", yytext); punctuation_count++; count_token(); }

[\n\t ]        ;  // Ignore whitespaces and newlines
.              { printf("Unknown character: %s\n", yytext); }

%%

int main() {
    printf("Enter the C program to be analyzed:\n");
    yylex();
    printf("\nTotal tokens: %d\n", total_tokens);
    printf("Keywords: %d\n", keyword_count);
    printf("Identifiers: %d\n", identifier_count);
    printf("Numbers: %d\n", number_count);
    printf("Operators: %d\n", operator_count);
    printf("Punctuations: %d\n", punctuation_count);
    return 0;
}

int yywrap() {
    return 1;
}
