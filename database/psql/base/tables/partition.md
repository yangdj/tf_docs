# partitioning

partitioning refers to splitting what is logically one large table into **small physical pieces**.

currently, pg supports partitioning via table **inheritance**. each partition must be created as a child table of a single parent table. the parent table itself is normally empty; it exists just to represent the entire data set.

partition is implemented in pg in the form of:

* range partitioning - the table is partitioned into *ranges* defined by a key column or set of columns, with no overlap between the ranges of values assigned to different partitions. e.g., one might partition by data ranges, or by ranges of identifiers for particular business objects.

* list partitioning - the table is partitioned by explicitly listing which key values appear in each partition.

