select * from company;
select age from company where sal>2000;
select * from company where age in(select age from company where sal>2000);

update company set sal=sal*1.50 where age in(select age from company where sal <= 2000);

update company set sal=sal/1.50 where age in(select age from company where sal <= 2000);

delete from company where age in (select age from company where age > 40);