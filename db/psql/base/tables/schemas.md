# schemas

a pg database cluster contains one or more named databases. users and groups of users are shared across the entire cluster, but no other data is shared across databases. any given client connecting to the server can access only the data in a single database, the one specified in the connection request.

a database contains one or more named *schemas*, which in turn contain tables. schemas also contain other kinds of named objects, including data types, functions, and operators. a user can access objects in any of the schemas in the database they are connected to, if they have privileges to do so. **schemas cannot be nested.**

you can create or drop schemas, using:

    create schema myschema;

    create schema myschema authorization user_name -- create a schema owned by some user

    drop schema myschema;

    drop schema myschema cascade; -- drop a schema incluing all contained objects

use `schema.table` to access the table in the specified schema. schemas names beginning with `pg_` are reserved for system purposes and cannot be created by users.

by default, tables created are automatically put into a schema named *public*. every new database contains such a schema.

qualified names are tedious to write, and it is often best not to write a particular schema name into applications anyway. therefore tables are often referred to by *unqualified names*, which consist of just the table name. the system determines which table is meant by following *a search path*, which is a list of schemas to look in. the first matching table in the search path is taken to be the one wanted. if there is no match in the search path, an error is reported, even if matching table names exist in other schemas in the database.

the first schema named in the search path is called the *current schema*. aside from being the first schema, it is also the schema in which new tables will be created if the `create table` command does not specify a schema name.

to show the current search path, using:

    show search_path;

to set search path, using:

    set search_path to myschema, public;

there is nothing special about the public schema except that it exists by default. it can be dropped, too.

the search path works in the same way for data type names, function names, and operator names as it does for table names. data type and function names can be qualified in exactly the same way as table names. there is a special provision: you must write

    operator(schema.operator)

for example:

    select 3 operator(pg_catalog.+) 4; -- select 3 + 4;

in practice one usually relies on the search path for operators, so as not to have to write anything so ugly as that.

if you do not want to allow users to create objects in its public schema, you can revoke that:

    revoke create on schema public from public;

the first *public* is the schema, the second *public* is *every user*.

in addition to *public* and user-created schemas, each database contains a *pg_catalog* schema, which contains the system tables and all the built-in data types, functions, and operators. *pg_catalog* is always effectively part of the *search path*. if it is not named explicitly in the path then it is implicitly search **before** searching path's schemas. this ensures that built-in names will always be findable. however, you can explicitly place *pg_catalog* at the end of your search path if you prefer to have user-defined names override built-in names.
