# postgresql introduction

## basic

*tables* are grouped into *databases*, and a collection of databases mangaged by a single postgresql server *instance* constitutes a database *cluster*.

the database server program is called `postgres`, and you can use program `psql` to connect to the server.

## options for `psql`:

for connection:

* `-U, --username=USERNAME`
* `-w, --o-password`
* `-W, --password`
* `-h, --host=HOSTNAME`
* `-p, --port=PORT`
* `-d, --dbname=DBNAME`
* `-c, --command=COMMAND` -  run only single command and exit
* `-f, --file=FILENAME` - execute commands from file, then exit
* `-l, --list` - list available databases, then exit

for output format:

* `-o, --output=FILENAME` - send results to file (or |pipe)
* `-A, --no-align` - unaligned table output mode
* `-F, --field-separator=STRING` - just for **unaligned mode**, default `|`
* `-R, --record-separator=STRING` - just for **unaligned mode**, default newline 
* `-H, --html` - html table output mode
* `-z, --field-separator-zero` - set field separator for unaligned output to zero byte
* `-0, --record-separator-zero` - set record separator for unaligned output to zero byte

for interactive:

* `select version()` - get the version
* `\q` - get out of psql
* `\c` - change database
* `\db` - list tablespaces
* `\i basic.sql` - `\i` read in commands from the `basic.sql` file
* `\h` - get help
* `\?` - get internal commands

you can create a file `.pgpass` in your home directory, and store your connection data, then you will not need to input password every time, and the format is `host:port:database:username:password`:

    localhost:5432:*:username:password
    localhost:5432:dbname:username:password

*white space* (i.e., spaces, tabs, and the newlines) can be used freely in sql commands.

`--` introduces comments. whatever follows them is ignored up to the end of the line.

sql is case insensitive about key words and identifiers, except when identifiers are double-quoted to preserve the case.
