# basics

table consists of rows and columns. the number and order of the columns is fixed, and each column has a name. the number of rows is variable.

## columns

each column has a data type. the data type constrains the set of possible values. there is a limit on how many columns a table can contain. depanding on column types, it is between 250 and 1600.

a column can be assign a default value. if no default value is declared explicitly, the default value is the `null` value. a `null` value can be considered to be an unknown data. in a table definition, default values are listed after the column data type `price numeric default 9.99`. the default value can be an expression, which will be evaluated whenever the default value is inserted (not when the table is created). a common example is for `timestamp` column to have a default of `current_timestamp`, so that it gets set to the time of row insertion. another is generating a serial number using `serial`.
