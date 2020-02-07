create or replace function fetcher(n integer)
returns void as $$
declare 
emp record;
begin 
for emp in select name 
from company 
order by age 
limit n
loop 
raise notice '%',emp.name;
end loop;
end $$ 
language plpgsql;


select fetcher(4);