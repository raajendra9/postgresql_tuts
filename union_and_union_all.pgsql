select  * from company;
select * from department;

-- alter table company add dept text default 'it billing';
--alter table company rename column dept to department;

select company.id, name, department from company inner join department on company.id= department.emp_id
union 
select company.id, name, department from company left outer join department on company.id=department.emp_id; 

select company.id, name, department from company inner join department on company.id= department.id
union all 
select company.id, name, department from company left outer join department on company.id = department.emp_id;