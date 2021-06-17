package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

func main() {

	msg := os.Getenv("MESSAGE")
	if msg == "" {
		msg = "Hello World!"
	}

	http.HandleFunc("/",
		func(w http.ResponseWriter, r *http.Request) {
			io.WriteString(w, msg)
		})

	err := http.ListenAndServe("0.0.0.0:8080", nil)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
