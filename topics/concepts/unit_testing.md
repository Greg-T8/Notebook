# Unit Testing Notes

This page covers my learnings on unit testing. Most of the material on this page comes from the book "Unit Testing: Principles, Practices, and Patterns" by Vladimir Khorikov.

- [Types of Testing in Software Development](#types-of-testing-in-software-development)
- [The Need for Unit Testing](#the-need-for-unit-testing)
  - [About Code Coverage](#about-code-coverage)
- [Properties of Successful Test Suites](#properties-of-successful-test-suites)
- [What is a Unit Test?](#what-is-a-unit-test)
  - [The London Approach vs the Classical Approach](#the-london-approach-vs-the-classical-approach)
  - [Dependency Types](#dependency-types)
  - [The London approach or the Classical approach?](#the-london-approach-or-the-classical-approach)
- [The Anatomy of a Unit Test](#the-anatomy-of-a-unit-test)
- [The Four Pillars of a Good Unit Test](#the-four-pillars-of-a-good-unit-test)
  - [1. Protection against regression](#1-protection-against-regression)
  - [2. Resistance to refactoring](#2-resistance-to-refactoring)
    - [About false positives](#about-false-positives)
  - [3. Fast feedback](#3-fast-feedback)
  - [4. Maintainability](#4-maintainability)
  - [Determining Test Value](#determining-test-value)
- [Mocks and Test Doubles](#mocks-and-test-doubles)
  - [Other Test Double Types](#other-test-double-types)
  - [Asserting interactions with stubs](#asserting-interactions-with-stubs)
    - [Observable Behavior vs Implementation Detail](#observable-behavior-vs-implementation-detail)
  - [Intra-System and Inter-System Communications](#intra-system-and-inter-system-communications)
- [The Styles of Unit Testing](#the-styles-of-unit-testing)
  - [Output-Based Style](#output-based-style)
  - [State-Based Style](#state-based-style)
  - [Communication-Based Style](#communication-based-style)
  - [Comparing the Three Styles of Unit testing](#comparing-the-three-styles-of-unit-testing)
  - [Understanding Functional Architecture](#understanding-functional-architecture)


## Types of Testing in Software Development

The Test Pyramid represents the three major test types. The width of the pyramid refers to the prevalance of a particular type of test in the suite. The wider the layer, the greater the test count. The height is a measure of how close these tests are to emulating the user's behavior. 

<img src='img/20240124-062428.png' width=600px>

Understanding the different types of testing suites is crucial in software development, as each type targets different aspects of an application and ensures its quality and reliability. Here are the key differences among some common types of testing suites:

1. **Unit Testing:**
   - **Focus:** The smallest parts of an application, typically individual functions or methods.
   - **Purpose:** To verify that each unit works as intended in isolation.
   - **Method:** Developers write these tests to check the correctness of their code. Mock objects and stubs are often used to isolate the unit from its dependencies.
   - **Example:** Testing a function that calculates the sum of two numbers.

2. **Integration Testing:**
   - **Focus:** The interaction between integrated units/modules of the application.
   - **Purpose:** To detect issues in the interaction between integrated units.
   - **Method:** These tests are typically written after unit tests and focus on the flow of data and control between modules. They may involve testing database interactions, API calls, etc.
   - **Example:** Testing how a database module interacts with a data processing module.

3. **End-to-End Testing:**
   - **Focus:** The entire application in a scenario that mimics real-world use.
   - **Purpose:** To replicate real-user scenarios to ensure the system works as intended.
   - **Method:** This involves testing the complete flow of an application from start to finish, including its interaction with external interfaces and networks.
   - **Example:** Testing an e-commerce application from product selection, cart management, checkout, payment, to order confirmation.

4. **Other Test Types**

  The following tests types fall under the categories mentioned above:

- **Functional Testing:**
  - **Focus:** The overall functionality of the system.
  - **Purpose:** To ensure the software is functioning according to the requirements or specifications.
  - **Method:** Conducted from the user's perspective, it involves testing complete features or functionalities of the application.
  - **Example:** Testing the complete workflow of a user registration feature.

- **System Testing:**
  - **Focus:** The complete and integrated software product.
  - **Purpose:** To evaluate the system’s compliance with specified requirements.
  - **Method:** This is a high-level testing suite that validates the overall behavior of the application in an environment that mimics production.
  - **Example:** Testing the entire application after integration to ensure it meets all technical, functional, and business requirements.

- **Acceptance Testing:**
  - **Focus:** The software in a "production-like" environment.
  - **Purpose:** To validate if the software meets the business requirements and is ready for deployment.
  - **Method:** Often performed by end-users or clients, it checks if the software is acceptable for delivery.
  - **Example:** Business stakeholders testing the software to decide if it meets the predetermined criteria and is ready for release.

- **Regression Testing:**
  - **Focus:** Ensuring that new changes haven't adversely affected existing functionalities.
  - **Purpose:** To check that the old code still works after the new changes.
  - **Method:** Typically automated, it involves re-running functional and non-functional tests to ensure that previously developed and tested software still performs after a change.
  - **Example:** Re-running tests after bug fixes or new feature additions.

## The Need for Unit Testing

Code tends to deteriorate. Each time you change something in a code base, the amount of disorder in it, or entropy, increases. Without proper care, such as constant cleaning and refactoring, the system becomes increasingly complex and disorganized. Tests help overturn this tendency.

_The goal of unit testing is to enable sustainable growth of the software project_. As projects progress through their lifecycle, stagnation occurs when there are no tests or the tests are of poor quality.

<img src='img/20240157-095728.png' width=500px>

The mechanism by which unit tests enable sustainable growth is that they allow you to add new features and conduct regular refactorings without introducing regressions (i.e. bugs). There are two benefits here:

1. Tests provide an early warning when you break existing functionality
2. You become confident that your code changes won't lead to regressions

Keep in mind that not every test holds the same importance. While certain tests significantly enhance the quality of software, others may not be as effective. These less helpful tests often lead to unnecessary alerts, fail to detect regression issues, and can be cumbersome and challenging to maintain. It's common to get caught up in creating unit tests just for the sake of it, without truly understanding if they are beneficial to the project.

> Code is a liability, not an asset. The more code you introduce, the more you extend the surface area for potential bugs in your software, and the higher the project's upkeep cost. It's always better to solve problems with as little code as possible. Tests are code too.

### About Code Coverage

A coverage metric shows how much source code a test suite examines, from none to 100%. However, code coverage metrics don't tell the full story for two reasons:
  
1. You can't guarantee that the test verifies all possible outcomes. 
2. No coverage metric can take into account code paths in external libraries

Per #1 above, code has explicit outcomes and implicit outcomes. An example of an explicit outcome is a value returned by a function. An example of an implicit outcome is a modification to a file by a function that returns no value. Code coverage metrics don't guarantee that the underlying code is tested; it only guarantees that the code has been executed at some point.

Per #2 above, external code paths may yield different results based on the input, and there's no way to see if your tests account for all possible outcomes.

> Targeting a specific coverage number creates a perverse incentive that goes against the goal of unit testing.

_The best way to view a coverage metric is as an indicator, not a goal in and of itself_. It's good to have a high level of coverage in core parts of your system.  It's bad to make this high level a requirement.

## Properties of Successful Test Suites

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

## What is a Unit Test?

A unit test is an automated test that

1. Verifies a small piece of code (also known as a unit),
2. Does it quickly, and
3. Does it in an isolated manner

### The London Approach vs the Classical Approach

Most people agree on the first and second points above. The third point, isolation, is so controversial that there are two distinct views on unit testing:

1. Classical Approach:

    - Focuses more on the state of the system after the unit's execution
    - Reflective of actual usage
    - Allows for the inclusion of dependencies during testing
    - How everyone originally approached unit testing and test-driven development

2. London Approach:
  
    - Isolates all dependencies from its collaborators; tests one class at a time
    - Heavily relies on mock objects to isolate the unit from its dependencies
    - Encourages design where units are highly decoupled, leading to a more modular and flexible design
    - More granular tests that focus on the behavior of a single unit in isolation
    - Popular in Test-Driven Development (TDD)

The London school isolates the system under test from its collaborators (i.e. dependencies). It involves replacing all dependencies with a _test double_, which is an object that looks and behaves like its release-intended counterpart but is actually a simplified version that reduces the complexity and facilitates testing.  The term _test double_ comes from the idea of using a stunt double in movies.

The following image shows how a test double replaces the dependencies of the system under test. 

<img src='img/20240102-120210.png' width=300px>

A benefit to this approach is that if the test fails, then you know for sure which part of the code base is broken: it's the system under test; it cannot be any of the dependencies because they have been removed.

Another benefit is that you don't have to recreate the full object graph in a test. Instead you can substitute the immediate dependencies of a class so that you don't have to deal with the dependencies of the dependencies.

In the Pester PowerShell testing suite, mocks are used as a test double. However, know that a mock is a special kind of test double that allows you to examine interactions between the system under test and its collaborators. Technically,

- A _test double_ is an overarching term that describes all kinds of non-production-ready, fake dependencies in a test
- A _mock_ is just one kind of such dependencies

In the classical approach, it's not the code that needs to be tested in an isolated manner; instead, the unit tests themselves should be run in isolation from each other. Isolating unit tests works fine so as long as they all reside in memory and don't reach out to a shared state, through which the tests can affect each other's execution context.  Typical examples of shared state are out-of-process dependencies&mdash;the database, the filesystem, and so on.


### Dependency Types

A dependency refers to any external system or component that the code under test interacts with or relies upon to function correctly.

There are several inter-related types of dependencies:

- Shared dependency: a dependency that is shared between tests and provides means for those tests to affect each other's outcome.
  - Examples: a static mutable field, a database, a file system.
- Private dependency: a dependency that is not shared.
- Out-of-process dependency: a dependency that runs outside the application's execution process. This type of dependency can be a shared dependency or private dependency
  - Examples:
    - Shared Out-of-Process Dependency: a database used by both tests
    - Private Out-of-Process Dependency: a database that runs isolated in a container.
- Volatile dependency: a dependency that either 
  1. introduces a requirement to set up and configure a runtime environment in addition to what's installed on the developer's machine (e.g. databases and APIs) or
  2. contains nondeterministic behavior (e.g. a random number generator).

Shared and volatile dependencies can overlap. For example, a dependency on the database is both shared and volatile. The file system is not volatile because it behaves deterministically in most cases. However, the file system is shared because it introduces a means by which the unit tests can interfere with each other's execution context. A random number generator isn't shared because you can supply a separate instance to each test; however, it is volatile.

| Dependency            | Shared | Volatile |
|-----------------------|--------|----------|
| Database              | Yes    | Yes      |
| File System           | Yes    | No       |
| Random Number Generator | No     | Yes      |


Shared dependencies decrease execution speed. Since the necessity to run quickly is the second attribute of the unit test definition, calls to shared dependencies fall out of the realm of unit testing and fall into the area of integration testing.

The classical approach views unit testing as isolating the unit tests themselves from each other. Isolating unit tests from each other entails isolating the class under test from dependencies only. Private dependencies can be kept intact.

<img src='img/20240258-045805.png' width=600px>

The following table sums up the difference between the London and Classical styles of unit testing. The London school views unit testing as isolation of the system under test from its collaborators. The classical school views unit testing as isolation of unit tests themselves from each other.

<img src='img/20240244-044411.png' width=700px>

### The London approach or the Classical approach?

In the chapters that follow, the author discusses that the most important attribute of a unit test is its resistance to refactoring. To achieve resistance to refactoring, you must decouple the unit test from its implementation details.

The London school advises mocking for all intra-system and inter-system dependencies. When mocking intra-system dependencies, there becomes a reliance on implementation details, as the end user doesn't care about private classes or private functions; the end user just needs to verify the result. Mocking intra-system dependencies leads to fragile tests (false positives).

With this concept in mind, the author advises for the Classical approach so that mocks are only established for dependencies that are external to the application. Dependencies for intra-system communications are not mocked in the Classical approach.

## The Anatomy of a Unit Test

A unit test tests a single unit of behavior, not a single unit of code.

Unit tests are structured using the arrange, act, and assert (AAA) pattern. In the arrange section, you bring the system under test (SUT) and its dependencies to a desired state. In the act section, you call methods on the SUT and capture the output value. In the assert section, you verify the outcome.

The arrange section is the largest section in terms of code.

The act section is typically one line of code. If you have more than one line in the act section, it is a sign of a problem with the SUT's API, which indicates that two actions must always be performed together, which can lead to inconsistencies.


## The Four Pillars of a Good Unit Test

A good unit test has the following four attributes:

1. Protection against regressions
2. Resistance to refactoring (most important)
3. Fast feedback
4. Maintainability

There is always a tradeoff between the first three pillars.

### 1. Protection against regression

A regression (i.e. a software bug) refers to a situation where a previously functioning feature  stops working after changes. With regard to protection against regression, here are a few points to keep in mind:

`To maximize the metric of protection against regression, the test needs to aim at exercising as much code as possible.`

- The larger the amount of code that gets executed, the higher the chance that the test will reveal a regression.
- The complexity and domain significance is also important. Code that represents complex business logic is more important than boilerplate code.
- It's rarely worthwhile to test trivial code. Trivial code does not contain a substantial amount of business logic and won't provide much chance of finding a regression error.

Protection against regressions is a measure of how good the test is at indicateing the presence of bugs (regressions). The more code the test executes (both your code and the code of libraries and frameworks used in the project), the higher the chance the test will reveal a bug.

### 2. Resistance to refactoring

Resistance to refactoring is the degree to which a test can sustain application code refactoring without producing a false alarm.

`To maximize the metric of resistance to refactoring, aim at the end result instead of implementation details.`

Refactoring means changing existing code without modifying its observable behavior. The intention of refactoring is usually to increase readability and reduce complexity. Resistance to refactoring is the degree to which a test can sustain a refactoring of the underlying application code without turning red (failing).

#### About false positives

False positives in unit tests that result from refactoring interfere with the benefits of units tests in the following ways:

1. They dilute your ability and willingness to react to problems in code. Over time, you get accustomed to failures and stop paying attention. After a while you start ignore legitimate failures, too.
2. When false positives are frequent, you lose trust in the test suite. This lack of trust leads to fewer refactorings, because you try to reduce code changes to a minimum to avoid regressions.

The only way to reduce false positives is to decouple the test from the implementation details. You need to make sure the test verifies the end result the SUT delivers: its observable behavior, not the steps it takes to do that test. Tests should approach SUT verification from the end user's point of view and check only the outcome meaningful to that end user. Everything else must be disregarded.

The best way to structure a test is to make it tell a story about the problem domain. Should a test fail, it means there's a disconnect between the story and the actual application behavior. All other tests are just noise that steer your attention away from things that matter.

Good unit tests focus on the end result. Bad unit tests focus on the implementation details.

<img src='img/20240158-045854.png' width=700px>

### 3. Fast feedback

Fast tests are an essential property of a unit test. The faster the tests, the more of them you can have in your test suite and the more often you can run them.

Slow tests delay feedback and discourage you from running them often.

Unit tests, by their isolated nature, are fast tests as compared to other types of tests, e.g. integration tests.

### 4. Maintainability

The ability to maintain a unit test has two components:

1. How hard is it to understand the test
2. How hard is it to run the test

Understand the test is related to the size of the test. The fewer lines of code, the more readable the test is (assuming you don't try to compress the code artificially to reduce the line count). The quality of the test code matters. Don't cut corners when writing tests; treat the test code as a first-class citizen.

The test may be hard to run if it relies on out-of-process dependencies. For example, you may have to spend time keeping the dependencies operational, e.g. reboot the database server, resolve network connectivity issues.

### Determining Test Value

A test's value is the product of each of the four unit test pillars/attributes:

1. Protection against regressions
2. Resistance to refactoring
3. Fast feedback
4. Maintainability

If a test gets zero in one of the attributes, then the test value's result is zero.

The first three attributes are mutually exclusive. This makes it impossible to get a maximum score in all four attributes. End-to-end tests, test the whole system and its dependencies and therefore do not have fast feedback. Brittle tests yield many false positives and therefore have low resistance to refactoring. Trivial tests aren't comprehensive enough to catch regressions.

<img src='img/20240150-045006.png' width=500px>

When needing to prioritize, resistance to refactoring is non-negotiable because whether a test possesses this attribute is mostly a binary choice: the test either has resistance to refactoring or it doesn't. The trade-off between the attributes comes down to choice between protection against regressions and fast feedback.

Tests must focus on the "what", not the "how"!

## Mocks and Test Doubles

A test double is an overarching term that describes all kinds of non-production-ready, fake dependencies to facilitate testing. There are five variations of test doubles: dummy, stub, spy, mock, and fake.

The five variations of the test doubles can be grouped into two types: mocks and stubs.

- Mock: emulate outbound interactions, i.e. calls from the system under test to its dependencies that change the state of those dependencies.

- Stub: emulate incoming interactions, for example calls that the system under test makes to get data. A stub is used to provide predetermined responses to calls made during the test. Stubs return fixed values and are programmed with simple logic to respond to different inputs in a controlled manner. However, they do not contribute to business logic and have no side effects. Example: if a method requires data from a database to proceed, a stub can be used to simulate database responses without connecting to an actual database.

### Other Test Double Types

An important distinction between a mock and a stub is that mocks help to _emulate_ and _examine_ interactions between the system under test (SUT) and its dependencies, while stubs only help to emulate those interactions. 

<img src='img/20240124-052423.png' width=600px>

The other test types are closely related to Mocks and Stubs:

- Spy: serves the same role as a mock, except that spies are written manually, whereas mocks are created with the help of a mocking framework. People refer to spies as handwritten mocks. Just like a spy in real life, a spy in software testing is used to gather information about function calls. It keeps track of the function it wraps and records behavior, but unlike a mock, it does not replace the functionality of the thing it is spying on.

- Dummy: a dummy is the simplest form of a test double. Its primary purpose is to fill parameter lists where an object is required but not actually used. Dummies do not have any implemented functionality. They are merely placeholders and do not contribute to test logic. 

- Fake: a fake is a more sophisticated and have working implementations, but usually take shortcuts and are not suitable for production. Unlike dummies or stubs, fakes perform some kind of useful logic or simulation. However, their implementation might be overly simplified or not adhere to production standards. An in-memory database to simulate database operations is a common usage of a fake. It behaves like a database but is lighter and faster, albeit less accurate and reliable compared to a real database.

**NOTE**: The term _mock_ is overloaded and can mean different things. You can use a mock (the tool) to create a test double (mock or stub). For example, in PowerShell you use the `mock` command to create a mock for function calls.

### Asserting interactions with stubs

Never assert interactions with stubs!

A call from a stub is not a part of the end result the system under test (SUT) produces. Such a call is only a means to produce the end result: a stub provides input from which the SUT then generates output.

Asserting interactions with stubs is an anti-pattern that leads to fragile tests. The only way to avoide fragile tests (false positives) and thus improve resistance to refactoring in tests is to make those tests verify the end result.

The process of verifying things that aren't part of the end result is also called _over-specification_. Most commonly, overspecification takes place when examining interactions. Checking for interactions with a stub is a flaw that's quite easy to spot because tests shouldn't check for _any_ interactions with stubs.

Mocks are a more complicated subject:  not all uses of mocks lead to test fragility, but a lot of them do.

#### Observable Behavior vs Implementation Detail

To improve the fragility of tests, the tests themselves must focus on the "what", not the "how". The "how" is the implementation detail.  The "what" is observable behavior.

All production code can be categorized along two dimensions:

- Public API vs private API
- Observable behavior vs implementation details

For a piece of code to be part of observable behavior, it has to do two of the following things:

- Expose an operation that helps the client achieve one of its goals. An _operation_ is a method that performs or incurs a side effect or both.
- Expose a state that helps the client achieve one of its goals. _State_ is the current condition of the system.

Any code that does neither of these things is an _implementation detail_.

Well-designed code is code whose observable behavior coincides with the public API and whose implementation details are hidden behind the private API. A code _leaks_ implementation detail when its public API extends beyond the observable behavior.

### Intra-System and Inter-System Communications

There are two types of communications in an application: intra-system communications and inter-system communications. Intra-system communications are implementation details. Inter-system communications are observable behavior, with the exception of external systems that are accessible only through your application. In the exception case, interactions with external systems are implementations details too, because the resulting side effects are not observed externally.

Using mocks to assert intra-system communications leads to _fragile_ tests. Mocking is legitimate only when it's used for inter-system communications&mdash;communications that cross the application boundary&mdash;and only when the side effects of those communications are visible to the external world.

<img src='img/20240214-051425.png' width=600px>

## The Styles of Unit Testing

There are threes styles of unit testing:

- Output-based testing
- State-based testing
- Communication-based testing

### Output-Based Style

The _output-based_ style of unit testing is where you feed an input into the system under test (SUT) and check the output it produces. This style of unit testing is only applicable to code that doesn't change a global or internal state, so the only component to verify is its return value.

<img src='img/20240231-043122.png' width=600px>

The output-based style of unit testing is also known as _functional_. This name takes root in _functional programming_, a method of programming that emphasizes a preference for side-effect-free code.

### State-Based Style

The _state-based_ style is about verifying the state of the system after an operation is complete. The term _state_ can refer to the SUT itself, or one of its collaborators, or an out-of-process dependency, such as the database or file system.

<img src='img/20240234-043454.png' width=600px>

### Communication-Based Style

The _communication-based_ style uses mocks to verify communications between the SUT and its collaborators.

<img src='img/20240237-043725.png' width=600px>

### Comparing the Three Styles of Unit testing

Output-based unit tests are preferred over state-based and communication-based unit tests. Output-based tests are easier to maintain because (1) they contain less code and (2) they do not rely on out-of-process dependencies.

<img src='img/20240243-044355.png' width=500px>

However, the output-based style of unit testing is only applicable to code that is written in a functional way, which is rarely the case for most object-oriented languages.

### Understanding Functional Architecture

Functional programming is programming with mathematical functions. A mathematical function is a function (or method) that doesn't have any hidden inputs or outputs. All inputs and outputs of a mathematical function must be explicitly express in its _method signature_, which consists of the method's name, arguments, and return type. A mathematical function produces the same output for a given input regardless of how many times it's called.

Mathematical functions are the only type of methods where you can apply output-based testing, which has the best maintability and the lowest chance of producing a false positive.

Hidden inputs and outputs make the code less testable (and less readable, too). Types of hidden inputs and outputs include:

- Side effects: A _side effect_ is an output that isn't expressed in the method signature and, therefore, is hidden. An operation creates a side effect when it mutates the state of a class instance, updates a file on the disk, etc.

- Exceptions: When a method throws an exception, it creates a path in the program flow that bypasses the contract established by the method's signature. The thrown exception can be caught anywhere in the call stack, thus introducing an additional output that the method signature doesn't carry.

- A reference to an internal or external state: For example, a method can get the current date and time using a static property such as DateTime.Now. It can query data from the database, or it can refer to a private mutable field. These are all inputs to the execution flow that aren't present in the method signature and, therefore, are hidden.

**NOTE:** The goal of functional programming is not to elimate side effects but rather to introduce a separation between code that handles business logic and code that incurs side effects.

Functional architecture separates business logic from side effects by pushing those side effects to the edges of a business operation. The separation between business logic and side effects is done by segregating two types of code:

- Code that makes a decision - this code doesn't require side effects and thus can be written using mathematical functions
- Code that acts upon that decision - this code converts all the decisions made by the mathematical functions into visible bits, such as changes in the database or messages sent to a bus.

The code that makes decisions is also known as the _functional core_ (or _immutable core_). The code that acts upon those decisions is a _mutable shell_.

<img src='img/20240239-043940.png' width=500px>

The functional core and the mutable shell cooperate in the following way:

- The mutable shell gathers all inputs
- The functional core generates decisions
- The shell converts those decisions into side effects

To maintain proper separation you need to make sure the classes representing the decisions contain enough information for the mutable shell to act upon them without additional decision-making. In other words, the mutable shell must be as dumb as possible. The goal is to cover the functional core extensively with output-based tests and leave the mutable shell to a much smaller number of integration tests.


