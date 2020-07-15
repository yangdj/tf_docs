# system columns

every table has several system columns that are implicitly defined by the system. therefore, these names cannot be used as names of user-defined columns.

names are:

* oid - object identifier (object id) of a row. this table is only present if the table was created using `with olds`, or if the `default with oids` configuration variable was set at the time. the column is of type `oid`.

* tableoid - the oid of the table containing this row. it is particularly handy for queries that select from inheritance hierarchies. without it, it is difficult to tell which individual table a row came from. the `tableoid` can be joined against the `oid` column of `pg_class` to obtain the table name.

* xmin - the identity (transaction id) of the inserting transaction for this row version. a row version is an individual state of a row; each update of a row creates a new version for the same logical row. 

* cmin - the command identifier (starting at zero) within the inserting transaction.

* xmax - the identity (transaction id) of the deleting transaction, or zero for an undeleted row version. it is possible for this column to be nonzero in a visible row version. that usually indicates that the deleting transaction hasnot committed yet, or that an attempted deleted was rolled back.

* cmax - the command identifier within the deleting transaction, or zero.

* ctid - the phpsical location of the row version within its table. note that although `ctid` can be used to locate the row version very quickly, a row's `ctid` will change if it is updated or moved by `vacuum full`. therefore, `ctid` is usefulless as a long-term row identifier. the `old`, or even better a user-defined serial number, should be used to identify logical rows.
