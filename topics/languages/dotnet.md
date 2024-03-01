# C# and .NET Notes

Most of my notes are taken from [C# 12 and .NET 8 Modern Cross-Platform Development Fundamentals](https://www.amazon.com/gp/product/B0CGZVT568/ref=ppx_yo_dt_b_d_asin_title_o00?ie=UTF8&psc=1).

- [C# Documentation](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [GitHub repository for Modern Cross-Platform Development Fundamentals](https://github.com/markjprice/cs12dotnet8)


## Introduction

<details><summary>1. Get started with .NET and Visual Studio</summary>

<br>

<details><summary>Brief overview of .NET</summary>

<br>

There are two main flavors of .NET:

- **Legacy .NET**: refers to the .NET Framework, Mono, Xamarin, and .NET Standard
- **Modern .NET**: refers to .NET 8 and its predecessors like .NET 6 that derive from .NET Core

Modern .NET is modularized compared to the legacy .NET Framework, which is monolithic. Modern .NET is open source.

See this article for a discussion on the history of .NET: https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch01-dotnet-history.md

### .NET Framework

.NET Framework is a development platform that includes a **Common Language Runtime (CLR)**, which manages execution of code, and a **Base Class Library (BCL)**, which provides a rich library of classes to build applications from.

.NET Framework has been an official component of the Windows operating system. However, it is now considered a Windows-only and a legacy platform.  Do not create new apps using it.

### Mono, Xamarin, and Unity Projects**

Third parties developed a .NET Framework implementation named the **Mono** project. Mono is cross-platform but fell behind the official implementation of .NET Framework.

Mono has a niche as the foundation of the **Xamarin** mobile platform as well as cross-platform game development platforms like **Unity**.

Microsoft purchased Xamarin in 2016 and has integrated its functionality into Visual Studio 2022 for Mac.  

### .NET Core

Since 2015, Microsoft has been working to rewrite the .NET Framework to be truly cross-platform. The new modernized product was initially branded **.NET Core**.  .NET Core was designed to run on Windows, Linux, and macOS. .NET Core shares some components with .NET Framework but has its own runtime and set of libraries known as CoreFX. .NET Core is an open source revamp of .NET, optimized for modern application development, mainly focusing on cloud and web applications.

.NET Core includes versions up to .NET Core 3.1. 

### Modern .NET**

The term **modern .NET** refers to .NET 5 and up and its predecessors that come from .NET Core.  The term **legacy .NET** refers to the .NET Framework, Mono, and Xamarin.

Starting with .NET 5, Microsoft rebranded .NET Core as **.NET**. New versions are released each year in November.  See [.NET and .NET Core Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core).

Modern .NET aims to unify .NET Core with the original .NET Framework into a single, consistent platform. Enhancements include performance improvements, more APIs, better tooling, and a range of features to support various types of development, including web, mobile (via MAUI), desktop, cloud, and IoT applications.

.NET MAUI (Multi-platform App UI) is an evolution of Xamarin.Forms and aims to simplify the development of cross-platform applications for mobile and desktop from a single codebase.

</details>

<details><summary>C# and .NET Timeline</summary>

<br>

### Timeline

In 1999, before the first release of C#, the codename was **C-like Object-Oriented Language (COOL)**. The lead architect was Anders Hejlsberg. Anders indicates that flaws in most major programming languages (e.g. C++, Java) drove the fundamentals of the Common Language Runtime (CLR), which in turn drove the design of the C# language. "C sharp" implies that the language is an increment of C++.

| C# Version | Release Date | .NET Version(s)                          | Key C# Language Features Introduced                                           | Major .NET Introductions                                   |
|------------|--------------|------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------|
| 1.0        | 2002         | .NET Framework 1.0                       | Classes, structs, interfaces, events, properties                             | Initial release of .NET Framework                          |
| 2.0        | 2005         | .NET Framework 2.0                       | Generics, partial types, anonymous methods, nullable types, iterator blocks  | Generics, partial classes, nullable types                   |
| 3.0        | 2007         | .NET Framework 3.0                       | LINQ, lambda expressions, extension methods                                  | WPF, WCF, WF, CardSpace                                    |
| 4.0        | 2010         | .NET Framework 4                         | Dynamic binding, named and optional arguments, generic co- and contravariance| Parallel Extensions, MEF                                    |
| 5.0        | N/A          | N/A                                      | N/A                                                                           | N/A                                                         |
| 6.0        | 2015         | .NET Framework 4.6                       | Roslyn compiler, string interpolation, expression-bodied members            | Compilation and runtime performance improvements            |
| 7.0        | 2017         | .NET Core 1.0/1.1, .NET Framework 4.6.2  | Out variables, tuples, pattern matching, local functions                     | Introduction of .NET Core, a cross-platform framework       |
| 8.0        | 2019         | .NET Core 3.0, .NET Framework 4.8        | Nullable reference types, async streams, default interface methods          | .NET Core 3.0 supports desktop applications (WPF, Windows Forms) |
| 9.0        | 2020         | .NET 5.0                                 | Records, init-only setters, top-level statements                             | Unified .NET SDK experience, performance improvements      |
| 10.0       | 2021         | .NET 6.0                                 | Global using directives, file-scoped namespaces, record structs             | Hot reload, minimal APIs, LTS release                       |
| 11.0       | 2022         | .NET 7.0                                 | List patterns, required members, raw string literals                         | Performance improvements, enhanced containers support      |
| 12.0       | 2023         | .NET 8.0                                 | Primary constructors, collection expressions, inline arrays, optional parameters in lamda expressions, alias any type, experimental attribute, interceptors |
| 13.0       | ?            | .NET 9.0 | | 

Please note:

- C# 5.0 is not listed; the version numbers went from 4.0 directly to 6.0.
- The table combines .NET Framework, .NET Core, and .NET versions, reflecting the evolution from .NET Framework to .NET Core and then to .NET (5.0 and beyond), which unifies these platforms.
- The .NET introductions listed include only major highlights. Each version introduced numerous features and improvements not listed here for brevity.
- For the most current information, including C# and .NET versions released after April 2023, consult the official Microsoft documentation or the .NET Blog.



See here for a complete timeline: [C# language versions and features](https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch02-features.md) 



</details>

<details><summary>About .NET support</summary>

<br>

.NET versions fall in three categories:

- Long Term Support (LTS): supported by Microsoft for 3 years after General Availability, or 1 year after the next LTS release ships, whichever is longer.
- Standard Term Support (STS): Formerly known as "Current". Includes features that change based on feedback, such as the latest improvements. Supported by Microsoft 18 months after GA, or 6 months until the next STS or LTS ships, whichever is longer.
- Preview: for public testing. Not supported by Microsoft, but some Release Candidates (RC) may be declared Go Live, meaning that Microsoft supports them in production.

<img src='img/20240250-035006.png' width=500px>

See https://dotnet.microsoft.com/en-us/platform/support/policy

</details>

<details><summary>Understanding .NET runtime and .NET SDK versions</summary>

<br>

The .NET runtime is the minimum needed to install so that the system can run a .NET application. The .NET SDK includes the .NET runtime as well as the compilers and other tools needed to build .NET code and apps. The following diagram shows alignment between the major and minor numbers, but the SDK uses a separate convention for the patch number.

<img src='img/20240202-040256.png' width=400px>

See https://learn.microsoft.com/en-us/dotnet/core/versions/

</details>

<details><summary>Using dotnet.exe to list and install .NET runtime and SDK versions</summary>

<br>

Use the `dotnet` command to uncover information about versions, runtimes, and SDKs.

`dotnet --version`

<img src='img/20240231-053104.png' width=150px>

`dotnet --list-sdks`

<img src='img/20240221-042115.png' width=300px>

`dotnet --list-runtimes`

<img src='img/20240222-042210.png' width=600px>

`dotnet --info`

<img src='img/20240224-042428.png' width=600px>

Use `winget search Microsoft.DotNet` to find all the available versions.

<img src='img/20240226-042627.png' width=600px>

Then use `winget install` to install a specific runtime or SDK version.

<img src='img/20240227-042725.png' width=600px>

</details>

<details><summary>Understanding intermediate language</summary>

<br>

The C# compiler (named **Roslyn**) used by the `dotnet.exe` CLI tool converts C# source code into **intermediate language (IL)** code and stores the IL in an **assembly** (a DLL or EXE file). IL code statements are like assembly language instructions, which are executed by .NET's virtual machine, known as CoreCLR.

At runtime, CoreCLR loads the IL code from the assembly, the **just-in-time (JIT)** compiler compiles it into native CPU instructions, and then it is executed by the CPU on your machine.

The benefit of this two-step process is that Microsoft can create CLRs for Linux and macOS as well as for Windows.  The same IL code runs everywhere because of the second compilation step, which generates code for the native OS and CPU instruction set.

See [this ChatGPT thread](https://chat.openai.com/share/37fbe918-a6fd-470b-9ffe-ec48dd62b920) for a brief discussion on the Common Language Runtime and just-in-time compilation.

See https://github.com/dotnet/roslyn

</details>


<details><summary>Visual Studio package source error</summary>

<br>

When creating a new application and building it for the first time, you may get an error like this:

<img src='img/20230656-155606.png' width=600px>

The error message is related to missing package sources from the NuGet package manager.  To fix this, open the NuGet package manager settings and verify the package source URL has been added:

<img src='img/20230658-155829.png' width=500px>

See [Visual Studio Package Sources](https://learn.microsoft.com/en-us/nuget/consume-packages/install-use-packages-visual-studio#package-sources) for more details.

</details>

<details><summary>About top-level programs</summary>

<br>  

Projects created with .NET SDK 5 or earlier always start with the following boilerplate code.

```dotnet
namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
        }
    }
}
```

Starting with .NET 6, Microsoft updated the project template such that new projects use the following minimal statements. These minimal statements are enabled because the required code is written for you by the compiler when you target .NET 6 or later.

```dotnet
// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");
```

The following screenshot shows how the compiler defined a hidden `Program` class with a method named `<Main>$`:  

<img src='img/20240245-064547.png' width=600px>

The only functional difference is that the auto-generated code does not define a namespace, so the `Program` class is implicitly defined in an empty namespace with no name instead of a namespace that matches the project.

The following screenshot shows how the Program class does not belong to a namespace:

<img src='img/20240256-065649.png' width=500px>

One main requirement is there can only be one file like this in a project.

See [Explore top-level statements](https://learn.microsoft.com/en-us/dotnet/csharp/tutorials/top-level-statements).

</details>

<details><summary>Implicitly and globally importing namespaces</summary>

<br>

Using the statement `Console.Writeline` requires the `using System` statement at the top of the file. Traditionally, every `.cs` file that needs to import namespaces would have to start with `using` statements to import those namespaces. Namespaces like `System` and `System.Linq` are needed in almost all `.cs` files.  

C# 10 introduced the `global using` keyword combination, which means you only need to import a namespace in one `.cs` file, and it will be available throughout all `.cs` files.

You can put `global using` statements in the `Program.cs` file, but it's recommended to create a separate file for those statements. The file can be named something like `GlobalUsings.cs` and could look like:

```c#
global using global::System;
global using global::System.Linq;
global using global::System.Collections.Generic;
```

Starting with .NET 6, for any new projects, the compiler generates a `<ProjectName>.GlobalUsings.g.cs` file. Note the **g** for **generated** to differentiate it from developer-written code files. The list of implicitly imported namespaces depends on which SDK you target, e.g. `Microsoft.NET.Sdk`, `Microsoft.NET.Sdk.Web`, `Microsoft.NET.Sdk.Worker`.

<img src='img/20240227-042723.png' width=600px>

You can control which namespaces are implicitly imported in the project's `.csproj` file by adding the `<ItemGroup>` and `<Using>` elements: 

<img src='img/20240225-042543.png' width=400px>

Upon saving the `.csproj` file, the `GlobalUsings.cs` file is automatically updated:

<img src='img/20240224-042457.png' width=400px>

Because we imported the `Console` class, his change allows you to call methods like `WriteLine` without having to prefix them with `Console`. You can also reference the `Environment` class using its alias `Env`: 

<img src='img/20240229-042959.png' width=600px>

See the following:

- [Implicit using directives](https://learn.microsoft.com/en-us/dotnet/core/project-sdk/overview#implicit-using-directives).
- [Global and implicit usings](https://devblogs.microsoft.com/dotnet/welcome-to-csharp-10/)

</details>

<details><summary>Visual Studio - configure startup projects</summary>

<br>

In Visual Studio, when you have multiple projects in a solution you must manually change a project as the startup project to run the application. You can avoid this behavior by setting the startup project to the current selection.

In Visual Studio, from the Solution options, click **Configure Startup Projects** and set the startup project to **Current Selection**. This makes it very easy to switch startup projects simply by clicking the project to make it the startup project.

<img src='img/20240214-051435.png' width=600px>

</details>

<details><summary>Using dotnext.exe to create solutions and projects</summary>

<br>

Using `dotnet help <command>` will open a web browser with the page in the documentation about the command.

See the following page for an overview on using the `dotnet` options: https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch01-project-options.md

Use `dotnet new sln` to create a new solution.

<img src='img/20240238-053807.png' width=350px>

Here are the contents of the resulting solution file:

<img src='img/20240239-053934.png' width=400px>

Use `dotnet new console` to create a new console application:

<img src='img/20240241-054101.png' width=400px>

This action creates a new file structure with the `.csproj` file:

<img src='img/20240242-054248.png' width=400px>

The previous command targets your latest .NET SDK version by default.  Use the `-f` switch to specify a target framework:

`dotnet new console -f net6.0`

Use `dotnet sln add` to add the project to the solution:

<img src='img/20240244-054454.png' width=400px>

Use `dotnet run` to compile and execute the program:

<img src='img/20240253-055306.png' width=500px>

</details>

<details><summary>Displaying inline hints</summary>

<br>

To enable assistance with explicitly-specified parameters, in Visual Studio enable the option **Display inline parameter hints**.

<img src='img/20240239-033947.png' width=450px>

Visual Studio Code has a setting with the same name.

This feature shows the names of the parameters without you having to type them.

<img src='img/20240244-034418.png' width=500px>

</details>

<details><summary>C# public repositories, design guidelines, standards, and timeline</summary>

<br>

### Design Guidelines

Back in the early .NET Framework era, Microsoft published a book that gave good practices in all areas of .NET development. Those recommendations are still very much applicable to modern .NET. Topics include:

- Naming guidelines
- Type design guidelines
- Member design guidelines
- Designing for extensibility
- Exception design guidelines
- Usage guidelines
- Common design patterns

Microsoft has made excerpts of this book available at the following link:

- https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/

### Public Repositories

- [C# Language Design](https://github.com/dotnet/csharplang) - Includes meeting notes, proposals, and spec.
- [Compiler Implementation (Roslyn)](https://github.com/dotnet/roslyn)

### Standards

C# has also become part of several standards. However, adoption takes a long time. The language is currently at 11/12, but the latest version standard, 6.0, was released in 2015. There are drafts for 7, 8, and 9. See [Standard to describe the language](https://github.com/dotnet/csharpstandard)

<img src='img/20240257-035744.png' width=400px>

</details>

<details><summary>Specifying SDK and C# language versions</summary>

<br>

The .NET language compiler for C# is also known as **Roslyn**. There is a separate compiler for F#. Both compilers are distributed as part of the .NET SDK. To use a specific version of C#, you must have at least that version of the .NET SDK installed. The projects you create can target older versions of .NET and still use a modern compiler version. 

Use `dotnet --version` to output the SDK version:

<img src='img/20240247-034747.png' width=150px>

The SDK will use the latest supported language version by default. To target a specific language version compiler, you must add the `<LangVersion>` tag to the project configuration file (*.csproj):

<img src='img/20240252-035248.png' width=300px>

Targeting a specific language version will override the default language version that is picked from the `<TargetFramework>` tag.  

The [C# language version reference](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version) shows all supported C# language versions and their corresponding .NET versions.

You can also get a list of supported language versions on your system. See [this explanation](https://github.com/dotnet/docs/issues/27101#issuecomment-1172989898) for more info. Using this technique, you can uncover the supported language versions, even for preview releases:  

<img src='img/20240259-055916.png' width=300px>

To confirm the language and compiler version, enter the following statement in a blank .cs program file and run it:  `#error version`.  You will get an error, but the error will indicate the language and compiler version. See [Override the default](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#override-the-default).

<img src='img/20240207-040703.png' width=700px>

</details>

<br>

</details>

<details open><summary>2. C# Language Features</summary>

<br>

<details><summary>C# Types vs Classes</summary>

<br>

C# doesn't define any types. Keywords such as `string` that look like types are **aliases**, which represent types provied by the platform on which C# runs. C# cannot exist alone. The platform on which C# runs is .NET, which provides tens of thousands of types to C#, including `System.Int32`, which is the C# keyword alias `int` maps to. In theory, someone could write a C# compiler that uses a different platform, with different underlying types.

**Type** is often confused with **class**. In C#, every **type** can be categorized as a `class`, `struct`, `enum`, `interface`, or `delegate`. As an example, the C# keyword `string` is a `class`, but `int` is a `struct`. So, it is best to use the term **type** to refer to both.

The following code outputs the number of types and methods in each loaded assembly:

```c#

using System.Reflection; 

System.Data.DataSet ds = new();
HttpClient client = new();

Assembly? myApp = Assembly.GetEntryAssembly();
if (myApp is null) return;
foreach (AssemblyName name in myApp.GetReferencedAssemblies())
{
    Assembly a =Assembly.Load(name);
    int methodCount = 0;
    foreach (TypeInfo t in a.DefinedTypes)
    {
        methodCount += t.GetMethods().Length;
    }
    WriteLine("{0:N0} types with {1:N0} methods in {2} assembly.",
        arg0: a.DefinedTypes.Count(),
        arg1: methodCount,
        arg2: name.Name);  
}
```

Output:  
<img src='img/20240253-035328.png' width=400px>

.NET assemblies have a large number of types and methods. The `System.Runtime` assembly does not have any types or methods because it only contains **type-forwarders** rather than actual types. A type-forwarder represents a type that has been implemented outside of .NET or for some other advanced reason.  

For this reason, learning C# can be challenging because there is an overwhelming number of types and methods to learn.

</details>

<details><summary>Variables and Naming Conventions</summary>

<br>

When using variables, you should think about, firstly, how much space the variable takes up in memory, and, secondly, how fast it can be processed. You control this by picking an appropriate type. 

### Naming Conventions

In addition to what's shown below, some developers prefix the names of private fields with an underscore, e.g. `_dateOfBirth`.

<img src='img/20240201-040139.png' width=600px>

</details>

<details><summary>Chars</summary>

<br>

For text, a single letter is stored as a `char` type. However, don't always assume one `char` equals one letter or you could introduce bugs in your code. For example, the Egyptian Hieroglyph A002 (U +13001) needs two `System.Char` values (known as surrogate pairs) to represent it: `\uD80C` and `\uDC01`.

A `char` is assigned using single quotes around the literal value.

```c#
char letter = 'A';
char digit = '1';
char symbol = '$';
char userChoice = GetChar();
```

Text with multiple letters are stored as a `string` type instead of a `char` type.

</details>

<details><summary>Regular string literals</summary>

<br>

A literal string is a sequence of characters enclosed in double quotes `"`. Literal strings allow for the inclusion of escape sequences. For example, `\n` represents a newline, `\t` represents a tab, and `\\` represents a backslash.

```c#
string regularString = "First Line,\nSecondLine.";
```

</details>

<details><summary>Verbatim string literals</summary>

<br>

A verbatim string is used to denote that the string should be taken exactly as is, without interpreting any escape sequences or special characters within it. All characters in the string, including newlines, tabs, and other escape sequences, are treated as literal characters and are part of the string itself.

In C#, verbatim strings are denoted by the `@` symbol placed before the opening quotation mark:

```c#
string path = @"C:\Users\Example\Documents\file.txt"
```

In this example, normally the backslash character is used as an escape character in strings, meaning it would need to be doubled `\\` to represent a single backslash in a regular string. However, by using a verbatim string (prefixing the string with the `@` character), every character string is treated exactly as it appears, so single backslashes can be used directly without needing to be escaped.

Verbatim strings are useful for file paths, regular expressions, and any other strings where escape characters might frequently occur, simplifying the string's readability and maintenance.

Verbatim string literals were introduced with the language's inception, which was C# 1.0, released in 2000.

</details>

<details><summary>Interpolated string literals</summary>

<br>

Interpolated strings simplify string creation by allowing the inclusion of expression values directly within a string literal.

An interpolated string is identified by a dollar sign `$` prefix before the string literal quote. Inside the string, curly braces (`{}`) are used to denote expressions.

```c#
var name = "World";
var greeting = $"Hello, {name}!";
Console.WriteLine(greeting); // Output: Hello, World!
```

This feature was introduced in C# 6.0, which was released as part of the .NET Framework 4.6 in July 2015.

</details>

<details><summary>Interpolated verbatim string literals</summary>

<br>

For strings that need to include escape sequences like file paths, you can combine interpolated strings with verbatim strings by using both `$` and `@` symbols:

```c#
var userName = "JohnDoe";
var documentsFolder = @"C:\Users";

// Using an interpolated verbatim string to construct a file path
var userProfilePath = $@"{documentsFolder}\{userName}\Profile.txt";

Console.WriteLine(userProfilePath);
```

</details>

<details><summary>Raw string literals</summary>

<br>

Raw string literals  allow for multi-line strings and minimize the need for escape sequences. They are particularly useful for working with complex strings, such as JSON, XML, HTML, or regular expressions, making the code more readable by directly mirroring the content's format within the string. 

Here is an example of a raw string literal: 

```c#
var jsonString = """
{
  "name": "John Doe",
  "age": 30,
  "isEmployee": true,
  "addresses": [
    {
      "street": "1234 Elm Street",
      "city": "Gotham",
      "state": "NY"
    },
    {
      "street": "5678 Maple Avenue",
      "city": "Metropolis",
      "state": "IL"
    }
  ]
}
""";
```

Raw string literals have three or more double-quote characters.  Why three or more?  For scenarios where the content itself needs to have three double-quote characters, you can then use four double-quote characters to indicate the beginning and end of the content. Where the content needs to have four double-quote characters, you can then use five double-quote characters, and so on.

The compiler also looks at the indentation of the last three or more double-quote characters, and then automatically removes that level of indentation from all content inside the raw string literal. 

Example: No indentation of double-quote characters; output retains spacing

<img src='img/20240214-041427.png' width=400px>

Example: Indentation of double-quote characters; spacing removed

<img src='img/20240216-041658.png' width=400px>

Raw string literals were introduced in C# 11, as part of the .NET 7 preview releases in 2022.  

</details>

<details><summary>Raw interpolated string literals</summary>

<br>

Raw interpolated string literals combine the features of raw string literals and string interpolation, allowing you to include expressions within a raw string literal. Raw interpolated string literals simplify working with strings that span multiple lines and contain embedded expressions, without needing to escape special characters. These string types are particularly useful for generating strings with complex formats where readability and maintainability are important, and it avoides common pitfalls of traditional string concatenation or escape sequences.

Raw interpolated string literals are prefixed with a double dollar sign `$$`. The number of dollar signs tells the compiler how many curly braces are needed to become recognized as an interpolated expression. Inside the string, the number of curly braces are used to indicate the expression.

```c#
string name = "John";
int age = 30;

var message = $$"""
Hello, {{name}}!
You are {{age}} years old.
""";

Console.WriteLine(message);
```

Raw interpolated string literals were introduced in C# 11 in 2022, along with raw string literals.

</details>

<details><summary>Integer literals: Decimal, Binary, and Hexadecimal Numbers</summary>

<br>

Whole numbers can be stored in decimal, binary, or hexadecimal notation. An underscore can be used as a digit separator to improve legibility.

```c#
int decimalNotation = 2_000_000;
int binaryNotation = 0b_0001_1110_1000_0100_1000_0000;
int hexadecimalNotation = 0x_001E_8480;

Console.WriteLine($"{decimalNotation == binaryNotation}"); // True
Console.WriteLine($"{decimalNotation == hexadecimalNotation}"); // True
Console.WriteLine($"{decimalNotation:N0}"); // 2,000,000
Console.WriteLine($"{binaryNotation:N0}"); // 2,000,000
Console.WriteLine($"{hexadecimalNotation:N0}"); // 2,000,000
Console.WriteLine($"{decimalNotation:X}"); // 1E8480
Console.WriteLine($"{binaryNotation:X}"); // 1E8480
Console.WriteLine($"{hexadecimalNotation:X}"); // 1E8480
```

See https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/integral-numeric-types#integer-literals

</details>

<details><summary>Integral types (Integers)</summary>

<br>

Integral numeric types represent integer numbers. The table in [Characteristics of integral types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/integral-numeric-types#characteristics-of-the-integral-types) lists all the supported types.

The following types are the main ones, but there are also additional signed types:

```c#
Console.WriteLine($"byte uses {sizeof(byte)} bytes and can store numbers in the range {byte.MinValue:N0} to {byte.MaxValue:N0}.");
Console.WriteLine($"short uses {sizeof(short)} bytes and can store numbers in the range {short.MinValue:N0} to {short.MaxValue:N0}.");
Console.WriteLine($"int uses {sizeof(int)} bytes and can store numbers in the range {int.MinValue:N0} to {int.MaxValue:N0}.");
Console.WriteLine($"long uses {sizeof(long)} bytes and can store numbers in the range {long.MinValue:N0} to {long.MaxValue:N0}.");
```

Output:  
<img src='img/20240248-034826.png' width=500px>

See [sizeof operator - determine the memory needs for a given type](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/sizeof).

</details>

<details><summary>Floating-point numeric types (Float, Double, Decimal)</summary>

<br>

Floating-point numeric types represent real numbers. C# supports three predefined floating-point types: float, double, and decimal. Here are general usage guidelines:

- Use `float` when you need to save memory and do not require high precision. 

- Use `double` for general purpose and where exact representation of numbers is not critical.

- Use `decimal` where exact representation of numbers is critical and when a high level of accuracy is required.

When initializing a **Decimal** to a literal, you must specify the `m` or `M` suffix. This is because the C# compiler defaults to treating numeric literals with a decimal point as a **Double**. The `m` suffix explicitly tells the compiler that the literal should be treated as a **Decimal**. Similarly, you must also use the `f` suffix to explicitly tell the compiler that the literal is to be treated as a `float`. Optionally, you can specify the `d` suffix to explicitly tell the compiler that the literal is a double.

```c#
float a = 1.0f;
double b = 1.0d;
double c = 1.0;
decimal d = 2.1m;
```

The following screenshot depicts the size of each floating-point type and its range in values.

<img src='img/20240253-035341.png' width=700px>

Interestingly, the smaller-sized double, which uses 8 bytes can store a wider range of numbers than the larger-sized decimal, which uses 16 bytes. The reason for this discrepancy pertains to the intent of use for each type.

The **Double** type uses 64-bits (8 bytes) of memory. Out of these bits, 1 bit is for the sign, 11 bits are for the exponent, and the remaining 52 bits are for the significant digts. The number of bits dedicated for storing the exponent are what yields the large range of numbers, but that large range comes at a cost of precision when compared to the **Decimal** type.

The **Decimal** types uses 128 bits (16 bytes) of memory. Out of these bits, 1 bit is for the sign, 5 bits are for the exponent, and the remaining 122 bits are for the signficant digits.

Because the **Decimal** type reserves a much higher number of bits for significant digits than the **Double** type, 122 vs 52, it has a much higher range of precision. As a result, the decimal type is appropriate applications where the degree of precision is important, such as financial applications.

The **Double** and **Decimal** use different internal representations, one of which may lead to unanticipated results.

Take the following code, which tests whether `0.1 + 0.2` is equal to `0.3` each for `Double` and `Decimal` types:

```c#
Console.WriteLine("Using doubles:");
double a = 0.1;
double b = 0.2;
if (a+b == 0.3)
{
    Console.WriteLine($"{a} + {b} equals 0.3");
}
else
{
    Console.WriteLine($"{a} + {b} does NOT equal 0.3");
}  

Console.WriteLine("Using decimals:");
decimal c = 0.1M;
decimal d = 0.2M;
if (c+d == 0.3M)
{
    Console.WriteLine($"{c} + {d} equals 0.3");
}
else
{
    Console.WriteLine($"{c} + {d} does NOT equal 0.3");
}
```

Output:  

<img src='img/20240216-041628.png' width=200px>

Why doesn't the **Double** type yield expected results, i.e. `0.1 + 0.2 == 0.3`?

The reason is that the **Double** (and **Float**) type represents numbers in base-2 (binary) floating-point format, according to the [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754) standard. This format has finite precision, and numbers are stored in a way that _most_ numbers cannot be represented exactly in binary.

In this standard, the number `0.1` represented in binary is an infinite pattern of `0.00011001100110011...`. The pattern must be truncated to fit within the finite number of bits allocated for storing floating-point numbers, _resulting in a small rounding errors_.

To contrast, the **Decimal** type represents numbers in base-10 format rather than base-2. This allows it to precisely represent decimal fractions like `0.1` without rounding errors. As mentioned earlier, the 128-bit **Decimal** type reserves 122 bits for the significant digits. 96 bits of this amount are used to store the significant digits of the decimal number in binary as a three-32-bit integer value.

**Good Practice**: 

- Never compare `float` or `double` values for exact equality, i.e. using `==`.
- Use `int` for whole numbers. Use `double` for real numbers that will not be compared for equality (but you can compare for less than and greater than). Use `decimal` to compare the "equality" of a real number and where the accuracy of a real number is important.

The `float` and `double` types have some useful special values:

- `NaN` represents not-a-number (for example, the result of dividing by zero)
- `Epsilon` represents the smallest positive number that can be stored in a `float` or `double`
- `PositiveInfinity` and `Negative Infinity` represent infinitely large positive and negative values

There are also methods for checking these special values, like `IsInfinity` and `IsNaN`.

See https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/floating-point-numeric-types

</details>

<details><summary>Implicit conversions of numeric types</summary>

<br>

You can mix [integral](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/integral-numeric-types) and the `float` and `double` types in an expression. In this case, integral types are implicitly converted to one of the following floating-point types and, if necessary, the `float` type is implicitly converted to `double`.

The expression is evaluated as follows:

- If there is a `double` type in the expression, the expression evaluates to `double` or to `bool` in relational and equality comparisons.
- If there is no `double` type in the expression, the expression evaluates to `float`, or to `bool` in relational and equality comparisons.

You can also mix integral and the `decimal` type in an expression. In this case, integral types are implicitly converted to the `decimal` type and the expression evaluates to `decimal`, or to `bool` in relational and equality comparisons.

You cannot mix the `decimal` type with the `float` and `double` types in an expression. If you want to perform an arithmetic, comparison, or equality operations, you must explicitly convert the operands either from or to the `decimal` type.

```c#
double a = 1.0;
decimal b = 2.1m;
Console.WriteLine(a + (double)b);
Console.WriteLine((decimal)a + b);
```


</details>


<details><summary>New number types (Half, Int128) and unsafe code</summary>

<br>

The `System.Half` type was introduced in .NET 5. See [Introducing the half type](https://devblogs.microsoft.com/dotnet/introducing-the-half-type/). Like `float` and `double`, it can store real numbers. It normally uses two bytes of memory. This type is useful in scenarios where the range and precision of `float` is not necessary and minimizing memory usage is desirable. Scenarios include game development, machine learning and AI, scientific computing, data transfer and storage, and embedded systems and IoT devices.

The `System.Int128` and `System.UInt128` types were introduced in .NET 7. Like `int` and `uint`, they can store signed and unsigned integers. They normally use 16 bytes of memory. This type is useful in scenarios requiring the representation of very large integers or precise arithmetic operations, including cryptography, financial calculations, scientific computing, high-resolution timekeeping, big data and analytics, game development, and distributed systems and blockchain.

For these new number types, the `sizeof` operator only works in an unsafe code block, and you must compile the project using an option to enable unsafe code.

```c#
unsafe
{
    Console.WriteLine($"Half uses {sizeof(Half)} bytes and can store numbers in the range {Half.MinValue:N0} to {Half.MaxValue:N0}.");
    Console.WriteLine($"Int128 uses {sizeof(Int128)} bytes and can store numbers in the range {Int128.MinValue:N0} to {Int128.MaxValue:N0}.");
}
```

Ouptut:

<img src='img/20240225-042520.png' width=700px>

To enable unsafe code, use the `<AllowUnsafeBlocks>` tag in the `.csproj` file: 

<img src='img/20240214-041413.png' width=300px>

See the following:

- [Unsafe code, pointer types, and function pointers](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/unsafe-code)
- [AllowUnsafeBlocks](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/language#allowunsafeblocks)
- [Unsafe keyword](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/unsafe)

</details>

<details><summary>Booleans</summary>

<br>

Booleans can only containe one of two literal values `true` or `false`, as shown:

```c#
bool happy = true;
bool sad = false;
```
Booleans are mostly used to branch and loop.

See [bool (C# reference)](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/bool)

</details>

<details><summary>Storing any type of object (Object type)</summary>

<br>

There is a special type named `object` that can store any type of data, but its flexibility comes at the cost of messier code and possibly poor performance. Because of those two reasons, you should avoid it whenever possible. 

The following steps show how you can use the `object` type:

```c#
object height = 1.88; // storing a double in an object
object name = "Amir"; // storing a string in an object 
Console.WriteLine($"{name} is {height} metres tall");
// int length1 = name.Length; // gives compile error!
int length2 = ((string)name).Length; // tell compiler it is a string
Console.WriteLine($"{name} has {length2} characters.");
```

The `object` type has been available since the first version of C#, but C# 2 and later have a better alternative called _generics_, which are covered later.

See [The object type](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/reference-types#the-object-type)

</details>

<details><summary>Dynamic types</summary>

<br>

The `dynamic` keyword was introduced with C# 4.0 (2010) and enables dynamic type resolution at runtime. Unlike statically-typed variables, where the type is known at compile time, a `dynamic` type bypasses compile-time checking. This means that the operations involving `dynamic` variables are not checked by the compiler for correctnesss. 

Dynamic variables allow for flexibility, especially when interacting with components or APIs where the type information is not available or not important at compile time. However, operations on `dynamic` variables, since they are not checked at compile time, can lead to runtime exceptions if the operation is not valid for the runtime object. 

Dynamic variables are most useful in scenarios where static type checking is either not possible or overly restrictive, such as when interacting with COM objects, dynamic programming languages, or when dealing with structures like JSON that may have a variable structure not known until runtime. Dynamic types are also useful when operating with non-.NET systems. For example, you might need to work with a class library written in F#, Python, or some JavaScript. You might also need to interop with technologies like **Component Object Model (COM)** when automating things in Word or Excel.

Here's an example on using the `dynamic` type:

```c#
dynamic something;
// Storing an array of int values in a dynamic object
// An array of any type has a Length property
something = new[] { 3, 5, 7 };
Console.WriteLine($"The length of something is {something.Length}");
// Output the type of the something variable
Console.WriteLine($"The type of something is {something.GetType()}");
```

**Output**: The code runs successfully because an array type has a `Length` property.

<img src='img/20240336-033659.png' width=250px>


```c#
dynamic something;
// Storing a string in a dynamic object
// string has a Length property
something = "Hello, World!";
Console.WriteLine($"The length of something is {something.Length}");
// Output the type of the something variable
Console.WriteLine($"The type of something is {something.GetType()}");
```

**Output**: The code runs successfully because a string type has a `Length` property.

<img src='img/20240341-034104.png' width=250px>


```c#
dynamic something;
// Storing an int in a dynamic object
// int does not have a Length property
something = 12;
// Storing a string in a dynamic object
// This compiles but might thrown an exception at run-time
Console.WriteLine($"The length of something is {something.Length}");
// Output the type of the something variable
Console.WriteLine($"The type of something is {something.GetType()}");
```

**Output**: The code compiles but throws an error at runtime because an int type does not have a `Length` property.

<img src='img/20240343-034338.png' width=700px>

See the following: 

- [Understanding the Dynamic keyword in C#](https://learn.microsoft.com/en-us/archive/msdn-magazine/2011/february/msdn-magazine-dynamic-net-understanding-the-dynamic-keyword-in-csharp-4)
- [Using type dynamic](https://learn.microsoft.com/en-us/dotnet/csharp/advanced-topics/interop/using-type-dynamic)

</details>

<details><summary>The var keyword and implicitly-typed local variables</summary>

<br>

You can use the `var` keyword to declare local variables with C# 3 (2007) and later. The compiler infers the type from the value that you assign after the assignment operator, `=`. This happens at compile time, so using `var` has no effect on runtime performance.

The following table shows inference of local variable types:

| Type   | Suffix | Inferred Type |
|--------|--------|---------------|
| Number without decimal | (none) | int          |
| Number without decimal | L      | long         |
| Number without decimal | UL     | ulong        |
| Number without decimal | M      | decimal      |
| Number without decimal | D      | double       |
| Number without decimal | F      | float        |
| Number with decimal    | (none) | double       |
| Number with decimal    | M      | decimal      |
| Number with decimal    | F      | float        |
| Text                  | " "    | string       |
| Character             | ' '    | char         |
| Boolean               | true/false | bool     |

See the following example code:

```c#
var population = 67_000_000; // 67 million in UK
var weight = 1.88; // in kilograms
var price = 4.99m; // in pounds sterling
var fruit = "Apples"; // strings use double-quotes
var letter = 'Z'; // chars use single-quotes
var happy = true; // Booleans have value of true or false
```

The following code example shows a good use case of the `var` keyword and a poor use case.

```c#
using System.Xml;

// Good use of var because it avoids the repeated type
// as shown in the more verbose second statement
var xml1 = new XmlDocument();  // Works with C# 3 and later
XmlDocument xml2 = new XmlDocument();  // Works with all C# versions

// Bad use of var because we cannot tell the type, so we
// should use a specific type declaration as shown in the 
// second statement.
var file1 = File.CreateText("something1.txt");
StreamWriter file2 = File.CreateText("something2.txt");
```

The second code block that uses `var file1` is a poor use choice because it is not clear what type `file` is. Hovering over the `var` keyword indicates the type is `System.IO.StreamWriter`.

<img src='img/20240307-040712.png' width=500px>

As a good practice, use `var` when the type is obvious. When in doubt, spell it out.  

See [Implicitly Typed Local Variables](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/implicitly-typed-local-variables)

</details>

<details><summary>Using target-typed new to instantiate objects</summary>

<br>

Microsoft introduced target-typed `new` expressions in C# 9.0 (2020) to improve the conciseness of code. This feature allows the type of the new expression to be inferred by the compiler based on the context in which it is used, eliminating the need to explicitly specify the type if it can be clearly inferred from the assignment or declaration.

**Benefits of Target-Typed New Expressions:**

1. **Conciseness and Readability**: It reduces the amount of boilerplate code, making the code more concise and easier to read, especially when the type is already mentioned in the variable declaration.

2. **Maintainability**: If you need to change the type of the variable, you only need to change it in the declaration, not in the instantiation.

3. **Less Redundancy**: It avoids the redundancy of having to repeat the type when it is already evident from the context.

4. **Compatibility with Anonymous Types**: It allows for more consistent syntax when dealing with anonymous types or when the exact type is unknown or cumbersome to type out.

Here's an example to illustrate the difference:

**Before C# 9.0:**
```csharp
List<string> names = new List<string>();
```

**With C# 9.0 using target-typed new expressions:**
```csharp
List<string> names = new();
```

In the example above, `List<string>` is specified twice in the pre-C# 9.0 syntax. With the introduction of target-typed `new` expressions, the type is specified once, and the `new` expression infers the type from the variable declaration.

**Prior to the Introduction:**

Before this feature was introduced, when instantiating objects or collections, developers had to specify the type both at the declaration and at the instantiation. This was particularly verbose when dealing with complex generic types or when the type was already specified on the left-hand side of an assignment. For example, when you had a property or method return type specified, you still had to repeat the type name when using `new` to create an instance.

**Example without target-typed new expressions:**
```csharp
Dictionary<int, List<string>> map = new Dictionary<int, List<string>>();
```

The introduction of target-typed `new` expressions streamlined object creation and made the code less verbose and more focused on the developer's intent rather than repeating type information.

**Good Practice**: Use target-typed `new` to intsantiate objects because it requires fewer characters, you immediately know the type of the variable, and it is not limited to local variables like `var` is. The only reason not to use target-typed `new` is if youmust use a pre-version 9 C# compiler, though this opinion may not be accepted by the whole C# community.

See [Target-typed `new` expressions](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/proposals/csharp-9.0/target-typed-new)

</details>

<details><summary>Value types and reference types</summary>

<br>

In C#, the distinction between value types and reference types is a fundamental concept related to how they are stored and handled in memory.

**Value Types:**

1. **Storage**: Value types are stored on the stack, which means they hold their data directly in the location where they are declared. However, when they are part of a class (which is a reference type), they are stored in the heap within that class object.

2. **Copying**: When a value type is assigned to another variable, a copy of the value is made. Changes to one variable do not affect the other.

3. **Default Values**: Value types cannot be null (unless they are nullable types) and have default values. For example, the default value for an `int` is `0`.

4. **Types**: Value types include all the primitive types such as `int`, `double`, `char`, `bool`, as well as structures (`struct`) and enumerations (`enum`).

**Reference Types:**

1. **Storage**: Reference types are stored on the heap. A variable of a reference type stores a reference (pointer) to the memory location where the data is held, not the data itself.

2. **Copying**: When a reference type is assigned to another variable, the reference is copied, not the object itself. This means both variables now refer to the same object in memory, so changes to one affect the other.

3. **Default Values**: Reference types can be null, meaning they do not reference any object.

4. **Types**: Reference types include classes (`class`), arrays, delegates, and interfaces (`interface`).

**Examples:**

Value type example:
```csharp
int a = 10;
int b = a; // b is a copy of a
b = 20; // Changing b does not affect a
```

Reference type example:
```csharp
var list1 = new List<int> { 1, 2, 3 };
var list2 = list1; // list2 references the same object as list1
list2.Add(4); // Changing list2 affects list1 because they reference the same object
```

**Boxing and Unboxing:**

The process of converting a value type to a reference type is called boxing, and the reverse process is called unboxing. Boxing is implicit, while unboxing is explicit and requires a cast. Boxing and unboxing can have performance implications because they involve copying data and potentially heap allocation.

**Example of Boxing and Unboxing:**

Boxing:
```csharp
int valType = 10;
object obj = valType; // Boxing
```

Unboxing:
```csharp
int valTypeAgain = (int)obj; // Unboxing
```

Understanding the difference between value types and reference types is crucial for effective memory management and performance optimization in C#.

See [Value types and reference types](https://learn.microsoft.com/en-us/dotnet/visual-basic/programming-guide/language-features/data-types/value-types-and-reference-types)

</details>

<details><summary>The Default keyword</summary>

<br>



</details>

