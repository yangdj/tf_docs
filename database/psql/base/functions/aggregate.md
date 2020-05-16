# aggregate funcitons

an *aggregate function* computes a single result from multiple input rows, and cannot be used in the `where` clause. `where` clause is evaluated before aggregate functions are computed. but we can filter grouped rows using `having`.

aggregate functions are:

* `count()`
* `sum()`
* `avg()`
* `max()`
* `min()`
