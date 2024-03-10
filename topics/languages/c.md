# C Language Notes

- [Introduction to C](#introduction-to-c)
  - [Hello World](#hello-world)
  - [VS Code Task Configuration](#vs-code-task-configuration)

## Introduction to C

Most of my notes are taken from the following resources. I also use ChatGPT to supplement my learnings.

- [C Programming Language](https://a.co/d/**hIfOsU9**) by Brian Kernighan and Dennis Ritchie
  - Dennis Ritchie - Created the C programming language and developed UNIX
  - Brian Kernighan - Developed UNIX and wrote the "K&R C" book
- [Effective C](https://a.co/d/gyYEF3B) by Robert Seacord
  - Robert Seacord - recognized as a leading authority on software security and secure coding practices

### Hello World

The following code is a simple C program that prints "Hello, World!" to the console.

```c
#include <stdio.h>

int main()
{
    printf("Hello World!\n");
    return 0;
}
```

Output:

<img src='img/20240217-161723.png' width=400px>

### VS Code Task Configuration

Here's a look at the VS Code task configuration in `tasks.json` for building and running the program on Windows Subsystem for Linux (WSL). With `GCC Run` set to the default build task, you can use the `CTRL+SHIFT+B` shortcut key to compile and run the program.

```json
{
    "tasks": [
        {
            "label": "GCC Build",
            "type": "cppbuild",
            "command": "/usr/bin/gcc",
            "args": [
                "-fdiagnostics-color=always",
                "-g",
                "${file}",
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}",
                "-Wall", "-Wextra", "-Wpedantic",
                "-std=c17",
            ],
            "options": {
                "cwd": "${fileDirname}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "presentation": {
                "echo": true,
                "reveal": "silent",
                "revealProblems": "onProblem",
                "focus": false,
                "panel": "shared",
                "clear": false,
                "showReuseMessage": false,
            },
            "group": {
                "kind": "build",
                "isDefault": false
            },
        },
        {
            "label": "GCC Run",
            "type": "shell",
            "command": "${fileDirname}/${fileBasenameNoExtension}",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "revealProblems": "onProblem",
                "focus": false,
                "panel": "shared",
                "clear": false,
                "showReuseMessage": false,
            },
            "dependsOn": "GCC Build",
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ],
    "version": "2.0.0"
}
```
