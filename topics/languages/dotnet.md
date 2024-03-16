# C# and .NET Notes

This page is a collection of my notes on learning C# and .NET. I captured most of my notes from the following resources:

- [C# 12 and .NET 8 Modern Cross-Platform Development Fundamentals](https://www.amazon.com/gp/product/B0CGZVT568/ref=ppx_yo_dt_b_d_asin_title_o00?ie=UTF8&psc=1)
- [C# Documentation](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [Companion Books](https://github.com/markjprice/cs12dotnet8?tab=readme-ov-file#companion-book)

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Introduction](#introduction)
  - [Getting started with .NET and Visual Studio](#getting-started-with-net-and-visual-studio)
    - [Brief overview of .NET](#brief-overview-of-net)
    - [C# and .NET Timeline](#c-and-net-timeline)
    - [C# feature overview](#c-feature-overview)
    - [About .NET support (LTS, STS, and Preview)](#about-net-support-lts-sts-and-preview)
    - [Understanding .NET runtime and .NET SDK versions](#understanding-net-runtime-and-net-sdk-versions)
    - [Using dotnet.exe to list and install .NET runtime and SDK versions](#using-dotnetexe-to-list-and-install-net-runtime-and-sdk-versions)
    - [Understanding intermediate language](#understanding-intermediate-language)
    - [Specifying Visual Studio package source](#specifying-visual-studio-package-source)
    - [About top-level programs and boilerplate code](#about-top-level-programs-and-boilerplate-code)
    - [Implicitly importing namespaces and static members](#implicitly-importing-namespaces-and-static-members)
    - [Visual Studio - configure startup projects](#visual-studio---configure-startup-projects)
    - [Using dotnext.exe to create solutions and projects](#using-dotnextexe-to-create-solutions-and-projects)
    - [Displaying inline hints](#displaying-inline-hints)
    - [C# public repositories, design guidelines, standards](#c-public-repositories-design-guidelines-standards)
    - [Specifying SDK and C# language versions](#specifying-sdk-and-c-language-versions)
  - [C# Language Features](#c-language-features)
    - [C# Types vs Classes](#c-types-vs-classes)
    - [Variables and Naming Conventions](#variables-and-naming-conventions)
    - [Chars](#chars)
    - [Regular string literals](#regular-string-literals)
    - [Verbatim string literals](#verbatim-string-literals)
    - [Interpolated string literals](#interpolated-string-literals)
    - [Interpolated verbatim string literals](#interpolated-verbatim-string-literals)
    - [Raw string literals](#raw-string-literals)
    - [Raw interpolated string literals](#raw-interpolated-string-literals)
    - [Integer literals: decimal, binary, and hexadecimal numbers](#integer-literals-decimal-binary-and-hexadecimal-numbers)
    - [Integer types and the `sizeof` operator](#integer-types-and-the-sizeof-operator)
    - [Real numbers: `float`, `double`, `decimal`](#real-numbers-float-double-decimal)
    - [Implicit conversions of numeric types](#implicit-conversions-of-numeric-types)
    - [New number types, `Half`, `Int128`, and unsafe code](#new-number-types-half-int128-and-unsafe-code)
    - [Booleans](#booleans)
    - [Storing any type of object using the `object` keyword](#storing-any-type-of-object-using-the-object-keyword)
    - [Dynamic types using the `dynamic` keyword](#dynamic-types-using-the-dynamic-keyword)
    - [The `var` keyword and implicitly-typed local variables](#the-var-keyword-and-implicitly-typed-local-variables)
    - [Using target-typed new, `new()`, to instantiate objects](#using-target-typed-new-new-to-instantiate-objects)
    - [Value types and reference types, boxing and unboxing](#value-types-and-reference-types-boxing-and-unboxing)
    - [Default value expressions using the `default` operator](#default-value-expressions-using-the-default-operator)
    - [Formatting using numbered positional arguments](#formatting-using-numbered-positional-arguments)
    - [Formatting using interpolated strings](#formatting-using-interpolated-strings)
    - [Interpolated strings with newlines in C# 11](#interpolated-strings-with-newlines-in-c-11)
    - [Format strings, `{1,6:N0}`](#format-strings-16n0)
    - [Text input and handling null cases, `?` and `!`](#text-input-and-handling-null-cases--and-)
    - [Key input](#key-input)
    - [Passing arguments to a console app](#passing-arguments-to-a-console-app)
    - [Setting options with arguments](#setting-options-with-arguments)
    - [Handling platforms that do not support an API (conditional preprocessor directives)](#handling-platforms-that-do-not-support-an-api-conditional-preprocessor-directives)
    - [Understanding `async` and `await`](#understanding-async-and-await)
    - [Knowledge check](#knowledge-check)

## Introduction

### Getting started with .NET and Visual Studio

#### Brief overview of .NET

There are two main flavors of .NET:

- **Legacy .NET**: refers to the .NET Framework, Mono, Xamarin, and .NET Standard
- **Modern .NET**: refers to .NET 8 and its predecessors like .NET 6 that derive from .NET Core

Modern .NET is modularized compared to the legacy .NET Framework, which is monolithic. Modern .NET is open source.

See this article for a discussion on the history of .NET: https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch01-dotnet-history.md

##### .NET Framework

.NET Framework is a development platform that includes a **Common Language Runtime (CLR)**, which manages execution of code, and a **Base Class Library (BCL)**, which provides a rich library of classes to build applications from.

.NET Framework has been an official component of the Windows operating system. However, it is now considered a Windows-only and a legacy platform.  Do not create new apps using it.

##### Mono, Xamarin, and Unity Projects

Third parties developed a .NET Framework implementation named the **Mono** project. Mono is cross-platform but fell behind the official implementation of .NET Framework.

Mono has a niche as the foundation of the **Xamarin** mobile platform as well as cross-platform game development platforms like **Unity**.

Microsoft purchased Xamarin in 2016 and has integrated its functionality into Visual Studio 2022 for Mac.  

##### .NET Core

Since 2015, Microsoft has been working to rewrite the .NET Framework to be truly cross-platform. The new modernized product was initially branded **.NET Core**.  .NET Core was designed to run on Windows, Linux, and macOS. .NET Core shares some components with .NET Framework but has its own runtime and set of libraries known as CoreFX. .NET Core is an open source revamp of .NET, optimized for modern application development, mainly focusing on cloud and web applications.

.NET Core includes versions up to .NET Core 3.1.

##### Modern .NET**

The term **modern .NET** refers to .NET 5 and up and its predecessors that come from .NET Core.  The term **legacy .NET** refers to the .NET Framework, Mono, and Xamarin.

Starting with .NET 5, Microsoft rebranded .NET Core as **.NET**. New versions are released each year in November.  See [.NET and .NET Core Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core).

Modern .NET aims to unify .NET Core with the original .NET Framework into a single, consistent platform. Enhancements include performance improvements, more APIs, better tooling, and a range of features to support various types of development, including web, mobile (via MAUI), desktop, cloud, and IoT applications.

.NET MAUI (Multi-platform App UI) is an evolution of Xamarin.Forms and aims to simplify the development of cross-platform applications for mobile and desktop from a single codebase.

#### C# and .NET Timeline

In 1999, before the first release of C#, the codename was **C-like Object-Oriented Language (COOL)**. The lead architect was Anders Hejlsberg. Anders indicates that flaws in most major programming languages (e.g. C++, Java) drove the fundamentals of the Common Language Runtime (CLR), which in turn drove the design of the C# language. "C sharp" implies that the language is an increment of C++.

| C# Version | Release Date | .NET Version(s)                         | Key C# Language Features Introduced                                                                                                                         | Major .NET Introductions                                         |
|------------|--------------|-----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| 1.0        | 2002         | .NET Framework 1.0                      | Classes, structs, interfaces, events, properties, delegates, operators and expressions, statements, attributes                                              | Initial release of .NET Framework                                |
| 2.0        | 2005         | .NET Framework 2.0                      | Generics, partial types, anonymous methods, nullable types, iterator blocks                                                                                 | Generics, partial classes, nullable types                        |
| 3.0        | 2007         | .NET Framework 3.0                      | LINQ, lambda expressions, extension methods                                                                                                                 | WPF, WCF, WF, CardSpace                                          |
| 4.0        | 2010         | .NET Framework 4                        | Dynamic binding, named and optional arguments, generic co- and contravariance                                                                               | Parallel Extensions, MEF                                         |
| 5.0        | 2012         | .NET Framework 4.5                      | `async` and `await` keywords                                                                                                                                | Portable Class Libraries (PCL)                                   |
| 6.0        | 2015         | .NET Framework 4.6                      | Roslyn compiler, string interpolation, expression-bodied members                                                                                            | Compilation and runtime performance improvements                 |
| 7.0        | 2017         | .NET Core 1.0/1.1, .NET Framework 4.6.2 | Out variables, tuples, pattern matching, local functions                                                                                                    | Introduction of .NET Core, a cross-platform framework            |
| 8.0        | 2019         | .NET Core 3.0, .NET Framework 4.8       | Nullable reference types, async streams, default interface methods                                                                                          | .NET Core 3.0 supports desktop applications (WPF, Windows Forms) |
| 9.0        | 2020         | .NET 5.0                                | Records, init-only setters, top-level statements                                                                                                            | Unified .NET SDK experience, performance improvements            |
| 10.0       | 2021         | .NET 6.0                                | Global using directives, file-scoped namespaces, record structs                                                                                             | Hot reload, minimal APIs, LTS release                            |
| 11.0       | 2022         | .NET 7.0                                | List patterns, required members, raw string literals                                                                                                        | Performance improvements, enhanced containers support            |
| 12.0       | 2023         | .NET 8.0                                | Primary constructors, collection expressions, inline arrays, optional parameters in lamda expressions, alias any type, experimental attribute, interceptors |                                                                  |
| 13.0       | ?            | .NET 9.0                                |                                                                                                                                                             |                                                                  |

Things to note:

- The table combines .NET Framework, .NET Core, and .NET versions, reflecting the evolution from .NET Framework to .NET Core and then to .NET (5.0 and beyond), which unifies these platforms.
- The .NET introductions listed include only major highlights. Each version introduced numerous features and improvements not listed here for brevity.
- For the most current information, including C# and .NET versions released after April 2023, consult the official Microsoft documentation or the .NET Blog.

#### C# feature overview

##### [C# version 1.0 (2003)](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history#c-version-10-1)

Initially looked very similar to Java. Major features introduced

- [Classes](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/classes) - a blueprint for creating objects that encapsulates data and behavior, facilitating code organization and reusability through inheritance and polymorphism
  
    <details><summary>Overview</summary><br>

    Classes in .NET provide a blueprint for creating objects with encapsulated data and behavior, simplifying code organization and promoting reusability compared to before their introduction, where developers typically used procedural programming with functions and data structures.

    **Before Classes:**

    ```csharp
    // Procedural programming with functions and data structures
    public class Calculator
    {
        public static int Add(int a, int b)
        {
            return a + b;
        }
    }

    // Usage
    int result = Calculator.Add(3, 5); // Perform addition operation
    ```

    **After Classes:**

    ```csharp
    // Object-oriented programming with classes
    public class Calculator
    {
        public int Add(int a, int b)
        {
            return a + b;
        }
    }

    // Usage
    Calculator calculator = new Calculator();
    int result = calculator.Add(3, 5); // Perform addition operation
    ```

    In the example above, before classes, developers used procedural programming with functions like `Add`, which operate directly on data. With classes, developers can encapsulate data and behavior within objects, promoting a more structured and modular approach to programming.

    Inheritance in .NET allows classes to inherit attributes and behaviors from parent classes, enabling code reuse and promoting a hierarchical structure in object-oriented programming compared to before its introduction, where code duplication was common when implementing similar functionalities across different classes.

    **Before Inheritance:**

    ```csharp
    // Code duplication without inheritance
    public class Vehicle
    {
        public string Make { get; set; }
        public string Model { get; set; }
    }

    public class Car
    {
        public string Make { get; set; }
        public string Model { get; set; }
        public int Doors { get; set; }
    }

    public class Truck
    {
        public string Make { get; set; }
        public string Model { get; set; }
        public int PayloadCapacity { get; set; }
    }
    ```

    **After Inheritance:**

    ```csharp
    // Code reuse with inheritance
    public class Vehicle
    {
        public string Make { get; set; }
        public string Model { get; set; }
    }

    public class Car : Vehicle
    {
        public int Doors { get; set; }
    }

    public class Truck : Vehicle
    {
        public int PayloadCapacity { get; set; }
    }
    ```

    In the example above, before inheritance, code duplication was necessary when creating classes such as `Car` and `Truck`. With inheritance, common attributes and behaviors can be defined in a base class (`Vehicle`), which is then inherited by subclasses (`Car` and `Truck`), promoting code reuse and reducing redundancy.

    Polymorphism in .NET enables objects of different classes to be treated as objects of a common base class, allowing for method invocation based on the specific object type at runtime, thus promoting flexibility and extensibility compared to before its introduction, where code had to be explicitly written to handle different types of objects.

    **Before Polymorphism:**

    ```csharp
    // Handling different types explicitly
    public class Shape
    {
        public virtual void Draw()
        {
            // Default implementation
        }
    }

    public class Circle
    {
        public void DrawCircle()
        {
            // Draw circle specific logic
        }
    }

    public class Rectangle
    {
        public void DrawRectangle()
        {
            // Draw rectangle specific logic
        }
    }

    // Usage
    Shape shape1 = new Circle();
    Shape shape2 = new Rectangle();
    // shape1.Draw(); // This won't work without polymorphism
    // shape2.Draw(); // This won't work without polymorphism
    ```

    **After Polymorphism:**

    ```csharp
    // Polymorphic behavior
    public class Shape
    {
        public virtual void Draw()
        {
            // Default implementation
        }
    }

    public class Circle : Shape
    {
        public override void Draw()
        {
            // Draw circle specific logic
        }
    }

    public class Rectangle : Shape
    {
        public override void Draw()
        {
            // Draw rectangle specific logic
        }
    }

    // Usage
    Shape shape1 = new Circle();
    Shape shape2 = new Rectangle();
    shape1.Draw(); // Draw circle
    shape2.Draw(); // Draw rectangle
    ```

    In the example above, before polymorphism, code had to be explicitly written to handle different types of shapes. With polymorphism, a common interface (`Shape`) is defined, and subclasses (`Circle` and `Rectangle`) override the `Draw` method as needed. This allows the code to handle different types of shapes uniformly, promoting flexibility and easier maintenance.

    </details>

- [Structs](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/struct) - a lightweight value type that contains data members and methods, suitable for small, simple data structures

    <details><summary>Overview</summary><br>

    In .NET, structs are lightweight, stack-allocated data structures that represent simple types and are commonly used to encapsulate small, related pieces of data. Unlike classes, which are reference types, structs are value types, meaning they are passed by value rather than by reference.

    Benefits:
    1. Efficiency: Structs are stack-allocated and do not require heap allocation, leading to better performance, especially for small data structures.
    2. Value semantics: Structs exhibit value semantics, meaning they are copied when passed as parameters or assigned to variables, which can simplify memory management and prevent unintended side effects.
    3. Suitable for small, simple data: Structs are ideal for representing small, self-contained pieces of data with value semantics, such as geometric points, dates, or currency amounts.

    Reasons to Use:
    1. Small data structures: When you need to represent simple data types with a small number of fields, structs provide a lightweight and efficient alternative to classes.
    2. Performance-sensitive scenarios: In performance-critical applications where memory allocation and usage are concerns, using structs can help improve performance by avoiding the overhead of heap allocation and garbage collection.
    3. Value semantics: When you want to ensure that data is copied rather than shared, structs with their value semantics can provide predictable behavior and help prevent unintended side effects.

    Example:

    ```csharp
    // Define a struct to represent a geometric point
    public struct Point
    {
        public int X { get; set; }
        public int Y { get; set; }

        // Constructor
        public Point(int x, int y)
        {
            X = x;
            Y = y;
        }

        // Method to calculate the distance between two points
        public double DistanceTo(Point other)
        {
            int deltaX = X - other.X;
            int deltaY = Y - other.Y;
            return Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Create instances of the Point struct
            Point p1 = new Point(0, 0);
            Point p2 = new Point(3, 4);

            // Calculate the distance between the points
            double distance = p1.DistanceTo(p2);
            Console.WriteLine($"Distance between p1 and p2: {distance}");
        }
    }
    ```

    In this example, the `Point` struct represents a geometric point with `X` and `Y` coordinates. The `DistanceTo` method calculates the Euclidean distance between two points. The struct is used to create instances `p1` and `p2`, and the `DistanceTo` method is invoked to calculate the distance between them.

    </details>

- [Interfaces](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/interfaces) - defines a contract for classes to implement, specifying a set of methods, properties, and events without providing implementation details

    <details><summary>Overview</summary><br>

    Interfaces in .NET define a contract that classes can implement, specifying a set of methods, properties, and events without providing any implementation details. Interfaces enable polymorphism, allowing objects of different classes to be treated uniformly based on shared behavior defined by the interface.

    Benefits:
    1. Encapsulation: Interfaces allow developers to define a clear separation between a type's contract and its implementation, promoting encapsulation and abstraction.
    2. Polymorphism: Interfaces enable polymorphic behavior, allowing objects of different classes to be treated interchangeably based on shared interface implementations, leading to more flexible and extensible code.
    3. Code reuse: Interfaces promote code reuse by defining a common set of functionality that multiple classes can implement, facilitating modular and maintainable code architectures.

    Reasons to Use:
    1. Define contracts: When you want to define a contract that multiple classes must adhere to, interfaces provide a way to specify the required methods, properties, or events without dictating the implementation details.
    2. Enable polymorphism: When you want to enable polymorphic behavior and treat objects of different classes uniformly based on shared behavior, interfaces serve as a common abstraction layer.
    3. Facilitate unit testing and mocking: Interfaces make it easier to write unit tests and create mock objects by allowing dependencies to be substituted with mock implementations, promoting testability and isolating components for testing.

    Example:

    ```csharp
    // Define an interface for a shape
    public interface IShape
    {
        double Area { get; }
        double Perimeter { get; }
    }

    // Implement the interface for a rectangle
    public class Rectangle : IShape
    {
        public double Width { get; }
        public double Height { get; }

        public Rectangle(double width, double height)
        {
            Width = width;
            Height = height;
        }

        public double Area => Width * Height;
        public double Perimeter => 2 * (Width + Height);
    }

    // Implement the interface for a circle
    public class Circle : IShape
    {
        public double Radius { get; }

        public Circle(double radius)
        {
            Radius = radius;
        }

        public double Area => Math.PI * Radius * Radius;
        public double Perimeter => 2 * Math.PI * Radius;
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Create instances of shapes
            IShape rectangle = new Rectangle(5, 3);
            IShape circle = new Circle(2);

            // Calculate and display area and perimeter of shapes
            Console.WriteLine($"Rectangle - Area: {rectangle.Area}, Perimeter: {rectangle.Perimeter}");
            Console.WriteLine($"Circle - Area: {circle.Area}, Circumference: {circle.Perimeter}");
        }
    }
    ```

    In this example, the `IShape` interface defines a contract for shapes with properties `Area` and `Perimeter`. The `Rectangle` and `Circle` classes implement this interface, providing their own implementations for calculating area and perimeter. Objects of different classes (`Rectangle` and `Circle`) are treated uniformly as `IShape`, demonstrating polymorphic behavior enabled by interfaces.

    </details>

- [Events](https://learn.microsoft.com/en-us/dotnet/csharp/events-overview) - provide a mechanism for communication between objects, allowing one object to notify other objects when a specific action or condition occurs, facilitating decoupled and loosely-coupled designs

    <details><summary>Overview</summary><br>

    Events in .NET provide a mechanism for communication between objects, allowing one object (the publisher) to notify other objects (subscribers) when a specific action or condition occurs. Events enable loosely coupled communication and facilitate the implementation of the Observer design pattern.

    Benefits:
    1. Loose coupling: Events promote loose coupling between components by allowing publishers to communicate with subscribers without requiring direct references to each other, enhancing modularity and maintainability.
    2. Extensibility: Events enable the implementation of the Observer pattern, allowing multiple subscribers to react to changes or actions independently, promoting extensibility and scalability.
    3. Decoupled communication: Events facilitate decoupled communication between different parts of an application, enabling components to respond to events without being tightly coupled to each other, leading to more flexible and resilient software architectures.

    Reasons to Use:
    1. Notification mechanism: When you need a mechanism for one part of your application to notify other parts about specific actions, events provide a convenient way to implement such communication.
    2. Decoupled architecture: When you want to design a decoupled architecture where components are loosely coupled and can interact without direct dependencies, events serve as an effective communication mechanism.
    3. Observer pattern: When you want to implement the Observer design pattern, where multiple observers (subscribers) listen for changes in a subject (publisher) and react accordingly, events provide a natural implementation approach.

    Example:

    ```csharp
    using System;

    // Publisher class that defines an event
    public class Button
    {
        // Define a delegate for the event handler
        public delegate void ClickEventHandler(object sender, EventArgs e);

        // Define the event
        public event ClickEventHandler Click;

        // Method to trigger the event
        public void OnClick()
        {
            // Check if there are any subscribers
            if (Click != null)
            {
                // Invoke the event
                Click(this, EventArgs.Empty);
            }
        }
    }

    // Subscriber classes that respond to the event
    public class Logger
    {
        // Event handler method
        public void LogButtonClick(object sender, EventArgs e)
        {
            Console.WriteLine("Button clicked - Logging event");
        }
    }

    public class EmailNotifier
    {
        // Event handler method
        public void SendEmail(object sender, EventArgs e)
        {
            Console.WriteLine("Button clicked - Sending email notification");
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Create instances of publisher and subscribers
            Button button = new Button();
            Logger logger = new Logger();
            EmailNotifier emailNotifier = new EmailNotifier();

            // Subscribe to the event
            button.Click += logger.LogButtonClick;
            button.Click += emailNotifier.SendEmail;

            // Simulate button click
            button.OnClick();
        }
    }
    ```

    In this example, the `Button` class defines an event named `Click`, which can be subscribed to by other classes. The `Logger` and `EmailNotifier` classes act as subscribers to the `Click` event and define event handler methods (`LogButtonClick` and `SendEmail`). When the `OnClick` method of the `Button` class is called, it triggers the `Click` event, and all subscribed event handler methods are invoked, demonstrating the communication between the publisher and subscribers through events.

    Delegates and events are related concepts in .NET, but they serve different purposes and have different characteristics:

    1. **Delegates:**
        - Delegates are type-safe function pointers that hold references to methods.
        - They define the signature of the method that they can reference, including the return type and parameters.
        - Delegates can be used to pass methods as parameters, assign methods to variables, and invoke methods indirectly.
        - Delegates are used for callback functionality, allowing one component to invoke methods on another component without knowing the concrete implementation.

    2. **Events:**
        - Events are a higher-level abstraction built on top of delegates, providing a way for objects to notify other objects when a specific action or condition occurs.
        - Events encapsulate the delegate instances and provide a mechanism for subscribing to and unsubscribing from the event.
        - Events are typically used for implementing the Observer design pattern, where multiple subscribers (event handlers) can react to changes or actions independently.
        - Events enforce a publisher-subscriber model, where the publisher (object raising the event) does not need to know about the subscribers (objects handling the event), promoting loose coupling and encapsulation.

    In summary, delegates are the underlying mechanism for defining and using callback functionality, while events provide a higher-level abstraction for implementing the observer pattern and facilitating communication between objects. Events use delegates internally to manage the invocation of event handler methods.

    </summary>

- [Properties](https://learn.microsoft.com/en-us/dotnet/csharp/properties) - provide a way to encapsulate data within a class while controlling access to it, enabling the implementation of getter and setter methods for reading and modifying the data, respectively

    <details><summary>Overview</summary><br>

    Properties in .NET provide a way to encapsulate data within a class while controlling access to it, enabling the implementation of getter and setter methods for reading and modifying the data. Properties combine the functionality of fields and methods into a single unit, allowing controlled access to class members.

    Benefits:
    1. Encapsulation: Properties allow developers to encapsulate data within a class, hiding the internal representation and providing controlled access to it through getter and setter methods.
    2. Abstraction: Properties abstract the underlying data representation, allowing classes to expose a consistent interface for interacting with data, regardless of its implementation details.
    3. Control access: Properties enable developers to define custom logic for getting and setting data, allowing validation, computation, or other operations to be performed transparently.

    Reasons to Use:
    1. Encapsulate data: When you need to encapsulate data within a class and control access to it, properties provide a convenient way to define getter and setter methods for accessing and modifying the data.
    2. Implement abstraction: When you want to abstract the underlying data representation and provide a consistent interface for interacting with data, properties help achieve abstraction by exposing a uniform access mechanism.
    3. Add behavior: When you need to add additional behavior, such as validation or computation, when getting or setting data, properties allow you to define custom logic within getter and setter methods.

    Example:

    ```csharp
    using System;

    public class Person
    {
        // Private field representing the age
        private int _age;

        // Public property Age with getter and setter
        public int Age
        {
            get { return _age; }
            set
            {
                if (value >= 0 && value <= 120)
                {
                    _age = value;
                }
                else
                {
                    throw new ArgumentException("Age must be between 0 and 120.");
                }
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Create an instance of the Person class
            Person person = new Person();

            // Set the age using the property
            try
            {
                person.Age = 30;
                Console.WriteLine($"Age: {person.Age}"); // Output: Age: 30
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine(ex.Message);
            }

            // Try setting an invalid age
            try
            {
                person.Age = 150; // Throws ArgumentException
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine(ex.Message); // Output: Age must be between 0 and 120.
            }
        }
    }
    ```

    In this example, the `Person` class encapsulates the age data using a private field `_age` and exposes it through a public property `Age`. The property `Age` provides a custom setter method that validates the input age before assigning it to the `_age` field. This demonstrates how properties can encapsulate data and control access to it, enabling validation and ensuring data integrity.

    </details>

- [Delegates](https://learn.microsoft.com/en-us/dotnet/csharp/delegates-overview) - enable the creation of type-safe function pointers, allowing methods to be passed as parameters or assigned to variables, facilitating callback mechanisms and event handling

    <details><summary>Overview</summary>

    Delegates in .NET allow for the creation of type-safe function pointers, enabling methods to be passed as parameters or assigned to variables. Delegates provide a flexible mechanism for implementing callback functionality and event handling.

    Benefits:
    1. Encapsulation of method calls: Delegates encapsulate method calls, allowing methods to be treated as objects and passed around in a type-safe manner.
    2. Decoupling of components: Delegates promote loose coupling between components by allowing one component to invoke methods on another component without knowing the concrete implementation, enhancing modularity and maintainability.
    3. Event handling: Delegates are commonly used to implement event handling mechanisms, enabling objects to notify other objects of changes or actions.

    Reasons to Use:
    1. Callback functionality: When you need to implement callback functionality, such as executing a method asynchronously or defining event handlers, delegates provide a convenient and type-safe way to achieve this.
    2. Extensibility: Delegates enable the implementation of the Observer pattern, allowing multiple subscribers to react to changes or actions independently, promoting extensibility and scalability.
    3. Decoupled communication: When you want to design a decoupled architecture where components are loosely coupled and can interact without direct dependencies, delegates serve as an effective communication mechanism.

    Example:

    ```csharp
    using System;

    // Define a delegate type for a method that takes an integer parameter and returns void
    public delegate void NumberManipulationHandler(int number);

    // Class with methods that match the delegate signature
    public class NumberProcessor
    {
        // Method that increments a number by 10
        public static void IncrementNumber(int number)
        {
            Console.WriteLine($"Incremented number: {number + 10}");
        }

        // Method that doubles a number
        public static void DoubleNumber(int number)
        {
            Console.WriteLine($"Doubled number: {number * 2}");
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Create delegate instances and associate them with methods
            NumberManipulationHandler incrementDelegate = NumberProcessor.IncrementNumber;
            NumberManipulationHandler doubleDelegate = NumberProcessor.DoubleNumber;

            // Call methods through delegates
            incrementDelegate(5); // Output: Incremented number: 15
            doubleDelegate(7);    // Output: Doubled number: 14
        }
    }
    ```

    In this example, a delegate type `NumberManipulationHandler` is defined, representing a method that takes an integer parameter and returns void. Two static methods (`IncrementNumber` and `DoubleNumber`) in the `NumberProcessor` class match this delegate signature. Delegate instances `incrementDelegate` and `doubleDelegate` are created and associated with these methods, allowing the methods to be called through the delegates. This demonstrates how delegates provide a flexible mechanism for invoking methods indirectly and decoupling method calls from their implementations.

    In the example below, before delegates, developers had to define interfaces and implement them for defining callbacks or events. With delegates, developers can define a delegate type directly, simplifying the process of creating and invoking function pointers for callback operations.

    **Before Delegates:**

    ```csharp
    // Define an interface
    public interface IOperation
    {
        void Execute();
    }

    // Implement the interface
    public class Addition : IOperation
    {
        public void Execute()
        {
            Console.WriteLine("Performing addition operation...");
        }
    }

    // Usage
    IOperation operation = new Addition();
    operation.Execute(); // Perform the operation
    ```

    **After Delegates:**

    ```csharp
    // Define a delegate
    public delegate void Operation();

    // Usage
    Operation operation = () =>
    {
        Console.WriteLine("Performing addition operation...");
    };

    operation(); // Perform the operation
    ```

    </details>

- [Operators](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/) - allow custom-defined functionality for built-in operators such as addition, subtraction, comparison, etc., enabling the customization of behavior for user-defined types

    <details><summary>Overview</summary><br>

    Operators in .NET are symbols or keywords that represent built-in operations on types, such as arithmetic, logical, comparison, and assignment operations. Operators provide a concise and familiar syntax for performing common operations on data types.

    Benefits:
    1. Conciseness: Operators provide a concise syntax for performing common operations, reducing verbosity and enhancing code readability.
    2. Efficiency: Operators are optimized for performance by the compiler and runtime, providing efficient implementations for common operations.
    3. Familiarity: Operators follow standard conventions and syntax that developers are accustomed to from other programming languages, making it easier to write and understand code.

    Reasons to Use:
    1. Expressiveness: When you need to perform arithmetic, logical, comparison, or assignment operations on data types, operators provide a succinct and expressive way to do so.
    2. Readability: When you want to write code that is easy to read and understand, operators help reduce clutter and improve readability by providing a clear and concise representation of operations.
    3. Performance: When performance is a concern, operators offer efficient implementations optimized by the compiler and runtime, making them suitable for high-performance scenarios.

    Example:

    ```csharp
    class Program
    {
        static void Main(string[] args)
        {
            // Arithmetic operators
            int a = 10;
            int b = 5;
            int sum = a + b;    // Addition
            int difference = a - b; // Subtraction
            int product = a * b; // Multiplication
            int quotient = a / b; // Division
            int remainder = a % b; // Modulus

            // Comparison operators
            bool isEqual = (a == b);    // Equal to
            bool isNotEqual = (a != b); // Not equal to
            bool isGreater = (a > b);   // Greater than
            bool isLess = (a < b);      // Less than
            bool isGreaterOrEqual = (a >= b); // Greater than or equal to
            bool isLessOrEqual = (a <= b);    // Less than or equal to

            // Logical operators
            bool x = true;
            bool y = false;
            bool resultAnd = x && y;    // Logical AND
            bool resultOr = x || y;     // Logical OR
            bool resultNot = !x;        // Logical NOT

            // Increment and decrement operators
            int count = 0;
            count++;    // Increment by 1
            count--;    // Decrement by 1

            // Assignment operators
            int value = 10;
            value += 5; // Equivalent to: value = value + 5
            value -= 3; // Equivalent to: value = value - 3
            value *= 2; // Equivalent to: value = value * 2
            value /= 4; // Equivalent to: value = value / 4
        }
    }
    ```

    In this example, various operators are demonstrated, including arithmetic, comparison, logical, increment/decrement, and assignment operators. These operators provide a concise and expressive way to perform common operations on data types, enhancing code readability and efficiency.

    </details>

- [Statements](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/statements) - individual instructions that perform specific actions, such as variable assignments, method calls, control flow operations, or exception handling, enabling the execution of logic within a program

    <details><summary>Overview</summary><br>

    Statements in .NET are instructions that perform specific actions or control the flow of execution within a program. Statements can include declarations, assignments, method calls, conditionals, loops, and more, allowing developers to express the logic and behavior of their programs.

    Benefits:
    1. Expressiveness: Statements provide a way to express the logic and behavior of a program in a clear and understandable manner.
    2. Control flow: Statements control the flow of execution within a program, enabling branching, looping, and decision-making based on conditions.
    3. Modularity: Statements allow developers to break down complex tasks into smaller, more manageable units of code, promoting modularity and code organization.

    Reasons to Use:
    1. Defining behavior: When you need to define the behavior of your program, statements provide a way to specify the actions it should perform.
    2. Controlling flow: When you need to control the flow of execution based on conditions or loops, statements enable branching and looping constructs to be used.
    3. Organizing code: When you want to organize your code into logical units and express the sequence of actions it should perform, statements help structure and clarify the program's logic.

    Example:

    ```csharp
    class Program
    {
        static void Main(string[] args)
        {
            // Declaration statement
            int a;

            // Assignment statement
            a = 10;

            // Method call statement
            int result = Add(5, a);

            // Conditional statement (if-else)
            if (result > 10)
            {
                Console.WriteLine("Result is greater than 10");
            }
            else
            {
                Console.WriteLine("Result is less than or equal to 10");
            }

            // Loop statement (for)
            for (int i = 0; i < result; i++)
            {
                Console.WriteLine($"Iteration {i}");
            }
        }

        // Method definition statement
        static int Add(int x, int y)
        {
            return x + y;
        }
    }
    ```

    In this example, various types of statements are demonstrated, including declaration, assignment, method call, conditional (if-else), loop (for), and method definition statements. These statements collectively define the behavior and flow of execution within the program, illustrating how statements are used to express the logic and structure of .NET programs.

    </details>

- [Attributes](https://learn.microsoft.com/en-us/dotnet/csharp/advanced-topics/reflection-and-attributes/) - provide a way to attach metadata to code elements, such as classes, methods, or properties, enabling declarative information to be used by the runtime or other tools for configuration, validation, or documentation purposes

    <details><summary>Overview</summary><br>

    Attributes in .NET are annotations or metadata that provide additional information about types, members, or other elements within a program. Attributes enable declarative programming by attaching descriptive information to code elements, allowing developers to control the behavior of the runtime, compilers, and tools.

    Benefits:
    1. Metadata: Attributes add metadata to code elements, providing additional information that can be used by the runtime, compilers, and tools for various purposes.
    2. Configuration: Attributes allow developers to configure the behavior of components, libraries, or frameworks by decorating them with specific attributes.
    3. Code analysis and tooling: Attributes enable static analysis, code generation, and tooling support by providing information that can be queried and processed by development tools and frameworks.

    Reasons to Use:
    1. Configuration: When you need to configure the behavior of code elements, such as classes, methods, properties, or assemblies, attributes provide a convenient and declarative way to specify settings and options.
    2. Metadata enrichment: When you want to enrich code elements with additional metadata for documentation, analysis, or tooling purposes, attributes allow you to attach descriptive information.
    3. Framework integration: When you develop libraries, frameworks, or components that interact with .NET runtime or development tools, attributes enable seamless integration and interoperability.

    Example:

    ```csharp
    using System;

    // Custom attribute definition
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true)]
    public class MyCustomAttribute : Attribute
    {
        public string Description { get; }

        public MyCustomAttribute(string description)
        {
            Description = description;
        }
    }

    // Applying custom attribute to a class and method
    [MyCustom("This is a sample class.")]
    class MyClass
    {
        [MyCustom("This is a sample method.")]
        public void MyMethod()
        {
            Console.WriteLine("Executing MyMethod...");
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Retrieving and using attributes at runtime
            Type classType = typeof(MyClass);
            object[] classAttributes = classType.GetCustomAttributes(typeof(MyCustomAttribute), true);
            foreach (MyCustomAttribute attribute in classAttributes)
            {
                Console.WriteLine($"Class Attribute Description: {attribute.Description}");
            }

            MyClass myObject = new MyClass();
            Type methodType = myObject.GetType();
            var methodInfo = methodType.GetMethod("MyMethod");
            object[] methodAttributes = methodInfo.GetCustomAttributes(typeof(MyCustomAttribute), true);
            foreach (MyCustomAttribute attribute in methodAttributes)
            {
                Console.WriteLine($"Method Attribute Description: {attribute.Description}");
            }

            // Output:
            // Class Attribute Description: This is a sample class.
            // Method Attribute Description: This is a sample method.
        }
    }
    ```

    In this example, a custom attribute `MyCustomAttribute` is defined with a `Description` property. The attribute is applied to a class `MyClass` and a method `MyMethod`. At runtime, reflection is used to retrieve and inspect the attributes attached to the class and method, demonstrating how attributes can be used to enrich code elements with additional metadata.

    </details>

##### [C# version 2.0 (2005)](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history#c-version-20)

Major features introduced:

- [Generics](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/generics) - allow for the creation of reusable code components that can work with any data type, enhancing type safety and reducing code duplication compared to before their introduction, where developers had to use non-generic collections and methods, often requiring manual casting or boxing.

    <details><summary>Overview</summary><br>

    Generics in .NET provide a way to define classes, interfaces, methods, and delegates with placeholders for types. This allows for the creation of reusable, type-safe components that can work with any data type. Generics enable code to be written once and used with multiple types, promoting code reuse and type safety.

    Benefits:

    1. Reusability: Generics enable the creation of reusable components that can operate on a wide range of data types without the need for duplication or modification.
    2. Type safety: Generics ensure type safety at compile-time by enforcing type constraints, preventing runtime errors related to type mismatches.
    3. Performance: Generics improve performance by reducing the need for boxing and unboxing operations and minimizing the use of runtime type checks.

    Reasons to Use:

    1. Code reuse: When you want to write code that can operate on multiple data types without duplicating or modifying it, generics provide a powerful mechanism for creating reusable components.
    2. Type safety: When you need to ensure type safety and prevent runtime errors caused by type mismatches, generics help enforce compile-time type checks.
    3. Performance optimization: When performance is a concern, generics offer efficient solutions by avoiding unnecessary type conversions and runtime checks.

    Example - Before Generics:

    ```csharp
    // Define a non-generic collection class to store integers
    public class IntList
    {
        private int[] data;
        private int size;

        public IntList(int capacity)
        {
            data = new int[capacity];
            size = 0;
        }

        public void Add(int item)
        {
            if (size == data.Length)
            {
                throw new InvalidOperationException("List capacity exceeded.");
            }

            data[size++] = item;
        }

        public int Get(int index)
        {
            if (index < 0 || index >= size)
            {
                throw new IndexOutOfRangeException("Index is out of range.");
            }

            return data[index];
        }
    }
    ```

    Example - After Generics:

    ```csharp
    // Define a generic collection class to store any type of data
    public class GenericList<T>
    {
        private T[] data;
        private int size;

        public GenericList(int capacity)
        {
            data = new T[capacity];
            size = 0;
        }

        public void Add(T item)
        {
            if (size == data.Length)
            {
                throw new InvalidOperationException("List capacity exceeded.");
            }

            data[size++] = item;
        }

        public T Get(int index)
        {
            if (index < 0 || index >= size)
            {
                throw new IndexOutOfRangeException("Index is out of range.");
            }

            return data[index];
        }
    }
    ```

    In the example before generics, a non-generic `IntList` class is defined to store integers. This class is limited to working only with integers, requiring separate implementations for other data types. With generics, the `GenericList<T>` class is defined, allowing it to store any type of data. This promotes code reuse and flexibility, as the same class can be used with different data types without modification.


    </details>

- [Partial Types](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/partial-classes-and-methods#partial-classes) - enable the splitting of a single class, struct, or interface definition across multiple source files, facilitating code organization, maintenance, and collaboration without sacrificing the integrity of the type's definition

    <details><summary>Overview</summary><br>

    Partial types in .NET allow a single class, struct, or interface declaration to be split into multiple files, providing a way to organize and manage large codebases more effectively. Partial types enable developers to distribute the definition of a type across multiple files while ensuring that the compiler treats them as a single cohesive entity.

    Benefits:
    1. Code organization: Partial types help organize large codebases by allowing developers to split the definition of a type into smaller, more manageable parts, each residing in its own file.
    2. Separation of concerns: Partial types support the separation of concerns by enabling different aspects of a type's implementation (e.g., methods, properties) to be defined in separate files, improving modularity and readability.
    3. Collaboration: Partial types facilitate collaboration among multiple developers by allowing them to work on different parts of the same type simultaneously without interfering with each other's changes.

    Reasons to Use:
    1. Large codebases: When working on projects with large and complex types, partial types provide a structured approach to organizing code and improving maintainability.
    2. Modular design: When designing classes or structures with multiple responsibilities, partial types allow developers to break them down into smaller, focused units, promoting a modular design.
    3. Seamless integration: When integrating generated code or working with code-generation tools, partial types ensure seamless integration of manually written code with generated code, enhancing productivity and code quality.

    Example - Before Partial Types:

    ```csharp
    // File1.cs
    public class MyClass
    {
        public void Method1()
        {
            // Method implementation
        }
    }

    // File2.cs
    public class MyClass
    {
        public void Method2()
        {
            // Method implementation
        }
    }
    ```

    In the example before partial types, the class `MyClass` is split into two separate files (`File1.cs` and `File2.cs`) to define its methods. However, each class definition is independent of the other, resulting in a compilation error due to a duplicate class declaration.

    Example - After Partial Types:

    ```csharp
    // File1.cs
    public partial class MyClass
    {
        public void Method1()
        {
            // Method implementation
        }
    }

    // File2.cs
    public partial class MyClass
    {
        public void Method2()
        {
            // Method implementation
        }
    }

    // Usage
    MyClass instance = new MyClass();
    instance.Method1();
    instance.Method2();
    ```

    In the example after partial types, the class `MyClass` is split into two separate files (`File1.cs` and `File2.cs`), with each file containing a partial definition of the class. This allows the methods of `MyClass` to be defined separately in different files while ensuring that they are treated as part of the same class by the compiler.

    </details>

- [Anonymous Methods](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/delegate-operator) - allow the definition of inline, unnamed code blocks that can be assigned to delegate types, providing a concise way to handle simple tasks or callbacks without the need for separate method declarations

    <details><summary>Overview</summary><br>

    Anonymous methods in .NET allow developers to define inline methods without explicitly declaring a separate named method. These methods are often used as event handlers or as arguments to other methods, providing a convenient way to encapsulate functionality without the need for a separate named method.

    Benefits:
    1. Conciseness: Anonymous methods allow for the definition of inline code blocks without the overhead of declaring a separate named method, resulting in more concise and readable code.
    2. Localized logic: Anonymous methods enable developers to define small, localized pieces of functionality inline where they are used, improving code organization and clarity.
    3. Encapsulation: Anonymous methods encapsulate functionality within a specific context, such as event handling or callback methods, without the need to expose them as separate named methods.

    Reasons to Use:
    1. Event handling: When defining event handlers, anonymous methods provide a convenient way to define the behavior inline, avoiding the need to declare separate methods for each event handler.
    2. Callbacks: When passing methods as arguments to other methods, such as in LINQ queries or asynchronous operations, anonymous methods allow for the definition of callback logic inline, reducing the need for additional named methods.
    3. Simplifying code structure: When the functionality is simple and localized to a specific context, using anonymous methods avoids the overhead of declaring separate named methods, resulting in cleaner and more readable code.

    Example - Before Anonymous Methods:

    ```csharp
    // Declaring a separate named method for event handling
    public class Program
    {
        public static void Main()
        {
            Button button = new Button();
            button.Click += Button_Click;
        }

        // Named method for event handling
        private static void Button_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Button clicked!");
        }
    }
    ```

    Example - After Anonymous Methods:

    ```csharp
    // Using anonymous method for event handling
    public class Program
    {
        public static void Main()
        {
            Button button = new Button();
            button.Click += delegate (object sender, EventArgs e)
            {
                Console.WriteLine("Button clicked!");
            };
        }
    }
    ```

    In the example before anonymous methods, event handling is accomplished by declaring a separate named method (`Button_Click`) and attaching it to the button's click event. With anonymous methods, the event handling logic can be defined inline using a delegate without the need for a separate named method, resulting in more concise code.

    </details>

- [Nullable Value Types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/nullable-value-types) - allow value types, such as integers or booleans, to represent an additional state of "null," providing a way to express the absence of a value and handle scenarios where a value may be missing in a type-safe manner

    <details><summary>Overview</summary><br>

    Nullable value types in .NET allow value types (such as `int`, `float`, `DateTime`, etc.) to represent an additional state of "null", in addition to their normal range of values. This allows variables to represent missing or undefined values, which is particularly useful when dealing with database values, user input, or when you need to differentiate between a value and the absence of a value.

    Benefits:
    1. Representing null values: Nullable value types enable value types to represent null, allowing variables to indicate that they are uninitialized, missing, or undefined.
    2. Avoiding runtime errors: Nullable value types help prevent runtime errors such as "NullReferenceException" by explicitly allowing variables to represent the absence of a value.
    3. Improved interoperability: Nullable value types facilitate better interoperability with database systems and other APIs that use null to represent missing values.

    Reasons to Use:
    1. Database interactions: When working with databases, nullable value types allow you to represent database columns that allow null values, ensuring compatibility between database nulls and .NET types.
    2. User input validation: Nullable value types can be useful for representing optional fields in user input forms, allowing you to distinguish between empty inputs and intentionally unspecified values.
    3. Domain modeling: When modeling domains where certain values may be unknown or undefined, nullable value types provide a clear and explicit way to represent these states.

    Example - Before Nullable Value Types:

    ```csharp
    int nullableInt = -1; // Use a sentinel value (e.g., -1) to represent null
    ```

    Example - After Nullable Value Types:

    ```csharp
    int? nullableInt = null; // Use nullable value type syntax to explicitly represent null
    ```

    In the example before nullable value types, representing a null value typically involved using a sentinel value (e.g., -1 for integers) to indicate null, which could lead to ambiguity and errors in code interpretation. With nullable value types, you can explicitly represent null using the nullable value type syntax (`int?`), providing clarity and avoiding confusion about the meaning of the value.

    </details>

- [Iterators](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/iterators) - enable the creation of custom collection-like objects that can be iterated through using foreach loops, providing a convenient way to traverse sequences of data without the need for explicit index management

    <details><summary>Overview</summary><br>

    Iterators in .NET allow developers to create methods that return a sequence of values iteratively. Iterators simplify the implementation of algorithms that produce sequences by enabling the use of a `yield` keyword to return elements one at a time, without the need to create temporary collections or implement custom enumerators.

    Benefits:
    1. Simplicity: Iterators simplify the implementation of algorithms that generate sequences by allowing developers to express the generation logic directly within a method using the `yield` keyword.
    2. Efficiency: Iterators provide a memory-efficient way to generate sequences by producing elements lazily, as they are requested, rather than storing the entire sequence in memory.
    3. Readability: Iterators improve code readability by encapsulating sequence generation logic within a single method, making it easier to understand and maintain.

    Reasons to Use:
    1. Generating sequences: When you need to generate a sequence of values dynamically, iterators provide a convenient and efficient way to do so without precomputing or storing the entire sequence in memory.
    2. Lazy evaluation: When working with large or potentially infinite sequences, iterators allow for lazy evaluation, producing elements only when they are needed, which can save memory and improve performance.
    3. Simplifying code: When implementing algorithms that produce sequences, iterators simplify code by allowing developers to focus on the generation logic rather than managing iteration state manually.

    Example - Before Iterators:

    ```csharp
    // Example of manually implementing an enumerator
    public class CustomSequence : IEnumerable<int>
    {
        public IEnumerator<int> GetEnumerator()
        {
            return new CustomEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        private class CustomEnumerator : IEnumerator<int>
        {
            private int currentIndex = -1;

            public int Current => currentIndex;

            object IEnumerator.Current => Current;

            public bool MoveNext()
            {
                currentIndex++;
                return true;
            }

            public void Reset()
            {
                currentIndex = -1;
            }

            public void Dispose()
            {
                // Dispose logic
            }
        }
    }
    ```

    Example - After Iterators:

    ```csharp
    // Example using iterator with yield keyword
    public class Program
    {
        public static void Main()
        {
            foreach (var number in GenerateSequence())
            {
                Console.WriteLine(number);
            }
        }

        public static IEnumerable<int> GenerateSequence()
        {
            for (int i = 0; i < 5; i++)
            {
                yield return i;
            }
        }
    }
    ```

    In the example before iterators, generating a custom sequence required manually implementing the `IEnumerable` and `IEnumerator` interfaces, along with managing the iteration state within a custom enumerator class. With iterators, sequence generation is simplified using the `yield` keyword, allowing the `GenerateSequence` method to yield values one at a time, eliminating the need for a separate enumerator implementation.

    </details>

- [Covariance and Contravariance](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/covariance-contravariance/) - allow for more flexible type conversions in generic types, with covariance enabling implicit conversion of generic types to more derived types and contravariance enabling implicit conversion to less derived types, facilitating more versatile usage of generic types in method signatures and assignments.

    <details><summary>Overview</summary><br>

    Covariance and contravariance in .NET allow for more flexible type conversions when dealing with delegate types and generic interfaces. Covariance allows for a more derived type to be used where a less derived type is expected, while contravariance allows for a less derived type to be used where a more derived type is expected. This enhances type compatibility and flexibility in scenarios involving inheritance and generic types.

    Benefits:
    1. Flexibility: Covariance and contravariance provide flexibility in method signatures, allowing for more natural and intuitive use of derived types.
    2. Type safety: Covariance and contravariance maintain type safety by ensuring that assignments and conversions are valid at compile-time, preventing runtime type errors.
    3. Code reuse: Covariance and contravariance facilitate code reuse by enabling the reuse of existing methods and interfaces with more derived types without modifications.

    Reasons to Use:
    1. Improved abstraction: When designing interfaces or delegates that operate on types in a hierarchy, covariance and contravariance allow for more flexible usage of these types, improving abstraction and generality.
    2. Enhanced interoperability: When interacting with libraries or frameworks that expect specific types but can accept more derived types safely, covariance and contravariance enable seamless integration without requiring unnecessary type conversions.
    3. Simplified code: When working with collections or sequences of objects, covariance and contravariance simplify code by allowing for more flexible usage of generic types without the need for explicit casting or conversions.

    Example - Before Covariance and Contravariance:

    ```csharp
    // Example without covariance and contravariance
    public class Animal { }
    public class Dog : Animal { }

    public delegate Animal AnimalFactory();

    public class Program
    {
        public static void Main()
        {
            AnimalFactory factory = CreateDog;
            Animal animal = factory(); // Error: Cannot convert AnimalFactory to DogFactory
        }

        public static Dog CreateDog()
        {
            return new Dog();
        }
    }
    ```

    Example - After Covariance and Contravariance:

    ```csharp
    // Example using covariance
    public class Animal { }
    public class Dog : Animal { }

    public delegate Animal AnimalFactory();

    public class Program
    {
        public static void Main()
        {
            AnimalFactory factory = CreateDog;
            Animal animal = factory(); // Covariance allows returning a more derived type
        }

        public static Dog CreateDog()
        {
            return new Dog();
        }
    }
    ```

    In the example before covariance and contravariance, the delegate `AnimalFactory` expects to return an `Animal`, so assigning it a method returning a `Dog` causes a compilation error. With covariance, the return type of the method can be a more derived type (`Dog`), allowing for a more natural and flexible usage of delegate types and interfaces.

    </details>

##### [C# version 3.0 (2007)](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history#c-version-30)

C# version 3.0 came in late 2007, along with Visual Studio 2008, though most of the language features would come with .NET Framework 3.5. The features in this release established C# as a truly formidable language.

Major features introduced:

- [Auto-implemented properties](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/auto-implemented-properties) - provide a concise syntax for declaring properties within a class without explicitly defining the backing fields, allowing for automatic generation of getter and setter methods by the compiler

    <details><summary>Overview</summary><br>

    Feature: Auto-implemented Properties

    Overview:
    Auto-implemented properties in .NET allow developers to declare properties without explicitly defining the backing field. The compiler automatically generates a private backing field and standard getter and setter methods, simplifying property declaration and reducing boilerplate code.

    Benefits:
    1. Conciseness: Auto-implemented properties reduce the amount of code required to define properties by eliminating the need to manually declare backing fields and accessor methods.
    2. Readability: Auto-implemented properties improve code readability by providing a more compact and standardized syntax for property declaration, making code easier to understand and maintain.
    3. Encapsulation: Auto-implemented properties encapsulate access to class fields, promoting encapsulation and ensuring that class internals remain hidden from external code.

    Reasons to Use:
    1. Simplifying property declaration: When defining simple properties that only require standard getter and setter methods, auto-implemented properties provide a convenient and concise syntax.
    2. Encouraging best practices: By promoting encapsulation and reducing the likelihood of errors in property declaration, auto-implemented properties encourage adherence to best practices in object-oriented programming.
    3. Enhancing productivity: Auto-implemented properties reduce the amount of boilerplate code that developers need to write, allowing them to focus on more critical aspects of software development.

    Example - Before Auto-implemented Properties:

    ```csharp
    public class MyClass
    {
        private int _myProperty;

        public int MyProperty
        {
            get { return _myProperty; }
            set { _myProperty = value; }
        }
    }
    ```

    Example - After Auto-implemented Properties:

    ```csharp
    public class MyClass
    {
        public int MyProperty { get; set; }
    }
    ```

    In the example before auto-implemented properties, developers had to manually declare a private backing field (`_myProperty`) and implement standard getter and setter methods for the property `MyProperty`. With auto-implemented properties, the compiler automatically generates the backing field and accessor methods, reducing the amount of boilerplate code required and improving code readability.


    </details>

- [Anonymous types](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/anonymous-types) - allow the creation of lightweight, nameless data structures directly within code, simplifying the declaration of temporary data compared to before their introduction, where developers had to define explicit classes or structures for such purposes

    <details><summary>Overview</summary><br>

    Anonymous types in .NET allow developers to create objects without explicitly defining the type's structure. They provide a concise way to define and initialize objects on the fly, especially when dealing with query results or when returning data from methods.

    Benefits:
    1. Conciseness: Anonymous types reduce the amount of code needed to define temporary objects by allowing developers to create them inline without declaring a formal class or structure.
    2. Flexibility: Anonymous types provide flexibility in scenarios where defining formal types would be cumbersome or unnecessary, such as query projections or method return values.
    3. Improved readability: By eliminating the need for developers to define separate types for temporary data structures, anonymous types can enhance code readability by keeping related data together in a single context.

    Reasons to Use:
    1. Query projections: When performing database queries or LINQ queries, anonymous types allow you to select specific fields or aggregate results without defining formal types for each query result.
    2. Method return values: When a method needs to return multiple values that are not part of an existing class or structure, anonymous types provide a convenient way to package and return the data.
    3. Interoperability: When interacting with APIs or frameworks that return data in a format that does not map directly to existing types, anonymous types can be used to adapt the data without introducing additional classes or structures.

    Example - Before Anonymous Types:

    ```csharp
    public class Program
    {
        public static void Main()
        {
            var person = new Person("John", 30);
            Console.WriteLine($"Name: {person.Name}, Age: {person.Age}");
        }

        public class Person
        {
            public string Name { get; }
            public int Age { get; }

            public Person(string name, int age)
            {
                Name = name;
                Age = age;
            }
        }
    }
    ```

    Example - After Anonymous Types:

    ```csharp
    public class Program
    {
        public static void Main()
        {
            var person = new { Name = "John", Age = 30 };
            Console.WriteLine($"Name: {person.Name}, Age: {person.Age}");
        }
    }
    ```

    In the example before anonymous types, a formal class `Person` is defined to represent a person with properties for name and age. With anonymous types, you can create an anonymous object inline with the desired properties, eliminating the need to define a separate class. This makes the code more concise and readable, especially for temporary or ad-hoc data structures.

    </details>

- [Query Expressions](https://learn.microsoft.com/en-us/dotnet/csharp/linq/get-started/query-expression-basics) - provide a higher-level, more readable syntax for writing LINQ queries, simplifying code compared to the verbose method-based syntax previously required for querying data. 

    <details><summary>Overview</summary><br>

    Query expressions in .NET provide a declarative syntax for querying data sources such as collections, arrays, databases, and XML. They offer a more readable and concise way to write queries compared to traditional imperative looping constructs like `foreach` or `for` loops.

    Benefits:
    1. Readability: Query expressions use a familiar SQL-like syntax, making them more readable and easier to understand, especially for developers familiar with SQL.
    2. Expressiveness: Query expressions allow developers to express complex queries in a concise and intuitive manner, reducing the amount of boilerplate code required.
    3. Abstraction: Query expressions abstract away the details of how the query is executed, allowing the underlying LINQ provider to optimize the query execution.

    Reasons to Use:
    1. Simplifying data manipulation: When working with collections or other data sources, query expressions provide a simpler and more expressive way to filter, project, and aggregate data.
    2. Enhancing code readability: Query expressions make code more readable by expressing the intent of the query directly, rather than focusing on the mechanics of how to achieve it.
    3. Improving maintainability: Query expressions encapsulate query logic in a single statement, making it easier to understand and maintain compared to manually written loop constructs.

    Example - Before Query Expressions:

    ```csharp
    public class Program
    {
        public static void Main()
        {
            List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };
            List<int> evenNumbers = new List<int>();

            foreach (var number in numbers)
            {
                if (number % 2 == 0)
                {
                    evenNumbers.Add(number);
                }
            }

            foreach (var number in evenNumbers)
            {
                Console.WriteLine(number);
            }
        }
    }
    ```

    Example - After Query Expressions:

    ```csharp
    using System.Linq;

    public class Program
    {
        public static void Main()
        {
            List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };
            var evenNumbers = from number in numbers
                            where number % 2 == 0
                            select number;

            foreach (var number in evenNumbers)
            {
                Console.WriteLine(number);
            }
        }
    }
    ```

    In the example before query expressions, filtering even numbers from a list required manual iteration using `foreach` loops and conditional statements. With query expressions, the same operation can be accomplished using a more declarative syntax that expresses the filtering criteria directly. This makes the code more concise, readable, and expressive.

    </details>

- [Lambda Expressions](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-expressions) - is a concise syntax for defining anonymous functions inline, typically used for short-lived functions or when passing functions as arguments to other methods.

    <details><summary>Overview</summary></br>

    Lambda expressions in .NET provide a concise way to define anonymous methods or delegates inline, allowing developers to create small, self-contained pieces of code without the need for formal method declarations. They are commonly used in LINQ queries, event handling, and functional programming scenarios.

    Benefits:
    1. Conciseness: Lambda expressions reduce the amount of boilerplate code required to define small functions or delegates, resulting in cleaner and more readable code.
    2. Readability: Lambda expressions allow developers to express the intent of a function or delegate directly inline with the calling code, improving code readability and maintainability.
    3. Flexibility: Lambda expressions enable the creation of ad-hoc functions or delegates on the fly, providing greater flexibility in scenarios where formal method declarations are impractical or unnecessary.

    Reasons to Use:
    1. LINQ queries: Lambda expressions are commonly used in LINQ queries to define filtering, projection, and sorting criteria inline, making it easier to express complex queries.
    2. Event handling: Lambda expressions provide a convenient way to define event handlers inline, eliminating the need for separate named methods for simple event handling scenarios.
    3. Functional programming: Lambda expressions support functional programming paradigms by allowing the creation of higher-order functions, such as map, reduce, and filter, inline with other code.

    Example - Before Lambda Expressions:

    ```csharp
    // Before lambda expressions, defining and passing delegates required explicit method declarations.
    public class Program
    {
        public static void Main()
        {
            // Declare a delegate type
            Func<int, int, int> add = Add;

            // Pass the delegate to a method
            int result = Calculate(5, 3, add);
            Console.WriteLine(result);
        }

        // Define a method to be used as a delegate
        public static int Add(int x, int y)
        {
            return x + y;
        }

        // Method that accepts a delegate as an argument
        public static int Calculate(int x, int y, Func<int, int, int> operation)
        {
            return operation(x, y);
        }
    }
    ```

    Example - After Lambda Expressions:

    ```csharp
    // After lambda expressions, delegates can be defined inline without explicit method declarations.
    public class Program
    {
        public static void Main()
        {
            // Define a lambda expression inline
            Func<int, int, int> add = (x, y) => x + y;

            // Pass the lambda expression to a method
            int result = Calculate(5, 3, add);
            Console.WriteLine(result);
        }

        // Method that accepts a delegate as an argument
        public static int Calculate(int x, int y, Func<int, int, int> operation)
        {
            return operation(x, y);
        }
    }
    ```

    In the example before lambda expressions, defining and passing delegates required explicit method declarations, leading to more verbose and less readable code. With lambda expressions, delegates can be defined inline using a concise syntax, improving code readability and reducing boilerplate code.

    Lambda expressions introduced the `=>` syntax, which is called the "lambda operator" or "arrow operator". It separates the input parameters from the expression or statement body of the lambda expression. The syntax `=>` indicates that the expression or statement(s) on the right side represent the body of the lambda expression.

    </details>

See here for a complete timeline: 

- [The history of C#](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history)
- [C# language versions and features](https://github.com/markjprice/cs12dotnet8/blob/main/docs/ch02-features.md)

#### About .NET support (LTS, STS, and Preview)

.NET versions fall in three categories:

- Long Term Support (LTS): supported by Microsoft for 3 years after General Availability, or 1 year after the next LTS release ships, whichever is longer.
- Standard Term Support (STS): Formerly known as "Current". Includes features that change based on feedback, such as the latest improvements. Supported by Microsoft 18 months after GA, or 6 months until the next STS or LTS ships, whichever is longer.
- Preview: for public testing. Not supported by Microsoft, but some Release Candidates (RC) may be declared Go Live, meaning that Microsoft supports them in production.

<img src='img/20240250-035006.png' width=500px>

See https://dotnet.microsoft.com/en-us/platform/support/policy

#### Understanding .NET runtime and .NET SDK versions

The .NET runtime is the minimum needed to install so that the system can run a .NET application. The .NET SDK includes the .NET runtime as well as the compilers and other tools needed to build .NET code and apps. The following diagram shows alignment between the major and minor numbers, but the SDK uses a separate convention for the patch number.

<img src='img/20240202-040256.png' width=400px>

See https://learn.microsoft.com/en-us/dotnet/core/versions/

#### Using dotnet.exe to list and install .NET runtime and SDK versions

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

#### Understanding intermediate language

The C# compiler (named **Roslyn**) used by the `dotnet.exe` CLI tool converts C# source code into **intermediate language (IL)** code and stores the IL in an **assembly** (a DLL or EXE file). IL code statements are like assembly language instructions, which are executed by .NET's virtual machine, known as CoreCLR.

At runtime, CoreCLR loads the IL code from the assembly, the **just-in-time (JIT)** compiler compiles it into native CPU instructions, and then it is executed by the CPU on your machine.

The benefit of this two-step process is that Microsoft can create CLRs for Linux and macOS as well as for Windows.  The same IL code runs everywhere because of the second compilation step, which generates code for the native OS and CPU instruction set.

See [this ChatGPT thread](https://chat.openai.com/share/37fbe918-a6fd-470b-9ffe-ec48dd62b920) for a brief discussion on the Common Language Runtime and just-in-time compilation.

See https://github.com/dotnet/roslyn

#### Specifying Visual Studio package source

When creating a new application and building it for the first time, you may get an error like this:

<img src='img/20230656-155606.png' width=600px>

The error message is related to missing package sources from the NuGet package manager.  To fix this, open the NuGet package manager settings and verify the package source URL has been added:

<img src='img/20230658-155829.png' width=500px>

See [Visual Studio Package Sources](https://learn.microsoft.com/en-us/nuget/consume-packages/install-use-packages-visual-studio#package-sources) for more details.

#### About top-level programs and boilerplate code

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

#### Implicitly importing namespaces and static members

Using the statement `Console.Writeline` requires the `using System` statement at the top of the file. Traditionally, every `.cs` file that needs to import namespaces would have to start with `using` statements to import those namespaces. Namespaces like `System` and `System.Linq` are needed in almost all `.cs` files.  

C# 10 (2021) introduced the `global using` keyword combination, which means you only need to import a namespace in one `.cs` file, and it will be available throughout all `.cs` files.

You can put `global using` statements in the `Program.cs` file, but it's recommended to create a separate file for those statements. The file can be named something like `GlobalUsings.cs` and could look like:

```c#
global using global::System;
global using global::System.Linq;
global using global::System.Collections.Generic;
```

Starting with .NET 6, for any new projects, the compiler generates a `<ProjectName>.GlobalUsings.g.cs` file. Note the **g** for **generated** to differentiate it from developer-written code files. The list of implicitly imported namespaces depends on which SDK you target, e.g. `Microsoft.NET.Sdk`, `Microsoft.NET.Sdk.Web`, `Microsoft.NET.Sdk.Worker`.

<img src='img/20240227-042723.png' width=600px>

You can control which namespaces are implicitly imported  by adding the `<ItemGroup>` and `<Using>` elements in the project's `.csproj` file:

<img src='img/20240225-042543.png' width=400px>

Upon saving the `.csproj` file, the `GlobalUsings.cs` file is automatically updated:

<img src='img/20240224-042457.png' width=400px>

**Good Practice**: To simplify your code, each time you create a new project, modify the project's `.csproj` file to change what is included in the auto-generated class file in the `obj` folder hierarchy.

##### Importing a static type for a single file

You can statically import the `System.Console` class by specifying the following at the top of the code:

```csharp
using static System.Console
```

This change allows you to call methods like `WriteLine` without having to prefix them with `Console`. You can also reference the `Environment` class using its alias `Env`:

<img src='img/20240229-042959.png' width=600px>

This specification is used to make the code more concise by allowing direct access to static members without having to repeat the class name (`Console` in this case). It's a feature introduced in C# 6.0 (2015) to improve code readability and reduce redundancy.

In C# and other .NET languages, the `static` keyword used in the context of a `using` directive serves a specific purpose that differs from the usage without `static`:

1. **`using System.Console;`**:
   - This line of code, as stated, would be incorrect because the `using` directive is typically used to include namespaces, not classes. The purpose of a `using` directive is to allow the use of types in a namespace so that you don't have to qualify the use of a type in that namespace with the namespace's name.
   - For example, `using System;` allows you to use types in the `System` namespace without prefixing them with `System.`, like `Console.WriteLine()` instead of `System.Console.WriteLine()`.

2. **`using static System.Console;`**:
   - This syntax is correct and useful. The `using static` directive imports the static members of a class, allowing you to use those static members without specifying the class name.
   - When you write `using static System.Console;`, you are telling the compiler that you want to use the static members of the `Console` class without having to prefix them with `Console.` every time. This means you can just write `WriteLine("Hello, World!");` instead of `Console.WriteLine("Hello, World!");`.
   - This makes the code cleaner and more concise, especially when you are using a lot of static members from a single class.


Instead of statically importing the `Console` class just for one code file, you can import it globally for all code files in a project.

<img src='img/20240317-041754.png' width=400px>

See the following:

- [Implicit using directives](https://learn.microsoft.com/en-us/dotnet/core/project-sdk/overview#implicit-using-directives).
- [Global and implicit usings](https://devblogs.microsoft.com/dotnet/welcome-to-csharp-10/)

#### Visual Studio - configure startup projects

In Visual Studio, when you have multiple projects in a solution you must manually change a project as the startup project to run the application. You can avoid this behavior by setting the startup project to the current selection.

In Visual Studio, from the Solution options, click **Configure Startup Projects** and set the startup project to **Current Selection**. This makes it very easy to switch startup projects simply by clicking the project to make it the startup project.

<img src='img/20240214-051435.png' width=600px>

#### Using dotnext.exe to create solutions and projects

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

#### Displaying inline hints

To enable assistance with explicitly-specified parameters, in Visual Studio enable the option **Display inline parameter hints**.

<img src='img/20240239-033947.png' width=450px>

Visual Studio Code has a setting with the same name.

This feature shows the names of the parameters without you having to type them.

<img src='img/20240244-034418.png' width=500px>

#### C# public repositories, design guidelines, standards

##### Design Guidelines

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

##### Public Repositories

- [C# Language Design](https://github.com/dotnet/csharplang) - Includes meeting notes, proposals, and spec.
- [Compiler Implementation (Roslyn)](https://github.com/dotnet/roslyn)

##### Standards

C# has also become part of several standards. However, adoption takes a long time. The language is currently at 11/12, but the latest version standard, 6.0, was released in 2015. There are drafts for 7, 8, and 9. See [Standard to describe the language](https://github.com/dotnet/csharpstandard)

<img src='img/20240257-035744.png' width=400px>

#### Specifying SDK and C# language versions

The .NET language compiler for C# is also known as **Roslyn**. There is a separate compiler for F#. Both compilers are distributed as part of the .NET SDK. To use a specific version of C#, you must have at least that version of the .NET SDK installed. The projects you create can target older versions of .NET and still use a modern compiler version. 

Use `dotnet --version` to output the SDK version:

<img src='img/20240247-034747.png' width=150px>

The SDK will use the latest supported language version by default. To target a specific language version compiler, you must add the `<LangVersion>` tag to the project configuration file (*.csproj):

<img src='img/20240252-035248.png' width=300px>

Targeting a specific language version will override the default language version that is picked from the `<TargetFramework>` tag.  

The [C# language version reference](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version) shows all supported C# language versions and their corresponding .NET versions.

You can also get a list of supported language versions on your system. See [this explanation](https://github.com/dotnet/docs/issues/27101#issuecomment-1172989898) for more info. Using this technique, you can uncover the supported language versions, even for preview releases:  

<img src='img/20240259-055916.png' width=300px>

To confirm the language and compiler version, enter the following statement in a blank .cs program file and run it:  `#error version`.  You will get an error, but the error will indicate the language and compiler version. 
<img src='img/20240207-040703.png' width=700px>

See:

- [Override the default](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#override-the-default)
- [Error and Warning information](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/preprocessor-directives#error-and-warning-information)

### C# Language Features

#### C# Types vs Classes

C# doesn't define any types. Keywords such as `string` that look like types are **aliases**, which represent types provided by the platform on which C# runs. C# cannot exist alone. The platform on which C# runs is .NET, which provides tens of thousands of types to C#, including `System.Int32`, which is the C# keyword alias `int` maps to. In theory, someone could write a C# compiler that uses a different platform, with different underlying types.

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

#### Variables and Naming Conventions</summary>

When using variables, you should think about, firstly, how much space the variable takes up in memory, and, secondly, how fast it can be processed. You control this by picking an appropriate type. 

In addition to what's shown below, some developers prefix the names of private fields with an underscore, e.g. `_dateOfBirth`.

<img src='img/20240201-040139.png' width=600px>

#### Chars

For text, a single letter is stored as a `char` type. However, don't always assume one `char` equals one letter or you could introduce bugs in your code. For example, the Egyptian Hieroglyph A002 (U +13001) needs two `System.Char` values (known as surrogate pairs) to represent it: `\uD80C` and `\uDC01`.

A `char` is assigned using single quotes around the literal value.

```c#
char letter = 'A';
char digit = '1';
char symbol = '$';
char userChoice = GetChar();
```

Text with multiple letters are stored as a `string` type instead of a `char` type.

#### Regular string literals

A literal string is a sequence of characters enclosed in double quotes `"`. Literal strings allow for the inclusion of escape sequences. For example, `\n` represents a newline, `\t` represents a tab, and `\\` represents a backslash.

```c#
string regularString = "First Line,\nSecondLine.";
```

#### Verbatim string literals

A verbatim string is used to denote that the string should be taken exactly as is, without interpreting any escape sequences or special characters within it. All characters in the string, including newlines, tabs, and other escape sequences, are treated as literal characters and are part of the string itself.

In C#, verbatim strings are denoted by the `@` symbol placed before the opening quotation mark:

```c#
string path = @"C:\Users\Example\Documents\file.txt"
```

In this example, normally the backslash character is used as an escape character in strings, meaning it would need to be doubled `\\` to represent a single backslash in a regular string. However, by using a verbatim string (prefixing the string with the `@` character), every character string is treated exactly as it appears, so single backslashes can be used directly without needing to be escaped.

Verbatim strings are useful for file paths, regular expressions, and any other strings where escape characters might frequently occur, simplifying the string's readability and maintenance.

Verbatim string literals were introduced with the language's inception, which was C# 1.0, released in 2000.

#### Interpolated string literals

Interpolated strings simplify string creation by allowing the inclusion of expression values directly within a string literal.

An interpolated string is identified by a dollar sign `$` prefix before the string literal quote. Inside the string, curly braces (`{}`) are used to denote expressions.

```c#
var name = "World";
var greeting = $"Hello, {name}!";
Console.WriteLine(greeting); // Output: Hello, World!
```

This feature was introduced in C# 6.0, which was released as part of the .NET Framework 4.6 in July 2015.

#### Interpolated verbatim string literals

For strings that need to include escape sequences like file paths, you can combine interpolated strings with verbatim strings by using both `$` and `@` symbols:

```c#
var userName = "JohnDoe";
var documentsFolder = @"C:\Users";

// Using an interpolated verbatim string to construct a file path
var userProfilePath = $@"{documentsFolder}\{userName}\Profile.txt";

Console.WriteLine(userProfilePath);
```

#### Raw string literals

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

#### Raw interpolated string literals

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

#### Integer literals: decimal, binary, and hexadecimal numbers

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

#### Integer types and the `sizeof` operator

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

#### Real numbers: `float`, `double`, `decimal`

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

#### Implicit conversions of numeric types

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

#### New number types, `Half`, `Int128`, and unsafe code

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

#### Booleans

Booleans can only containe one of two literal values `true` or `false`, as shown:

```c#
bool happy = true;
bool sad = false;
```
Booleans are mostly used to branch and loop.

See [bool (C# reference)](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/bool)

#### Storing any type of object using the `object` keyword

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

#### Dynamic types using the `dynamic` keyword

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

#### The `var` keyword and implicitly-typed local variables

You can use the `var` keyword to declare local variables with C# 3 (2007) and later. The compiler infers the type from the value that you assign after the assignment operator, `=`. This happens at compile time, so using `var` has no effect on runtime performance.

The following table shows inference of local variable types:

| Type                   | Suffix     | Inferred Type |
|------------------------|------------|---------------|
| Number without decimal | (none)     | int           |
| Number without decimal | L          | long          |
| Number without decimal | UL         | ulong         |
| Number without decimal | M          | decimal       |
| Number without decimal | D          | double        |
| Number without decimal | F          | float         |
| Number with decimal    | (none)     | double        |
| Number with decimal    | M          | decimal       |
| Number with decimal    | F          | float         |
| Text                   | " "        | string        |
| Character              | ' '        | char          |
| Boolean                | true/false | bool          |

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

From ChatGPT: 

In C#, the `var` keyword is used for implicitly typing local variables. Instead of explicitly specifying the data type of a variable, you can use `var`, and the compiler infers the type based on the expression used to initialize the variable.

The benefits of using `var` include:

1. **Conciseness**: Using `var` can make your code more concise and readable, especially when the type is obvious from the context. This can reduce unnecessary repetition and make the code easier to understand at a glance.

2. **Flexibility**: If you decide to change the type of the variable later, you only need to change the type of the expression on the right-hand side of the assignment, rather than having to update the type in multiple places throughout your code.

3. **Enhanced Maintenance**: Since the type is inferred by the compiler, there's less chance of introducing bugs due to type mismatches when refactoring or modifying code.

4. **Promotes Encapsulation**: Using `var` encourages developers to focus on the interface rather than the implementation details, promoting encapsulation and abstraction.

However, it's important to use `var` judiciously. While it can improve readability and maintainability in many cases, it should not be used excessively, especially in cases where the type is not immediately obvious from the context. Additionally, it's essential to ensure that the type inferred by the compiler is indeed what you intended, as using `var` excessively might obscure the actual type of the variable, making the code less understandable for others.

See [Implicitly Typed Local Variables](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/implicitly-typed-local-variables)

#### Using target-typed new, `new()`, to instantiate objects

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

#### Value types and reference types, boxing and unboxing

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

#### Default value expressions using the `default` operator

The `default` operator in C# is used to obtain the default value of a type. The behavior of the `default` operator depends on whether the type is a reference type or a value type:

- For **reference types** (strings, classes, interfaces, delegates, or records), the default value is `null`.
- For **value types** (structs, enums, and all primitive types like `int`, `bool`, `char`, etc.), the default value is a bit pattern that represents 0. For example, for numeric types, it's `0`; for `bool`, it's `false`; and for a struct, it's each member set to its default value.

##### When It Was Introduced

The `default` keyword has been part of C# since its early versions, but its usage was enhanced in C# 7.1.

- **Prior to C# 7.1**, you had to specify the type when using `default`, like `default(int)` or `default(T)` where `T` is a type parameter in generics.
- **Starting with C# 7.1**, you can use the `default` literal without specifying a type, and the compiler infers the type based on the context. This means you can write `int myInt = default;` instead of `int myInt = default(int);`.

##### Practical Use Cases

1. **Initialization**: When you need to initialize a variable to its default value but don't want to hardcode a specific value. This is particularly useful in generics where the type `T` might be unknown.
   
   ```csharp
   T value = default;
   ```

2. **Resetting Values**: In scenarios where you need to reset a variable to its default state.

   ```csharp
   myVariable = default;
   ```

3. **Default Parameters in Methods**: You can use `default` as a way to specify default values for parameters in methods, especially for generic parameters.

   ```csharp
   void MyMethod<T>(T param = default) { }
   ```

4. **Switch Statements**: In pattern matching with `switch` statements, you can use `default` as a catch-all case for types that don't match any of the specified patterns.

   ```csharp
   switch (obj)
   {
       case int i:
           Console.WriteLine("It's an integer");
           break;
       default:
           Console.WriteLine("It's something else");
           break;
   }
   ```

5. **Null Coalescing and Conditional Operations**: You can use `default` with the null-coalescing operator `??` to provide a default value for nullable types when they are null.

   ```csharp
   int? nullableInt = null;
   int myInt = nullableInt ?? default; // myInt will be 0
   ```

6. **Generics and Constraints**: When working with generic types with constraints, `default` can be used to initialize or reset generic variables to a base state without knowing the specific type at compile time.

In summary, the `default` operator in C# offers a flexible and type-safe way to work with default values, making code more readable and maintainable, especially in generic programming and scenarios where type inference is beneficial.

##### Exploring default values

Take the following code:

```c#
Console.WriteLine($"default(int) = {default(int)}");
Console.WriteLine($"default(bool) = {default(bool)}");
Console.WriteLine($"default(DateTime) = {default(DateTime)}");
Console.WriteLine($"default(string) = {default(string)}");
```

Output: 

<img src='img/20240324-042428.png' width=200px>

The following code assigns a variable to its `default` value:

```c#
int number = 13;
Console.WriteLine($"number set to: {number}");
number = default;
Console.WriteLine($"number reset to its default: {number}");
```

Output:

<img src='img/20240328-042827.png' width=200px>

See [default value expressions - produce the default value](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/default)

#### Formatting using numbered positional arguments

One way of generating formatted strings is to use numbered positional arguments. This feature is supported in methods like `Write()`, `WriteLine()`, and `Format()`. These methods have up to three numbered arguments, named `arg0`, `arg1`, and `arg2`. If you need to pass more values, you cannot name them.

Example:

```c#
int numberOfApples = 12;
decimal pricePerApple = 0.35M;
string type = "organic";

// Up to three parameter values can use named arguments
Console.WriteLine(
    format: "{0} {1} apples cost {2:C}",
    arg0: numberOfApples,
    arg1: type,
    arg2: pricePerApple * numberOfApples);

// Four or more parameter values cannot use named arguments
Console.WriteLine(
    "{0} {1} lived in {2} and worked in the {3} team at {4}.",
    "Roger", "Cevung", "Stockholm", "Education", "Optimizely");

```

**Good Practice**: Once you become familiar with formatting strings, you should stop naming the parameters. For example, stop using `format:`, `arg0:`, and `arg1:`. The preceeding code using a canonical style to show where the `0` and `1` came from.

In C#, formatting strings with numbered positional arguments enhances string manipulation and output formatting by providing a more flexible and readable way to compose strings with dynamic data. This feature is particularly useful in scenarios involving internationalization, complex string constructions, and when reusing arguments in different places within the same string.

##### Benefits of Numbered Positional Arguments

1. **Reusability of Arguments**: You can reuse the same argument multiple times in a formatting string without having to specify it multiple times. This reduces redundancy and the potential for errors.

2. **Order Independence**: The arguments can be placed in any order within the string, providing flexibility in how the string is composed. This is especially useful for localization where the order of words might change based on the language.

3. **Improved Readability**: By using numbered placeholders, the string's intended structure is clearer to the reader, especially in complex formats or when the same argument is used multiple times.

4. **Simplifies Dynamic Content Insertion**: It makes it easier to dynamically insert content into strings, as the placeholders clearly define where the dynamic content goes.

##### History and Evolution

- **Early C# Versions**: Initially, C# supported format strings in methods like `String.Format()`, `Console.WriteLine()`, and others, using indexed placeholders (`{0}`, `{1}`, etc.) which referred to the zero-based index of the corresponding object in the method call. This feature has been available since the first version of C#.

- **C# 6.0 (Introduced in 2015)**: String interpolation was introduced, allowing developers to embed expressions directly in string literals using the `$` syntax. However, this doesn't use numbered positional arguments but rather directly embeds the variable or expression within the string.

- **C# 10 and Beyond**: While the basic concept of formatting strings with numbered positional arguments has not fundamentally changed, improvements and additions to string manipulation and formatting options have been introduced over the years, including enhanced string interpolation, raw string literals for better handling of escape sequences and newlines, and more.

The introduction of string interpolation did not eliminate the use of numbered positional arguments but provided an alternative that can be more readable and concise for inline expressions and variables. The choice between using traditional format strings with numbered placeholders and string interpolation often comes down to the specific needs of the application, such as whether the format string is dynamically generated or localized, or the preference for inline variable embedding versus explicit positional arguments.

In summary, the use of numbered positional arguments in C# format strings offers a combination of flexibility, readability, and reusability that is essential for producing dynamic strings in a maintainable and error-resistant manner. This feature complements the string manipulation capabilities of C#, adapting to various scenarios from simple console outputs to complex internationalized applications.

#### Formatting using interpolated strings

In .NET, interpolated strings provide a convenient way to format strings with embedded expressions. Introduced in C# 6 (2015), interpolated strings allow you to insert values of variables or expressions directly into a string literal, making your code more readable and easier to understand. The interpolated string is defined by using the `$` symbol before the string literal, and expressions are enclosed in `{}` braces.

Here’s a basic overview of how to use interpolated strings in .NET:

##### Basic Syntax

```csharp
var name = "John";
var age = 30;
var message = $"My name is {name} and I am {age} years old.";
Console.WriteLine(message);
```

In the example above, `name` and `age` are variables whose values are embedded into the `message` string. The output will be: "My name is John and I am 30 years old."

##### Formatting Expressions

You can also apply format specifiers to control the formatting of the embedded expressions. Format specifiers follow the expression, separated by a colon `:`.

```csharp
var price = 123.456;
var formattedMessage = $"The price is {price:C2}.";
Console.WriteLine(formattedMessage);
```

In this example, `C2` is a format specifier that formats the number as currency with two decimal places. The output depends on the culture settings of your system; in the US, it might be "The price is $123.46."

##### Using With `CultureInfo`

You can specify the culture for formatting numbers, dates, and currencies within an interpolated string by using the `FormattableString` class and `CultureInfo`.

```csharp
using System.Globalization;

var date = DateTime.Now;
var culture = new CultureInfo("en-US");
var message = FormattableString.Invariant($"Today's date is {date:D}.");
var formattedMessage = string.Format(culture, $"Today's date is {date:D}.");
Console.WriteLine(message);
Console.WriteLine(formattedMessage);
```

In the above example, `FormattableString.Invariant` is used to apply a culture-invariant format, and `string.Format` along with `CultureInfo` is used to format the date according to a specific culture.

##### Escaping Braces

If you need to include a literal `{` or `}` in the string, you double them:

```csharp
var score = 10;
var message = $"Your score is {{score}}: {score}.";
Console.WriteLine(message);
```

This will output: "Your score is {score}: 10."

##### Combining `string` constants

Before C# 10 (2021), `string` constants could only be combined by using concatenation with the `+` operator, as shown here:

```csharp
private const string firstname = "Omar";
private const string lastname = "Rudberg";
private const string fullname = firstname + " " + lastname;
```

With C# 10, interpolated strings (prefixed with `$`) can now be used, as shown below:

```csharp
private const string fullname = $"{firstname}{lastname}";
```

This only works for combining `string` constant values. It cannot work for other types like numbers, which would require runtime data type conversions.

##### Caveats with interpolated strings

For short, formatted `string` values, an interpolated `string` can be easier for people to read. But things can get tricky if you need to restrict strings to certain column widths, where statements then need to wrap over multiple lines. In this case, it is easier to use numbered positional arguments rather than interpolated strings.

References:

- [String interpolation using `$`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/interpolated)
- [String interpolation in C#](https://learn.microsoft.com/en-us/dotnet/csharp/tutorials/string-interpolation)

#### Interpolated strings with newlines in C# 11

Typically strings cannot include newlines its text segments, and must instead use escape sequences (like `\r\n`).  

```c#
// The following statement must be all on one line when using C# 10 or earlier.
// If using C# 11 or later, we can include a line break in the middle of an
// expression but not in the string text.

Console.WriteLine($"{numberOfApples} apples cost {pricePerApple 
    * numberOfApples:C}");
```

In C# 11 (2022), a notable improvement was made regarding string interpolation, specifically allowing new-lines (line breaks) in all interpolations within interpolated strings. This enhancement is part of the broader efforts to make string handling in C# more flexible and expressive, particularly in scenarios involving complex string construction or when embedding large blocks of text or code.

##### Before C# 11

Prior to C# 11, if you wanted to include an expression within an interpolated string that spanned multiple lines, you had to explicitly handle the new-lines or concatenate multiple interpolated strings together, which could lead to less readable and more cumbersome code.

For example, consider you had a multi-line expression you wanted to embed within an interpolated string. You would typically need to do something like the following:

```csharp
var name = "John";
var age = 30;
var address = "123 Main St";

// Pre C# 11 - Needing to concatenate strings or use workarounds
var message = $"Name: {name}\n" +
              $"Age: {age}\n" +
              $"Address: {address}";
```

##### With C# 11

Starting with C# 11, you can directly include new-line characters within interpolations in an interpolated string, making it significantly easier to work with multi-line expressions. This means you can now insert expressions that span multiple lines directly into the interpolation braces (`{}`), improving the readability and maintainability of your code.

Here's how you can leverage this in C# 11:

```csharp
var name = "John";
var age = 30;
var address = "123 Main St";

// C# 11 - Allowing new-lines in all interpolations
var message = $"""
    Name: {name}
    Age: {age}
    Address: {
address}
    """;
```

In this example, notice how the address expression is included directly within the interpolation braces and spans multiple lines. This is just a simple demonstration; the real benefit comes when dealing with complex expressions or formatting that would otherwise clutter your code.

##### Benefits and Use Cases

- **Improved Readability:** Code involving complex string constructions becomes easier to read and understand.
- **Enhanced Maintainability:** Reduces the need for concatenation or using additional variables to handle multi-line expressions, making code maintenance simpler.
- **Better Formatting Control:** Offers more control over the formatting of embedded expressions, especially when dealing with dynamically generated content or templates.

References:

- [Allow new-lines in all interpolations](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/proposals/csharp-11.0/new-line-in-interpolation)

#### Format strings, `{1,6:N0}`

Format strings allow you to control how values are displayed, including numbers, dates, times, and custom formats. C# utilizes composite formatting, which combines a format string with an array of objects to produce a formatted result. This system is used across various methods like `String.Format`, `Console.WriteLine`, and string interpolation (introduced in C# 6 with the `$` prefix).

```csharp
public static void WriteLine (string format, object? arg0, object? arg1);
```

A format string consists of static text intermixed with indexed placeholders, referred to as format items. A format item is enclosed in braces `{}` and can contain an index, an optional format string, and an optional alignment component:

```plaintext
{index[,alignment][:formatString]}
```

- **Index**: Refers to the zero-based position of the item in the method's argument list.
- **Alignment**: An optional integer indicating the total length of the field in which the argument is inserted. Positive values align the text to the right, while negative values align it to the left.
- **Format String**: An optional directive specifying how the argument should be formatted.

Here's an example:

```csharp
string applesText = "Apples";
int applesCount = 1234;
string bananasText = "Bananas";
int bananasCount = 56789;
Console.WriteLine();
Console.WriteLine(format: "{0,-10}{1,6}",
    arg0: "Name", arg1: "Count");
Console.WriteLine(format: "{0,-10}{1,6:N0}",
    arg0:applesText, arg1: applesCount);
Console.WriteLine(format: "{0,-10}{1,6:N0}",
    arg0:bananasText, arg1: bananasCount);
```

Output:

<img src='img/20240334-053414.png' width=200px>

Reference:

- [Standard numeric format strings](https://learn.microsoft.com/en-us/dotnet/standard/base-types/standard-numeric-format-strings)
- [Custom numeric format strings](https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-numeric-format-strings)

#### Text input and handling null cases, `?` and `!`

Here's an example of using `Console.Readline()` to capture input.  

```csharp
Console.WriteLine("Type your first name and press Enter: ");
string? firstName = Console.ReadLine();
Console.WriteLine("Type your age and press Enter: ");
string age = Console.ReadLine()!;
Console.WriteLine($"Hello {firstName}, you look good for {age}!");
```

Things to note:

1. The `?` after `string` declaration is used to indicate the variable is nullable. See [Nullable Reference Types](https://learn.microsoft.com/en-us/dotnet/csharp/nullable-references).
2. The `!` before the semicolon suppresses nullable warnings. See [Null-forgiving operator](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/null-forgiving).

#### Key input

You can use the `ReadKey` mehtod to get keyboard input from a user. This method waits for the user to press a key or key combination, which is returned as a `ConsoleKeyInfo` value.

```csharp
using static System.Console;

Write("Press any key combination: ");
ConsoleKeyInfo key = ReadKey();
WriteLine();
WriteLine("Key: {0}, Char: {1}, Modifiers: {2}", 
    arg0:key.Key, arg1:key.KeyChar, arg2:key.Modifiers);
```

Output: note how `key` has the properties representing the key pressed and any modifier keys

<img src='img/20240332-043232.png' width=300px>

#### Passing arguments to a console app

When you want to run a console app, you often want to change its behavior by passing arguments. In every version of .NET prior to version 6 (2015), the console app project template made it obvious, as shown in the following code:

```csharp
namespace Arguments
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

The `string[] args` arguments are declared and passed in the `Main` method of the `Program` class. However, in top-level programs, as used by the console app project template in .NET 6 and later, the `Program` class and its `Main` method are hidden, along with declaration of the `args` array. The trick is that you must know it still exists.

Command-line arguments are separated by spaces. Other characters like hyphens and colons are treated as part of an argument value.

To include spaces in an argument value, enclose the argument value in single or double quotes.

In Visual Studio, you can specify the arguments for running your program by clicking **Debug > "Project Name" Debug Properties**. This action brings up the "Launch Profiles" menu, where you can specify the arguments.

<img src='img/20240357-035733.png' width=400px>

The results of the launch profile configuration are written to the **launchSettings.json** file in the project directory.

<img src='img/20240358-035842.png' width=400px>

Given the following code, 

```csharp
WriteLine($"There are {args.Length} arguments.");
foreach (string arg in args)
    WriteLine(arg);
```

The resulting output is:

<img src='img/20240359-035957.png' width=200px>

#### Setting options with arguments

The following example shows how you can 

```csharp
if (args.Length < 3)
{
    WriteLine("You must specify two colors and cursor size, e.g.");
    WriteLine("dotnet run red yellow 50");
    return; // stop running
}

ForegroundColor = (ConsoleColor)Enum.Parse(
    enumType: typeof(ConsoleColor),
    value: args[0], ignoreCase: true);
BackgroundColor = (ConsoleColor)Enum.Parse(
    enumType: typeof(ConsoleColor),
    value: args[1], ignoreCase: true);
CursorSize = int.Parse(args[2]);
```

When specifying `red yellow 50` in the launch profile configuration, the resulting output is, indicating that the foreground color was set to `red`, and the background color was set to `yellow`, and the cursor size, which you can't see, was set to `50`:

<img src='img/20240314-041456.png' width=400px>

References

- [System.Console class](https://learn.microsoft.com/en-us/dotnet/api/system.console?view=net-8.0)

#### Handling platforms that do not support an API (conditional preprocessor directives)

In the last section, the call to set the cursor size is not supported on the macOS platform; it throws an exception. You can use `try`-`catch` statements to catch the exception and provide a friendlier message:

```csharp
try
{
    CursorSize = int.Parse(args[2]);
}
catch (PlatformNotSupportedException)
{
    WriteLine("This current platform does not support changing the size of the cursor.")
}
```

Another way to handle the differences is to use the `OperatingSystem` class in the `System` namespace, as shown:

```csharp
if (OperatingSystem.IsWindows())
{
    // Execute code that only works in Windows
} 
else if (OperatingSystem.IsWindowsVersionAtLeast(major:10))
{
    // Execute code that only works on Windows 10 or later
} else if (OperatingSystem.IsIOSVersionAtLeast(major:14, minor:5))
{
   // Execute code that only works on iOS 14.5 or later 
} else if (OperatingSystem.IsBrowser())
{
    // Execute code that only works in the browser with Blazor
}
```

See [OperatingSystem class](https://learn.microsoft.com/en-us/dotnet/api/system.operatingsystem?view=net-8.0)

A third way to handle different platforms is to use conditional compilation statements. There are four preprocessor directives that control conditional compilation: `#if`, `#elif`, `#else`, and `#endif`. The conditional preprocessor directives let you include or exclude code based on the existence of one or more symbols.

You define symbols using `#define` as shown:

```csharp
#define MYSYMBOL
```

Many symbols are automatically defined for you:

<img src='img/20240346-044627.png' width=600px>

You can then write statements that will compile only for the specified platforms:

```csharp
#if NET7_0_ANDROID
// Compile statements that only work on Android
#elif NET7_0_IOS
// Compile statements that only work on iOS
# else
// Compile statements that work everywhere else.
#endif
```

See [C# preprocessor directives](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/preprocessor-directives)

#### Understanding `async` and `await`

C# 5 (2012) introduced two C# keywords when working with the `Task` type that enable easy multi-threading. The pair of keywords is especially useful in

- Implementing multitasking for a graphical user interface
- Improving the scalability of web applications and web services
- Preventing blocking calls when interacting with the filesystem, databases, and remote services, all of which tend to take a long time to complete their work

One of the limitations with console apps is that you can only use the `await` keyword inside methods that are marked as `async`, but C# 7 (2015) and earlier do not allow the `Main` mehtod to be marked as `async`. Luckily, a new feature introduced in C# 7.1 was support for `async` in `Main`.

The following code provides an example of how `async` can be used in a console app.

```csharp
HttpClient client = new();
HttpResponseMessage response = await client.GetAsync("http://www.apple.com");
WriteLine("Apple's home page has {0:N0} bytes.", response.Content.Headers.ContentLength);
```

Output:

<img src='img/20240308-050851.png' width=300px>

In .NET 5 and earlier you would've received an error message indicating the `await` operator can only be used within an async method, and to change the return type of the method to `Task`. You would've had to add the `async` keyword for your `Main` method and change its return type from `Void` to `Task`. 

With .NET 6 and later, the console app project template uses the top-level program feature to automatically define the `Program` class with an asynchronous `<Main>$` method for you.

<img src='img/20240245-064547.png' width=600px>

#### Knowledge check

##### Exercise 2.1 - Test your knowledge

<details><summary>1. What statement can you type in a C# file to discover the compiler and language version?</summary><br>

Use statement `#error version`. See [Specifying SDK and C# language versions](#specifying-sdk-and-c-language-versions).

</details>

<details><summary>2. What are the two types of comments in C#?</summary><br>

The two types of comments are a single-line comment, `//`, and a multi-line comment, `/*` and `*/`.

</details>

<details><summary>3. What is the difference between a verbatim string and an interpolated string?</summary><br>

Standard strings allow for escape characters, e.g. `\n` to represent a newline. Verbatim strings, which are denoted with a `@`, do not process escape characters; instead, they depict an escape character as literal text.

Interpolated strings make code more user-friendly by allowing references to variables directly in the string itself, within curly braces, `{}`. Interpolated strings are denoted with a `$`.

See [Verbatim string literals](#verbatim-string-literals) and [Interpolated string literals](#interpolated-string-literals).

</details>

<details><summary>4. Why should you be careful when using `float` and `double` values?</summary><br>

`float` and `double` values store the fraction portion of the real number in binary representation rather than decimal representation. As a result, some numbers cannot be represented exactly, resulting in small rounding errors. You should never compare a `float` and `double` value for equality; instead, you should use a greater-than or less-than approach. Use the `decimal` type to compare real numbers for equality, as the decimal type stores the fraction part of the real number decimal representation rather than binary representation.

See [Real number types](#real-numbers-float-double-decimal).

</details>

<details><summary>5. How can you determine how many bytes a type like `double` uses in memory?</summary><br>

Use the `sizeof` operator.

See [Integer types and the `sizeof` operator](#integer-types-and-the-sizeof-operator)

</details>

<details><summary>6. When should you use the `var` keyword?</summary><br>

The `var` keyword is used to allow the compiler to infer type type of a variable. You should make a good habit of using the `var` keyword but only use it when the type can be easily deduced from the variable assignment.

See [The `var` keyword](#the-var-keyword-and-implicitly-typed-local-variables)

</details>

<details><summary>7. What is the newest syntax to create an instance of a class like `XmlDocument`?</summary><br>

The target-typed `new()` operator can be used to create new instances without having to explicitly list the type during assignment or declaration.

See [The `new()` operator](#using-target-typed-new-new-to-instantiate-objects).

</details>

<details><summary>8. Why should you be careful when using the `dynamic` type?</summary><br>

Operations on `dynamic` types are not checked at compile time. Therefore, there is increased risk of an error occurring during runtime for `dynamic` types.

See [Dynamic types](#dynamic-types-using-the-dynamic-keyword)

</details>

<details><summary>9. How do you right-align a format string?</summary><br>

When specifying a format, the alignment number can be used after the index number to indicate the number of characters to align. A positive number indicates left alignment. A negative number indicates right alignment.

```csharp
{index[,alignment][:formatString]}
```

See [Format strings](#format-strings-16n0)

</details>

<details><summary>10. What character separates arguments for a console app?</summary><br>

A space character separates arguments.

See [Passing arguments to a console app](#passing-arguments-to-a-console-app).

</details>

##### Exercise 2.2 - Test your knowledge of number types

What type would you choose for the following numbers?

- A person's telephone number:  `string`
- A person's height: `decimal`
- A person's salary: `int`
- A book's ISBN: `string`
- A book's price: `decimal`
- A book's shipping weight: `float`
- A country's population: `long`
- The number of stars in the universe: `double`
- The number of employees in each of the small or medium businesses in the US (up to ~50k employees per business): `long`

##### Exercise 2.3 - Practice number sizes and ranges

In the Chapter02 solution, create a console app project named Ch02Ex03Numbers that outputs the number of bytes in memory that each of the following number types uses and the minimum and maximum values they can have: `sbyte`, `byte`, `short`, `ushort`, `int`, `uint`, `long`, `ulong`, `Int128`, `UInt128`, `Half`, `float`, `double`, and `decimal`.

The result should look like the following

<img src='img/20240349-054921.png' width=500px>

<details><summary>My solution</summary><br>

Here is the code to my solution:

```csharp
string hyphens = new string('-', 105);
string titleformat = "{0,-10}{1,-20}{2,30}{3,45}";
string format = "{0,-10}{1,-5}{2,45}{3,45}";
WriteLine($"{hyphens}");
WriteLine(titleformat, "Type", "Byte(s) of memory", "Min", "Max");
WriteLine(hyphens);
WriteLine(format, "sbyte", sizeof(sbyte), sbyte.MinValue, sbyte.MaxValue);
WriteLine(format, "byte", sizeof(byte), byte.MinValue, byte.MaxValue);
WriteLine(format, "short", sizeof(short), short.MinValue, short.MaxValue);
WriteLine(format, "ushort", sizeof(ushort), ushort.MinValue, ushort.MaxValue);
WriteLine(format, "int", sizeof(int), int.MinValue, int.MaxValue);
WriteLine(format, "uint", sizeof(uint), uint.MinValue, uint.MaxValue);
WriteLine(format, "long", sizeof(long), long.MinValue, long.MaxValue);
WriteLine(format, "ulong", sizeof(ulong), ulong.MinValue, ulong.MaxValue);
unsafe
{
    WriteLine(format, "Int128", sizeof(Int128), Int128.MinValue, Int128.MaxValue);
    WriteLine(format, "UInt128", sizeof(UInt128), UInt128.MinValue, UInt128.MaxValue);
    WriteLine(format, "Half", sizeof(Half), Half.MinValue, Half.MaxValue);
}
WriteLine(format, "float", sizeof(float), float.MinValue, float.MaxValue);
WriteLine(format, "double", sizeof(double), double.MinValue, double.MaxValue);
WriteLine(format, "decimal", sizeof(decimal), decimal.MinValue, decimal.MaxValue);
```

Output:

<img src='img/20240308-050826.png' width=600px>

</details>

##### Exercise 2.4 - Explore topics

Use the links on the following page to learn more details about the topics covered in this chapter:

https://github.com/markjprice/cs12dotnet8/blob/main/docs/book-links.md#chapter-2---speaking-c

##### Exercise 2.5 - Explore Spectre

**Spectre** is a package that enhances console apps: https://spectreconsole.net



