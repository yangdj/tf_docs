# pandoc markdown syntax

* title - start after a blank line
    * setext style
        * `===` leve1 one

                level one header
                ================

        * `---` level two

                level two header
                ---------------
    * atx style
        * `#` level one
        * `##` level two
        * `###` level three
        * `####` level four
        * `#####` level five
        * `#######` level six

* paragraph - start after a blank line. a line break rendered as a blank space, end with two spaces indicating a new line

* horizontal
    * `***`
    * `---`
    * `___`

* quote - start after a blank line, and can be nested
    * `> block quote`
    * `>> nested quote`

* inline
    * italics
        * `*italics*` 
        * `_italics_`

    * bold
        * `**bold**`
        * `__bold__`

    * strikethrough
        * `~~strikethrough~~`

    * superscript
        * `superscript^2^`

* link
    * `[link](www.path.com)`

* images
    * `![](path/to/image.png)`

* list
    * unordered - using `*`, `+`, `-`

            * item1
            * item2
            * item3

    * ordered

            1. item1
            2. item2
            3. item3

    * definition

            term1
            : definition 1

            term2
            : definition 2

* table
    * pipe style

            | right | left | default | center |
            |------:|:-----|---------|:-------|
            | 12    | 12   | 12      | 12     |
            | 123   | 123  | 123     | 123    |
