package main

import (
	"fmt"
	"go/parser"
	"go/token"
	"os"

	"golang.org/x/tools/go/loader"
	"golang.org/x/tools/go/ssa/ssautil"
)

func main() {
	// Sample Go program (hello world)
	src := `package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}`



	// Create a new file set and parse the source code
	fset := token.NewFileSet()
	file, err := parser.ParseFile(fset, "hello.go", src, parser.AllErrors)
	if err != nil {
		fmt.Println("Error parsing Go file:", err)
		return
	}

	// Load the parsed file into the SSA package
	var conf loader.Config
	conf.Fset = fset
	conf.CreateFromFiles("main", file)

	prog, err := conf.Load()
	if err != nil {
		fmt.Println("Error loading program:", err)
		return
	}

	// Generate SSA form
	ssaProg := ssautil.CreateProgram(prog, 0)
	mainPkg := ssaProg.Package(prog.Created[0].Pkg)
	ssaProg.Build()

	// Print the SSA for the main package
	mainPkg.Func("main").WriteTo(os.Stdout)
}
