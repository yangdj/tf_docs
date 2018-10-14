# numeric types

## integer types

the types `smallint`, `integer`, and `bigint` store whole numbers, that is, numbers without fractional components, of various ranges. attemps to store values outside of the allowed range will result in an error.

the type `integer` is the common choice, as it offers the best balance between range, storage size, and performance. the `smallint` type is generally only used if disk space is at a premium. the `bigint` type is designed to be used when the range of the `integer` type is insufficient.

SQL only specifies the integer type `integer` or (`int`), `smallint`, and `bigint`. the type names `int2`, `int4`, and `int8` are extensions, which are also by some other SQL database systems.

## arbitrary precision numbers

the type `numeric` can store numbers with a very large number of digits. it is especially recommended for storing *monetary amounts* and other quantities where *exactness* is required. calculations with `numeric` values yield exact results where possible, e.g., addition, subtraction, multiplication. however, calculations on `numeric` values are very slow compared to the integer types, or to the floating-point types.

we use the following terms below: the *scale* of a `numeric` is the count of decimal digits in the fractional part, to the right of the decimal point. the *precision* of a `numeric` is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point. so the number `23.5141` has a precision of 6 and a scale of 4. integers can be considered to have a scale of zero.

both the maximum precision and the maximum scale of `numeric` column can be configured. to declare a column of type `numeric` use the syntax:

    numeric(precision, scale)

the precision must be positive, the scale zero or positive. alternatively:

    numeric(precision)

selects a scale of 0. specifying:

    numeric

without any precision or scale creates a column in which numeric values of any precision and scale can be stored, up to the implementation limit on precision. a column of this kind will not coerce input values to any particular scale, whereas `numeric` columns with a declared scale will coerce input values to this scale.

the SQL standard requires a default scale of 0, i.e., coercion to integer precision. so if you're concerned about portability, always specify the precision and scale explicitly.

if the *scale* of a value to be stored is greater than the declared scale of the column, the system will round the value to the specified number of fractional digits. then, if the number of digits to the left of the decimal point exceeds the declared precision minus the declared scale, an error is raised.

numeric values are physically stored without any extra leading or trailing zeroes. thus, the declared precision and scale of a column are maximums, not fixed allocations. (in this sense the `numeric` type is more akin to `varchar(n)` than to `char(n)`). the actual storage requirement is two bytes for each group of four decimal digits, plus three to eight bytes overhead.

in addition to ordinary numeric values, the `numeric` type allows the special value `NaN` meaning *not-a-value*. any operation on `NaN` yields another `NaN`. when writing this value as a constant in an SQL command, you must put quotes around if, for example `update table set x = 'NaN'`. on input, the string `NaN` is recognized in a case-insensitive manner.

**note:** in most implementations of the *not-a-number* concept, `NaN` is not considered equal to any other numeric values (including `NaN`). in order to allow `numeric` values to be stored and used in tree-based indexes, pg treats `NaN` values as equal, and greater than all non `NaN` values.

the type `decimal` and `numeric` are equivalent, both types are part of the SQL standard.

when rounding values, the `numeric` type **rounds ties away from zero**, while (on most machines) the `real` and `double precision` types round ties to the nearest even number.

## floating-point types

the data types `real` and `double precision` are inexact, variable-precision numeric types. in practice, these types are usually implementations of *IEEE Standard 754 for Binary Floating-Point Arithmetic(single and double precision, respectively)*, to the extent that the underlying processor, operating system, and compiler support it.

inexact means that some values cannot be converted exactly to the internal format and are stored as approximations, so that storing an retrieving a value might show slight discrepancies:

* if you require exact storage and calculations (such as for monetary amounts), use the `numeric` type instead.
* comparing two floating-point values for equality might not always work as expected

on most platforms, the `real` type has a range of at least `1E-37` to `1E+37` with a precision of at least 6 decimal digits. the `double precision` type typically has a range of around `1E-307` to `1E+308` with a precision of at least 15 digits. values that are too large or too small will cause an error. rounding might take place if the precision of an input number is too high. numbers too close to zero that are not representable as distinct from zero will cause an underflow error.

in addition to ordinary numeric values, the floating-point types have several special values:

* Infinity
* -Infinity
* NaN

these represent the IEEE 754 special values *infinity*, *negtive infinity*, and *not-a-number*. when writing these values as constants in an SQL command, you must put quotes around them, for example `update table set x = 'Infinity'`. on input, these strings are recognized in a *case-insensitive* manner.

     IEEE754 specifies that NaN should not compare equal to any other floating-point value (including NaN). In order to allow floating-point values to be sorted and used in tree-based indexes, PostgreSQL treats NaN values as equal, and greater than all non-NaN values.

## serial types

the data types `smallserial`, `serial` and `bigserial` are not true types, but merely a notational convenience for creating unique identifier columns (similar to the `AUTO_INCREMENT` property supported by some other database). in the current implementation, specifying:

    create table tablename (
        colname serial
    )

is equivalent to specifying:

    create sequence tablename_colname_seq;
    create table tablename (
        colname integer not null default nextval('tablename_colname_seq')
    );
    alter sequence tablename_colname_seq owned by tablename.colname

thus, we have created an integer column and arranged for its default values to be assigned from a sequence gengerator. a `not null` constraint is applied to ensure that a null value cannot be inserted. (in most cases, you would also want to attach `unique` or `primary key` constraint to prevent duplicate values from being inserted by accident, but this is not automatic). lastly, the sequence is marked as *owned by* the column, so that it will be dropped if the column or table is dropped.

to insert the next value of the sequence into the `serial` column, specify that the `serial` column should be assigned its default value. this can be done either by excluding the column from the list of columns in the `insert` statement, or through the use of the `default` key word.
