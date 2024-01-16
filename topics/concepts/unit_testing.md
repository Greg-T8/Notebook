# Unit Testing Notes

This page covers my learnings on unit testing. Most of the material on this page comes from the book "Unit Testing: Principles, Practices, and Patterns" by Vladimir Khorikov.

<details><summary>The Goal of Unit Testing</summary>

## Goal of Unit Testing
Code tends to deteriorate. Each time you change something in a code base, the amount of disorder in it, or entropy, increases. Without proper care, such as constant cleaning and refactoring, the system becomes increasingly complex and disorganized. Tests help overturn this tendency.

The goal of unit testing is to enable sustainable growth of the software project. As projects progress through their lifecycle, stagnation occurs when there are no tests or the tests are of poor quality.

<img src='img/20240157-095728.png' width=500px>

Keep in mind that not every test holds the same importance. While certain tests significantly enhance the quality of software, others may not be as effective. These less helpful tests often lead to unnecessary alerts, fail to detect regression issues, and can be cumbersome and challenging to maintain. It's common to get caught up in creating unit tests just for the sake of it, without truly understanding if they are beneficial to the project.

> Code is a liability, not an asset. The more code you introduce, the more you extend the surface area for potential bugs in your software, and the higher the project's upkeep cost. It's always better to solve problems with as little code as possible. Tests are code too.

## About Code Coverage

A coverage metric shows how much source code a test suite examines, from none to 100%. However, code coverage metrics don't tell the full story for two reasons:
  
1. You can't guarantee that the test verifies all possible outcomes. 
2. No coverage metric can take into account code paths in external libraries

Per #1 above, code has explicit outcomes and implicit outcomes. An example of an explicit outcome is a value returned by a function. An example of an implicit outcome is a modification to a file by a function that returns no value. Code coverage metrics don't guarantee that the underlying code is tested; it only guarantees that the code has been executed at some point.

Per #2 above, external code paths may yield different results based on the input, and there's no way to see if your tests account for all possible outcomes.

> Targeting a specific coverage number creates a perverse incentive that goes against the goal of unit testing.

The best way to view a coverage metric is as an indicator, not a goal in and of itself. It's good to have a high level of coverage in core parts of your system.  It's bad to make this high level a requirement.

## Successful Test Suites

A successful test suite has the following properties:

- It's integrated into the development cycle
- It targets only the most important parts of your code base
- It provides maximum value with minimum maintenance costs

The only point in having automated tests is if you constantly use them. All tests should execute on every code change, even the smallest one.

Not all parts of your code base are worth the same attention in terms of unit testing. It's important to direct your unit testing efforts to the most critical parts of the system; then verify the other parts of the system only briefly or indirectly.

The most critical part of the system is the _domain model_. The domain model refers to a conceptual model that represents the various entities, their attributes, roles, and relationship within a specific domain of knowledge or business. 

The _domain model_ should be where most of the unit testing effort takes place.

All other parts of the system can be divided into three categories:

- Infrastructure code
- External services and dependencies, such as the database and third-party systems
- Code that glues everything together

To follow this model, it's important to isolate the domain model from the non-essential parts of the code base.

The most difficult part of unit testing is achieving maximum value with minimum maintenance costs. The only way to achieve the goal of unit testing is to 

- Learn how to differentiate between a good test and a bad test
- Be able to refactor a test to make it more valuable

</details>

## What is a Unit Test?

There are two distinct views on how to approach unit testing:

1. Classical (Detroit) school - how everyone originally approached unit testing and test-driven development
2. London school - rooted in the programming community in London

### The definition of a unit Test

A unit test is an automated test that

- Verifies a small piece of code (also known as a unit),
- Does it quickly, and
- Does it in an isolated manner

Most people agree on the first and second points. People have differences on the third point. The isolation issue is the root of the differences between the classical and London schools of unit testing.

The most canonical book on the classical school is [Test Driven Development: By Example](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627/ref=sr_1_1?crid=23PA6751RMJS7&keywords=growing+object-oriented+software%2C+guided+by+tests&qid=1704477374&sprefix=Growing+object-o%2Caps%2C97&sr=8-1) by Kent Beck.

The London style is sometimes referred to as _mockist_. The most prominent book for the London style is [Growing Object-Oriented Software, Guided by Tests](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627/ref=sr_1_1?crid=23PA6751RMJS7&keywords=growing+object-oriented+software%2C+guided+by+tests&qid=1704477374&sprefix=Growing+object-o%2Caps%2C97&sr=8-1), by Steve Freeman and Nat Pryce.

#### The London take

The London school isolates the system under test from its collaborators.  It involves replacing all dependencies with a _test double_, which is an object that looks and behaves like its release-intended counterpart but is actually a simplified version that reduces the complexity and facilitates testing.  The term _test double_ was introduced in the book [xUnit Test Patterns: Refactoring Test Code](https://www.amazon.com/xUnit-Test-Patterns-Refactoring-Addison-Wesley-ebook/dp/B004X1D36K/ref=sr_1_1?crid=2PVQI7B8WYTKH&keywords=xunit+test+patterns&qid=1704477623&sprefix=xunit+test+patterns%2Caps%2C95&sr=8-1). _Test double_ comes from the notion of using a stunt double in movies.

The following image shows how a test double replaces the dependencies of the system under test. 

<img src='img/20240102-120210.png' width=300px>

A benefit to this approach is that if the test fails, then you know for sure which part of the code base is broken: it's the system under test; it cannot be any of the dependencies because they have been removed.

Another benefit is that you don't have to recreate the full object graph in a test. Instead you can substitute the immediate dependencies of a class so that you don't have to deal with the dependencies of the dependencies.

In the Pester PowerShell testing suite, mocks are used as a test double. However, know that a mock is a special kind of test double that allows you to examine interactions between the system under test and its collaborators. Technically,

- A _test double_ is an overarching term that describes all kinds of non-production-ready, fake dependencies in a test
- A _mock_ is just one kind of such dependencies

The London style approaches the isolation requirement by segregating pieces of code under test from its collaborators with the help of test doubles: specifically mocks.

In the classical approach, it's not the code that needs to be tested in an isolated manner; instead, the unit tests themselves should be run in isolation from each other. Isolating unit tests works fine so as long as they all reside in memory and don't reach out to a shared state, through which the tests can affect each other's execution context.  Typical examples of shared state are out-of-process dependencies&mdash;the database, the filesystem, and so on.



