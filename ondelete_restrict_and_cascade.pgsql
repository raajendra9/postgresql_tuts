-- create table order_items1(product_no integer references products(product_no) on delete restrict,
--                             order_id integer references orders(order_id) on delete cascade,
--                             primary key(product_no, order_id));
-- select * from products;
-- select * from orders;

-- insert into orders values(1, 'delhi'), (2, 'kolkata');
-- insert into order_items values(1, 1, 3), (2, 1, 2);
-- now we can delete orders but we can't delete order_items 