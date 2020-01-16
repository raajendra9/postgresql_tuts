select * from company where age>33 and sal>20000;

select * from company where age>33 or sal>20000;

select * from company where sal is null;

select * from company where name like 'p%';

select * from company where name like '%a';

select * from company where name like '%a%';

select * from company where age in ('23', '34', '40');

select * from company where age between 24 and 40;

