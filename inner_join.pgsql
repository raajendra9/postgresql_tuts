select * from company;
select name, sal from company inner join department on company.id=department.id;
select name, age, address, dept from company c , department d where c.id=d.id;
