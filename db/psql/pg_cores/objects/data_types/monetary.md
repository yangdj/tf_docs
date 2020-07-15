# monetary types

the `money` type stores a currency amount with a fixed fractional precision. the fractional precision is determined by the database's `lc_monetary` setting. input is accepted in a variety of formats, including integer and floating-point literals, as well as typical currency formatting, such as `$1,000.00`. output is generally in the latter form bue depends on the locale.

since the output of this data type is locale-sensitive, it might not work to load `money` data into a database that has a different setting of `lc_monetary`. to avoid problems, before restoring a dump into a new database, make sure `lc_monetary` has the same or equivalent value as in the database that was dumped.

values of the `numeric`, `integer`, and `bigint` data types can be cast to `money`. conversion from the `real` and `doule precision` data types can be done by casting to `numeric` first:

    select '12.34'::double precision::numeric::money

however, this is not recommended. floating point numbers should not be used to handle money due to the potential for rounding errors.

a `money` value can be cast to `numbers` without loss of precision. conversion to other types could potential lose precision, and must also be done in two stages:

    select '52093.89'::money::numeric::double precision
