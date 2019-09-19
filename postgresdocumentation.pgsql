--inserting data when created table it contains no data. the first thing to do before a database
-- a database can be of much is use to insert data



--querying table
select * 
    from cities;
select city, temp_lo 
    from weather;

--AS clause is used to relabel the output column
select city, temp_lo+temp_hi/2 as temp_avg 
    from weather;

--A query can be qulified by 'where' clause that specifies which rows are wanted
--where clause can contain boolean expressions 
select * 
    from weather
        where city='san francisco' and prcp > 0.0;

--you can request the results of query be returned in sorted order
select * 
    from weather
         order by city, temp_hi;

--you can request that duplicate rows be removed from the result of a query
select distinct city 
    from weather;

--here, the result row ordering might vary. you can ensure consistent results
--by using distinct and order by together;
select distinct city    
    from weather order by city;

-- joins between tables
select * 
    from weather, cities
        where city = name;

--Since the columns  all had different names, the parser automatically 
--found which table they belong to. if there were duplicate column names
-- you need to qualify the names to show which one you meant, as in 
select weather.city, weather.temp_lo, weather.temp_hi, weather.prcp, 
        weather.date, cities.location
        from cities, weather
            where weather.city = cities.name;

--join queries of the kind seen thus far can also be written in this alternative form
select * 
    from weather inner join cities on(weather.city=cities.name);

--now we will figure out how we can get the hayword records back in
--what we want query to do is scan the weather table and for each row
--to find the matching cities rows. if no matching foudn we want some empty values
--to substitute cities's table columns. this kind of query is called an outer join

select * from weather left outer join cities on(weather.city = cities.name);

--this query is called left outer join because the the table mentioned on the left of the
--join operator will have each of its rows in the output atleast once
-- where as the table on the right will only have those rows output that match some rows of the left table.
--when ouputting a left table row for which there is no right table match

-- self join is a query in which table joined to itself. self joins useful for comparing values in a
-- column of rows with in the same table

select w1.city, w1.temp_lo as low, w1.temp_hi as high,
	w2.city, w2.temp_lo as low, w2.temp_hi as high
	from weather w1, weather w2
	where w1.temp_lo < w2.temp_lo
	and w1.temp_hi > w2.temp_hi;

-- here we relabeled the weather table as w1 and w2 to be able to 
-- distingush the left and right side of the join, you can also use these kinds of aliases
-- to save sometyping
select * from weather w , cities c
    where w.city = c.name;

--aggregate functions 
-- An aggregate funcition computes a single result from multiple input rows
-- some are count, sum, avg, max and min
select max(temp_lo) from weather;

--if wanted to know which city at reading occured
select city from weather
    where temp_lo = (select max(temp_lo) from weather);

-- this is ok but subquery is an independent computation that 
-- computes ite own aggregate function separately from what is happening in outer query
-- aggregate is also useful with group by clause
-- we can get the maximum low temperature in each city with
select city, max(temp_lo)
    from weather
    group by city;

-- it gives one output from each city. each aggreagate result is computed over the table rows matching that city
-- we can filter these grouped rows using having clause

select city, max(temp_lo)
    from weather 
    group by city 
    having max(temp_lo) > 40;

-- if we only care about cities whose names begin with s
select city, max(temp_lo)
    from  weather 
    where city like 'S%' or city like 's%'
    group by city
    having max(temp_lo) > 40;

--update the table columns
update weather
    set temp_hi = temp_hi-2, temp_lo = temp_lo-2
    where date > '1994-11-28';

select * from weather;


-- rows can be removed from the table using the Delete command.
delete from weather 
    where city='hayward';

select * 
    from weather;

-- one should be vary of the form
-- delete from tablename;

--suppose the the combined listing of weather records and city location is 
--particular interest to your application,but you do not want to type the query eah time
-- you need it, you can create a view over the query, which gives a name to the query that you can refer
-- to like an ordinary table

-- create view thisview as
--     select city, temp_lo, temp_hi, prcp, date, location
--         from weather, cities 
--         where city = name;

select * from myview;



--foreign keys 
-- you want to make sure that no one can insert rows in the weather table that do not have matching entry
-- in the cities table. this is called maintaining the referential intigrity of your data. in simplistic 
-- database systems this would be implemented by first looking at cities table to check if a matching record exist
-- and then inserting or rejecting the new weather records . this appraoch has number of problems and is very 
-- in convinent, so PostgreSQL can do this for you 
-- create table cities2(
--     city        varchar(80) primary key,
--     location    point
-- );

-- create table weather2(
--     city        varchar(80) references cities2(city),
--     temp_lo     int,
--     temp_hi     int,
--     prcp        real,
--     date        date
-- );
-- insert into cities2 values('berkely', '(193, 46)');
-- insert into weather2 values('berkely', 45, 53, 0.0, '1994-11-28'); 
--  you will get an error like insert or update on weather table
--  voilates foreign key constraint 

-- transactions are fundamental concept of all database systems
-- The essential point of transaction is that it bundles multiple
-- steps into a single, all or nothing operation
-- consider bank database that contains balances for various customer accounts
-- as well as total deposit balances for branches

-- there are several updates need to be made or nothing to made if one of that failed, if updates happen, or none of them happen
-- in PostgreSQL transaction is setup by surrounding SQL commands of the transaction with BEGIN and COMMIT 
-- commands so our bannking treansaction would be like this

-- create table branches1(
-- branchname varchar(80) primary key,
-- acno  int,
-- balance real
-- );

-- create table accounts1(
-- name        varchar(80),
-- branchname  varchar(80) references branches1(branchname), 
-- acno        int,
-- balance     real
-- );



-- insert into branches1 values('banglore', 112233, 1000.0);
-- insert into branches1 values('hyderabad', 334455, 1000.0);
-- insert into branches1 values('mumbai', 445566, 1000.0);

-- insert into accounts1 values('bob', 'banglore', 112233, 1000.0);
-- insert into accounts1 values('alice', 'hyderabad', 334455, 1000.0);
-- insert into accounts1 values('wally', 'mumbai', 445566, 1000.0);

begin;
update accounts1 set balance = balance - 100.0
    where name = 'alice';
savepoint mysavepoint;
update accounts1 set balance = balance + 100.0
    where name = 'bob';
--oops  ... forget that and use wallys account 
rollback to mysavepoint;
update accounts1 set balance = balance + 100.0
    where name = 'wally';
commit;


select distinct name, branchname, acno, balance
    from accounts1;

-- create table empsalary(
--     depname varchar(80),
--     empno int,
--     salary int
-- );

insert into empsalary values('personnel', 11, 5200);
insert into empsalary values('develop', 7, 4200);
insert into empsalary values('develop', 9, 4500);
insert into empsalary values('sales', 8, 6000);
insert into empsalary values('sales', 10, 5200);
insert into empsalary values('sales', 5, 3500);
insert into empsalary values('personnel', 2, 3900);
insert into empsalary values('personnel', 3, 4800);
insert into empsalary values('develop', 1, 5000);
insert into empsalary values('develop', 4, 4800);


select * from empsalary;

-- select depname, empno, salary, avg(salary) 
-- over (partition by depname)  
--     from empsalary;

--rename column name in a table
--alter table weather rename column temp_hi to temp_hi;

--Default values
create table products(
    product_no  integer,
    name        text,
    price       numeric Default 9.99
);
-- data types are a way to limit the kind of data that can be stored in a table for example the column contains 
-- a product price should probably only accepts positive values. but there is no standard data type that accepts only positive numbers
-- sql allows you to define the constraints on columns and tables. constraints give you much control over the data in your tables as you wish as user attempts
-- to store data in a column that would violate a contraint an error is raised. this applies even if the values came from default definition
-- check contraint is the most generic contraint type. it allows you to specify that the value in certain column must satisfy a boolean expression.


create table products2(
    product_no      integer,
    name            text,
    price           numeric check (price > 0)
);


-- as you seen the contraint definition comes after data type just like default vaule
-- a check contraint also refer to several columns . say you store a regular price and discounted price and you
-- want to ensure that the discounted price lower than the regular price
create table products(
    product_no      integer,
    name            text,
    price           numeric check(price > 0),
    discounted_price   check(discounted_price > 0),
    check(price > discounted_price)
);

-- The first two constraints should look familiar the third one uses a new syntax
-- It is not attached to a particular column, instead it appears in separate column 
-- we can say that first two are column conraints, where as third one is table constarint
-- because it is written in separately from from any one column definition
-- column constraints can also be written as table constraints, while the reverse is not
-- neccessarily possible  since a column constraint is supposed to refer the one of the column 


create table products2(
    product_no      integer,
    name            text,
    price           numeric,
    check           (price > 0),
    discounted_price    numeric,
    check           (discounted_price >0),
    check           (price > discounted_price)
);

-- names can assigned to table constraint in the same way as column contraits

create table products3(
    product_no integer,
    name        text,
    price       numeric,
    check(price > 0),
    discounted_price    numeric,
    check(discounted_price > 0),
    constarint valid_discount check(price > discounted_price)
);

-- It should be noted that check constarint satisfied if the check expression evaluates to true or the null value
-- Since most expressions will evaluate to the null values in the constraint null value if any operand is null, they will not prevent null values 
-- in the constrained columns. to ensure that column does not contain null values, the not null constraint described in the next section can be used 

-- A not null constarint simply specifies that a column must not assume the null value
create table products4(
    product_no integer not null,
    nam        text  not null,
    price      numeric,
);

--A not null constarint simply specifies that a column must not assume the null value
create table products5(
    product_no integer,
    name        text not null,
    price       numeric,
);

-- A not nuill constraint is functionally equivalent to creating a check constrain
-- but in postgresql creating an explicit not null constraint is more efficient. the drawback is that you can not 
-- give explicit names to not null contraint is more efficient created this way

-- of course, a column may have one or more constraint. Just write constraint one after another
create table products6(
    product_no integer not null,
    name        text not null,
    price       numeric not null check(price > 0)
);

-- the not null constraint has an inverse: the null constraint. this does not mean that the column must be null


-- Unique constraint ensure that the data contained in a column, or a group of columns, is unique among all the rows in the table
-- the syntax
create table products7(
    product_no  integer null,
    name        text null,
    price       numeric null
);

-- Unique constraints
--unique constraints ensure that the data contained in a column,
--agroup of columns, is unique among all the rows in the table
create table products8(
    product_no      integer unique,
    name            text,
    price           numeric
);

-- when written as a column constraint  and
create table products9(
    product_no integer,
    name        text,
    price       numeric,
    unique(product_no)
);

--when written as a table constraint
-- to define a unique constraint for a group of columns
--write it as a table constraint with the column names separated by

create table  products10(
    a integer,
    b integer,
    c integer,
    unique(a, c)
);

-- this specifies that the combination of values in the indicated columns is unique
--across the whole table though any one of the columns need not be unique
-- you can assign your own name for a unique constraint, in the usual way

create table product11(
    product_no integer constraint must_be_different unique,
    name    text,
    price   numeric
);

-- adding unique constraint will automatically create unique b tree index on the column 
-- or group of columns on column or group of columns listed in the constraint
-- A uniqueness covering in only somerows can not be 

-- primary keys
-- a primary key constraint indicates that a column, or group of columns
-- can used as a unique identifier for rows in the table
-- following two tables accepts the same data

create table products12(
    product_no integer unique not null,
    name        text,
    price       numeric
);

create table products13(
    product_no integer primary key,
    name        text,
    price       numeric
);

-- primary keys can span more than one column: the syntax is similar to unique constarint
create table products14(
    a integer,
    b integer,
    c integer,
    primary key(a, c)
);

-- adding primary key will automatically create a unique b tree index
-- on the column liste in the primary key and will force the columns to be marked not null

--foreign keys
-- A foreign key constraint specifies that the values that the values in a column 
-- must match the values appering in some row of another table
-- we say this maitains the referential integrity between two related tables

-- say you have the product table that we have used several times already
create table products15(
    product_no primary key,
    name    text,
    price  numeric
);

-- we define a foreign key constraint in the orders table that references the product table

create table orders(
    order_id integer primary key,
    product_no integer references products15(product_no),
    quantity integer
);

-- now it is impossible to create orders with non-null product no entries that do not appear in the product table
-- wwe say that in this situation the order table is referencing table and the products table is the referenced table
-- you can also shorten the command above
create table orders1(
    order_id integer primary key,
    product_no integer references products15,
    quantity integer
);

-- A foreign key can also constrain an reference a group of columns
create table products16(
    a integer primary key,
    b integer, 
    c integer,
    foreign key(b, c) references other_table(c1, c2)
);

-- you can assign your own name for a foreign key constraint, in the usualway
-- A table can have more than one foreign key constraint
create table products17(
    product_no integer primary key,
    name  text,
    price   integer
);

create table orders2(
    order_id integer primary key,
    shipping_address text
);

create table order_items(
    product_no integer references products17,
    order_id   integer references orders2,
    quantity   integer,
    primary key(product_no, order_id)
);

-- we know that primary key overlaps with the foreign keys in the last table
-- we know that the foreign keys disallow creation of orders that do not relate to any products
-- but what if a product is removed after an order is created that references it

-- disallow deleting a referenced product
-- delete the orders as well
-- something else

-- illistrates this.lelts implement the following policy on the many to many relationship
-- when someone wants to remove product that is still referenced by an order
-- we disallow it. if someone removes an order, the order 

-- restricting and cascading deletes are the two most common options
-- restrict prevents deletion of a referenced row. no action means that if any referencing rows
-- still exist when the constrain is checked, an error is raised


-- to add column use command like 
alter table products add column description text;
-- the new column is initially filled with whatever default value is given 

--you can also define constraints on the column at the same time, using the usual 
alter table products add column description text check(description <> '');

-- removing column 
alter table products drop column description:

--however if the column is referenced by a foreign key constraint of another table
--postgresql will not silently drop that constraint. you can autherize dropping everything that depends on the
--column by adding cascade
alter table products drop column descrption cascade;

-- to add a constraint, the table constraint syntax
alter table product add check(name <> '');
alter table products add constraint some_name unique(product_no);
alter table products add foreign key (product_group_id) references product_groups;


-- to add a not null constraint, which can not be written as table constraint 
alter table products alter column product_no set not_null

--removing constraint 
-- to remove constraint you need to know its name if you gave name to it then it is easy
-- otherwise system assigned a generated name, which you need to find out 
-- the psql command \d table name can be helpful here other interfaces might also provide a way to inspect table details
alter table drop constraint some_name;

--As with dropping column, you need to add cascade if you want to drop a constraint 
-- that something depends on a unique or primary key constraint on the referenced column 

-- this works the same for all constraint types except not null constraint, to drop not null constraint use
alter table products alter column product_no drop not null;

-- changing a columns default value
-- to set a new default for a column use command like this
alter table products alter column price set default 7.77;


-- to remocve any default value
alter table products alter column price drop;

-- to convert a column to a different data type 
alter table products alter column price price type numeric(10,2);


--renaming column 
alter products rename column product_no to product_number

--renaming table
alter table products rename to items

-- updating data
update products set price = 5 where price = 10;

update products set price = price * 10;

-- likewise 
update products set a = 4 , b = 5, c = 10 where  a > 0;

-- deleting data 
delete from products where price = 10;

-- if you simply  writes 
delete from products;
-- then all rows in table will be deleted 

-- returning data
-- the returning clause is very useful with select and insert
-- In an update, the data available  to returning is the new content of the modified row
update products set price = price * 10
    where price <= 99.99
    returning name, price as new_price;

-- in a delete, the data available to returning is the content of the deleted row
delete from products
where price = 5
returning *;