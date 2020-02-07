create or replace function min_max( a integer, b integer, c integer, out max integer, out min integer)
as $minmax$
begin
max = greatest(a, b, c);
min = least(a, b, c);
end;
$minmax$
language plpgsql; 


select min_max(30, 40, 50);
 
create or replace function sq(inout a numeric)  
as $s$
begin
a = a * a;
end;
$s$
language plpgsql;

select sq(3);
select sq(9);