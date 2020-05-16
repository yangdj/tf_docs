# shell basic

this includes basic usages about shell.

## comments

use `#` for comment.

## environment

shell stores two basic type of data in the environment, environment variables and shell vairables. in addition to variables, the shell also stores some programmatic data, namely `alias` and shell `function`.

`set` command will show both the shell and environment variables, while `printenv` will only display the latter. `set` also display any defined shell functions.you can use `echo` to views the contents of a variable:

    echo $HOME

neither `set` or `printenv` displays aliases. you can use `alias` to display aliases.

in mac, you can view `PATH` value in the file `/etc/paths`.

in ubuntu, you can view `PATH` value in the file `/etc/environment`.

use `export` command to make variables available to child processes.

## commands

a command can be one of four different things:

* an executable program. it can be compiled binaries or script such as `shell` and `python`
* a command built into the shell itself, such as `cd`, which is a shell builtin
* a shell function, just shell scripts incorporated into the environment
* an alias, commands that we can define ourselves, built from other commands. `alias` without arguments will list all alias

it is possible to put more than one command on a line separated by a semicolon `;` character:

    command1; command2; command3...

use `alias` to create an alias, and `unalias` to remove an alias:

    alias foo='cd /usr; ls; cd -'

    unalias foo

use `type command` to display a command's type, which is a shell builtin.

use `which command` to display an executable's location. it only works for executable programs, not builtins nor alias that are substitutes for actual executable programs.

### command documentation

`help` for shell builtins:

    help cd

`--help` options that many executable programs support also gives some usage information

    mkdir --help

`man` for a program's manual page. most executable programs intended for command line use provide a formal piece of documentation called a manual or man page. the `man` program is used to view them:

    man ls

`apropos` for appropriate commands. this searches the list of man pages for possible matches on a search item.

    apropos ls

`whatis` for a brief description of a command.

    whatis ls

`info`, an alternative to man pages, reads into files which are tree structured into individual nodes, each containing a single topic. info files contain hyperlinks that can move from node to node

## assignment

    variable=value

there must be no spaces between the variable name, the equals sign, and the value. multiple variable assignments may be done on a single line.

    a=5 b=10

you can use `unset` to cancel a assignment.

## variables

### local variables

you can use `local` to create local variable:

    local foo

    foo=1

### read-only variables

you can also use `-r` to create read-only variabls:

    declare -r TITLE="Page Title"

## here document

    command << token
    text
    token

we always use `_EOF_` (end of file) for the token. token must appear alone and that there must not be trailing spaces on the line

use here document, the shells pays no attention to the quotation marks. it treats them as ordinary characters. this allows us to embed quotes freely within a here document.

if we change the direction operation from `<<` to `<<-`, the shell will ignore leading tab characters in the here document. this allows a here document to be indented, which can improve readability

`<<<` operator indicates a *here string*. a *here string* is like a *here document*, only shorter, consisting of a single string.

## shell function

two syntactic form:

    function name {
        commands
        return
    }

and

    name() {
        commands
        return
    }

in order for function calls to be recognized as shell functions and not interpreted as the names of external programs, shell function definitions must appear in the script before they are called

a function must contain at least one command. the return command(which is optional)satisfies the requirment

## flow control

### exit status

commands incluing the scripts and shell functions we write, issue a value to the system when they terminate, called an exit status. this value, which is an integer in the range of 0 to 255, indicates the success or failure of the command's execution. by convention, a value of zero indicates success and any other value indicates failure. we can use `$?` to examine the exit status.

the `true` command always executes successfully and the `false` command always executes unsuccessfully.

    true
    echo $? --> 0

    false
    echo $? --> 1

if a list of commands follows if, the last command in the list is evaluated:

    if false; true; then echo "it's true"; fi --> will be it's true

`exit` command accepts a single, optional argument, which becomes the script's exit status. when no argument is passed, the exit status defaults to exit status of the last command executed.

    exit 0
    exit 1
    exit

similarly, shell functions can return an exit status by including an integer argument to the `return` command.

    return 1

### test

the `test` command performs a variety of checks and comparisons. it has two equivalent forms:

    test expression

and the more popular:

    [ expression ]

where expression is an expression that is evaluated as either true or false. the `test` command returns an exit status of zero when the expression is true and a status of one when the expression is false.

### file expression

file type:

* `-e file` - file exists
* `-s file` - file exists and has length greater than zero
* `-f file` - file exists and is a regular file
* `-d file` - file exists and is a directory
* `-L file` - file exists and is a symbolic link
* `-p file` - file exsits and is a named pipe
* `-S file` - file exsits and is a network socket
* `-b file` - file exsits and is a block-special (device) file
* `-c file` - file exsits and is a character-special (device) file

file permissions and special permissions:

* `-r file` - file exists and is readable (has readable permission for effective user)
* `-w file` - file exists and is writable (has write permission for effective user)
* `-x file` - file exists and is executable (has execute/search permission for effective user)
* `-u file` - file exists and is setuid
* `-g file` - file exists and is set-group-id
* `-k file` - file exists and has its *sticky bit* set
* `-t fd` - fd is a file descriptor directed to/from the terminal. this can used to determine whether standard input/output/error is being redirected

file owner

* `-G file` - file exists and is owned by the effective group id
* `-O file` - file exists and is owned by the effective user id

file comparison

* `file1 -ef file2` - file1 and file2 have the same inode numbers (the two filenames refer to the same file by hard linking)
* `file1 -nt file2` - file1 is newer than file2
* `file1 -ot file2` - file1 is older than file2

### string expressions

* `string` - true if string is not null
* `-n string` - true if the length of string is greater than zero
* `-z string` - the length of string is zero
* `string1 = string2` or `string1 == string2` - string1 and string2 are equal. single or double equal signs may be used, but double equal sign is greatly preferred
* `string1 != string2` - string1  and string2 are not equal
* `string1 > string2` - string1 sorts after string2
* `string1 < string2` - string1 sorts before string2

when use `<` or `>`, they must be quoted or escaped with a blackslash. if they are not, they will be interpreted by the shell as redirection operators, with potentially destructive results. you can use double square bracket, like `[[ a > b ]]`, especially for `zsh`. `zsh` has some difference between `bash`. you can hava a try and test.

### integer expressions

`interger1 -op interger2`, op can be:

* `eq` - for equal
* `ne` - for not equal
* `le` - less than or equal to
* `lt` - less than
* `ge` - greater than or equal to
* `gt` - greater than

### modern test

`[[ expression ]` acts as an enhanced replacement for test. expression is an expression that evaluates to either a true or fallse result. the `[[ ]]` command adds a new string expression `string =~ regex`, which returns true if `string` is matched by the extended regular expression `regex`. another added feature of `[[ ]]` is that `==` operator supports pattern matching the same way pathname expansions does. e.g., `FILE=foo.bar; [[ $FILE == foo.* ]]`. so this makes `[[ ]]` useful for evaluating file and pathnames.

`bash` also prividesa the `(( ))` compound command, which is useful for operating on integers. it supports a full set of arithmetic evaluations. the result of `(( ))` will be true if the evaluation is non-zero.

**notice**: because the compound command `(( ))` is part of the shell syntax rather than an ordinary command, and it deals only with integers, it is able to recognize variables by name, and dose not require expansion to be performed. so you can use `(( int == 0))`, not `(( $int == 0 ))`.

### logical operators

* for `test` and `[ ]`, use `-a`, `-o` and `!`.
* for `[[ ]]` and `(( ))`, use `&&`, `||` and `!`.

since all expresisons and operators used by `test` are treated as command arguments by the shell (unlike `[[ ]]` and `(( ))`), characters which have special meaning to `bash`, such as `<`, `>` `(`, and `)`, must be quoted or escaped.

`test` is traditional (and part of POSIX), whereas `[[ ]]` is specific to bash. it's important to know how to use `test`, since it is very widely used, but `[[ ]]` is clearly more useful and is easier to code.

### branching control

as long as the exit status is zero, it performs the commands inside the loop.

`if` syntax is:

    if commands; then
        commands
    elif commands; then
        commands
    else
        commands
    fi

`case` for multiple-choice compound commands, the syntax is:

    case word in 
        [pattern [| pattern]...) commands ;;]...
    esac

    case $PEPLY in
        0)  echo "item 0"
            exit
            ;;
        1)  echo "item1"
            exit
            ;;
        *) echo "others"
            exit
            ;;
    esac

the `patterns` used by `case` are the same as those used by pathname expansion. `patterns` are terminated with a `)` character. here are some valid patterns:

* `a)` - matches if word equals `a`
* `[abc])` - matches `a` or `b` or `c`
* `[[:alpha:]])` - matches if word is a single alphabetic character
* `???)` - matches if word is exactly three characters long
* `*.txt)` - matches if word ends with the characters `.txt`
* `*)` - matches any value of word. it is good practice to include this as the last pattern in a case command, to catch any values of word that did not match a previous pattern

it is also possible to combine multiple patterns using the `|` vertical bar character as a separator. this creates an `or` conditional pattern.

modern versions of `bash`, since version 4.0, `;;&` notation allows `case` to continue onto the next test rather than simply terminating.

### looping control

#### `while` 

the syntax is:

    while commands; do commands; done

#### `until` 

the syntax is:

    until commands; do commands; done

`until` command is much like `while`, except instead of exiting a loop when a non-zero exit status is encounted, it does the opposite. an `unitl` loop continues until it receives a zero exit status.

the decision of whether to use the `while` or `until` loop is usually a matter of choosing the one that allows the clearest test to be written.

#### `for` 

the `for` loop differs from the `while` and `until` loops in that it provides a means of processing sequnces during a loop.

`for` has two forms. the original form is:

    for variable [in words]; do
        commands;
    done

if the optional `in words` portion of the `for` command is omitted, for defaults to processing the positional parameters.

and the c language form:

    for (( expression1; expression2; expression3 )); do
        commands;
    done

where `expression1`, `expression2` and `expression3` are arithmetic expressions. this form is equvalent to:

    (( expression1 ))
    while (( expression2 )); do
        commands;
        (( expression3 ))
    done

#### `break` and `continue`

`bash` provides two builtin commands that can be used to control program flow inside loops. the `break` command immediately terminates a loop, and program control resumes with the next statement following the loop. the `continue` command causes the remaider of the loop to be skipped, and program control resumes with the next iteration of the loop.

## io

### reading keyboard input

`read` is builtin command used to read a single line of standard input. this command can be used to read keyboard input, or when redirection is employed, a line of data from a file. the syntax is:

    read [-options] [variable...]

where `option` is one or more of the available options and `variable` is the name of one or more variables used to hold the input value. if no variable name is supplied, the shell variable `REPLY` contains the line of data.

    read int

the input value will be assigned to `int`.

`read` can assign input to multiple variables:

    read var1 var2 var3 var4

if `read` receives fewer than the expected number, the extra variables are empty, which an excessive amount of input results in the final variable containing all of the extra input.

options:

* `-a array` - assigns the input to array, starting with index zero
* `-d delimiter` - the first character in the string `delimeter` is used to indicate end of input
* `-e` - use `readline` to handle input. this permits input editing in the same manner as the command line
* `-i string` - use `string` as the default reply if the use simply presses enter. requires the `-e` option
* `-n num` - read `num` characters of input, rather than an entire line
* `-p prompt` - display a prompt for input using string prompt
* `-r` - raw mode. do not interpret backslash characters as escapes
* `-s` - silent mode. do not echo characters to the display as they are typed. this is useful when inputting passwords and other confidential information
* `-t seconds` - timeout. terminate input after `seconds`. `read` returns a non-zero exit status if an input times out
* `-u fd` - use input from file descriptor `fd`, rather than standard input

`IFS` (internal field separator) is used for separating variables by `read`. the default value of `IFS` contains a space, a tab, and a newline character, each of which will separate items from one another.

    IFS=":" read user pw uid <<< "$user_info"

the shell allows one or more variable assignments to take place immediately before a command. these assignments alter the environmental for the command that follows. the effect of the assignment is temporary, only changing the environment for the duration of the command.

### reading files with loops

    while read field1 field2; do
        printf "field1: %s\tfield2: %s\n" $field1 $field2
    done < files.txt

the loop will use `read` to input the fields from the redirected file. the `read` command will exit after each line is read, with a `zero` exit status until the end-of-file is reached. at that point, it will exit with a non-zero exit status, thereby terminating the loop.

it is also possible to pipe the standard input to a loop:

    sort file.txt | while read field1 field2; do
        printf "field1: %s\tfield2: %s\n" $field1 $field2
    done

it is important to remember that since a pipe will execute the loop in a subshell, any variables created or assigned within the loop will be lost when the loop terminates.

## other usages

### group commands and subshells

group command:

    { command1; command2; [commands; ...] }

subshell:
    
    (  command1; command2; [commands; ...]  )

the two forms differ in that a group command surrounds its commands with *braces* and a subshell use *parentheses*. note the braces must be separated from the commands by a space and the last command must be terminated with either a semicolon or a newline prior to the closing brace.

you can use:

    { ls -l; echo "hello, world!"; cat foo.txt; } > output.txt

or:

    (  ls -l; echo "hello, world!"; cat foo.txt;  ) > output.txt

instead of:

    ls -l > output.txt
    echo "hello, world!" >> output.txt
    cat foo.txt >> output.txt

when combines pipes, it will be more power:

    { ls -l; echo "hello, world!"; cat foo.txt; } | wc

group commands and subshells are both used to combine streams for redirction, there is an important difference between them. whereas a group command executes all of its commands in the current shell, a subshell (as the name suggests) executes its commands in a child copy of the current shell. this means that the environment is copied and given to a new instance of the shell. when the subshell exits, the copy of the environment is lost, so any changes made to the subshell's environment (including variable assignment) is lost as well. therefore, in most cases, unless a script requires a subshell, group commands are preferable to subshells. group commands are both faster and require less memory.

because commmands in pipelines are always executed in subshells, any command that assigns variables will encounter this issue. so the shell provides an exotic form of expansion called `process substitution` that can be used to work around this problem. there are two forms:

for processes that produce standard output:

    <(list)

or for processes that intake standard input:

    >(list)

for example:

    read < <(echo "foo")
    echo $REPLY

*process substitution* allows us to treat the output of a subshell as an ordinary file for purposes of redirection. in fact, since it is a form of expansion, we can examine its real value:

    echo <(echo "foo") --> /dev/fd/63

### named pipes

named pipes behave like files, but actually form first-in first-out (FIFO) buffers. you  can set up something like this:

    process1 > named_pipe

and:

    process2 < named_pipe

and it will behave as if:

    process1 | process2

you can create a named pipe, using `mkfifo` command:

    mkfifo named_pipe
