# alter tables

you can use `alter table` to alter the definition, or structure of the table, like:

* rename tables
* add columns
* remove columns
* rename columns
* change column data types
* change default values
* add constraints
* remove constraints

e.g.,
    
    alter table products add column description text;

    alter table products add column description text check (description <> '');

    alter table products drop column description;

    alter table products drop column description cascade;

    alter table products alter column product_no set not null;

    alter table products alter column product_no drop not null;

    alter table products alter column price set default 7.77;

    alter table products alter column price drop default ;

    alter table products alter column price type numeric(10, 2);

    alter table products rename column product_no to product_number;

    alter table products add check (name <>'');

    alter table products add constraint some_name unique (product_no);

    alter table products add foreign key (product_group_id) references product_groups;

    alter table products drop constraint some_name;

    alter table products rename to items;
