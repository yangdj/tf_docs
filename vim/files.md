## file and buffer

a *buffer* is an in-memory representation of a file, while a file is stored on the disk.

synchronizing operations:

* `:quit`, `:qall` - close the buffer
* `:write`, `:wall`, `write {filename}` - save the buffer to the current file or a new file, and keep in the current buffer
* `:update` - like `:write`, but only write when the buffer has been modified
* `:edit {filename}` - load file `{filename}`
* `:edit!` - reread the file from disk, overwriting the contents of the buffer
* `:saveas {filename}` - save the current buffer under the `{filename}` and set the current buffer to `{filename}`, different to `:write {filename}`
* `:pwd` - print working directory
* `%` - short for current buffer
* `%:h` - the path of current buffer, excluding the filename
* `:find` - open a file by its name without having to provide a full qualified path, using the `path` setting
* `:echo &path` - get the current `path` value, see `:h path`

operations with all buffers:

* `ls` - list all of buffers
    * `%`, `#` - indicate the current and alternate file
    * `a`, `h` - active or hidden buffer
* `<c-^>` - toggle between current and alternate file
* `bnext`, `bpre`, `bfirst`, `blast` - switch to the next, previous, first and last buffer
* `buffer N` - jump to a buffer by number
* `buffer {bufname}` - jump to a buffer by buffer name, just need partial characters to identify the buffer
* `bufdo ex` - allow to execute an Ex command in all of the buffers listed by `ls`
* `bdelete N1, N2, N3`, `N,M bdelete` - delete specified or continuous buffers

operations using *argument list* to group buffers into a collection

* `args` - print argument list, with the current file in `[]`
* `args {arglist}` - use arglist to set the contents of the argument list, and arglist can be filenames, wildcards, or even the output from a shell command. `*` will match zero or more characters, but only in the scope of the specified directory, while `**` can recurse downward into directories below the specified directory, see `h starstar-wildcard`. backtick can also be used, e.g., `args \`cat .chapters\``. vim execute the text inside the backtick characters in the shell, using the output as the argument for the `:args` command, see `h backtick-expansion`
* `next`, `prev`, `first`, `last` - traverse the files in the argument list
* `set hidden` - make possible to use `:bufdo` and `:argdo` to change a collection of buffers with a single command
* `argdo Ex` - execute the same command on each buffer in the argument list

split window:

* `<c-w>s`, `<c-w>v` - split window horizontal or vertical
* `split {filename}`, `vsplit {filename}` - split and load file `{filename}`
* `<c-w>[h,j,k,l,w]` - change focus between windows
* `close` `<c-w>c` - close the active window
* `only`, `<c-w>o` - keep only the active window, closing all others
* `<c-w>[=_|+-]`, `N<c-w>[_|]` - resize window
* `<c-w>[rXHJKL]` - move windows

use tab page:

* `:lcd {path}` - set the working directory locally for the current window
* `:windo lcd {path}` - set the local working directory for the current tab page
* `:tabedit {filename}` - open a new tab page, if `{filename}` omitted, a new blank tab page opens
* `<c-w>T` - move the current window into a new tab page
* `:tabclose` - close the current tab page
* `:tabonly` - keep the active tab page, closing all others
* `:tabnext {n}`, `:tabnext`, `:tabprevious`, `{n}gt`, `gt`, `gT` - switch between tab pages
* `:tabmove {n}` - rearrange tab page, if `{n}=0` then move to the beginning, if `{n}` omitted, then move to the end
