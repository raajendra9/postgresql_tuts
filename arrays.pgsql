-- create table sal_emp(name text, 
--                     pay integer[],
--                     schedule text[][]);

-- insert into sal_emp values('raj', '{1000,1000,1000,1000}', '{{"meeting","lunch"},{"training", "presentation"}}');
-- insert into sal_emp values('anji', '{2000,2000,1000,1000}', '{{"meeting","lunch"},{"training", "presentation"}}');
-- select * from sal_emp;
-- select pay[2] from sal_emp;
-- select name from sal_emp where pay[1]<>pay[2];
-- select array_dims(schedule) from sal_emp where name='raj';
-- update sal_emp set pay = '{25000, 25000, 25000, 25000}' where name='raj';
select * from sal_emp;
update sal_emp set pay[2]=30000 where name='raj';
select * from sal_emp; 
update sal_emp set pay = array_append(pay, 20000); 

update sal_emp set pay = array_cat(pay, array[30000, 10000]);
update sal_emp set pay = array_cat(pay,array[20000, 15000]) where name='raj';
update sal_emp set pay = array_remove(pay, 20000);
select * from sal_emp;

select * from sal_emp where pay[1]=10000 or pay[2]=10000 or pay[3]=30000 or pay[4]=1000;
select * from sal_emp where 10000=any(pay);

select * from sal_emp where 10000=all(pay);
