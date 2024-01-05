# Unit Testing Notes

This page covers my learnings on unit testing. Most of the material on this page comes from the book "Unit Testing: Principles, Practices, and Patterns" by Vladimir Khorikov.

<details open><summary>The Goal of Unit Testing</summary>

## Goal of Unit Testing

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

The most difficult part of unit testing is achieving maximum value with minimum maintenance costs.

</details>






