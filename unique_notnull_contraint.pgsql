-- create table products1(
--                         product_no int not null,
--                         name text not null,
--                         price numeric not null check(price>0)
--                         );
-- check constraint can be applied with not null constraint
--insert into products1 values(12, null, 5);

-- null value in column 'name' voilate the not null CONSTRAINT

-- insert into products1 VALUES(12, 'soap', 20);

-- create table products2(product_no int not null unique,
--                         name text not null,
--                         price numeric not null check(price>0));


--product no can not be regoperatorsend

-- you could declare unique like unique(product_no, name) in one line at the end of the query

insert into products2 values(4, 'paste', 25);
-- insert into products2 values(1, 'soap', 30);

-- duplicate key values violates unique constraint products2_product_no_name_key

insert into products2 values(3, 'plate', 30);