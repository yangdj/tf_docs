# regular expression

## grep

* `-i` - ignore case
* `-v` - invert match, print every line that does not contain a match
* `-c` - print the number of matches
* `-l` - print the nameo of each file that contains a match instead of the lines themselves
* `-L` - like the `-l` option, but print only the names of files that do not contain matches
* `-n` - prefix each matching line with the number of the line within the file
* `-h` - for multi-file searches, suppress the output of filenames

## metacharacters

* `^` - at the beginning of the line
* `$` - at the end of the line
* `.` - any character, having to be one and only one
* `[]` - contain any number of characters, and metacharacters lose their special meaning when placed within brackets, except for `^` and `-`. `^` is used to indicate negation when placed in the first in a `[]` expression, otherwise, it loses its special meaning and becomes an ordinary character in the set.
* `-` - used in `[]` to indicate a character range. when placed in the beginning of `[]`, it will lose its special meaning
* `{}`
* `*`
* `+`
* `?`
* `()`
* `|`
* `\\`

POSIX splits regular expression implementations into two kinds: *basic regular expressions (BRE)* and *extended regular expressions (ERE)*. their difference is just a matter of *metacharacters*.

with BRE, the following metacharacters are recognized and all other characters are considered liteals.

    ^ $ . [] *

with ERE, the following metacharacters (and their associated functions) are added:

    () {} ? + |

however, the `(`, `)`, `{`, and `}` characters are treated as metacharacters in BRE if they are escaped with a backslash, whereas with ERE, preceing any metacharacters with a backslash causes it to be treated as a literal.

`egrep` and `grep -E` supports extended regular expressions.

## POSIX character classes

* `[:alnum:]` - alphanumeric characters, in ASCII, equivalent to `[A-Za-z0=9]`
* `[:word:]` - the same as `[:alnum:]`, with the addition of the underscore `_` character
* `[:alpha:]` - alphabetic characters, in ASCII, equivalent to `[A-Za-z]`
* `[:blank:]` - includes the space and tab characters
* `[:cntrl:]` - the ASCII control codes, includes the ASCII characters 0 through 31 and 127
* `[:digit:]` - 0 through 9
* `[:graph:]` - the visible characters, in ASCII, it includes characters 33 through 126
* `[:lower:]` - lowercase letters
* `[:punct:]` - punctuation characters, in ASCII, equivalent to 

        [-!"#$%&'()*+,./:;<=>?@[\\\]_`{|}~]

* `[:print:]` - printable characters, all characters in `[:graph:]` plus the space character
* `[:space:]` - the whitespace characters including space, tab, carriage return, newline, vertical tab, and form feed, in ASCII, equivalent to `[ \t\n\v\f\r]`
* `[:upper:]` - uppercase characters
* `[:xdigit:]` - characters userd to express hexadecimal numbers, in ASCII, equivalent to `[0=9A-Fa-f]`
