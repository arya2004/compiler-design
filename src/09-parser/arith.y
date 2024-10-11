%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  /* Needed for strdup */

typedef struct node {
    char *token;
    struct node *left;
    struct node *right;
} Node;

Node* createNode(char *token, Node *left, Node *right);
void printTree(Node *tree, int level);
void freeTree(Node *tree);  /* Function to free the allocated memory */

%}

/* Yacc's union to handle different types of data */
%union {
    char *id;           /* For identifiers (like variable names) */
    struct node *tree;  /* For building the parse tree */
}

/* Define tokens and their types */
%token <id> ID NUM
%left '+'    /* Left associative '+' */
%left '*'    /* Left associative '*' */
%nonassoc '=' /* Non-associative '=' operator */

%type <tree> expr assign term factor

%%

/* Grammar rules */
program:
    assign
    ;

assign:
    ID '=' expr { 
        $$ = createNode("=", createNode(strdup($1), NULL, NULL), $3); 
    }
    ;

expr:
    expr '+' term {
        $$ = createNode("+", $1, $3);
    }
    | term {
        $$ = $1;
    }
    ;

term:
    term '*' factor {
        $$ = createNode("*", $1, $3);
    }
    | factor {
        $$ = $1;
    }
    ;

factor:
    ID {
        $$ = createNode(strdup($1), NULL, NULL);  /* Use strdup to copy the identifier */
    }
    | NUM {
        $$ = createNode(strdup($1), NULL, NULL);  /* Use strdup to copy the number */
    }
    ;

%%

/* Helper functions for parse tree creation and display */

Node* createNode(char *token, Node *left, Node *right) {
    if (!token) {
        fprintf(stderr, "Error: Token is NULL!\n");
        exit(1);  /* Exit if there's a critical memory issue */
    }

    Node *node = (Node *)malloc(sizeof(Node));
    if (!node) {
        fprintf(stderr, "Error: Memory allocation failed!\n");
        exit(1);  /* Exit if memory allocation fails */
    }

    node->token = token;
    node->left = left;
    node->right = right;
    return node;
}

void printTree(Node *tree, int level) {
    if (tree == NULL) return;

    for (int i = 0; i < level; i++) printf("  ");  /* Indent based on level */
    printf("%s\n", tree->token);

    printTree(tree->left, level + 1);
    printTree(tree->right, level + 1);
}

void freeTree(Node *tree) {
    if (tree == NULL) return;

    free(tree->token);  /* Free the token */
    freeTree(tree->left);
    freeTree(tree->right);
    free(tree);         /* Free the node itself */
}

int main() {
    printf("Enter an expression:\n");
    yyparse();  /* Start parsing */
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
