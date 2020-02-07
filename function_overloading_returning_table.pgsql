create or replace function get_employee(eage integer)
returns table(ident integer, nam text)
as $info$
begin 
return query select id, name from company
where age=eage;
end;
$info$
language plpgsql;

create or replace function get_employee(eage integer, loc  text)
returns table(ident integer, nam text)
as $info$
begin 
return query select id, name from company
where age=eage and address=loc;
end;
$info$ 
language plpgsql;


-- select get_employee(20);
select get_employee(20,'mumbai');