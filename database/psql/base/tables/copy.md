# copy

* `copy` and `\copy` copy files from or to the database. 
* `copy` is used in the server which the database located.
* `\copy` is used in the local machine different from the database server.
* `copy` is faster to load large amounts of data from flat-text files.

syntax:

    copy tablename from '/your/file/path' delimiter ','

    psql -U username -d database -c "copy tablename from '/your/file/path' delimiter ','"

    psql -U username -d database -h host -p port -c "\copy tablename from '/your/file/path' delimiter ','"
