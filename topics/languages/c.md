# C Language Notes

- [Introduction to C](#introduction-to-c)
  - [The Spirit of C](#the-spirit-of-c)
  - [A Brief History of C](#a-brief-history-of-c)
  - [The C Standard](#the-c-standard)
  - [Compilers for Unix-like systems](#compilers-for-unix-like-systems)
    - [GCC and Clang](#gcc-and-clang)
    - [VS Code Task Configuration](#vs-code-task-configuration)
  - [Hello World Analysis](#hello-world-analysis)
    - [Preprocessor directives](#preprocessor-directives)
    - [The `puts` function](#the-puts-function)
    - [The `EXIT_SUCCESS` macro](#the-exit_success-macro)
    - [Checking function return values](#checking-function-return-values)
    - [Formatted output](#formatted-output)

## Introduction to C

Most of my notes are taken from the following resources. I also use ChatGPT to supplement my learnings.

- [C Programming Language](https://a.co/d/**hIfOsU9**) by Brian Kernighan and Dennis Ritchie
  - Dennis Ritchie - Created the C programming language and developed UNIX
  - Brian Kernighan - Developed UNIX and wrote the "K&R C" book
- [Effective C](https://a.co/d/gyYEF3B) by Robert Seacord
  - Robert Seacord - recognized as a leading authority on software security and secure coding practices

According to the [TIOBE Index](https://www.tiobe.com/tiobe-index/), C has been the most popular or second-most popular programming language since 2001.

### The Spirit of C

The "spirit of C" refers to the fundamental principles and characteristics that define the C programming language. These principles include:

1. **Efficiency**: C is designed to be efficient in terms of both execution speed and memory usage. It provides low-level access to system resources, which allows developers to write code that can execute quickly and with minimal overhead.

2. **Portability**: C code is highly portable, meaning it can run on various hardware platforms and operating systems with minimal modifications. This portability is achieved through the use of standard libraries and well-defined language features.

3. **Simplicity**: C is a relatively simple language with a small set of keywords and syntax rules. This simplicity makes it easy to learn and understand, and it encourages developers to write clear and concise code.

4. **Flexibility**: C offers a high degree of flexibility, allowing developers to write code at different levels of abstraction. It supports both low-level programming, such as system-level operations and hardware interaction, as well as high-level programming, such as data structures and algorithms.

5. **Control**: C provides developers with a high degree of control over the behavior of their programs. It allows for manual memory management, precise control over data structures and algorithms, and direct manipulation of hardware resources.

Overall, the spirit of C is characterized by its focus on efficiency, portability, simplicity, flexibility, and control, making it a powerful and versatile language for a wide range of applications.

### A Brief History of C

- The C programming language was developed in 1972 by Dennis Ritchie and Ken Thompson at Bell Labs.
- Brian Kernighan co-authored "The C Programming Language" with Dennis Ritchie.
- The ANSI X3J11 committee formed in 1983 to establish a standard C specification, resulting in ANSI C or C89 in 1989.
- The C Standard was adopted internationally as ISO/IEC 9899:1990 (C90) and has had several updates, the latest being C17 (ISO/IEC 9899:2018).
- A new major revision, referred to as C2x, is under development.

### The C Standard

The ISO/IEC 9899:2018 C Standard is the definitive authority on C language behavior. This standard is crucial for anyone aiming to write code that is portable, safe, and secure. It grants compilers a significant amount of flexibility to ensure optimal efficiency across various hardware platforms.

The term "implementations," as used in the C Standard, refers to compilers operating under specific conditions and environments, including a particular set of command-line flags and the C Standard Library. Each compiler configuration is considered a unique implementation, and differences between these can lead to significantly different behaviors, particularly in areas not explicitly defined by the standard or that are implementation-defined.

Notably, the GNU Compiler Collection (GCC) uses the `-std=` flag to select the C language standard, offering several choices including c89, c90, c99, c11, c17, c18, and c2x, with the default setting depending on the compiler version. For example, GCC 10's default is `-std=gnu17`, which includes extensions to the standard C language.



### Compilers for Unix-like systems

If you are in a Unix-like operating system that has a C compiler installed then you can compile the code by running the following command:

```bash
cc hello_world.c -o hello_world.out
```

The command `cc` is a shorthand for the C Compiler command. In most cases this command in an alias or symbolic link to the actual compiler installed on the system.  

You can determine which compiler the `cc` command references by using the following command:

```bash
readlink -f $(which cc)
```

The `readlink` command, part of the GNU Core utilities, is used to resolve symbolic links, showing the ultimate target. In the case below, `cc` references the `gcc` compiler.

<img src='img/20240319-091921.png' width=200px>

#### GCC and Clang

On Unix-like systems, the two main compilers are the **[GCC](https://gcc.gnu.org/)** and **[Clang](https://clang.llvm.org/)**. 

GCC is part of the GNU Compiler Collection, which was introduced in 1987 by Richard Stallman. It was part of the GNU Project's efforts to create a complete free operating system. Over time, GCC evolved to support more languages beyond C, such as C++, Java, and Fortran, thus leading to the name change to GNU Compiler Collection.

LLVM, which originally stood for "Low Level Virtual Machine," reflecting its early goals as a research project. It was designed to provide a modern approach to compiler design, emphasizing the compilation of program code into an intermediate representation (IR), which could then be optimized and translated into machine code for different architectures. Over time, as LLVM grew to encompass a broader set of compiler and toolchain technologies beyond just the virtual machine aspect, the acronym LLVM has essentially become the name of the project itself, rather than standing for those original words. Now, LLVM refers to the whole project, including the LLVM intermediate representation, the LLVM compiler infrastructure, and its collection of tools and compilers.

LLVM and GCC are both compiler infrastructures that support a variety of programming languages, but they have distinct designs, philosophies, and capabilities. Here's a comparison to highlight some of their differences:

##### Architecture and Design

- **LLVM (Low Level Virtual Machine):** LLVM is designed around a language-agnostic Intermediate Representation (IR), allowing it to support multiple front-ends (languages) and back-ends (target architectures). Its modular design enables reuse in a variety of different tools, including compilers, debuggers, and static analyzers. LLVM emphasizes providing a modern, SSA-based (Static Single Assignment form) compilation strategy, enabling sophisticated optimizations and analyses at the IR level.
- **GCC (GNU Compiler Collection):** GCC, traditionally, has a monolithic architecture where the front-end (language parser) is more tightly coupled with the optimization and code generation phases. Although it has evolved over time to be more modular, its architecture is considered less flexible compared to LLVM's. GCC was initially developed for C but has been extended to support multiple languages (like C++, Java, Fortran).

##### Performance and Optimization

- Both LLVM and GCC provide a wide range of optimizations and are highly competitive in terms of performance of the generated code. The performance can vary depending on the specific program, optimization level, and target architecture.
- LLVM's architecture facilitates the development of sophisticated optimizations and static analysis tools, partly due to its use of a uniform IR.

##### Developer Tools and Ecosystem

- **LLVM** comes with a rich set of tools, including Clang (for C/C++/Objective-C), LLD (linker), and sanitizers for detecting various kinds of bugs. LLVM's design also allows for easy development of new tools.
- **GCC** includes compilers for C, C++, Objective-C, Fortran, Ada, Go, and D, among others. It also has a wide array of optimizations and support for various standards. GCC is known for its robust support for different platforms and architectures.

##### Licensing

- **LLVM** is under the "University of Illinois/NCSA Open Source License," a permissive license that is similar to the BSD license. This allows for relatively unrestricted use, including in proprietary software.
- **GCC** is licensed under the GNU General Public License (GPL), which requires that modifications be open-sourced under the same license. This makes GCC less attractive for proprietary tool vendors who do not want to share their modifications.

##### Adoption and Community

- **LLVM** has seen increasing adoption in recent years, especially in commercial and proprietary environments, due to its permissive licensing and modular architecture. Apple's adoption of LLVM and Clang for iOS and macOS development is a notable example.
- **GCC** has a long history and has been widely used in open-source projects, academic settings, and by various Unix-like operating systems, including Linux. It has a large and established user base and community.

Both LLVM and GCC are powerful tools in the compiler landscape, each with its strengths and areas of application. The choice between them can depend on factors like specific project requirements, licensing concerns, and the ecosystem of tools and languages involved.

#### VS Code Task Configuration

You can use a VS Code task configuration to automate the build and run process. The following `tasks.json` configuration shows how to use the `gcc` compiler to compile a C program. With `GCC Run` set to the default build task, you can use the `CTRL+SHIFT+B` shortcut key to compile and run the program.

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

### Hello World Analysis

The following code is a simple C program that prints "Hello, World!" to the console.

```c
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    puts("Hello, world!");
    return EXIT_SUCCESS;
}
```

#### Preprocessor directives

Preprocessor directives are lines in a program that start with the `#` symbol and are considered before the compilation of the code. These directives are not part of the C language itself but are instructions to the preprocessor, which runs before the compiler processes the source code. The `#include` directive specifically is used to include the contents of another file into the source code file, which is crucial for accessing the functionality provided by the C Standard Library or other libraries and header files.

There are two preprocessor directives in the above code block, `#include <stdio.h>` and `#include <stdlib.h>`. Here's what they do:

##### `#include <stdio.h>`

- This directive tells the preprocessor to include the contents of the standard input-output header file `stdio.h` into the current file before the actual compilation process begins.
- `stdio.h` is part of the C Standard Library and provides functionalities for input and output operations. For instance, it includes declarations of functions like `printf()`, `scanf()`, and in this case, `puts()`, which is used in the program to output "Hello, world!" to the standard output (typically the console).

##### `#include <stdlib.h>`

- Similar to the first, this directive includes the contents of the standard library header file `stdlib.h` into the current file during the preprocessing phase.
- `stdlib.h` contains functions involving memory allocation, process control, conversions, and others. In this code, it's included to provide access to the `EXIT_SUCCESS` macro, which is used as the return value from `main()`. `EXIT_SUCCESS` is a standard macro that indicates successful program termination.

#### The `puts` function

The `puts` function is a standard input/output library function in C, declared in the `stdio.h` header file. Its purpose is to write a string to the standard output (stdout) and automatically append a newline character (`\n`) at the end. The syntax of the `puts` function is as follows:

```c
int puts(const char *s);
```

- `s`: A pointer to the string to be displayed on stdout. The string should be null-terminated.

The `puts` function writes the string pointed to by `s` to stdout and appends a newline character. It returns a non-negative number on success to indicate successful execution. If an error occurs, it returns `EOF` (End Of File indicator).

Compared to `printf`, `puts` is simpler to use for printing strings because it does not require format specifiers and automatically adds a newline at the end, which `printf` does not do unless explicitly told to by including `\n` in the string. However, `puts` is less flexible than `printf` because it can only print strings and cannot format numbers or other data types.

#### The `EXIT_SUCCESS` macro

The `EXIT_SUCCESS` macro is used as the return value of the `main` function. Here's an explanation:

- `EXIT_SUCCESS` is a macro that represents a successful program termination status code. It is defined in the `<stdlib.h>` header file. Programs conventionally return 0 to indicate success and a non-zero value to indicate an error. The `EXIT_SUCCESS` macro is part of the C Standard Library and is used to improve the readability and portability of the code. While it is often defined as 0, using `EXIT_SUCCESS` makes the intention behind the return value more explicit and allows for the code to be portable across different platforms that might use a different value for successful termination.
- When a program ends, it returns an exit status to the operating system. Using `EXIT_SUCCESS` as the return value from `main()` explicitly indicates that the program terminated successfully.

##### More about macros in C

- A macro is a fragment of code which has been given a name. Whenever the name is used, it is replaced by the contents of the macro. Macros are defined using the `#define` directive and are handled by the preprocessor, a step before the actual compilation of code begins.
- Macros can be used to define constants, as with `EXIT_SUCCESS`, or to create function-like macros that can take arguments. The use of macros can save time and reduce errors by allowing repetitive code to be defined in a single location but used in many places.
- Unlike functions, macros do not perform any type checking and are simply expanded by the preprocessor. Therefore, they can be more efficient in cases where they are used to define constants (since no function call overhead is involved) but also riskier if not used carefully, especially for complex expressions.

#### Checking function return values

The Hello World program in the code block above has a bug. The `puts` function takes a string to print and returns a value of type `int`. The `puts` function returns the value of the macro `EOF` (a negative integer) if a write error occurs; otherwise it returns a nonnegative integer value. 

Although it's unlikely that the `puts` function will fail and return `EOF` for the simple program, it's possible. Here's how it can be improved:

```c
#include <stdio.h>
#include <stdlib.h>

int main (void) {
    if (puts("Hello, world!") == EOF) {
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}
```

The revised version checks whether the `puts` call returns `EOF` and exits with a nonzero error code if so.

#### Formatted output

The `puts` function is a nice, simple way to write a string to `stdout`, but eventually you'll need to print formatted output by using the `print` function. The `printf` function takes a format string that defines how the output is formatted.

```c
printf("%s\n", "Hello, world!");
```

The first argument is the format string, `"%s\n"`. The `%s` is a conversion specification that instructs the `printf` function to read the second argument (a string literal) and print it to `stdout`.

Unlike with the `puts` function, with `printf` you must add a newline character at the end of the format string.

See:

- [Table of output conversions](https://www.gnu.org/software/libc/manual/html_node/Table-of-Output-Conversions.html)
- [Formatted output functions](https://www.gnu.org/software/libc/manual/html_node/Formatted-Output-Functions.html)


