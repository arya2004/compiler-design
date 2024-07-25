# Compiler Design Uni Lab Course Codes in Lex

This repository contains the laboratory course codes for the Compiler Design course using Lex. The codes are designed to illustrate various concepts in compiler design, including lexical analysis, token generation, pattern matching, and more.



## Prerequisites

Before running any Lex program, ensure you have the following installed:

- **Flex**: Fast Lexical Analyzer Generator
- **GCC**: GNU Compiler Collection (for compiling the generated C code)

## Installation

1. **Install Flex**:
    - On Ubuntu: `sudo apt-get install flex`
    - On macOS: `brew install flex`

2. **Install GCC**:
    - On Ubuntu: `sudo apt-get install gcc`
    - On macOS: `brew install gcc`

## How to Use and Run Lex Programs

1. **Write or Edit the Lex file** (e.g., `lab1.l`) to define the patterns and actions.

2. **Generate the C file** from the Lex file using Flex:
    ```bash
    flex lab1.l
    ```

    This will produce a file named `lex.yy.c`.

3. **Compile the generated C file** using GCC:
    ```bash
    gcc lex.yy.c -o lab1
    ```

    This will produce an executable named `lab1`.

4. **Run the executable**:
    ```bash
    ./lab1 < input.txt
    ```

    Replace `input.txt` with the name of the file you want to process, or provide input directly if the program reads from standard input.


## Contributing

If you have any improvements or additional lab exercises to contribute, please fork this repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any queries or issues, please create an issue in this repository or contact the course instructor.



