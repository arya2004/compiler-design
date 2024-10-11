# Lex Program for Extracting and Modifying Words from a File

This Lex program is designed to process text from an input file (`input.txt`) and extract specific words based on a pattern. These words are then written to an output file (`output.txt`). Afterward, the contents of the output file are copied back into the original input file, effectively modifying the input file by filtering out specific patterns of text.

Here’s an in-depth explanation of how this Lex program works.

## Overview of the Program's Functionality

- **Input**: The program reads text from an `input.txt` file.
- **Processing**: It extracts words that start and end with the letter 'a', and optionally contain lowercase letters or spaces in between. These words are written to an `output.txt` file.
- **Post-processing**: After the lexical analysis, the content of `output.txt` is copied back into `input.txt`, modifying the original file with the filtered output.

## Lex Program Structure

As usual, the Lex program follows the three-section structure:

1. **Declarations Section**: This is where we declare global variables, include headers, and set up files for input and output.
2. **Rules Section**: Here we define the patterns that the program will match and the actions that will be executed when a pattern is found.
3. **User Code Section**: This contains the `main()` function and any additional logic needed after the lexical analysis.

## The Lex Code

Here is the complete Lex code:

```lex
%{
#include<stdio.h>
#include<stdlib.h>      
FILE *output;  // Declare a file pointer for output
%}

%%
// Define patterns and actions

a{1}[a-z ]*a{1}  { fprintf(yyout, "%s", yytext); }  // Write words starting and ending with 'a' to the output file
. {}  // Ignore all other characters

%%

// Function called when the end of input is reached
int yywrap(){
    return 1;
}

int main() {
    extern FILE *yyin, *yyout;  // Declare yyin and yyout to handle input and output files

    // Open input and output files
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    // Start lexical analysis
    yylex();

    // Close input and output files after processing
    fclose(yyin);
    fclose(yyout);

    // Copy contents of output.txt back to input.txt
    FILE *fptr1, *fptr2;
    int c;

    // Open output.txt for reading
    fptr1 = fopen("output.txt", "r");
    
    // Open input.txt for writing (this overwrites the original content)
    fptr2 = fopen("input.txt", "w");

    // Copy content from output.txt to input.txt
    while ((c = fgetc(fptr1)) != EOF) {
        fputc(c, fptr2);
    }

    // Close the files after copying
    fclose(fptr1);
    fclose(fptr2);

    return 0;  // Exit successfully
}
```

### Section 1: Declarations Section

```lex
%{
#include<stdio.h>
#include<stdlib.h>      

FILE *output;  // Declare a file pointer for output
%}
```

- **Purpose**: The Declarations Section is enclosed in `%{` and `%}` and contains C code that is copied directly into the generated C file. 
- **Includes**: It includes standard I/O libraries (`stdio.h`) and the `stdlib.h` library for basic file operations.
- **Global Variables**:
  - `FILE *output`: A file pointer that will be used to write to the output file (`output.txt`).

### Section 2: Rules Section

```lex
a{1}[a-z ]*a{1}  { fprintf(yyout, "%s", yytext); }  // Match and print words that start and end with 'a'
. {}  // Ignore all other characters
```

#### Breakdown of the Rules:

1. **Pattern: `a{1}[a-z ]*a{1}`**
   - **Explanation**: This pattern matches a string that starts and ends with the letter `'a'`. Between these two `'a'` characters, there can be any combination of lowercase letters (`a-z`) and spaces (` `).
     - `a{1}`: Matches exactly one `'a'` at the start and end of the word.
     - `[a-z ]*`: Matches any combination of lowercase letters and spaces, zero or more times.
   - **Action**: When a word that matches this pattern is found, it is written to the output file using `fprintf(yyout, "%s", yytext);`.
     - `yytext` is a Lex variable that holds the matched text.

   **Example**: If the input is "apple arena alpha", the words "arena" and "alpha" will be written to `output.txt`.

2. **Pattern: `.`**
   - **Explanation**: The dot (`.`) is a special regular expression symbol that matches any single character.
   - **Action**: Since the action for this pattern is an empty block (`{}`), it effectively ignores all characters that don’t match the previous rule.
   - **Purpose**: This pattern ensures that any characters that don’t start and end with `'a'` are simply skipped.

### Section 3: User Code Section

```c
int yywrap() {
    return 1;
}

int main() {
    extern FILE *yyin, *yyout;  // Declare yyin and yyout for handling files

    // Open input and output files
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    // Perform lexical analysis
    yylex();

    // Close input and output files
    fclose(yyin);
    fclose(yyout);

    // Copy content of output.txt back to input.txt
    FILE *fptr1, *fptr2;
    int c;

    fptr1 = fopen("output.txt", "r");  // Open output.txt for reading
    fptr2 = fopen("input.txt", "w");   // Open input.txt for overwriting

    // Copy each character from output.txt to input.txt
    while ((c = fgetc(fptr1)) != EOF) {
        fputc(c, fptr2);
    }

    // Close both files
    fclose(fptr1);
    fclose(fptr2);

    return 0;
}
```

#### `yywrap()` Function:
- **Purpose**: This function is called when the end of the input is reached. It returns `1` to indicate the end of input, allowing `yylex()` to stop processing.

#### `main()` Function:
- **Purpose**: This is the main entry point of the program where all operations are carried out:
  
  1. **File Handling**:
     - **`yyin`**: The input file (`input.txt`) is opened in read mode.
     - **`yyout`**: The output file (`output.txt`) is opened in write mode. Words matching the pattern are written to this file.
  
  2. **Lexical Analysis**:
     - The `yylex()` function is called to start the lexical analysis process. It reads the input file and writes matching words to the output file.

  3. **Post-processing**:
     - After lexical analysis is complete, the program reopens `output.txt` for reading and `input.txt` for writing.
     - The contents of `output.txt` are copied back into `input.txt`, effectively modifying the original input file with only the matched words.

  4. **Closing Files**:
     - Both the input and output files are closed after the copying process is complete.

### How the Program Works

1. **Input**: The program reads text from `input.txt`.
2. **Processing**:
   - The Lex program matches words that start and end with the letter `'a'` and contain only lowercase letters or spaces in between.
   - The matched words are written to `output.txt`.
   - Any other characters or words that don’t match the pattern are ignored.
3. **Post-processing**: After lexical analysis is complete, the program copies the contents of `output.txt` back into `input.txt`, modifying the original file with the filtered output.
4. **Final Result**: The `input.txt` file now contains only the words that matched the pattern.

### Example

**Example Input (`input.txt`)**:
```
apple arena alpha cat dog anaconda alaska
```

**Explanation**:
- The words that match the pattern `a{1}[a-z ]*a{1}` are:
  - "arena"
  - "alpha"
  - "anaconda"
  - "alaska"
- These words will be written to `output.txt`.

**Final Output (`input.txt` after modification)**:
```
arena alpha anaconda alaska
```

### How to Compile and Run the Program

1. **Save the Lex code** in a file, for example, `filter_words.l`.

2. **Create an input file** named `input.txt` and add the text you want to process.

3. **Compile the Lex file**:

```bash
lex filter_words.l    # Generates lex.yy.c
gcc lex.yy.c -o filter_words -ll  # Compiles and links the Lex library
```

4. **Run the program**:

```bash
./filter_words
```

This will process the `input.txt` file and produce the filtered output,

 overwriting the contents of `input.txt` with the matched words.

## Summary

This Lex program is designed to filter words from an input file that start and end with the letter `'a'`. It writes the matched words to an output file (`output.txt`), and then copies the contents of the output file back into the original input file (`input.txt`).

- **Key Concepts**:
  - **Regular Expression**: The pattern `a{1}[a-z ]*a{1}` is used to match words that start and end with `'a'` and optionally contain lowercase letters or spaces in between.
  - **File Handling**: The program reads from `input.txt` and writes matching words to `output.txt`. After processing, the contents of `output.txt` are copied back into `input.txt`, modifying the original input file.
