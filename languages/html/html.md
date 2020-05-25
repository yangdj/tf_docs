## html

all HTML documents have a required structure inlcuding:

* `<!DOCTYPE html>` - informs web browsers which version of HTML is being used, this is the latest version.

* `<html>`  - signifies the beginning of the document.

* `<head>` - identifies the top of document, including any metadata. the content inside the `<head>` is not displayed on the web page itself, has links to any external files, and any other benificial metadata.
    * `<meta charset="UTF-8">` - define the document's encoding
    * `<title>your-title</title>` - displayed on the title bar in the browser window

* `<body>` - displays all of the visible content.

e.g., 

    <!DOCTYPE html>
    <html lang="zh-Hans">
    <head>
        <meta charset="UTF-8">
        <title>hello world</title>
    </head>
    <body>
        <p>hello, world!</p>
    </body>
    </html>

### syntax

* `<!-- ... -->` - comments for html
* `/* ... */` - comments for css

### special characters

each character begin with an ampersand(&) ,and ends with a semicolon(;).

* `&ndash;` - `-`
* `&copy;` - `c`
* `&eacute;`
* `&#60;` - `<`
* `&#62;` - `>`

for `url`:

* `%20` - space

### elements

#### self-closing elements

* `<meta>`
* `<embed>`
* `<br>`
* `<hr>`
* `<param>`
* `<source>`
* `<wbr>`
* `<link>`
* `<img>`
* `<input>`

#### text-based elements

* `<h1>` 
* `<h2>`
* `<h3>`
* `<h4>`
* `<h5>`
* `<h6>`
* `<p>`
* `<strong>`
* `<em>`
* `<small>`
* `<cite>` - refer to a creative work, author, or resource
* `<q>` - for short, inline quotations
* `<blockquote>` - for longer external quotations and is a block-level element

#### structure-based elements

these are introduced since HTML5, and are all block-level elements and do not have any implied position or style.

* `<header>`
* `<nav>`
* `<article>`
* `<section>`
* `<aside>`
* `<footer>`

#### lists

*  unordered lists

        <ul>
            <li>orange</li>
            <li>green</li>
            <li>blue</li>
        </ul>

* ordered lists
    * `start=""` - defines the number from which an ordered list should start
    * `reversed` - boolean value, appear in reversed order
    * `value=""` - change its value within the list

        <ol>
            <li>left</li>
            <li>middle</li>
            <li>right</li>
        </ol>

        <ol start="30" reversed>
            <li>left</li>
            <li value="40">middle</li>
            <li>right</li>
        </ol>

* description lists

        <dl>
            <dt>apple</dt>
            <dd>...</dd>
            <dt>pear</dt>
            <dd>...</dd>
            <dt>grape</dt>
            <dd>...</dd>
        </dl>

#### reference elements

* `<link>` - define the relationship between the HTML file and other files.
    * `rel=`
        * `stylesheet`
        * `shortcut icon` - for page collection. the icon always has suffix `.ico`
    * `href=""` - specify file's location

        <link rel="stylesheet" href="main.css" />
        <link rel="shortcut icon" href="http://hello.icon" />
* `<script>` - load js file:
    * `src=""` - specify file's location

            <script src="hello.js"></script>
* `<a>` - in HTML5, anchor elements can wrap either block-, inline-, or any other level elements.
    * `href=""`
        * `a.html`
        * `#top`
        * `https://www.google.com`
        * `mailto:hello@google.com`
    * `target=""` 
        * `_blank` - opens a link in a new window

        <a href="https://www.google.com">google</a>
        <a href="mailto:hello@google.com?subject=test&body=how%20are%20you">mail</a>
        <a href="http://www.google.com" target="_blank">google</a>

* `<img>` - add images to a page:
    * `src="test.jpg"`
    * `alt="image title"`

the most commonly supported formats online for images are *gif*, *jpg*, and *png*. of these, the most widely used formats today are *jpg* and *png*. the *jpg* format provides quality images with high color counts while maintaining a decent file size, ideal for faster load times. the *png* format is great for images with transparencies for lower color counts. we most commonly see *jpg* images used for photographs and *png* images used for icons or background patterns.

* `<iframe>` - embed another HTML page within the current page, you can set attributes:
    * `src=""` - document's url

* `<figure>` - identify and wrap self-contained content. it may surrounds images, audio clips, videos, block of code, and so on. `<figcaption>` element is to add a caption or legend to the `<figure>` element. `<figcaption>` may replace an `<img>` element's `alt` attribute if the `<figcaption>` element provides a useful description of the visual content of the image.

        <figure>
            <img src="dog.jpg">
            <figcaption>A beautiful black, brown, and white hound dog wearing kerchief.</figcaption>
        </figure>

#### forms

* `<form>` - add a form to a page and idtentify where on the page control elements will appear and wrap all of the elements included within the form, much like a `<div>` element. 
    * `action=""` - contains the URL to which information included within the form will be sent for processing by the server
    * `method=""` - is the HTTP method browsers should use to submit the form data
        * `get`
        * `post`

        <form action="/login" method="post">
            ... 
        </form>

* `<input>` - for information input.
    * `type=""` - input type
        * `text` - a single line of text input
        * `password`
        * `radio` - radio buttons permit users to select one option from a small list of options 
            * `name=""` - must be defined and have the same value
            * `value=""` - must be defined
            * `checked` - boolean value, preselect a radio button
        * `checkbox` - similar to radio buttons. they use the same attributes and patterns and allow users to select multiple values and tie them all to one control name, while radio buttons limit users to one value.
        * `submit` - submit form values
            * `value=""` - specify the text that appears within the button
        * `hidden` - pass data to the server without displaying it to users
        * `file` - add a file to a form


        <input type="text" name="username">

        <input type="radio" name="day" value="friday" checked>Friday
        <input type="radio" name="day" value="saturday">Saturday
        <input type="radio" name="day" value="sunday">Sunday

        <input type="checkbox" name="day" value="friday" checked>Friday
        <input type="checkbox" name="day" value="saturday">Saturday
        <input type="checkbox" name="day" value="sunday">Sunday

        <input type="submit" name="submit" value="Send">

        <input type="hidden" name="tracking-code" value="abc-123">

the `type` can also have the following value for html5:

    * `color`
    * `date`
    * `datetime`
    * `email`
    * `month`
    * `number`
    * `range`
    * `search`
    * `tel`
    * `time`
    * `url`
    * `week`

* `<textarea>` - accept larger passages of text spanning multiple lines:
    * `cols=""` - for width in terms of the average character width
    * `rows=""` - for height in terms of the number of lines of visible text

        <textarea id="" name="" cols="30" rows="10">add your comment here</textarea>

* `<select` - for drop-down lists, provide users with a long list of options in a practical manner, used with `<option>`.
    * `name=""` - `name` attribute resides on the `<select>` element
    * `multiple` - boolean value, allow choosing more than one options
    * `<option>`
        * `value=""`
        * `selected` - boolean value, preselect an option

        <select id="select-1" name="day">
            <option value="friday" selected>Friday</option>
            <option value="saturday">Saturday</option>
            <option value="sunday">Sunday</option>
        </select>

        <select id="select-1" name="day" multiple>
            <option value="friday" selected>Friday</option>
            <option value="saturday">Saturday</option>
            <option value="sunday">Sunday</option>
        </select>


* `<button>` - perform the same way as the `<input>` element with the type attribute value of `submit`, but it includes opening and closing tags, which may wrap other elements. rather than using the `value` attribute to control the text within the submit button, the text that appears between the opening an closing tags of the `<button>` element will appear.

        <button name="submit">
            <strong>Send us</strong> a messaage
        </button>

* `label` - provide captions or heading for form controls
    * `for=""` - the value is the `id` attribute on the form control that label correspond to. matching up the `for` and `id` attribute values ties the two elements together, allowing users to click on the `<label>` element to bring focus on the proper form control.

        <label for="username">Username</lable>
        <input type="text" name="username" id="username">

the `<label>` element may wrap form control, such as radio buttons or check boxes. Doing so allows omission of the `for` and `id` attributes.

    <label><input type="radio" name="day" value="Friday">Friday</label>
    <label><input type="radio" name="day" value="Saturday">Saturday</label>
    <label><input type="radio" name="day" value="Sunday">Sunday</label>

* `fieldset` - a block-level element that wraps related elements, specifically within a `<form>` element, for better organization. by default, it inlcudes a border outline, which can be modified using css
    * `<legend>` - provide a caption, or heading, for the `<fieldset>` element, directly after the opening `<fieldset>` tag

        <fieldset>
            <label>Username<input type="text" name="username"></label>
            <label>Password<input type="text" name="password"></label>
        </fieldset>

        <fieldset>
            <legend>Login</legend>
            <label>Username<input type="text" name="username"></label>
            <label>Password<input type="text" name="password"></label>
        </fieldset>

* other attributes
    * `disabled` - turn off an element, so that it is not available for interation or input, and not sends any value to the server

    * `placeholder` - HTML5 attribute provides a hint or tip within the form control of an `<input>` or `<textarea>` element that disappear once the control is clicked in or gains focus.

    * `required` - HTML5 attribute enforces that an element or form control must contain a value upon being submitted to the server. currently, error message styles are controlled by the browser and cannot be styled with css. invalid elements and form controls, on the other hand, can be styled using the `:optional` and `:required` css pseudo-classes.

    * `accept`
    * `autocomplete`
    * `autofocus`
    * `formaction`
    * `formenctype`
    * `formmethod`
    * `formnovalidate`
    * `formtarget`
    * `max`
    * `maxlength`
    * `min`
    * `pattern`
    * `readonly`
    * `selectionDirection`
    * `step`
