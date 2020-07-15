# token

SQL input consists of a sequence of *commands*. a *command* is composed of a sequence of *tokens*, terminated by a semicolon `;`.

a *token* can be a *keyword*, an *identifier*, a *quoted identifier*, a *literal* (or *constant*), or a special character symbol. *tokens* are normally separated by whitespace (space, tab, newline), but need not be if there is no ambiguity.

## keywords and identifiers


*keywords* have a fixed meaning in the SQL language. *identifiers* name objects, so they are often called *name*.

SQL identifiers and key words must begin with a letter (a-z) or an underscore `_`. subsequent characters in an identifier or key word can be letters, underscores, digits (0-9), or dollar `$`. `$` is not allowd in identifiers according to the letter of the SQL standard, so their use might render applications less portable. **the SQL standard will not define a keyword that contains digits or starts or ends with an underscore, so identifiers of this form are safe against possible conflict with future extensions of the standard.**

the system uses no more than `NAMEDATALEN -1` bytes of an identifier; longer names can be written in commands, but they will be *truncated*. by default, `NAMEDATALEN` is 64, so the maximum identifier length is 63. **it can be raised by changing the `NAMEDATALEN` constant in `src/include/pg_config_manual.h`**.

*keywords* and *unquoted identifiers* are *case insensitive*.

there is a second kind of identifier: the *delimited identifier* or *quoted identifier* using double quotes `"`. a *delimited identifier* is always an identifier, **never** a key word. so "select" could be used to refer to a column or table named "select", whereas an unquoted *select* would be taken as a keyword and therefore provoke a parse error.

*quoted identifiers* can contain any character, except the character with code *zero*. to include a double quote, write *two double quotes*. this allows constructing table or column names that would otherwise not be possible, such as one containing spaces or ampersands. **the length limitation still applies.**

*quoted identifiers* also makes it case-sensitive, whereas unquoted names are always folded to **lower case**. but SQL standard says that quoted identifiers should be folded to **upper case**.

## constants

there are three kinds of *implicitly-typed constants*: `strings`, `bit strings`, and `numbers`. constants can also be specified with explicit types.

### string constants

a string constant in SQL is an arbitary sequence of characters bounded by *single quotes `'`*. to include a single-quote character within a string constant, write two adjacent single quotes, e.g., 'dianne''s horse'.

postgresql also accepts *escape* string constants. an escape string constant is specified by writing the letter `E` (upper or lower case) just before the opening single quote, e.g., `E'foo'`. within an escape string, a backslash character `\\` begins a C-like backslash escape sequence.

backslash escape sequences:

* `\b` - backspace
* `\f` - form feed
* `\n` - newline
* `\r` - carrige return
* `\t` - tab
* `\o`, `\oo`, `\ooo` (o = [0-7]) - octal byte value
* `\xh`, `\xhh` (lower x and h in [0-9a-fA-F]) - hexadecimal byte value
* `\uxxxx`, `\Uxxxxxxxx` (notice difference between lower u and upper U and x in [0-9a-fA-F]) - 16 or 32-bit hexadecimal unicode character value

any other character following a backslash is taken literally. to include a backslash character, write two backslashed. and a single quote can be included in an escape string by writing `\'`, in addition to the normal way of `''`.

the unicode escape syntax works fully only when the server encoding is `UTF8`.

### bit-string constants

bit-string constants look like regular constants with a `B` or `b` immediately before the opening quote, e.g., B`1001`. the only characters allowed within bit-string constants are `0` and `1`.

alternatively, bit-string constants can be specified in hexadecimal notation, using a leading `X` or `x`, e.g., X`1FF`. this notation is equivalent to a bit-string constant with four binary digits for each hexadecimal digit.

### numeric constants

numeric constants are accepted in these general forms, where digits is one or more decimal digits (0 throught 9).

    digits => 42
    digits.[digits][e[+-]digits] => 42. 42.4 42e-3 42.4e3
    [digits.][digits][e[+-]digits] .42e3 .42.e-3
    digitse[+-]digits 42e3 42e-3

**note** any leading plus or minus sign is not actually considered part of the constant; it is an operator.

a numeric constant that contains neither a decimal point nor an exponent is initially presumed to be type `integer` if its value fits in type `integer` (32 bits); otherwise it is presumed to be type `bigint` if its value fits in type `bigint` (64 bits); otherwise it is taken to be type `numeric`. constants that contain decimal points and/or exponents are always initially presumed to be type `numeirc`. you can force a numeric value to be interpreted as a specific data type by casting it. e.g., force a numeric value to be treated as type `real` (float4) by writing:

    real '1.23' -- string style
    1.23::real  -- historical style

### constants of other types

a constant of an arbitrary type can be entered using one of the following notations:

    type 'string'
    'string'::type
    cast ('string' as type)

it is also possible to specify a type coercion using a function-like syntax:

    typename ('string')

but not all type names can be used.
