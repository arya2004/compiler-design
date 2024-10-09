package main

import (
	"fmt"
	"go/scanner"
	"go/token"
)

func main() {
	// Sample Go program (hello world)
	src := `package main
import "fmt"
func main() {
	a := 6
	b := 7

    fmt.Println("Hello, World!,", a + b)
}`

	// Initialize the token file set (used for position information)
	fset := token.NewFileSet()
	file := fset.AddFile("hello.go", fset.Base(), len(src))

	

	// Initialize the scanner
	var s scanner.Scanner
	s.Init(file, []byte(src), nil, scanner.ScanComments)

	// Print tokens
	for {
		pos, tok, lit := s.Scan()
		if tok == token.EOF {
			break
		}
		fmt.Printf("%s\t%s\t%q\n", fset.Position(pos), tok, lit)
	}
}
