# create databases

* database names must hava an alphabetic first character and are limited to 63 bytes in length

* `createdb dbname` is to create a database in the server end. be sure `createdb` path is in your `PATH` environment variable, or `createdb -U username dbname` to specify a user account to create a database.

* `dropdb` is used to delete a database. similarly,  you can use `dropdb mytest` or `dropdb -U username mytest`

* `dropdb` phisically removes all files associted with the database and cannot be undone, so this should only be done with a great of forethought.
