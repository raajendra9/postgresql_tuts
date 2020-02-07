select * from company;
select * from department;

select  * from company c inner join company e on c.id= e.id;
select * from company c, company e where c.id=e.id;
