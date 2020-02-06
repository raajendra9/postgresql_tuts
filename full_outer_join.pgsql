select * from  company;
select * from department;
select name, sal, dept from company full outer join department on company.id = department.id;