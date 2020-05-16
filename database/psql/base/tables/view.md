# views

you can create a `view` to name a query that can be referred to like an ordinary table:

    create view myview as
        select city, temp_lo, temp_hi, prcp, date, location
        from weather, cities
        where city = name

    select * from myview

making liberal use of view is a key aspect of good sql database design. views allows you to encapsulate the details of your tables, which might change as your application evolves, behind consistent interfaces.

views can be used in almost any place a real table can be used. building views upon other views is not uncommon.
