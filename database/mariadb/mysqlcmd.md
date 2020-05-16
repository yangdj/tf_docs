# mysql execution commands

## update user 

you can change the root login name, if an attacker is trying to access the root mysql login, they will need to perform the additional step of finding the username. you can change root name this way:

    rename user 'root'@'localhost' to 'new-admin-user'@'localhost';

after this you have to login into mysql using this new user name:

    mysql -u new-admin-user -p

updating passowrd:

    update mysql.user set password=password('newpassword') where user = 'demo-user';

`host is "%'` is a wild that means any host. you can modify it:

    update mysql.user set host = 'localhost' where user = 'demo-user';

you can delete blank user:

    delete from mysql.user where user = '';

after modifying the user table, we need to input the folloing command to implement the new permissions:

    flush privileges;

## create databases;

first create database testdb:

    create database testdb;

then create a user to manage that database, and assign it only the privileges it needs, otherwise, the new user will have no permissions to do anything with the databases. in fact, if new user even tries to login (with the password), they will not be able to reach mysql shell:

    create user 'demo-user'@'localhost' identified by 'password';

    grant select, update, delete on testdb.* to 'demo-user'@'localhost';

you can also revoke some privileges later from the user:

    revoke update on testdb.* from 'demo-usr'@'localhost';

if we need all privileges on a certain database, we can specify that:

    grant all on testdb.* to 'demo-user'@'localhost';

    grant all on *.* to 'demo-user'@'localhost';

the `*` refers to the database and table (respectively) that they can access.`*.*` means all the databases and tables.

permissions consist of:

* `all privileges` - allows you to do anything
* `create` - allows you to create new tables and databases
* `drop` - allows you to delete tables or databases
* `delete` - allows you to delelte rows from tables
* `insert` - allows you to insert rows into tables
* `select` - allow you to use the select command to read through databases
* `update` - allow you to update table rows
* `grant option` - allows you to grant or remove other user's privileges

the general grant permission command:

    grant [type of permission] on [database name].[table name] to '[username]'@'localhost';

the general revoke permission command:

    revoke [type of permission] on [database name].[table name] from '[username]'@'localhost';

you can also `drop` to delete a user:

    drop user 'demo-user'@'localhost';

to show the current priviledes of a user, we first must implement the privileges we specified using `flush privileges` command, and then can query what grants a user has:

    flush privileges;
    show grants for 'demo-user'@'localhost';

always flush privileges when you are finishing makeing changes.

## character set

set character set to utf8 in the file `/et/my.conf`:

    character_set_server=utf8

use mysqlbinlog to view binlog file and specify encoding:

    mysqlbinlog --no-defaults --set-charset=utf8 mysql-bin.00004

## query data

* `mysql -u user -ppassword -h hostname database -e "sql-to-run;..."`
* `mysqldump -u user -ppassword -h host database table1 table2... > output.sql`
* `mysql -u user -ppassword -h host database < output.sql`
