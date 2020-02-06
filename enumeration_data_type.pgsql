-- create type mood as enum('sad', 'ok', 'happy');
-- create table person(name text,
--     current_mood mood);
-- insert into person values('rahul', 'happy');
-- insert into person values('rashi', 'ok');
select * from person;
select * from person order by current_mood;
select * from person order by current_mood desc;
select max(current_mood) from person;