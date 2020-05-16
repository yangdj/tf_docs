## regular usage

* `<c-g>` - echo the name and status of the current file
* `ga` - show the character ascii value
* `<c-v>ooo` - insert character in ascii number, using three digits, `<c-v>001` means ascii values is `1`
* `<c-r>{register}` - insert the contents of {register}
* `gUU` - make current line uppercase
* `gv` - hight the last selection in visual mode
* `~` - toggle between uppercase and lowercase
* `/searching/e` - place the cursor at the end of the search match
* `:%s/searching//gn` - find counts of the searching words
* `:&&` - act on the current line. the first `&` repeats the last `:substitute` command, and the second `&` indicates that the flags from the previous `:s` command should be used
* `g&` - `%s//~/&`
* `:!mkdir -p %:h`
* `:w !sudo tee % > /dev/null`
* `:@:` - repeat the last ex command
* `q:`, `:<c-f>` - open the window with history of ex commmands
* `q/` - open the window with history of searches
* `qaq` - clear register `a`. `qa` tells vim to start recording a macro into register `a`, and then `q` stops recording. we type nothing while the marco was recording, so the register ends up empty. we can check that using `:reg a`.
* `:global /{/ .+1,/}/-1sort`
* `<c-a>`, `<c-x>` - increase or subtract a number
