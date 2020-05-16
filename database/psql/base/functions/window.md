# window functions

a *window function* performs a calculation across a set of table rows that are somehow related to the current row. it always contain an `over` clause directly following the window function's name and arguments. this is what syntactically distinguishes it from from a regular function or aggregate function.

the `over` clause determines exactly how the rows of the query are split up for processing by the window function. the `partition by` list within `over` specifies dividing the rows into groups, or partitions, that share the same values of the `partition by` expressions. for each row, the window function is computed across the rows that fall into the same partition as the current row.

`order by` within `over` controls the order in which rows are processed.

the rows considered by a window function are those of the *virtual talbe* produced by the query's `from` clause as filtered by its `where`, `group by`, and `having` clause if any. for each row, there is a set of rows within its partition called its *window frame*. many window function act only on the rows of the *window frame*, rather than of the whole partition. by default, if `order by` is supplied then the frame consists of all rows from the start of the partition up through the current row, plus any  following rows that are equal to the current row according to `order by` clause. when `order by` is omitted, the default frame consists of all rows in the partition.

window functions are permitted only in the `select` list and `order by` clause of the query. they are forbidden elsewhere, such as in `group by`, `having` and `where` clauses. also, window functions execute after regular aggregate functions. this means it is valid to include an aggregate function call in the arguments of a window function, but not vice versa. each windowing behavior can be named in a `window` clause and then referenced in `over`.

    select sum(salary) over w, avg(salary) over w
    from empsalary
    window w as (partition by depname order by salary desc)
