## patterns

### case sensitivity:

* `set ignorecase` enables global case insensitive.
* `\c` causes search pattern to ignore case, while the uppercase `\C` at the end forces case sensitivity
* when `set ignorecase`, then after `set smartcase`, if pattern is all lowercase, then the search will be case insensitive, while including an uppercase letter, the search becomes case sensitive

### regexp

these characters have special meanings:

* `^`, `$`, `.`, `\\`
* `\(`, `\)`, `[`, `]`
* `\*`, `\?`, `\+`, `\{`, `}`
* `\|`
* `\0, \1, \2, ...\9` refers the submatch inside of parentheses `()`. `\0` refers the entire match, whether or not parentheses were used in the pattern
* `\%` before `()` will not capture the submatch contents in the register
* `\x ~ [0-9a-fA-F]`
* `\w ~ [0-9a-fA-F_]` `\W ~ [^\w]`
* `\zs`, `\ze` sets the start or end of the match
* `\_s` matches whitespaces or a line break
* `\<`, `\>` word boundary, `\< ~ \W\zs\w`, `\> ~ \w\ze\W`
* `~` - previous substitute string

for example:

    /#\([0-9a-fA-F]\{6}\|[0-9a-fA-F]\{3}\)

`\v` pattern enables all characters with a special meaning, with the exception of `_`, `a-z`, `A-Z` and `0-9`. if that character do not yet have a sepcial meaning, it will be reserved for future expansions. e.g., `#` has no special meaning today does not mean that will be true for future versions. but now `#` is used literally, with no special meaning.

    /\v#([0-9a-fA-F]{6}|[0-9a-fA-F]{3})

### substitute

the syntax:

    :[range]s[ubstitute]/{pattern}/{string}/{flags}

pattern:

* `""` - when blank, then use the previous pattern

flags:

* `&` - keep the flags from the previous command, must be the first one
* `g` - substitute all matches within the line
* `c` - confirm or reject the change
* `n` - just report the number of occurences
* `e` - suppress error messages

for `string`, you can see `h sub-replace-special`, and common usages list here:

* `\r` - insert a carriage return
* `\t` - insert a tab character
* `\\` - insert a single backslash
* `\1, \2, ..., \9` - insert the first, second, up to ninth submatch
* `\0`, `&` - insert the entire match
* `~` - use `string` from the previous invocation of `:substitute`
* `\={vim script}` - evaluate `{vim script}` expression; use results as replacement `string`, e.g., `\=submatch(0)-1`

### vimgrep

the syntax:

    :vim[grep][!] /{pattern}/[g][j] {file} ...

* `{pattern}` - when blank, then match all of the lines, use `<c-r>/` to paste current search pattern
* `[g]` - create a match for each one on the same line, otherwise, just create only one for the entire line
* `[j]` - stay on the current position, otherwise jump straight to the first match
* `{file}` - accept the parameter as `:args`, including filenames, wildcards, backtick expressions and combinations of all of them. the `*` matches any file in a directory, and `**` matches any file in the specified directory or any of its subdirectories. `##` expands to the names of each file in the argument list
