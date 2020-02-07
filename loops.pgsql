create or replace function fibonacci(n integer)
returns integer as $$
declare
counter integer=0;
i integer=0;
j integer=1;
begin
if (n < 1) then 
return 0;
end if;

loop 
exit when counter = n;
counter = counter + 1;
select j, i+j into i, j;
end loop;
return i;
end;
$$
language plpgsql;


select fibonacci(7);
select fibonacci(5);