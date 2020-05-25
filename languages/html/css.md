## css

### selectors

selectors are based on:

* type - `div {...}`
* class `.awesome {...}`
* id - `#awesome {...}`
* universal - it's a good practice to also include the *pseudo-elements* in case they should ever appear. e.g., 

        *,
        *:before,
        *:after {
            -webkit-box-sizing: border-box;
               -moz-box-sizing: border-box;
                    box-sizing: border-box;
        }

selectors' specificity:

* type selector has the lowest weight and has a point value of `0-0-1`
* class selector has the medium weight and has a point value of `0-1-0`
* id selector has the highest weight and has a point value of `1-0-0`

### box model

**every element on a page is a rectangular box** and may have:

* width
* height
* margins
    * `margin: 10px` - set the same value for all four sides
    * `margin: 10px 20px` - `10px` for `top` and `bottom`, `20px` for `left` and `right`
    * `margin: 10px 20px 0 15px` - for `top`, `right`, `bottom` and `left`, moving clockwise
* borders
* paddings

`width` and `height` properties are not accepted by inline-level elements or any values tied to them. `top` and `down` are not accepted by inline-level elements for vertical margins. `padding` property works vertically on inline-level elements.

#### vender prefixes

the most common vender prefixes are:

* `-moz-` - Mozilla Firefox
* `-ms-` - Microsoft internet Explorer
* `-webkit-` - Webkit(Google Chrome and Apple Safari)

        div {
            -webkit-box-sizing: content-box;
               -moz-box-sizing: content-box;
                    box-sizing: content-box;
        }

#### box-sizing

css3 introduces the `box-sizing` property, it receives three primary values:

* `content-box` - the default value
* `padding-box` - have been deprecated and should not be used
* `border-box`

#### border

the `border` property requires three values: `width`, `style` and `color`. shorthand values for the border properties are in the order `width`, `style` and `color`: 

    6px solid #949599.

in longhand, these three values can be broken up into:

* `border-width=""`
* `border-style=""`
    * `solid`
    * `dotted`
    * `dashed`
    * `double`
    * `none`
* `border-color=""`.
* `border-radius=""`- round the corners of an element
    * `20%`
    * `20px`

### styles

* colors - four primary ways to represent color:
    * keywords - `red`, `green`, `blue`
    * hexadecimal - `#ff6600`, `#f60`
    * rgb - `rgb(128, 0, 0)`, `rgba(255, 102, 0, .5)`
    * hsl - `hsl(250, 100%, 25%)`, `hsla(250, 100%, 25%, .5)`

* lengths
    * absolute lengths
        * pixels is almost equal to `1/96` of an inch.
    * relative lengths
        * `%` - percentage defined in relation to the langth of another object, always its' parent element
        * `em` - calculated based on an element's font size. a single `em` unit is equivalent to an element's font size. when a font size is not explicitly stated for an element, the `em` unit will be relative to the font size of the closest parent element with a stated font size.

* `display: ` - determine how are elements are displayed:
    * `none` - completely hide an element and render the page as if that element does not exist
    * `inline`
    * `block`
    * `inline-block` - behave like a block-level element, accepting all box model properties, but display in line with other elements and will not begin on a new line by default. usually a small space will exist between two inline-block elements. there are two of the easiest ways to remove spaces between inline-block elements:

        section {
            display: inline-block;
        }

        <section>
            ...
        </section><section>
            ...
        </section><section>
            ...
        </section>

        or
        <section>
            ...
        </section><!--
        --><section>
            ...
        </section><!--
        --><section>
            ...
        </section>

* layout
    * `float: ` remove an element from the normal flow of a page, and position it to the left or right of its parent element. all other elements on the page will then flow around the floated element. if there isn't a parent element, the floated element will float all the way to the edge of the page.
        * `left`
        * `right`
    * `clear: ` - prevent content from wrapping around the floated elements
        * `left`
        * `right`
        * `both`

typical use for containing float which is knonw as a *clearfix* or *cf*:

    .group:before,
    .group:after {
        content: "";
        display: table;
    }

    .group:after {
        clear: both;
    }

    .group {
        clear: both;
        *zoom: 1;
    }

* `position: ` - identify how an element is positioned on a page and whether or not it will appear within the normal flow of a document.
    * `static` - the default value, exists in the normal flow of a document and do not accept any box offset properties.
    * `relative` - allow an element's postition to be modified with the box offset properties. the element will overlap the element below it rather moving that element down as the `margin` or `padding` properties would.
    * `absolute` - element will not appear within the normal flow of a document, and the original space and position of the absolutely positioned element will not be preserved. absolutely positioned elements are moved in relation to their closest relatively positioned parent element. should a relatively positioned parent element not exist, the absolutely positioned element will be positioned in relation to the `<body>` element.

you can change the offset using:

* top
* right
* bottom
* left

#### fonts

* `color: `

* `font-family: ` - declare which font and fallback or substitute fonts. the value contains multiple font names, all comma separated. font names consisting of two or more words need to be **wrapped in quotation marks**. the last font should be a keyword value, which will use the system default font for the specified type, most commonly either `sans-serif` or `serif`

        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif
* `font-size: ` - set the size of text using common length values
    * pixels
    * em
    * percentage
    * points

* `font-style: `
    * `normal`
    * `italic`
    * `oblique`
    * `inherit`.

* `font-variant: ` - sets text in small capitals
    * `normal`
    * `small-caps`
    * `inherit`.

* `font-weight: `
    * `normal`
    * `bold` 
    * `bolder` 
    * `lighter` 
    * `inherit` 
    
**it's better to use a numeric value for more specific control**. the numeric values are `100, 200, 300, 400, 500, 600, 700, 800, 900`. the `normal` maps to `400`, and `bold` maps to `700`. any numeric value below `400` will be fairly thin, and any value above `700` will be fairly thick, e.g., `font-weight: bold`, `font-weight: 700`.

* `line-height: ` - set the distance between two lines of text. 

the best practice for legibility is to set the `line-height` to around one and a half times our `font-size` value. this could be quickly accomplished by setting the `line-height` to `150%` or just `1.5`. however, if we're working with a baseline grid, having a little more control over our `line-height`, using pixels may be preferable. you can vertically center a single line of text within an element, using the same property value for the `line-height` and `height` properties, `btn {height: 22px; line-height: 22px;}`. this technique may be seen with buttons, alter messages, and other single-line text blocks.

* `font: ` 

all of the `font-`based properties listed before may be combined and rolled into one `font` property and shorthand value. the order of these property values should be as follows, from left to right: `font-style, font-variant, font-weight, font-size, line-height, font-family`. as a shorthand value, these property values are listed from left to right without use of commas, except for font names as the `font-family` property value uses commas. a forward slash `/`, separator is needed between the `font-size` and `line-height`. when using this shorthand value, every property values is optional except the `font-size` and `font-family` property values, e.g., `html {font: italic small-caps bold 14px/22px "Helvetica Neue", Helvetica, Arial, sans-serif;}`.

there are only a handful *web-safe* fonts, and they are:

* Arial
* Garamond
* Lucida Sans, Lucida Grande, Lucida
* Tahoma
* Trebuchet
* Courier New, Courier
* Georgia
* Palatino Linotype
* Times New Roman, Times
* Verdana

#### text

* `text-align: `
    * `left`
    * `right`
    * `center`
    * `justify`
    * `inherit`
* `text-decoration: ` - multiple values may be applied to an element by space-separating each keyword
    * `none`
    * `underline`
    * `overline`
    * `line-through`
    * `inherit`
* `text-indent: ` - indent the first line of text within an element. all common length values are available. positive values will indent text inward, while negative values will indent text outward.
* `text-shadow: ` - add a shadow or multiple shadows to text.
* `text-transform: `
    * `none`
    * `capitalize`
    * `uppercase`
    * `lowercase`
    * `inherit`
* `letter-spacing: ` - adjust the space between the letters on a page.
* `word-spacing: ` - adjust the space between words within element.
* `vertical-align: ` - work only with inline and table-cell elements not for block, inline-block, or any other levels
    * `top`
    * `middle`
    * `bottom`

#### background

* `background` - accept colors and images in shorthand form. the order of the shorthand `background` property commonly falls as `background-color`, `background-image`, `background-position` and `background-repeat`.
* `background-color` - set solid background colors
* `background-image` - use image
* `background-repeat: ` - repeat images
            * `repeat`
            * `repeat-x`
            * `repeat-y`
            * `no-repeat`
* `background-position` - controls the image position relative to the corner. the first value controls the horizontal offset, and the second value controls the vertical offset

        div {
            background-color: #b2b2b2;
        }

        div {
            background-image: url("alert.pgn");
            background-position: 20px 10px;
        }

#### lists

* `list-style-type: `  - set the content of a list item marker, containing
    * `none` - no list item
    * `disc` - a filled circle
    * `circle` - a hollow circle
    * `square` - a filled square
    * `decimal` - decimal numbers
    * `decimal-leading-zero` - decimal numbers padded by initial zeros
    * `lower-roman` - lowercase roman numerals
    * `upper-roman` - uppercase roman numerals
    * `lower-greek` - lowercase classical greek
    * `lower-alpha/lower-latin` - lowercase ASCII letters
    * `upper-alpha/upper-latin` - uppercase ASCII letters
    * `armenian` - traditional Armenian numbering
    * `georgian` - traditional Georgian numbering
* `list-style-position: ` - set the list item marker position
    * `outside` - outside of the list item marker, and do not allow any content to wrap below the list item marker
    * `inside` - in line with the first line of the `<li>` element and allows other content to wrap below as needed
    * inherit
* `list-style` - shorthand for `list-style-type` and `list-style-position`

        ul {
            list-style: circle inside;
        }

        ol {
            list-style: lower-roman;
        }
