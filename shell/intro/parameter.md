# parameter process

## command parameter usage

* `$$` - the pid of current process
* `$!` - the pid of the last job put into the background
* `$#` - the number of parameters, not include `$0`
* `$0` - the current script name
* `$1` to `$9` - parameters from 1 to 9. you can access more than nine parameters using `${10}`, `${200}`, and so on
* `$?` -exit status of last command 
* `$*` - expand into the list of positional parameters, starting with 1. when surrounded by double quotes, it expands into a double quoted string containing all of the positional parameters, each separatd by the first character of the `IFS` shell varaible (by default space)
* `$@` - expand into the list of positional parameters, starting with 1. when surrounded by double quotes, it expands each positional parameter into a separate word surrounded by double quotes

`shift` command causes all the parameters to move down one each time it is executed. each time `shifit` is executed, the value of `$2` is moved to `$1`, the value of `$3` is moved to `$2` and so on. the value of `$#` is also reduced by one.

## function parameters

just as positional parameters are used to pass arguments to shell scripts, theay can also be used to pass arguments to shell functions.

the shell variable `FUNCNAME` is automatically updated to keep track of the currently executed shell function. and `$0` always contains the full pathname of the first item on the command line (i.e., the name of the program) and does not contain the name of the shell function as we expect.
