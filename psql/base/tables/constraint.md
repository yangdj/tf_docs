# constraints

you can define constraints on columns and tables. constraints give as much control over the data in the tables.

## check constraints

a check constraint is the most generic constraint type. e.g., `price numeric check (price > 0)`. *default values* and *constraints* can be listed in any order. you can also give constraint a separate name. `price numeric constraint positive_price check (price > 0)`. a check constraint can also refer to several columns:

    create table products (
        product_no integer,
        name text,
        price numeric check (price > 0),
        discounted_price numeric check (discounted_price > 0),
        check (price > discounted_price)
    )

the first two constraints are column constraints, whereas the third one is a table constraint because it is written separately from any one column definition. the above can also be written as:

    create table products (
        product_no integer,
        name text,
        price numeric,
        check (price > 0),
        discounted_price numeric,
        check (discounted_price > 0),
        check (price > discounted_price)
    );

or even:

    create table products (
        product_no integer,
        name text,
        price numeric check (price > 0),
        discounted_price numeric,
        check (discounted_price > 0 and price > discounted_price)
        );

**note:** a check constraint is satisfied if the check expression evaluates to `true` or the `null` value. to ensure that a column does not contain null values, the *not-null* constraint can be used.

## not-null constraints

a not-null constraint simply specifies that a column must not assume the null value, e.g., `product_no integer not null` equvalent to `price_no integer check (price no is not null)`. but in pg, creating an explicit not-null constraint is more efficient.

a column can have more than one constraint. just write the constraints one after another. the order doesnot matter:

    create table products (
        product_no integer not null,
        name text not null,
        price numeric not null check (price > 0)
    );

the `not null` constraint has an inverse: then `null` constraint. this simply selects the default behavior that the column might be null. then `null` constraint is not present in the SQL standard and should not be used in portable applications. it was only added to pg to be compatible with some other database system.

## unique constraints

unique constraints ensure that the data contained in a column, or a group of columns, is unique among all the rows in the table `product_no integer unique` or `product_no integer constraint must_be_different unique` or `product_no integer, unique(product_no)` or `a integer, b integer, unique(a, b)`.

adding a unique constraint will automatically create a unique b-tree index on the column or group of columns listed in the constraint.

two null values are **never** considered equal in this way. that means even in the presence of a unique constraint it is possible to store duplicate rows that contain a null value in at least one of the constrained columns. this behavior conforms to the SQL standard, but other database might not follow this rule.

## primary key constraints

a primary key constraint indicates that a column, or group of columns, can be used as a unique identifier for rows i n the table. this requires that the value be both `unique` and `not null`. so `product_no integer primary key` is equvalent to `product_no integer unique not null`. primary keys can span more than one column `a integer, b integer, primary key (a, b)`.

adding a primary key will automatically creates a unique b-tree index on the column or group of columns listed in the primary key, and will force the columns to be marked `not null`.

a table can have **at most one** primary key. but there can be any number of unique and not-null constraints, which are functionally almost the same thing, but only one can be identified as the primary key. relational database theory dictates that every table must have a primary key. this rule is not enforced by pg, but it is usually best to follow it.

## foreign keys constraints

a foreign key constraint specifies that the values in a column (or a group of columns) must match the values appearing in some row of another table. we say this maintains the *referential integrity* between two related tables: `product_no integer references products (product_no)`. you can also shorten the command to `product_no integer references products`. because in absence of a column list, the primary key of the referenced table is used as the referenced column(s).

a *foreign keys* can also constraint and reference a group of columns. as usual, it then needs to be written in table constraint form: `b integer, c integer, foreign key (b, c) references other_table(c1, c2)`. of course, the number and type of the constrained columns need to match the number and type of the referenced columns.

a foreign key must reference columns that either are a primary key or form a unique constraint. this means that the referenced columns always have an index. it is often a good idea to index the referencing columns too for the referenced table to be **delete** or **update**.

## exclusion constraints

adding an exclusion constraint will automatically create an index of the type specified in the constraint declaration.
