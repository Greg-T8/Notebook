# My Notes on Learning .NET

- [Resources](#resources)
- [Introduction](#introduction)

## Resources
Most of my notes are taken from [C# 12 and .NET 8 Modern Cross-Platform Development Fundamentals](https://www.amazon.com/gp/product/B0CGZVT568/ref=ppx_yo_dt_b_d_asin_title_o00?ie=UTF8&psc=1).

- [C# Documentation](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [GitHub repository for Modern Cross-Platform Development Fundamentals](https://github.com/markjprice/cs12dotnet8)

## Introduction

<details><summary>1. Get started with .NET and Visual Studio</summary>

<br>

<details><summary>Brief overview of .NET</summary>
There are two main flavors of .NET:

- **Legacy .NET**: refers to the .NET Framework, Mono, Xamarin, and .NET Standard
- **Modern .NET**: refers to .NET 8 and its predecessors like .NET 6 that derive from .NET Core

Modern .NET is modularized compared to the legacy .NET Framework, which is monolithic. Modern .NET is open source.

See this article for a discussion on the history of .NET: https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch01-dotnet-history.md

**.NET Framework**

.NET Framework is a development platform that includes a **Common Language Runtime (CLR)**, which manages execution of code, and a **Base Class Library (BCL)**, which provides a rich library of classes to build applications from.

.NET Framework has been an official component of the Windows operating system. However, it is now considered a Windows-only and a legacy platform.  Do not create new apps using it.

**Mono, Xamarin, and Unity Projects**

Third parties developed a .NET Framework implementation named the **Mono** project. Mono is cross-platform but fell behind the official implementation of .NET Framework.

Mono has a niche as the foundation of the **Xamarin** mobile platform as well as cross-platform game development platforms like **Unity**.

Microsoft purchased Xamarin in 2016 and has integrated its functionality into Visual Studio 2022 for Mac.  

**.NET Core**

Since 2015, Microsoft has been working to rewrite the .NET Framework to be truly cross-platform. The new modernized product was initially branded **.NET Core**.  .NET Core was designed to run on Windows, Linux, and macOS. .NET Core shares some components with .NET Framework but has its own runtime and set of libraries known as CoreFX. .NET Core is an open source revamp of .NET, optimized for modern application development, mainly focusing on cloud and web applications.

.NET Core includes versions up to .NET Core 3.1. 

**Modern .NET**

The term **modern .NET** refers to .NET 5 and up and its predecessors that come from .NET Core.  The term **legacy .NET** refers to the .NET Framework, Mono, and Xamarin.

Starting with .NET 5, Microsoft rebranded .NET Core as **.NET**. New versions are released each year in November.  See [.NET and .NET Core Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core).

Modern .NET aims to unify .NET Core with the original .NET Framework into a single, consistent platform. Enhancements include performance improvements, more APIs, better tooling, and a range of features to support various types of development, including web, mobile (via MAUI), desktop, cloud, and IoT applications.

.NET MAUI (Multi-platform App UI) is an evolution of Xamarin.Forms and aims to simplify the development of cross-platform applications for mobile and desktop from a single codebase.

</details>

<details><summary>About .NET support</summary>

.NET versions fall in three categories:

- Long Term Support (LTS): supported by Microsoft for 3 years after General Availability, or 1 year after the next LTS release ships, whichever is longer.
- Standard Term Support (STS): Formerly known as "Current". Includes features that change based on feedback, such as the latest improvements. Supported by Microsoft 18 months after GA, or 6 months until the next STS or LTS ships, whichever is longer.
- Preview: for public testing. Not supported by Microsoft, but some Release Candidates (RC) may be declared Go Live, meaning that Microsoft supports them in production.

<img src='img/20240250-035006.png' width=500px>

See https://dotnet.microsoft.com/en-us/platform/support/policy

</details>

<details><summary>Understanding .NET runtime and .NET SDK versions</summary>

The .NET runtime is the minimum needed to install so that the system can run a .NET application. The .NET SDK includes the .NET runtime as well as the compilers and other tools needed to build .NET code and apps. The following diagram shows alignment between the major and minor numbers, but the SDK uses a separate convention for the patch number.

<img src='img/20240202-040256.png' width=400px>

See https://learn.microsoft.com/en-us/dotnet/core/versions/

</details>

<details><summary>Using dotnet.exe to list and install .NET runtime and SDK versions</summary>

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

The C# compiler (named **Roslyn**) used by the `dotnet.exe` CLI tool converts C# source code into **intermediate language (IL)** code and stores the IL in an **assembly** (a DLL or EXE file). IL code statements are like assembly language instructions, which are executed by .NET's virtual machine, known as CoreCLR.

At runtime, CoreCLR loads the IL code from the assembly, the **just-in-time (JIT)** compiler compiles it into native CPU instructions, and then it is executed by the CPU on your machine.

The benefit of this two-step process is that Microsoft can create CLRs for Linux and macOS as well as for Windows.  The same IL code runs everywhere because of the second compilation step, which generates code for the native OS and CPU instruction set.

See [this ChatGPT thread](https://chat.openai.com/share/37fbe918-a6fd-470b-9ffe-ec48dd62b920) for a brief discussion on the Common Language Runtime and just-in-time compilation.

See https://github.com/dotnet/roslyn

</details>


<details><summary>Visual Studio package source error</summary>

When creating a new application and building it for the first time, you may get an error like this:

<img src='img/20230656-155606.png' width=600px>

The error message is related to missing package sources from the NuGet package manager.  To fix this, open the NuGet package manager settings and verify the package source URL has been added:

<img src='img/20230658-155829.png' width=500px>

See [Visual Studio Package Sources](https://learn.microsoft.com/en-us/nuget/consume-packages/install-use-packages-visual-studio#package-sources) for more details.

</details>

<details><summary>About top-level programs</summary>

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

In Visual Studio, when you have multiple projects in a solution you must manually change a project as the startup project to run the application. You can avoid this behavior by setting the startup project to the current selection.

In Visual Studio, from the Solution options, click **Configure Startup Projects** and set the startup project to **Current Selection**. This makes it very easy to switch startup projects simply by clicking the project to make it the startup project.

<img src='img/20240214-051435.png' width=600px>

</details>

<details><summary>Using dotnext.exe to create solutions and projects</summary>

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

To enable assistance with explicitly-specified parameters, in Visual Studio enable the option **Display inline parameter hints**.

<img src='img/20240239-033947.png' width=450px>

Visual Studio Code has a setting with the same name.

This feature shows the names of the parameters without you having to type them.

<img src='img/20240244-034418.png' width=500px>

</details>

<details><summary>C# timeline, language, and features</summary>

**Public Repositories**

- [C# Language Design](https://github.com/dotnet/csharplang) - Includes meeting notes, proposals, and spec.
- [Compiler Implementation (Roslyn)](https://github.com/dotnet/roslyn)

**Timeline**

- 1999: Before the first release of C#, the codename was **C-like Object-Oriented Language (COOL)**.
  - Lead architect: Anders Hejlsberg
  - Anders indicates that flaws in most major programming languages (e.g. C++, Java) drove the fundamentals of the Common Language Runtime (CLR), which in turn drove the design of the C# language
  - "C sharp" implies that the language is an increment of C++
- 2002: C# 1 release
- 2023: C# 12

See here for a complete timeline: [C# language versions and features](https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch02-features.md) 

**Standards**

C# has also become part of several standards. However, adoption takes a long time. The language is currently at 11/12, but the latest version standard, 6.0, was released in 2015. There are drafts for 7, 8, and 9. See [Standard to describe the language](https://github.com/dotnet/csharpstandard)

<img src='img/20240257-035744.png' width=400px>

</details>

<details><summary>Specifying SDK and C# language versions</summary>

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

</details>

<details open><summary>2. C# Language Features</summary>

<br>

<details><summary>C# Types vs Classes</summary>

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

When using variables, you should think about, firstly, how much space the variable takes up in memory, and, secondly, how fast it can be processed. You control this by picking an appropriate type. 

**Naming Conventions**
In addition to what's shown below, some developers prefix the names of private fields with an underscore, e.g. `_dateOfBirth`.

<img src='img/20240201-040139.png' width=600px>

</details>

<details><summary>Chars</summary>

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

A literal string is a sequence of characters enclosed in double quotes `"`. Literal strings allow for the inclusion of escape sequences. For example, `\n` represents a newline, `\t` represents a tab, and `\\` represents a backslash.

```c#
string regularString = "First Line,\nSecondLine.";
```

</details>

<details><summary>Verbatim string literals</summary>

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

<details><summary>Decimal, Binary, and Hexadecimal Numbers</summary>

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

</details>




</details>



