# data types

## numeric types

numeric types consist of two-, four-, and eight-byte integers, four- and eight-byte floating-point numbers, and selectable decimals.

* `smallint` - 2 bytes, from -2**15 to 2**15 - 1
* `integer` - 4 bytes, from -2**31 to 2**31 - 1
* `bigint` - 8 bytes, from -2**63 to 2**63 - 1
* `real` - 4 bytes, 6 decimal digits precision
* `double precision` - 8 bytes, 15 decimal digits precision
* `numeric` - variable length, user-specific precision, up to (2**17) digits before the decimal point and up to (2**14 - 1) digits after the decimal point
* `decimal` - equivalent to numeric
* `smallserial` - 2 bytes, autoincrementing integer, from 1 to (2**15 - 1)
* `serial` - 4 bytes, autoincrementing integer, from 1 to (2**31 - 1)
* `bigserial` - 8 bytes, autoincrementing integer, from 1 to (2**63 - 1)

## monetary types

* `money` - 8 bytes

## character types

* `character varying(n)`, `varchar(n)` - variable length with limit
* `character(n),` `char(n)` - fixed length, blank padded
* `text` - variable unlimited length

## binary types

* `bytea` - 1 or 4 bytes plus the actual binary string, variable length binary string

## date-time types
