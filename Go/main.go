package main

import (
    "os"
    "fmt"
    "strings"
)

func main() {
    fmt.Print(hello(strings.Join(os.Args[1:]," ")))
    os.Exit(42)
}
