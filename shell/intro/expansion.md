# expansion

## pathname expansion

the mechanism by which wildcards work is called *pathname expansion*.

* `?` - any one character
* `*` - any characters
* `[]` - any one character in set `[]`
* `[!]` - any one character, except in `[!]`, `[^]` in some shell may also work
* `[[:class:]]` - any one character of the specified class

## tilde expansion

when `~` is used at the beginning of a word, it expands into the name of the home directory of the name user, or if no user is named, the home directory of the current user.

## arithmetic expansion

the shell allows arithmetic to be performed by expansion:

    echo $((2+2)) -> 4

arithmetic expansion users the form:

    $((expresion))

where expression is an arithmetic expression consisting of values and arithmetic operations.arithmetic expansion only supports integers, but can perform quite a number of different operations:

    + - * / % **

spaces are not significant in arithmetic expressions and expressions may be nested:

    echo $(($((5**2)) * 3))

single parentheses may be used to group multiple subexpressions, so we can do like this:

    echo $(((5**2) * 3))

## brace expansion

we can create multiple text strings from a pattern containing braces:

    echo front-{a,b,c}-back

    will be

    front-a-back front-b-back front-c-back

patterns to be brace expanded may contain a leading portion called a *preamble* and a trailing portion called a *postscript*. the brace expression it self may contain either a comma-separated list of strings, or a range of integers or single characters. the pattern may not contain embeded whitespace.

    echo {1..5} -> 1 2 3 4 5

intergers may also be zero-padded:

    echo {01..05} -> 01 02 03 04 05

or:

    echo {z..a}

    echo a{A{1,2},B{3,4}}b

## parameter expansion

like `echo $USER` or `echo ${USER}`.

## command substitution

*command substitution* allows us to use the output of a command as an expansion:

    echo $(ls)

`` echo `ls` `` is an alternate systax for command substitution in older shell programs which is also supported in `bash`.


## quoting

quoting can suppress unwanted expansions.

### double quotes

if we place text inside double quotes, all the special characters used by shell lose their special meaning and are treated as ordinary characters. the exceptions are `$`, `\`, and `````. this means that *word-spliting*, *pathname expansion*, *tilde expansion*, and *brace expansion* are suppressed, but *parameter expansion*, *arithmetic expansion*, and *command substitution* are still carried out.

### single quotes

single quotes will suppress all expansions.
