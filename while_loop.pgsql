create or replace function fibonacci(n integer)
returns integer as $$
declare
i integer=0;
j integer=1;
count integer=0;
begin
if(n<i) then
return 0;
end if;
while count<n loop
count = count+1;
select j, i+j into i, j;
end loop;
return i;
end;
$$ language plpgsql;


select fibonacci(9);