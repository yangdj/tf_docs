# strings and numbers

## parameter expansions

* `$a` - becomes whatever the variable `a` contains when expanded. simple parameters may also be surrounded by braces `${a}`.
* `${parameter:-word}` - if `parameter` is unset (i.e., does not exist) or is empty, this expansion results in the value of word. if parameter is not empty, the expansion results in the vvalue of `parameter`.
* `${parameter:=word}` - if `parameter` is unset or empty, this expansion results in the value of `word`. in addition, the value of `word` is assigned to parameter. if `parameter` is not empty, the expansion results in the value of `parameter`.
* `${parameter:?word}` - if `parameter` is unset or empty, this expansion causes the script to exit with an error, and the contents of `word` are sent to standard error. if `parameter` is not empty, the expansion results in the value of `parameter`.
* `${parameter:+word}` - if `parameter` is unset or empty, the expansion results in nothing. if `parameter` is not empty, the value of `word` is substituted for `paramter`; however, the value of parameter is not changed.

`bash` also has the ability to return the names of variables:

* `${!prefix*}`
* `${!prefix@}`

this expansion returns the names of existing varaibles with names beginning with `prefix`.

## string expansions

* `${#parameter}` - expands into the length of the string contained by `parameter`. normally, `parameter` is a string; however, if `parameter` is either `@` or `*`, then expansion results in the number of positional parameters.
* `${paramter:offset}`, `${parameter:offset:length}` - extracts a portion of the string contained in `parameter`. the extraction begins at `offset` characters from the beginning of the string and continues until the end of the string, unless the `length` is specified. if the `offset` is negative, it is taken to mean it starts from the end of the string rather than the beginning. note that negative values must be preceded by *a space to prevent confusion with the `${parameter:-word}` expansion*. `length`, if present, must not be less than zero. if `parameter` is `@`, the result of expansion is `length` positional parameters, starting at `offset`.
* `${parameter#pattern}`, `${parameter##pattern}`  - removes a leading portion of the string contained in `parameter`define by `pattern`. `pattern` is a *wildcard* pattern like those used in *pathname expansion*. the difference in the two forms is that `#` form removes the *shortest* match, while the `##` form removes the *longest* match.
* `${parameter%pattern}`,  `${parameter%%pattern}` - same as `#` and `##` expansion, except they remove text from the end of string contained in `parameter` rather than from the beginning.
* `${paramter/pattern/string}`, `${paramter//pattern/string}`, `${paramter/#pattern/string}`, `${paramter/%pattern/string}`  - performs a search-and-replace upon the contents of `parameter`. if text is found matching wildcard `pattern`, it is replaced with the contents of `string`. in the normal form, only the first occurence of `pattern` is replaced. in the `//` form, all occurences are replaced. the `/#` form requires that match occur at the beginning of the string, and `/%` form requires the match to occur at the end of the string. `/string` may be ommited, which causes the text matched by `pattern` to be *deleted*.

case conversion

the `declare` command can be used to normalize strings to either upper or lowercase. using `declare`, we can force a variable to always contain the desired format no matter what is assigned to it:

    declare -u upper-varaible-name
    declare -l lower-variable-name

there are also parameter expansions performing upper and lowercase conversion:

* `${parameter,,}` - expands the value of `parameter` into all lowercase
* `${parameter,}` - expands the value of `parameter` changeing only the first character to lowercase
* `${parameter^^}` - expands the value of `parameter` into all uppercase letters
* `${parameter^}` - expands the value of `parameter` changeing only the first

## arithmetic expansions

the basic form is `$((expression))`. where `expression` is a valid arithmetic expression. `(( ))` is also related to compound command, used for arithmetic evaluation (truth tests).

### number bases

* `number` - by default, numbers without any notation are treated as decimal (base 10) integers
* `0number` - in arithmetic expressions, numbers with a leading zero are considered octal
* `0xnumber` - hexadecimal notation
* `base#number` - `number` is in `base`

### arithmetic operator

there are two unary operators, the `+` and `-`, which are used to indicate if a number is positive or negative, respectively.

others are:

* `+` - addition
* `-` - subtraction
* `*` - multiplication
* `/` - division
* `**` - exponentiation
* `%` - modulo (remainder)

since the shell's arithmetic only operates on integers, the results of division are always whole numbers.

### assignment

you can use:

* `parameter = value`
* `parameter += value`
* `parameter -= value`
* `parameter *= value`
* `parameter /= value`
* `parameter %= value`
* `parameter++`
* `parameter--`
* `++parameter`
* `--parameter`

`bash` does not support `parameter **= value` assignment.

### bit operations

bitwise operators treat their operands as a sequence of 32 or 64 bits integer, depending on the machine used. you can use `~0` to test the default bits used. for 64 bits, the right operand should be less than 64, but if not only the lower 6 bits will be used; for 32 bits, only the lower 5 bits will be used.

* `~` -  bitwise negation
* `<<` - left bitwise shift. shift all the bits in a number to the left
* `>>` - right bitwise shift. shift all the bits in a nuber to the right
* `&` - bitwise `and`
* `|` - bitwise `or`
* `^` - bitwise `xor`

there are also corresponding assignment operators ( for example, `<<=`) for all but bitwise negation.

### logic and relational operatations

there are:

* `<=`
* `>=`
* `>`
* `<`
* `==`
* `!=`
* `&&`
* `||`
* `expr1?expr2:expr3` - only works for arithmetic expressions, strings won't work

### `bc`

you can use `bc` for floating point number operations, and use *here documents*, *here string* and *pipes* to perform calculation.

    bc <<< "2 + 3.5"

    echo 2 + 3.5 | bc

    bc <<-_EOF_
       2 + 2.5
       3 - 1.5
   _EOF_
