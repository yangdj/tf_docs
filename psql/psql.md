# postgresql

## search path

    alter role username set search_path = path1, path2

## databases

every instance of a running postgresql server manages one or more databases a database is a collection of *schemas*, and the *schema* contain the *tables*, *functions*, etc. so the full hierarchy is: server, database, schema, table (or some other kind of objects, such as a function).

you can query databases using:

    select * from pg_database;
    \l;

to create database:

    create database dbname

or create a database for someone else and have them become the owner of the new database:

    create database dbname owner rolename;

or to create a database using specified template, the default is template1:

    create database dbname template template0;

to drop a database:

    drop database dbname;

## tablespaces

tablespaces in postgresql allow database administrators to define locations in the file system where the files representing database objects can be stored. once created, a tablespace can be referred to by name when creating database objects.

using `create tablespace` to define a tablespace:

    create tablespace fastspace location '/ssd1/postgresql/data';

the location must be an existing, empty directory that is owned by the postgresql operating system user. tables, indexes, and entire databases can be assigned to a particular tablespaces. you must pass the tablespace name as a parameter to this relevent command:

    create table foo(i int) tablespace space1;

or use the `default_tablespace` parameter:

    set default_tablespace = space1;
    create table foo(i int);

to query the tablespaces:

    select * from pg_tablespaces;

to remove the tablespaces:

    drop tablespace space1;
    \db;

two tablespaces are automatically created when the database cluster is initialized. the *pg_global* is used for shared system catalogs. the `pg_default` tablespace is the default tablespace of the *tempate0* and *template1* databases (and, therefore, will be the default tablespace for other databases as well, unless overridden by tablespace clause in `create database`).

## schemas

a database contains one or more named schemas, which in turn contain tables. schema names beginning with `pg_` are reserved for system purposes and cannot be created by users.

to create a schema:

    create schema myschema;

to create a schema owned by someone else:

    create schema myschema authorization username;

to drop a schema:

    drop schema myschema;

to drop a schema including all contained objects:

    drop schema myschema cascade;

you can set `search_path` to specify the schema to look for.

to show the current search path:

    show search_path;

to set the path:

    set search_path to myschema, public;

by default, users cannot access any objects in schemas they do not own. to allow that, the owner of the schema must grant the *usage* privilege on the schema. to allow users to make use of the objects in the schema, additional privileges might need to be granted, as appropriate for the object.

## roles

the concept of roles subsumes the concepts of *users* and *groups*. in postgresql versions before 8.1, *users* and *groups* were distinct kinds of entities, but now there are only roles. any role can act as a user, a group, or both.

to create role:

    create role name;

to drop the role:

    drop role name;

to alter the role:

    alter role
    alter role dbuser createdb

to list the role:

    select * from pg_roles;
    \du;

because roles can own database objects and can hold privileges to access other objects, dropping a role is often not just a matter of a quick `drop role`. any objects owned by the role must first be dropped or reassigned to other owners, and any permissions granted to the role must be revoked.

    alter table table_name owner to another_role;

alternatively, the `reassign owned` command can be used to reassign ownership of all objects owned by the role-to-be-dropped to a single other role. because `reassign owned` cannot access objects in other databases, it is necessary to run it in each database that contains objects owned by the role.

once any valuable objects have been transferred to new owners, any remaining objects owned by the role-to-be-dropped can be dropped with the `drop owned`. again, this command cannot access objects in other databases, so it is necessary to run it in each database that contains objects by the role. `drop owned` will not drop entire databases or tablespaces, so it is necessary to do that manually if the role owns any databases or tablespaces that have not been transferred to new owners.

    reassign owned by alice to bob;
    drop owned by alice;
    drop role alice;

a role with the `login` attribute can be considered the same as a database user. `create user` is equivalent to `create role` except that `create user` assumes `login` by default, while `create role` does not:

    create role name login;
    create user name;

the `superuser` attribute bypasses all permission checks, except the right to log in. it is best to do most of your work as a role that is not a `superuser`:

    create role name superuser;

the `createdb` gives a role permission to create databases:

    create role name createdb;

the `createrole` can create more roles. it can alter and drop other roles too, as well as grant and revoke membership in them. to create, alter, drop, or change membership of a superuser role, `superuser` status is required; `createrole` is insufficient for that.

    create role name createrole;

the `replication` give permission to initiate streaming replication. a role used for streaming replication must have `login` permission as well.

    create role name replication login;

the `password` is only significant if the client authentication method requires the user to supply a password when connecting to the database. the `password` and `md5` authentication methods make use of passwords.

    create role name password 'your-password';

the `inherit` determines whether a role inherit the privileges of roles it is a member of. a role with the `inherit` attribute can automatically use whatever database privileges have been granted to all roles it is directly or indirectly a member of. without `inherit`, membership in another role only grants the ability to `set role` to that other role. the privileges of the other role are only available after having done so. if not specified, `inherit` is the default.

    set role joe; -- use joe privileges
    set role none or reset role; -- restore to original privileges

**it is good practice to create a role that has the createdb and createrole privileges, but is not a superuser, and then use this role for all routine management of database and roles. this approach avoids the danger of operating as a superuser for tasks that do not really require it.**

the role attributes `login`, `superuser`, `createdb`, and `createrole` can be thought of as special privileges, but they are never inherited as ordinary privileges on database objects are. you must actually `set role` to a specific role having one of these attributes in order to make use of the attribute.

## privileges

    grant role1 to role2;
