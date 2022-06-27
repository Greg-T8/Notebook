# More on CSS
Reference
- https://learn.shayhowe.com/html-css/getting-to-know-css/

- Benefits of CSS
  - Allows for adding layout and design to web pages
  - Allow for sharing styles across elements and pages

## The Cascade
- Within CSS, call styles cascade from the top of a style sheet to the bottom, allowing different styles to be overwritten as the style sheet progresses
- Example:
  ```css
  p { 
    background: orange;
    font-size: 24px;
  }
  p {
    background: green;
  }
  ```
- In the example above, the paragraph selector that sets the background to `green` takes precedence in the cascade

### Cascading Properties
- The cascade also works with properties inside individual selectors
- In the example below, `green` takes precedence in the cascade
  ```css
  p { 
    background: orange;
    background: green;
  }
  ```

## Calculating Specificity
- Every selector in CSS has a specificity weight
- A selector's specificity weight, along with its placement in the cascade, identifies how its styles will be rendered
- In the [intro](index.md), I noted three main types of selectors: type selector, class selector, and id selector
- Here's how the selectors match up

  | Selector Type | Specificity Weight | Point Value |
  | - | - | - |
  | Type Selector | Lowest Specificity | 0-0-1
  | Class Selector | Medium Specificity | 0-1-0
  | ID Selector | High Specifictity | 1-0-0

- From the table above, specificity points are calculated using three columns
  - The first column counts the ID selectors, the second column counts class selectors, and the third column counts type selectors
  - The specificity point values are always hyphenated. More on that shortly.

- The higher the specificity weight of a selector, the more superiority the selector is given when a styling conflict occurs
  - If a paragraph element is selected using a type selector in one place and an ID selector in another, the ID selector will take precedence, regardless of where the ID selector appears in the cascade  
    **HTML**
    ```html
    <p id="food">...</p>
    ```
    **CSS**
    ```css
    # food { 
      background: green;
    }
    p {
      background: orange;
    }
    ```
  - In the example above, the paragraph will appear with a green value because the ID selector, `# food`, has a higher specificity weight

## Combining Selectors
- Combining selectors allows you to be more specific about which element or group of elements you can select
- Example: 
  - Paragraph element with class attribute of `hotdog`, the background color is brown
  - Paragraph element with class attribute of `mustard`, the background color is yellow  
  **HTML**
    ```html
    <div class="hotdog">
      <p>...</p>
      <p>...</p>
      <p class="mustard">...</p>
    </div>
    ```
    **CSS**
    ```css
    .hotdog p {
      background: brown;
    }
    .hotdog p.mustard {
      background: yellow;
    }
    ```
- The example above combines selectors in several ways
- When selectors are combined, they should be read from right to left
  - The selector farthest to the right is known as the *key selector* 
  - The key selector identifies exactly which element the styles will be applied to
  - Selectors to the left of the key selector serve as a prequalifier
- The first combined selector above, `.hotdog p`, combines two selectors: a class selector and a type selector
  - The key selector is a type selector targeting the paragraph elements
  - This type selector is prequalified with the class selector of `hotdog`
  - The full combined selector will only select paragraph elements that reside within an element with a class attribute of `hotdog`
- The second combined selector above, `.hotdog p.mustard`, includes three selectors: two class selectors and one type selector
  - The only difference between the second selector and the first selector is the addition of the class selector of mustard to the end of the paragraph type selector
  - The new class selector, `mustard`, falls all the way to the right of the combined selector. It is the key selector, and all the individual selectors before it are now prequalifiers
- Note: spaces are important
  - If the paragraph selector was removed, and the `mustard` class selector had spaces on both sides of it, then it would select any element with class of `mustard`, not just paragraphs
- <strong>Best Practice</strong>: Do not prefix a class selector with a type selector
  - Generally, you want to select any element with a given class, not just one type of element
  - Following this best practice, the new combined type selector would be better as `.hotdog .mustard`

### Specificity Within Combined Selectors
- When selectors are combined, so are the specificity weights of the individual selectors
  - The combined specificity weights are calculated by counting each different type of selector within a combined selector

- In the hotdog example above, the first selector `.hotdog p`, had both a class selector and a type selector
  - Knowing that the point value of a class selector is `0-1-0` and the point value of a type selector is `0-0-1`, the total combined point value is `0-1-1`
- The second selector, `.hotdog p.mustard` has two class selectors and one type selector, so the combined specificity point value is `0-2-1`
- If you were to flip the order of these selectors in the style sheet, the appearance of their styles would not be affected due to each selector's specificity weight
- In general it is good to keep an eye on specificity weight of your selectors.  The higher the specificity weights rise, the more likely the cascade is to break.


