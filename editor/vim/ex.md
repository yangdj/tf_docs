## ex mode

### commands

common usages:

* `:[range]print` - print specified lines
* `:[range]delete [x]` - delete specified lines [into register x]
* `:[rank]yank [x]` - yank specified lines [into register x]
* `:[line]put [x]` - put the text from register x after the specified line
* `:[range]copy {address}` - copy the specified lines to below the line specified by {address}, and `:t` short for `:copy`
* `:[range]move {address}` - move the specified lines to below the line specified by {address}
* `:[range]join` - join the specified lines
* `:[range]normal {commands}` - execute normal mode {commands} on each specified line
* `:[range]substitute/{pattern}/{string}/[flags]` - replace occurences of {pattern} with {string} on each specified line
* `:[range]global/{pattern}/[cmd]` - execute the ex command [cmd] on all specified lines where the {pattern} matches

`range` is separated by `,`, using `{start},{end}`. the values can be:

* line number
    * `0` - virtual line above the first line of the file
    * `1` - line 1
    * `$` - the last line
    * `.` - the current line
    * `%` - all the line in the current buffer, short for `1,$`
* pattern - e.g., `/<html>/,/<\/html>/p`, `/<html>/+1,/<\/html>/-1p`
* mark
    * `'m` - line containing mark `m`
    * visual selection
        * `'<` - stand for the first line of the visual selection
        * `'>` - stand for the last line of the visual selection

`range` also supports offset:

    :{address}+n
    :{address}-n

### interact with shell

vim can invoke exteral programs by prefixing them with a `!`:

* `!{cmd}` - execute `{cmd}` in the shell. `!ls` list the contents of the current directory
* `:shell` - start a shell
* `:read !{cmd}` - put the output from `{cmd}` into current buffer
* `:[range]write !{cmd}`, `:[range]write ! {cmd}` - wirte the content of the current buffer to the specified `{cmd}`, while `:write! sh` writes the current buffer to the file `sh`
* `:[range]!{filter}` - lines specified by `[range]` are passed as standard input for the `{filter}`, and then the output from `{filter}` overwrites the original contents of `[range]`
* `:make`, `:grep` - wrapper commands executed inside vim, the output can be populated in the quickfix list
* `:sort` - vim bulit-in command for sort

### global command

the syntax:

    :[range] global[!] /{pattern}/ [cmd]

explains:

* the default range for `:global` is the entire file `%`, while most other ex commands use current line `.` by default
* the `{pattern}` can be blank and use the current search pattern automatically
* the `[cmd]` can be any ex commands except for `global`. the default is `:print`
* `:global!`, `:vglobal` - invert the behavior of the `:global`, execute `[cmd]` on each line that doesnot match the specified pattern
