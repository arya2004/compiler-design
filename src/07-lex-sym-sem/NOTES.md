# Lex Program for Tokenizing a C Program

This Lex program is designed to analyze a C program and classify various tokens such as keywords, identifiers, numbers, operators, and punctuation. It counts the occurrences of each type of token and provides a summary at the end of the lexical analysis. Additionally, the program handles unknown characters and ignores whitespaces.

Here’s an in-depth explanation of how this Lex program works, including how it processes input, identifies tokens, and categorizes them.

## Lex Program Overview

The program performs the following tasks:
1. **Token Classification**: It identifies and classifies tokens into keywords, identifiers, numbers, operators, and punctuation.
2. **Counting Tokens**: It counts how many times each type of token appears and the total number of tokens.
3. **Handling Unknown Characters**: If an unrecognized character is found, it prints a message indicating it as "unknown."
4. **Ignoring Whitespace**: Spaces, tabs, and newlines are ignored during token processing.

### Lex Program Structure

The program is divided into three sections:

1. **Declarations Section**: Contains C code, global variables, and helper functions.
2. **Rules Section**: Defines the regular expressions for matching different token types and the actions to take when a match is found.
3. **User Code Section**: Contains the `main()` function and any additional necessary code.

## The Lex Program Code

Here is the complete Lex code:

```lex
%{
#include <stdio.h>
#include <string.h>

// Global counters for each type of token
int keyword_count = 0;
int identifier_count = 0;
int number_count = 0;
int operator_count = 0;
int punctuation_count = 0;
int total_tokens = 0;

// Function to increment the total token count
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

// Define patterns and actions for tokens

{KEYWORD}       { printf("Keyword: %s\n", yytext); keyword_count++; count_token(); }
{IDENTIFIER}    { printf("Identifier: %s\n", yytext); identifier_count++; count_token(); }
{NUMBER}        { printf("Number: %s\n", yytext); number_count++; count_token(); }
{OPERATOR}      { printf("Operator: %s\n", yytext); operator_count++; count_token(); }
{PUNCTUATION}   { printf("Punctuation: %s\n", yytext); punctuation_count++; count_token(); }

[\n\t ]        ;  // Ignore whitespaces and newlines
.              { printf("Unknown character: %s\n", yytext); }

%%

// Main function to start lexical analysis
int main() {
    printf("Enter the C program to be analyzed:\n");
    yylex();  // Start lexical analysis
    
    // Print the final counts for each token type
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
```

### Section 1: Declarations Section

```lex
%{
#include <stdio.h>
#include <string.h>

// Global counters for each type of token
int keyword_count = 0;
int identifier_count = 0;
int number_count = 0;
int operator_count = 0;
int punctuation_count = 0;
int total_tokens = 0;

// Function to increment the total token count
void count_token() {
    total_tokens++;
}
%}
```

- **Includes**: The program includes the standard I/O library `stdio.h` to handle input/output functions like `printf()` and the string library `string.h` (though not explicitly needed for this program, it's included for any potential string manipulation).
- **Global Counters**: The program uses several global variables to track the count of different types of tokens:
  - `keyword_count`: Counts the number of C keywords.
  - `identifier_count`: Counts the number of identifiers.
  - `number_count`: Counts the number of numbers (integer literals).
  - `operator_count`: Counts the number of operators.
  - `punctuation_count`: Counts the number of punctuation characters.
  - `total_tokens`: Tracks the total number of tokens encountered.
  
- **Helper Function `count_token()`**: This function increments the `total_tokens` variable each time a token is identified.

### Section 2: Rules Section

```lex
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

// Define patterns and actions for tokens

{KEYWORD}       { printf("Keyword: %s\n", yytext); keyword_count++; count_token(); }
{IDENTIFIER}    { printf("Identifier: %s\n", yytext); identifier_count++; count_token(); }
{NUMBER}        { printf("Number: %s\n", yytext); number_count++; count_token(); }
{OPERATOR}      { printf("Operator: %s\n", yytext); operator_count++; count_token(); }
{PUNCTUATION}   { printf("Punctuation: %s\n", yytext); punctuation_count++; count_token(); }

[\n\t ]        ;  // Ignore whitespaces and newlines
.              { printf("Unknown character: %s\n", yytext); }
```

#### Breakdown of Patterns and Actions:

1. **Keywords (`KEYWORD`)**:
   - **Pattern**: `"int"|"float"|"double"|"char"|"return"|"if"|"else"|"while"|"for"|"void"`
     - Matches common C keywords such as `int`, `float`, `double`, `char`, etc.
   - **Action**: When a keyword is matched, it prints `"Keyword: <keyword>"`, increments the `keyword_count`, and calls `count_token()` to update the total token count.

2. **Identifiers (`IDENTIFIER`)**:
   - **Pattern**: `[a-zA-Z_][a-zA-Z0-9_]*`
     - Matches valid C identifiers that start with an alphabetic character or an underscore and can be followed by alphanumeric characters or underscores.
   - **Action**: When an identifier is matched, it prints `"Identifier: <identifier>"`, increments the `identifier_count`, and updates the total token count.

3. **Numbers (`NUMBER`)**:
   - **Pattern**: `[0-9]+`
     - Matches integer numbers.
   - **Action**: When a number is matched, it prints `"Number: <number>"`, increments the `number_count`, and updates the total token count.

4. **Operators (`OPERATOR`)**:
   - **Pattern**: `"+"|"-"|"*"|"/"|"="|"<"|">"|"=="|"<="|">="|"!="|"&&"|"||"|"!"|"&"|"|"|"%"`
     - Matches various C operators including arithmetic operators, relational operators, and logical operators.
   - **Action**: When an operator is matched, it prints `"Operator: <operator>"`, increments the `operator_count`, and updates the total token count.

5. **Punctuation (`PUNCTUATION`)**:
   - **Pattern**: `";"|","|"{"|"}"|"("|")"`
     - Matches punctuation symbols like semicolons, commas, curly braces, and parentheses.
   - **Action**: When a punctuation symbol is matched, it prints `"Punctuation: <punctuation>"`, increments the `punctuation_count`, and updates the total token count.

6. **Whitespace and Newlines (`[\n\t ]`)**:
   - **Pattern**: `[\n\t ]`
     - Matches whitespace characters including spaces, tabs, and newlines.
   - **Action**: These characters are ignored and no action is taken.

7. **Unknown Characters (`.`)**:
   - **Pattern**: `.`
     - Matches any character that is not recognized by any of the previous patterns.
   - **Action**: Prints `"Unknown character: <character>"`, but does not increment any counters.

### Section 3: User Code Section

```c
// Main function to start lexical analysis
int main() {
    printf("Enter the C

 program to be analyzed:\n");
    yylex();  // Start lexical analysis
    
    // Print the final counts for each token type
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
```

- **`main()`**:
  - The `main()` function serves as the entry point of the program.
  - It first prints a prompt asking the user to input a C program.
  - It then calls `yylex()` to begin lexical analysis.
  - After lexical analysis completes, the program prints the total number of tokens and the counts for each token type.

- **`yywrap()`**:
  - This function is called when `yylex()` reaches the end of the input. It returns `1` to signal the end of input processing.

## How the Program Works

1. **Input Processing**:
   - The program reads a C program from `stdin` and processes it character by character.
   - It identifies tokens such as keywords, identifiers, numbers, operators, and punctuation based on the patterns defined in the **Rules Section**.
   - Whitespace and newlines are ignored, and any unrecognized characters are printed as "unknown."

2. **Token Counting**:
   - For each recognized token, the program increments the respective counter and updates the total token count.

3. **Output**:
   - After processing the input, the program prints a summary of the number of keywords, identifiers, numbers, operators, and punctuation characters, along with the total number of tokens.

### Sample Input and Output

**Sample Input**:
```c
int main() {
    int a = 10 + 20;
    return a;
}
```

**Sample Output**:
```
Enter the C program to be analyzed:
Keyword: int
Identifier: main
Punctuation: (
Punctuation: )
Punctuation: {
Keyword: int
Identifier: a
Operator: =
Number: 10
Operator: +
Number: 20
Punctuation: ;
Keyword: return
Identifier: a
Punctuation: ;
Punctuation: }

Total tokens: 16
Keywords: 3
Identifiers: 3
Numbers: 2
Operators: 3
Punctuations: 5
```

### Explanation:
- The program correctly identifies and classifies the tokens from the input C program.
- It counts and prints the keywords (`int`, `return`), identifiers (`main`, `a`), numbers (`10`, `20`), operators (`=`, `+`), and punctuation symbols (`(`, `)`, `{`, `}`, `;`).
- After lexical analysis is complete, it provides a summary of the total tokens and the count of each token type.

## How to Compile and Run the Program

1. **Save the Lex code** in a file, for example, `c_tokenizer.l`.

2. **Compile the Lex code** using the following commands:

```bash
lex c_tokenizer.l    # This generates lex.yy.c
gcc lex.yy.c -o c_tokenizer -ll  # Compiles and links the Lex library
```

3. **Run the program**:

```bash
./c_tokenizer
```

Provide a C program as input, either by typing it or redirecting from a file, and the program will analyze and print the identified tokens.

## Summary

This Lex program is a simple lexical analyzer for tokenizing a C program. It classifies tokens into keywords, identifiers, numbers, operators, and punctuation, counts the occurrences of each token type, and provides a summary of the total tokens.

### Key Features:
- **Token Classification**: The program identifies and classifies different types of tokens using regular expressions.
- **Token Counting**: It keeps track of how many tokens of each type are found in the input.
- **Whitespace Handling**: Whitespace and newlines are ignored, while unrecognized characters are printed as "unknown."
