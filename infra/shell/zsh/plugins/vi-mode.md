# vi-mode

this plugin increases `vi-like` zsh functionality.

add `vi-mode` in the `plugin` section of `.zshrc` configuration file:

    plugins=(git, vi-mode)

add `export KEYTIMEOUT=1` in the `.zshrc` for little delay time.

use `esc` or `ctrl+[` to enter `normal mode`.

## history

* `ctrl+p`: previous command in history
* `ctrl+n`: next command in history
* `/`: search backward in history
* `n`: repeat the last `/`

## mode indicators

*normal mode* is indicated with red `<<<` mark at the right prompt, when it wasn't defined by theme.

## vim edition

* `v`: edit current command line in `vim` when in the *normal mode*. 

when use `v`, there may be some error like `E492: Not an editor command: Plugin`, you can set environment variable `export EDITOR=vim`, then the error disappears.

## movement

* `$`: to the end of the line
* `^`: to the first non-blank character of the line
* `0`: to the first character of the line
* `w`: [count] words forward
* `W`: [count] WORDS forward
* `e`: forward to the end of word [count] inclusive
* `E`: forward to the end of WORD [count] inclusive
* `b`: [count] words backward
* `B`: [count] WORDS backword
* `t{char}` till before [count]'th occurrence of {char} to the right
* `T{char}`: till before [count]'th occurrence of {char} to the left
* `f{char}`: to [count]'th occurrence of the {char} to the right
* `F{char}`: to [count]'th occurrence of the {char} to the left
* `;`: repeat latest `f`, `t`, `F`, `T` [count] times
* `,`: repeat latest `f`, `t`, `F`, `T` in opposite direction

## insertion

* `i`: insert text before the cursor
* `I`: insert text before the first character of the line
* `a`: append text after the cursor
* `A`: append text at the end of the line
* `o`: insert new command line below the current one
* `O`: insert new command in the above the current one

## delete and insert

* `ctrl+h`: which in *insert mode*, delete character before the cursor
* `ctrl+w`: which in *insert mode*, delete word before the cursor
* `d{motion`: delete text that {motion} moves over
* `dd`: delete line
* `D`: delete characters under the cursor until the end of the line
* `c{moton}`: delete {motion} text and start insert
* `cc`: delete line and start insert
* `C`: delete to the end of line and start insert
* `r{char}`: replace the character under the cursor with {char}
* `R`: enter *relace mode*, each character replaces exsiting one
* `x`: delete [count] characters under and after the cursor
* `X`: delete [count] characters before the cursor

