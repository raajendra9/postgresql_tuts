select * from company;
select * from department;
select name,age,address,dept from company c left outer join department d on c.id=d.id;
select name,age,address, dept from company c right outer join department d on c.id=d.id;
