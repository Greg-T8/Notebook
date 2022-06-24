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

### ID Selectors
- More precise than class selectors, as they target only one unique element at a time
- ID selectors use an element's `id` value as a selector
- `id` attribute values can only be used once per page. If used they should be reserved for significant elements
- ID selectors are denoted by a leading hash sign, `#`, followed by the `id` attribute value
- Example:  the ID selector will only select the element containing the `id` attribute value of `special`:  
  **CSS**
  ```css
  #special { ... }
  ```
  **HTML**
  ```html
  <div id="special">...</div>
  ```
### Additional Selectors
- The selectors above are the most common, but there are many more selectors
- See [Complex Selectors](https://learn.shayhowe.com/advanced-html-css/complex-selectors/)

## Referencing CSS
- Best practice for referencing style sheets is to include all styles in an external style sheet, which is referenced from within the `<head>` element.
- There are other options for referencing CSS using internal and inline styles, but they are generally frowned upon, as they make updating websites cumbersome
- Use the following code to reference a CSS stylesheet:
  ```html
  <head>
    <link rel="stylesheet" href="main.css">
  </head>
  ```
- In the code above, `rel` and `href` are attributes to the `link` element
- `href` stands for "hyperlink reference"
- The `rel` attribute defines the relationship between a linked resource and the current document. In this case `rel` imports a stylesheet. See [here](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel) for more info.
- The path referenced by `href` must correlate to where the CSS file is saved

## CSS Resets
- Every web browser has its own default styles for different elements, and it's important to recognize the value of cross-browser compatibility and testing
- CSS resets are used to ensure cross-browser compatibility
- CSS resets take every common HTML element with a predefined style and provide one unified style for all browsers
- CSS resets generally remove all sizing, margins, padding, or additional styles
- CSS resets need to be at the very top of the style sheet.  Doings so ensures those styles are read first and all of the different web browsers are working from the same baseline
- CSS reset examples
  - [Eric Meyer's reset](https://meyerweb.com/eric/tools/css/reset/)
    - adapted to include styles for the new HTML5 elements
  - [Normalize CSS](https://necolas.github.io/normalize.css/)
    - Focuses on setting common styles for common elements; requires a stronger understanding of CSS

