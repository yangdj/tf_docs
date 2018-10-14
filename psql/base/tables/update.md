# update table

## single table

    update tablename set column1 = column1 - 2, column2 = column2 * 2
        where column3 between 1 and 10

    update tablename set (column1, column2) = (column1 - 2, column2 * 2)
        where column3 between 1 and 10

## joined table

    update table1 set (column1, column2) =
        (select column1, column2 from table2
        where table1.id = table2.id)

    update table1 t1 set t1.column1 = t2.column1
                         t1.column2 = t2.column2
         from table2 t2 where t1.id = t2.id
