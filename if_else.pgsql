do $$
declare 
num1 integer = 11;
num2 integer = 23;
begin
if num1 > num2 then
raise notice 'num1 is greater than num2';
end if;

if num1 < num2 then 
raise notice 'num1 is less than num2';
end if;

if num1 = num2 then 
raise notice 'num1 is equal to num2';
end if;
end $$


do $$
declare 
num1 integer = 11;
num2 integer = 23;
begin
if num1 > num2 then
raise notice 'num1 is greater than num2';
else
raise notice 'num1 is not greater than num2 / num1 is less than num2 or num1 is equal to num2';
end if;
end $$

do $$
declare 
num1 integer = 11;
num2 integer = 23;
begin
if num1 > num2 then
raise notice 'num1 is greater than num2';
elsif num1 < num2 then
raise notice 'num1 is less than num2';
else
raise notice 'num1 is equal to num2';
end if;
end $$