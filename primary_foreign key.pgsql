-- create table products(product_no integer primary key,
--                         name varchar,
--                         price numeric);
-- insert into products values(2, 'hellow' ,100), (3, 'world', 70);

-- create table orders(order_id integer primary key,
--                     product_no integer references products(product_no),
--                     quantity integer);
-- drop table orders;


-- create table orders(order_id integer primary key,
--                     address text);
drop table order_items;
create  table order_items(product_no integer references products(product_no),
                            order_id integer references orders(order_id),
                            quantity integer,
                            primary key(product_no, order_id));