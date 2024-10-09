package main

import (
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"
)

func main() {
	// Sample Go program (hello world)
	src := `package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}`

	// Parse the source code to generate an AST
	fset := token.NewFileSet()
	node, err := parser.ParseFile(fset, "hello.go", src, parser.AllErrors)
	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	// Print the AST
	ast.Print(fset, node)
}
