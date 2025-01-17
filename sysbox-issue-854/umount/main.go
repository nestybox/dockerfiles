// Simple program to call the umount syscall on a given path directly, without
// any path resolution.

package main

import (
	"fmt"
	"os"
	"syscall"
)

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: umount <path>")
		os.Exit(1)
	}

	path := os.Args[1]

	// Call the umount syscall
	err := syscall.Unmount(path, 0)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to unmount %s: %v\n", path, err)
		os.Exit(1)
	}

	fmt.Printf("Successfully unmounted %s\n", path)
}
