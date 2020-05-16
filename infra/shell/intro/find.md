# finding files

`find` can be used to identify files that meet specific criteria through application of *options*, *tests*, and *actions*.

## file types

* `b` - block special device file
* `c` - character special device file
* `d` - directory
* `f` - regular file
* `l` - symbolic link
* `p` - pipe (FIFO)
* `s` - socket

for example, finding directory under current directory:

    find . -type d

## file name

using `-name` to specify file name supporting wildcard pattern.

## size units

* `b` - 512-byte blocks. this is the default if no unit is specified
* `c` - bytes
* `w` - 2-byte words
* `k` - kilobytes (units of 1024 bytes)
* `M` - megabytes (units of 1024k)
* `G` - gigabytes (units of 1024M)

the leading `+` indicates files larger than the specified number. a leading `-` indicates files smaller than the specified number. using no sign means, matching the value exactly.

    find . -type f -size +1M -name "*.jpg"

## tests

attribute tests:

* `-name pattern` - match files or directories with the specified wildcard pattern
* `-iname pattern` - like the `-name` test but case insensitive
* `-inum n` - match files with inode number `n`. this is helpful for finding all the hard links to a particular inode
* `-samefile name` - similar to the `-inum` test, match files that share the same inode numbers as file name
* `-type c` - match files of type `c`
* `-empty` - match empty files and directories
* `-size n` - match file of size `n`
* `-perm mode` - match files or directories that have permission set to the specified `mode`. `mode` may be expressed by either octal or symbolic notation
* `-group name` - match files or directories belonging to `group`. `group` may be expressed as either a group name or as a numeric group id
* `-nouser` - match files or directories that do not belong to a valid user. this can be used to find files belonging to deleted accounts or to detect activity by attackers
* `-nogroup` - match files or directories that do not belong to a valid group

time tests:

* `-newer file` - match files or directories whose contents were modified more recently than the specified file. this is very useful when writing shell scripts that perform file backups. each time you make a backup, update a file (such as log), and the use `find` to determine which files have changed since the last update
* `-mmin n` - match files or directories whose content were last modified `n` minutes ago
* `-mtime n` - match files or directories whose contents were last modified `n*24` hours ago
* `-cnewer file` - match files or directories whose contents or attributes were last modified more recently than those of file
* `-cmin n` - match files or directories whose content or attributes were last modified exactly `n` minutes ago. to specify less than `n` minutes ago, use `-n` and specify more than `n` minutes ago, use `+n`
* `-ctime n` - match files or directories whose contents or attributes were last modified `n*24` hours ago

## operators

    find . \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)

logical operators:

* `-and` or `-a`
* `-or` or `-o`
* `-not` or `!`
* `()` - groups tests and operators together to form larger expressions. since parentheses characters have special meaning to the shell, they must be quoted when using them on the command line to allow them to be passed as argument to `find`. usually the backslash character is used to escape them

## actions

predefined actions:

* `-delete` - delete the currently matching file
* `-ls` - perform the equvalent of `ls -dils` on the matching file, output is sent to standard output
* `-print` - output the full pathname of the matching file to standard output. this is the default action if no other action is specified
* `-quit` - quit once a match has been made

user-defined actions: in addition to the predefined actions, we can also invoke arbitary commands, the traditional way of doing this is with the `-exec` action:

    -exec command {} ;

where `command` is the name of a command, `{}` is a symbolic representation of the current pathname, and `;` is a required delimiter indicating the end of the command. here is an example of using `-exec` to act like `-delete`:

    -exec rm '{}' ';'

since the `{}` and `;` have special meaning to the shell, they must be quoted or escaped

it's also possible to execute a user-defind action interactively by using the `-ok` action in place of `-exec`, the user is prompted before execution of each specified command:

    find . -type f -name 'foo*' -ok ls -l '{}' ';'

by changing the trailing `;` character to a `+` sign, we activate the ability of `find` to combine the results of the searching into an argument list for a single execution of the desired command:

    find . -type f -name 'foo*' -exec ls -l '{}' '+'

`xargs` command accepts input from standard input and converts it into an argument list for a specified command.

    find . -type f -name 'foo*' -print | xargs ls -l

the `find` command provides the action `-print0`, which produces *null-separated* output, and the `xargs` command has the `--null` option, which accepts *null separated* input:

    find . -iname '*.jpg' -print0 | xargs --null ls -l

## options

the *options* are used to control the scope of a `find` search:

* `-depth` - direct `find` to process a directory's files before directory itself. this option is automatically applied when the -delete action is specified
* `-maxdepth levels` - set maximum number of levels that `find` will descend into a directory tree when performing tests an actions
* `-mindepth levels` - set the minimum numbe of levels that `find` will descend into a directory tree before appling tests and actions
* `-mount` - direct `find` not to traverse directories that are mounted on other filesystems
* `-noleaf` - direct `find` not to optimize its search based on the assumption that it is searching a unix-like file system. this is needed when scanning DOS/Windows file systems and CD-ROMS
