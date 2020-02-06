select * from company;
select age,count(*) from company group by age;

select address, count(*) from company group by address;
select address, count(*) from company group by address having max(sal) > 20000;