select * from company;

begin;

update company set name='rishi' where id=6;

select * from company;

rollback;

commit;

select * from company;