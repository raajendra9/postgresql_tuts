-- create table products(product_no int, 
--                         name text,
--                         price numeric check(price>0),
--                         discounted_price numeric check(discounted_price > 0),
--                         check(price > discounted_price));

--insert into products values(10, 'soap', -10);
--new row for relation products violates check constraint products_price-check
--insert into products values(20, 'oil', 40, -1);
--new row for relation products violates check constraint products_discounted_price_check

insert into products values(10, 'soap', 10, 2);

