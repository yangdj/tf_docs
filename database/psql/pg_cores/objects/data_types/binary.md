# binary types

a binary string is a sequence of octets (or bytes). binary string are distinguished from character string in two ways:

* binary strings specifically allow storing octets of value zero and other *non-printer* octets (usually, octets outside the range 32 to 126). character strings disallow zero octets, and also disallow any other values and sequences of octet value that are invalid according to the database's selected character set encoding.
* operations on binary strings process the actual bytes, whereas the processing of character strings depands on locale setting.

so, binary strings are appropriate for storing data that the programmer thinks of as *raw bytes*, whereas character strings are appropriate for storing text.

the `bytea` type supports two external formats for input and output: pg's historical *escape* format, and *hex* format. both of these are always accepted on input. the output format depands on the configuration parameter `bytea_output`: the default is *hex*. **note:** the hex format was introduced to pg9.0; earlier versions and some tools donot understand it.

the SQL standard defines a different binary string type, called `blob` or `binary large object`. the input format is different from `bytea`, but the provided functions and operations are mostly the same.

## hex format

hex format encodes binary data as **2 hexadecimal digits per byte, most significant nibble first**. the entire string is preceded by the sequence `\x` (to distinguish it from the escape format). in some contexts, the initial backslash may need to be escaped by doubling it, in the same cases, in which backslashes have to be doubled in escape format. the hexadecimal digits can be either upper or lower case. the hex format is compatible with a wide range of external applications and protocals, and it tends to be faster to convert than the escape format, so its use is preferred.

    select E'\\xabcd'::bytea

    select '\xabcd'::bytea

## escape format

escape format takes the approach of representing a binary string as a sequence of ASCII characters, while converting those bytes that cannot be represented as an ASCII character into special escape sequences.

in genteral, to escape an octet, convert it into its three-digit octal value and precede it by a backslash (or two backslashes, if writing the value as a literal using escape string syntax). to encode octal non-printable values between 0 and 31 or 127 to 255, you can use `E'\\xxx'`, `e'\\000'` for 0, `e'\\001'` for 1, `e'\\\\'` for `\\`.
