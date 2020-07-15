# character types

SQL defines two primary character types: `character varying(n)` and `character(n)` where `n` is a positive integer. both of these types can store up to `n` characters **not bytes** in length. an attempt to store a longer string into a column of these types will result in error, unless the excess characters are all spaces, in which case, the string will be truncated to the maximum length. if the string to be stored is shorter than the declared length, values of type `character` will be space-padded; values of type `character varying` will simply store the shorter string.

if one explicitly casts a value to `character varing(n)` or `character(n)`, then an over-length value will be truncated to `n` characters without raising an error. (this is required by the SQL standard.)

the notations `varchar(n)` and `char(n)` are alias for `character varying(n)` and `character(n)`, respectively. `character` without length specifier is equivalent to `character(1)`. if `character varying` is used without length specifier, the type accepts strings of any size. the latter is a pg extension.

in addition, pg provides the `text` type, which stores strings of any length. although the type `text` is not the SQL standard, several other SQL database management systems have it as well.

in most situations, `text` or `character varying` should be used instead.
