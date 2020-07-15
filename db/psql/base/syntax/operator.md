# operators

an operator name is a sequence of up to `NAMEDATALEN-1` (63 by default) characters from the following list:

     + - * / < > = ~ ! @ # % ^ & !  ?

`--` is a single line comment and `/*...*/` is block comment.

operator precedence

* `.`: left, table/column name separator
* `::`: left, postgresql-style typecast
* `[]`: left, array element selection
* `+-`: right, unary plus, unary minus
* `^` : left, exponentiation
* `*` `/` `%`: left, multiplication, division, modulo
* `+-`: left, addition, subtraction
* (any other operator): left, all other native and user-defined operators
* `between` `in` `like` `ilike` `similar`: range containment, set membership, string matching
* `<` `>` `=` `<=` `>=` `<>`: comparison operators
* `is isnull notnull`: is true, is false, is null, is distinct from, etc
* `not`: right, logical negation
* `and`: left, logical conjunction
* `or`: left, logical disjunction
