# create tables

    CREATE TABLE weather (
        city            varchar(80),
        temp_lo         int,           -- low temperature
        temp_hi         int,           -- high temperature
        prcp            real,          -- precipitation
        date            date
        );

    CREATE TABLE cities (
        name            varchar(80),
        location        point
        );

*point* type is an example of a postgresql-specific data type.

`drop table tablename` removes a table.

`drop table if exists tablename` avoids error messages.
