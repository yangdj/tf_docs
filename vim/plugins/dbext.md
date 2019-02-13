# dbext

reading `h dbext-tutorial` to know the basics.

## configuration

the configuration profile is:

    let g:dbext_default_profile_<profile_name> = '<connection string>'

the **connection string** has the following keywords:

* type
    * `PGSQL` - for postgresql, using `psql` client, storing passwd in `~/.pgpass` file and `$HOME/pgpass.conf` for windows
    * `MYSQL` - for mysql, using `mysql` client
    * `SQLSRV` - for sqlserver, using `osql` client
    * `SQLITE` - for sqlite
* user
* passwd
* srvname
* host
* port
* dbname
* extra
    * mysql
        * `--default-character-set=utf8 -t`
* dsnname

## commands

shortcuts:

* `<leader>sbp` - **s**ql **b**uffer **p**rofile, display the profiles defined
* `<leader>sel` - **s**ql **e**xecute **l**ine
* `<leader>se` - **s**ql **e**xecute current statement, maybe multiline queries
* `<leader>st` - **s**ql **t**able under the cursor
* `<leader>sT` - **s**ql **t**able under the cursor, but prompt for the number of rows to select, much saver and quiker then `<leader>st`
* `<leader>stw` - **s**ql **t**able under the cursor, but prompt for a **w**here condition clause
* `<leader>sta` - prompt for a table name, then select from that table
* `<leader>slt` - **s**ql **l**ist **t**able
* `<leader>slv` - **s**ql **l**ist **v**iew
* `<leader>slp` - **s**ql **l**ist **p**rocedure
* `<leader>sdt` - **s**ql **d**escribe **t**able under the cursor
* `<leader>sdp` - **s**ql **d**escribe **p**rocedure under the cursor
* `<leader>sdv` - **s**ql **d**escribe **v**iew under the cursor
* `<leader>slc` - **s**ql **l**ist copy of the column names in the table under the cursor to the unnamed register

## results buffer

shortcuts:

* `R` - re-run the command populating the current results
* `q` - quite the results window
* `<leader>sh` - **s**ql **h**istory list, press return key on selected statement to re-execute
* `:res +num` `:res -num` - resize window size bigger or smaller

## auto-completion

when using auto-completion, you have to:

1. work from a saved file ending in `.sql`
2. populute the vim dictionary using either of the commands `DBCompleteTables`, `DBCompleteViews`, `DBCompleteProcedures`

you can config in the `.vimrc` file:

    autocmd VimEnter *.sql DBCompleteTables

then, after the `from` keyword, press `ctrl+x` followed by`ctrl+o`, the matching tables will be shown. scroll up and down the menu using `ctrl+n` and `ctrl-p`.

## references

[using-vim-as-a-sql-server-client](http://blog.gypsydave5.com/posts/2015/11/17/using-vim-as-a-sql-server-client/)
