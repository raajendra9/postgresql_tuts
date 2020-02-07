-- create table emp_logs(id integer, name text, oldaddress text, newaddress text);
--insert into emp_logs values(1, 'raj', 'hyderabad', 'banglore'), (1, 'anji', 'pppalem', 'bapatla'), (3, 'srinivas', 'kapalem', 'tanuku');


-- create or replace function log_change()
-- returns trigger as
-- $body$
-- begin
-- if new.address<>old.address then 
-- insert into emp_logs values(old.id, old.name, old.address, new.address);
-- end if;
-- return new; 
-- end;
-- $body$ language plpgsql;     


-- create trigger log_changer
-- before update
-- on company
-- for each row
-- execute procedure log_change();

select * from company;
update company set address = 'delhi' where id=4;

update company set address = 'kashmir' where id=2;

select * from emp_logs;

-- alter trigger log_changer on company
-- rename to  log_changer_renamed;

--alter table company disable trigger log_changer_renamed;

--alter table company disable trigger all;

--update company set address = 'kolkata' where id = 7;

-- alter table company enable trigger log_changer_renamed;

--drop trigger log_changer_renamed on company;