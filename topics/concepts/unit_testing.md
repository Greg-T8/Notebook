# Unit Testing Notes

This page covers my learnings on unit testing. Most of the material on this page comes from the book "Unit Testing: Principles, Practices, and Patterns" by Vladimir Khorikov.

<details><summary>The Need for Unit Testing</summary>

Code tends to deteriorate. Each time you change something in a code base, the amount of disorder in it, or entropy, increases. Without proper care, such as constant cleaning and refactoring, the system becomes increasingly complex and disorganized. Tests help overturn this tendency.

_The goal of unit testing is to enable sustainable growth of the software project_. As projects progress through their lifecycle, stagnation occurs when there are no tests or the tests are of poor quality.

<img src='img/20240157-095728.png' width=500px>

Keep in mind that not every test holds the same importance. While certain tests significantly enhance the quality of software, others may not be as effective. These less helpful tests often lead to unnecessary alerts, fail to detect regression issues, and can be cumbersome and challenging to maintain. It's common to get caught up in creating unit tests just for the sake of it, without truly understanding if they are beneficial to the project.

> Code is a liability, not an asset. The more code you introduce, the more you extend the surface area for potential bugs in your software, and the higher the project's upkeep cost. It's always better to solve problems with as little code as possible. Tests are code too.

</details>

<details><summary>About Code Coverage</summary>

A coverage metric shows how much source code a test suite examines, from none to 100%. However, code coverage metrics don't tell the full story for two reasons:
  
1. You can't guarantee that the test verifies all possible outcomes. 
2. No coverage metric can take into account code paths in external libraries

Per #1 above, code has explicit outcomes and implicit outcomes. An example of an explicit outcome is a value returned by a function. An example of an implicit outcome is a modification to a file by a function that returns no value. Code coverage metrics don't guarantee that the underlying code is tested; it only guarantees that the code has been executed at some point.

Per #2 above, external code paths may yield different results based on the input, and there's no way to see if your tests account for all possible outcomes.

> Targeting a specific coverage number creates a perverse incentive that goes against the goal of unit testing.

_The best way to view a coverage metric is as an indicator, not a goal in and of itself_. It's good to have a high level of coverage in core parts of your system.  It's bad to make this high level a requirement.

</details>

## Properties of Successful Test Suites

A successful test suite has the following properties:

- It's integrated into the development cycle
- It targets only the most important parts of your code base
- It provides maximum value with minimum maintenance costs

<details><summary>More info</summary>

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


A unit test is an automated test that

1. Verifies a small piece of code (also known as a unit),
2. Does it quickly, and
3. Does it in an isolated manner

Most people agree on the first and second points. The third point, isolation, is so controversial that there are two distinct views on unit testing:

1. Detroit Approach (Classicist):

    - Focuses more on the state of the system after the unit's execution
    - Reflective of actual usage
    - How everyone originally approached unit testing and test-driven development

2. London Approach (Mockist):
  
    - Heavily relies on mock objects to isolate the unit from its dependencies
    - Encourages design where units are highly decoupled, leading to a more modular and flexible design
    - More granular tests that focus on the behavior of a single unit in isolation
    - Popular in Test-Driven Development (TDD)

<details><summary>The London Approach vs the Classicist Approach</summary>

The London school isolates the system under test from its collaborators (i.e. dependencies). It involves replacing all dependencies with a _test double_, which is an object that looks and behaves like its release-intended counterpart but is actually a simplified version that reduces the complexity and facilitates testing.  The term _test double_ comes from the idea of using a stunt double in movies.

The following image shows how a test double replaces the dependencies of the system under test. 

<img src='img/20240102-120210.png' width=300px>

A benefit to this approach is that if the test fails, then you know for sure which part of the code base is broken: it's the system under test; it cannot be any of the dependencies because they have been removed.

Another benefit is that you don't have to recreate the full object graph in a test. Instead you can substitute the immediate dependencies of a class so that you don't have to deal with the dependencies of the dependencies.

In the Pester PowerShell testing suite, mocks are used as a test double. However, know that a mock is a special kind of test double that allows you to examine interactions between the system under test and its collaborators. Technically,

- A _test double_ is an overarching term that describes all kinds of non-production-ready, fake dependencies in a test
- A _mock_ is just one kind of such dependencies

In the classical approach, it's not the code that needs to be tested in an isolated manner; instead, the unit tests themselves should be run in isolation from each other. Isolating unit tests works fine so as long as they all reside in memory and don't reach out to a shared state, through which the tests can affect each other's execution context.  Typical examples of shared state are out-of-process dependencies&mdash;the database, the filesystem, and so on.

Dependency Types: 

- Shared dependency: a dependency that is shared between tests and provides means for those tests to affect each other's outcome. Examples: a static mutable field, a database.
- Private dependency: a dependency that is not shared.
- Out-of-process dependency: a dependency that runs outside the application's execution process. This type of dependency can be a shared dependency, such as a database used by both tests, or a private dependency, such as a database that runs isolated in a container.
- Volatile dependency: a dependency that either (1) introduces a requirement to set up and configure a runtime environment in addition to what's installed on the developer's machine (e.g. an API) or (2) contains nondeterministic behavior (e.g. a random number generator).

</details>

## The Anatomy of a Unit Test

Unit tests are structured using the arrange, act, and assert (AAA) pattern. In the arrange section, you bring the system under test (SUT) and its dependencies to a desired state. In the act section, you call methods on the SUT and capture the output value. In the assert section, you verify the outcome.

The arrange section is the largest section in terms of code.

The act section is typically one line of code. If you have more than one line in the act section, it is a sign of a problem with the SUT's API, which indicates that two actions must always be performed together, which can lead to inconsistencies.

A unit test tests a single unit of behavior, not a single unit of code.

## The Four Pillars of a Good Unit Test

A good unit test has the following four attributes:

1. Protection against regressions
2. Resistance to refactoring
3. Fast feedback
4. Maintainability

Points to keep in mind:

- A regression refers to a situation where a previously functioning feature  stops working after changes. Generally, the larger the amount of code that gets executed, the higher the chance that the test will reveal a regression.

- Code that represents complex business logic is more important than boilerplate code.

- It's rarely worthwhile to test trivial code. Trivial code does not contain a substantial amount of business logic and won't provide much chance of finding a regression error.


