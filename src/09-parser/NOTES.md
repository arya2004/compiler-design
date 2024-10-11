# Lex and Yacc Program for Evaluating Arithmetic Expressions

This Lex and Yacc program serves as a **calculator** that evaluates arithmetic expressions involving numbers, variables (represented by identifiers), and basic arithmetic operators such as addition, subtraction, multiplication, and division. The program can handle both positive and negative numbers, as well as nested expressions within parentheses.

The Yacc code defines the grammar for parsing arithmetic expressions, while the Lex code tokenizes the input into numbers, identifiers, operators, and other necessary components.

## Yacc Program (Parser)

### Overview
The Yacc program processes and evaluates arithmetic expressions using grammar rules for basic arithmetic operations. It supports:
- Arithmetic operations: addition (`+`), subtraction (`-`), multiplication (`*`), and division (`/`).
- Nested expressions with parentheses.
- Both numbers and identifiers (for simplicity, identifiers are treated as numbers in this version).

### Yacc Code Explanation

```yacc
%{
    #include <stdio.h>
%}

/* Token definitions */
%token NUMBER ID

/* Operator precedence */
%left '+' '-'
%left '*' '/'

%% 
/* Grammar rules */
E : T  {
                printf("Result = %d\n", $$);
                return 0;  // Stop parsing after successfully evaluating the expression
            }

T : 
    T '+' T { $$ = $1 + $3; }  // Addition
    | T '-' T { $$ = $1 - $3; }  // Subtraction
    | T '*' T { $$ = $1 * $3; }  // Multiplication
    | T '/' T { $$ = $1 / $3; }  // Division
    | '-' NUMBER { $$ = -$2; }  // Unary minus for negative numbers
    | '-' ID { $$ = -$2; }  // Unary minus for negative identifiers
    | '(' T ')' { $$ = $2; }  // Parentheses for grouping expressions
    | NUMBER { $$ = $1; }  // Single number
    | ID { $$ = $1; };  // Single identifier

%%

/* Main function */
int main() {
    printf("Enter the expression\n");
    yyparse();  // Start parsing and evaluating the expression
}

/* Error handling function */
int yyerror(char* s) {
    printf("\nExpression is invalid\n");
}
```

### Key Components of the Yacc Code:

1. **Tokens**:
   - `NUMBER`: Represents numeric constants (integers) in the input.
   - `ID`: Represents identifiers (variables or symbolic names).

2. **Operator Precedence**:
   - The `%left` declarations specify the precedence and associativity of the operators:
     - `+` and `-` have the same precedence and are left-associative.
     - `*` and `/` have the same precedence but higher than `+` and `-`, and are also left-associative.

3. **Grammar Rules**:
   - The grammar defines how arithmetic expressions are formed and evaluated:
     - `T '+' T`: Adds two subexpressions.
     - `T '*' T`: Multiplies two subexpressions.
     - `'-' NUMBER`: Applies a unary minus to a number.
     - `'(' T ')'`: Evaluates a subexpression within parentheses.
     - `NUMBER`: Evaluates a single number.
     - `ID`: Evaluates a single identifier (here treated as a number).

4. **Action Code**:
   - Each rule contains action code (inside `{}`) to compute the result of the expression. The result of each rule is stored in `$$`, and the values of the subexpressions are accessed via `$1`, `$2`, etc.
   - For example, in the rule `T '+' T { $$ = $1 + $3; }`, `$1` is the value of the left operand, and `$3` is the value of the right operand.

5. **Main Function**:
   - The `main()` function prompts the user for input, starts the parsing process by calling `yyparse()`, and terminates when parsing is complete.

6. **Error Handling**:
   - If the input expression is invalid, the `yyerror()` function is called, printing an error message.

### How It Works:
- The Yacc parser processes the arithmetic expression using the defined grammar rules.
- If the expression is valid, the parser evaluates the result and prints it.
- Example input: `3 + 4 * 2`
  - Output: `Result = 11`

## Lex Program (Lexer)

### Overview
The Lex program is responsible for tokenizing the input expression. It identifies numbers, identifiers, arithmetic operators, and other components such as parentheses and whitespace.

### Lex Code Explanation

```lex
%{
    /* Include the Yacc header for token definitions */
    #include "y.tab.h"
    extern yylval;
%}

%%

/* Tokenizing rules */

/* Numbers */
[0-9]+ { 
            yylval = atoi(yytext);  // Convert the string to an integer
            return NUMBER;  // Return a NUMBER token
        } 

/* Identifiers */
[a-zA-Z]+ { return ID; }  // Return an ID token for variable names

/* Whitespace */
[ \t]+ ;  // Ignore spaces and tabs

/* Newline */
\n { return 0; }  // Return 0 to indicate the end of the input

/* Single character tokens */
. { return yytext[0]; }  // Return the character itself (e.g., operators like +, -, etc.)

%%

/* Wrap function to signal end of input */
int yywrap(void) {
    return 1;
}
```

### Key Components of the Lex Code:

1. **Token Definitions**:
   - The Lex code returns tokens like `NUMBER` and `ID` to the Yacc parser based on the patterns it matches.

2. **Tokenizing Numbers**:
   - The pattern `[0-9]+` matches one or more digits and converts the matched text to an integer using `atoi()`. The integer value is stored in `yylval`, which is used by Yacc for evaluating expressions.

3. **Tokenizing Identifiers**:
   - The pattern `[a-zA-Z]+` matches variable names or symbolic names (identifiers). The corresponding token `ID` is returned.

4. **Whitespace Handling**:
   - Whitespace characters like spaces and tabs are ignored by the lexer (`[ \t]+`), meaning they have no effect on parsing.

5. **Newline**:
   - The newline character (`\n`) signals the end of input, and the lexer returns `0` to indicate this to the parser.

6. **Single Characters**:
   - Any other single character (like `+`, `-`, `*`, `/`, `(`, `)`) is returned as itself, allowing the parser to handle these tokens directly.

### How It Works:
- Lex scans the input expression and converts it into tokens that the Yacc parser can process.
- For example, the input `3 + 4` is tokenized into:
  - `NUMBER(3)`, `+`, `NUMBER(4)`

### Combined Workflow

1. **Lex**:
   - Lex scans the input, tokenizes the numbers, identifiers, operators, and parentheses, and sends these tokens to Yacc.

2. **Yacc**:
   - Yacc processes the tokens according to the grammar rules for arithmetic expressions.
   - It evaluates the expression and prints the result.

### Example Run:

**Input**:
```
3 + 4 * 2 - ( 1 + 2 )
```

**Output**:
```
Result = 6
```

### Explanation of the Example:
- Lex tokenizes the input as:
  - `NUMBER(3)`, `+`, `NUMBER(4)`, `*`, `NUMBER(2)`, `-`, `(`, `NUMBER(1)`, `+`, `NUMBER(2)`, `)`
- Yacc parses the tokens and evaluates the expression step by step:
  - `4 * 2` is evaluated first (`8`).
  - `3 + 8` is evaluated next (`11`).
  - `1 + 2` is evaluated within the parentheses (`3`).
  - Finally, `11 - 3` is computed, resulting in `6`.

## How to Compile and Run the Program

1. **Generate Yacc Files**:
   ```bash
   yacc -d parser.y
   ```
   This will generate `y.tab.c` and `y.tab.h`.

2. **Generate Lex Files**:
   ```bash
   lex lexer.l
   ```
   This will generate `lex.yy.c`.

3. **Compile Lex and Yacc Together**:
   ```bash
   gcc y.tab.c lex.yy.c -o calculator -ll
   ```

4. **Run the Program**:
   ```bash
   ./calculator
   ```

   Provide an arithmetic expression as input and get the result.

## Summary

This Lex and Yacc program creates a basic arithmetic expression evaluator. It supports operations like addition, subtraction, multiplication, and division, as well as nested expressions within parentheses. The Lex code tokenizes the input, while the Yacc code parses the tokens and evaluates the expression.

### Key Features:
- **Lex**: Tokenizes numbers, identifiers, operators, and parentheses.
- **Yacc**: Parses the arithmetic expressions based on operator precedence and associativity, and evaluates the result.
- **Error Handling**: If an invalid expression is provided, the program displays an error message.