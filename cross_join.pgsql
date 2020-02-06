select * from company;
select * from department;
-- insert into department values(1, 'it billing', 1), (2, 'engineering', 2), (3, 'finance', 7);
select emp_id, name, dept from company cross join department;