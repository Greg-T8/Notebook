# Overview of HTML and CSS
Reference
- [ShayHowe.com](https://learn.shayhowe.com/html-css/)

## Common HTML Terms
- Elements - designators that define the structure and content of objects within a page
  - Examples: `<h1>` through `<h6>`, `<p>`, `<a>`, `<div>`, `<span>`, etc.
  - Some elements are self-closing, e.g. `<br`>, `<img>`
- Tags - the use of angle brackets surrounding an element
	- Occur in opening and closing tags
	- The content of an element falls in between the opening and closing tags
- Attributes - properties used to provide additional info about an element
	- Defined within the opening tag after an element's name
	- Attributes include a name and a value with an equals sign in between
	- Examples:  id, href, class
- Document structure
	- All HTML documents are required to have the following declaration and elements:  `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>`

## Common CSS Terms
- Selectors
  - Style HTML elements
  - Generally target an attribute value, e.g. `id` or `class`, or the type of an element, such as `<h1>` or `<p>`
  - Are followed w/ curly brackets, which encompasses the styles to be applied:
    ```css
    p { ... }
    ```
- Properties
  - Determines the styles that will be applied to that element
  - Property names fall after a selector, within curly brackets and immediately preceding a colon
  - Property examples: `background`, `color`, `font-size`, `height`
    ```css
    p {
      color: ...;
      font-size: ...;
    }
- Values
  - Determines the behavior of the property
  - Identified as the text between the colon and semicolon
    ```css
    p {
      color: orange;
      font-size: 16px;
    }
    ```

## Working with Selectors
- Selectors indicate which HTML elements are being styled
- There are several types of selectors:  Type Selectors, Class Selectors, ID Selectors, and more

### Type Selectors
- Target elements by their element type
- Example: type selector for `<div>` element:  
    **CSS**
    ```css
    div { ... }
    ```
    **HTML**
    ```html
    <div>...</div>
    <div>...</div>
    ```

### Class Selectors
- Allow for selecting an element based on the element's `class` attribute value
- More specific than type selectors as they target a particular group of elements rather than all elements of one type
- Allow for applying the same styles to different elements at once by using the same `class` value across multiple elements
- Within CSS, classes are denoted by a leading period, `.`, followed by the `class` attribute value
- Example: class selector that selects any element containing the `class` attribute value of `awesome`:  
  **CSS**
  ```css
  .awesome { ... }
  ```
  **HTML**
  ```html
  <div class="awesome">...</div>
  <p class="awesome>...</p>
  ```

