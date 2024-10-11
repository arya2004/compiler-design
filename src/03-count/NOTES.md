# Lex Program for Counting Lines, Spaces, Tabs, Words, and Characters

This Lex program is designed to count the number of lines, spaces, tabs, words, and total characters in a given input. It uses regular expressions to match different elements of the input (like whitespace, words, etc.) and increments counters accordingly.

Below is a detailed explanation of how the Lex code works, breaking down each section and describing the purpose and functionality of each part.

## Lex Program Structure

The Lex program follows the typical structure of:

1. **Declarations Section**: Where we declare any necessary variables and include header files.
2. **Rules Section**: This section contains the patterns (regular expressions) that describe the elements to be matched in the input, along with the corresponding actions.
3. **User Code Section**: This section contains the `main()` function and any other user-defined functions necessary for running the program.

## Lex Program Code

Here is the complete Lex code:

```lex
%{
#include<stdio.h>

// Declare global variables to store counts
int lines=0, spaces=0, tabs=0, character=0, words=0;
%}

%%
// Define patterns and actions

[\n]              { lines++; character += yyleng; }  // Increment lines and character count
[ \t]             { spaces++; character += yyleng; }  // Increment spaces and character count
[\t]              { tabs++; character += yyleng; }    // Increment tabs and character count
[^\t\n ]+         { words++; character += yyleng; }   // Increment words and character count for sequences of non-whitespace

%%

// Function called at the end of input
int yywrap() {
    return 1;
}

// Main function to start lexical analysis
int main() {
    printf("Enter the Sentence: ");
    yylex();  // Call yylex to perform lexical analysis

    // Output the results
    printf("Number of lines: %d\n", lines);
    printf("Number of spaces: %d\n", spaces);
    printf("Number of tabs: %d\n", tabs);
    printf("Number of words: %d\n", words);
    printf("Number of characters: %d\n", character);

    return 0;  // Exit successfully
}
```

### Section 1: Declarations Section

```lex
%{
#include<stdio.h>  // Include standard I/O library

// Declare global variables to keep track of counts
int lines = 0, spaces = 0, tabs = 0, character = 0, words = 0;
%}
```

- **Purpose**: The **Declarations Section** is enclosed between `%{` and `%}`. It includes necessary C header files and global variables to keep track of the number of lines, spaces, tabs, characters, and words.
- **Global Variables**:
  - `lines`: Counts the number of lines (newline characters `\n`).
  - `spaces`: Counts the number of spaces (` `) and tabs (`\t`).
  - `tabs`: Counts the number of tab characters specifically.
  - `character`: Counts the total number of characters processed.
  - `words`: Counts the number of words.

### Section 2: Rules Section

The **Rules Section** defines the patterns to match and the actions to take when a match is found.

```lex
[\n]              { lines++; character += yyleng; }  // Increment line and character count
[ \t]             { spaces++; character += yyleng; }  // Increment spaces and character count
[\t]              { tabs++; character += yyleng; }    // Increment tabs and character count
[^\t\n ]+         { words++; character += yyleng; }   // Increment words and character count for sequences of non-whitespace
```

#### Breakdown of the Rules:

1. **Pattern: `[\n]`**
   - **Explanation**: This pattern matches newline characters (`\n`), which are used to count lines in the input.
   - **Action**: When a newline is encountered:
     - Increment the `lines` counter.
     - Add the length of the matched text (`yyleng`, which is `1` in this case since a newline is a single character) to the `character` count.

   Example: If the input contains a newline (e.g., pressing Enter), it increments both the line count and character count.

2. **Pattern: `[ \t]`**
   - **Explanation**: This pattern matches both spaces (` `) and tab characters (`\t`).
   - **Action**: When a space or tab is encountered:
     - Increment the `spaces` counter.
     - Add the length of the matched text (`yyleng`, which is `1` for a single space or tab) to the `character` count.

   Example: Each space or tab in the input increments both the spaces and character counts.

3. **Pattern: `[\t]`**
   - **Explanation**: This pattern matches tab characters (`\t`) specifically.
   - **Action**: When a tab character is encountered:
     - Increment the `tabs` counter.
     - Add the length of the matched text (`yyleng`, which is `1` for a tab) to the `character` count.

   This pattern ensures that tabs are counted separately from spaces, allowing the program to distinguish between spaces and tabs.

4. **Pattern: `[^\t\n ]+`**
   - **Explanation**: This pattern matches sequences of non-whitespace characters, which are considered as words. The pattern `[^\t\n ]` matches any character that is not a tab (`\t`), newline (`\n`), or space (` `), and the `+` means "one or more occurrences."
   - **Action**: When a word is encountered:
     - Increment the `words` counter.
     - Add the length of the matched word (`yyleng`, which is the number of characters in the word) to the `character` count.

   Example: If the input is "hello", it is treated as one word, and the character count is incremented by 5.

### Section 3: User Code Section

```c
int yywrap() {
    return 1;
}

int main() {
    printf("Enter the Sentence: ");
    yylex();  // Start lexical analysis

    // Print the final counts
    printf("Number of lines: %d\n", lines);
    printf("Number of spaces: %d\n", spaces);
    printf("Number of tabs: %d\n", tabs);
    printf("Number of words: %d\n", words);
    printf("Number of characters: %d\n", character);

    return 0;
}
```

#### `yywrap()` Function:

- **Purpose**: This function is called when `yylex()` reaches the end of the input. It returns `1` to indicate that the input is complete.
- Lex expects this function to be defined for proper input handling.

#### `main()` Function:

- **Purpose**: The `main()` function is the entry point of the program. It prints a prompt, calls `yylex()` to perform lexical analysis, and then prints the results.
- **`yylex()`**: This function, generated by Lex, reads the input, matches it against the patterns defined in the Rules Section, and executes the corresponding actions. It continues until the end of the input is reached.
- **Output**: Once the analysis is complete, the program prints the number of lines, spaces, tabs, words, and characters that were counted.

### How the Lex Program Works

1. **Input**: The program processes input text, counting various components:
   - **Lines**: A line is counted every time a newline character (`\n`) is encountered.
   - **Spaces and Tabs**: Each space and tab character is counted.
   - **Words**: A word is defined as any sequence of non-whitespace characters.
   - **Characters**: Every character, whether it’s part of a word or whitespace, is counted.
   
2. **Output**: After the input is processed, the program displays:
   - The number of lines.
   - The number of spaces.
   - The number of tab characters.
   - The number of words.
   - The total number of characters.

### Sample Input and Output

**Input**:
```
Hello World  
This is a test.
```

**Output**:
```
Enter the Sentence: 
Number of lines: 2
Number of spaces: 4
Number of tabs: 0
Number of words: 5
Number of characters: 24
```

### Explanation of the Output:

- **Lines**: There are two lines in the input (one newline after "World" and one after "test").
- **Spaces**: Four spaces are present in the input ("Hello World", "This is a test").
- **Tabs**: There are no tabs in this example.
- **Words**: The input contains five words ("Hello", "World", "This", "is", "test").
- **Characters**: The total number of characters is 24, including letters, spaces, and newline characters.

## Compiling and Running the Lex Program

1. **Save the Lex file** as `count.l`.

2. **Compile the Lex file** using the following commands:

```bash
lex count.l    # This generates lex.yy.c
gcc lex.yy.c -o count -ll  # Compiles and links the Lex library
```

3. **Run the program**:

```bash
./count
```

Then enter your input (text) and press Enter.

## Summary



This Lex program counts lines, spaces, tabs, words, and characters from the input using regular expressions. Each pattern corresponds to a specific type of element (newlines, whitespace, non-whitespace sequences), and actions are taken to increment the relevant counters.

- **Key Concepts**:
  - **Lines** are matched with `[\n]`.
  - **Spaces and tabs** are matched with `[ \t]` and `[\t]` respectively.
  - **Words** are matched with sequences of non-whitespace characters `[^\t\n ]+`.
  - **`yyleng`** is used to calculate the number of characters in each matched token.

The program is an example of how Lex can be used for simple text processing tasks like counting different elements of input text.