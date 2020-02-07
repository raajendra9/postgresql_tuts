create or replace function total()
returns integer as $total$
declare 
total integer;
begin
select count(*) into total from company;
return total;
end;
$total$ language plpgsql;


select total();


create or replace function inc(value integer)
returns integer as $inc$
begin
return value+1;
end;
$inc$ language plpgsql;


select inc(1);
select inc(3);

create or replace function sum(val1 integer, val2 integer)
returns integer as $sum$
begin
return value1 + value2;
end;
$sum$ language plpgsql;


select sum(5+4);
select sum(10+9);