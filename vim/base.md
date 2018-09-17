## base

### mode

single mode:

* `i I a A o 0` - insert mode from normal mode, `esc` back to normal mode
* `/` `?` - search mode, to search forward or backward
* `:` - ex mode
* `v`, `V`, `<C-v>` - visual mode
* `x`, `d{motion}`, `y{motion}`, `p` - delete, copy, paste in normal mode. `dd`, `yy` means delete or copy the current line

delete, then go to insert mode

* `c{motion}`
* `cc`, `S` - delete current line
* `s` - delete current character

### text object

you can select objects like `a}`, `it`:

* `a i` - mean around or inside the object
* `) } ] > ' " \` t` - usual objects
* `w W s p` - word, WORD, sentense and paragraph

### motion

see `:h motion.txt`

move in the same file:

* `%` - move between opening and closing of parentheses, like `() [] {} <>`
* `0 g0` - move to the first character of the realline or display line
* `^ g^` - move to the first nonblank character of the realline or display line
* `$ g$` - move the end of real line or display line
* `hjkl` - move left, right, up, and down for one real line or one column
* `g[jk]` - move down and up by display lines
* `w b e ge W B E GE` - move to the end or beginning of the word, see `:h word|WORD`
* `* #` - move next or previous word same as the cursor
* `g* g#` - move next or previous word same as the cursor without word delimiters
* `; ,` - move to the next or previous character using `f{char}` or `t{char}`
* `n N` - move to the next or previous searching word using `/{pattern}`
* `m{a-zA-Z}` - mark the current cursor location. lowercase marks are local to each individual buffer, whereas uppercase marks are globally accessible
* `'{mark}` - move to the line where a mark was set, positioning the cursor on the first non-whiltespace character
* `\`{mark}` - move the cursor to the exact position where a mark was set. 
* `mm` and `\`m` commands make a handy pair. they set the mark and jump to it

long-range motions may be classified as a *jump*, but short-range motions are just *motions*.  use `:jumps` to list all the jumps, `:changes` shows a list of the modifications made to each buffer during an editing session:

* `<c-o> <c-i>` - jump back and forward
* `gf` - jump to file name under the cursor
* `H/M/L` - jump to top, middle and bottom of screen
* `<c-]>` - jump to definition of keyword under the cursor
* `<c-t>` - jump back from the tags visited
* `g<c-]>` - same as `<c-]>`, but present a list of choice when multiple tags match

`suffixesadd` option allows to specify one or more file extension, which vim will attemp to use when looking up a filename with `gf` command, e.g., `:set suffixesadd+=.rb`

### copy and paste

vim does not deal with a clipboard, but instead with registers, and vim has multiple registers. the delete, yank and put commands all interact with one of vim's registers.

when use `y{motion}`, the specified text is copied not only into the unnamed register `"`, but also into the yank register `0`. while `x`, `s`, `c{motion}` and `d{motion}` are just copied to unnamed register.

an uppercase register in `[A-Z]` tells vim to append to the specified register, whereas a lowercase in  `[a-z]` would overwrite the register's contents.

`"_` - called the black hole, from which nothing returns, e.g., `"_d{motion}`. this can be useful if we want to delete text without overwriting the contents of the unamed register.

* `<c-r>"` - paste the string in the unnamed register
* `<c-r><c-w>` - copy and paste current word under the cursor
* `"uyiw; <C-r>u` - copy inner word to register u, then paste it
* `<c-r>.` - last inserted text
* `<c-r>:` - last ex command
* `<c-r>/` - last search pattern
* `<c-r>%` - name of the current file
* `<c-r>#` - name of the alternate file
* `@u` - refers to the value in the register u
* `<C-r>=` - enters to the expression register prompt
* `:reg a` - list all registers and show their value

### macros

the `q` key functions both as the "record" button and the "stop" button. `q{register}` begins to record, giving the address of the register where we want to save the macro. every command that we execute will be captured, right up until we press `q` again to stop recording.

`@a` executes the contents of the specified register `a`. `@@` repeats the macro that was invoked most recently.

### function

* `getcmdtype()`
* `.` - concats strings
* `escape(); <C-r>=escape(@u, getcmdtype."\")`
* `:promptfind()` - for searching in gvim
