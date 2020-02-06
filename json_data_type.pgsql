-- create table jsondata(id integer,
--                         doc json);

-- insert into jsondata values(1, '{
--                                 "name":"raj", 
--                                 "address":{
--                                 "lane1":"my lane",
--                                 "pincode":"1232434"
--                                 }}');

select * from jsondata;
select doc->> 'address' from jsondata; 
select doc->'address'->> 'pincode' from jsondata;
select doc->'address'->> 'pincode' from jsondata where id=2;
select doc#>>'{address,pincode}' from jsondata;