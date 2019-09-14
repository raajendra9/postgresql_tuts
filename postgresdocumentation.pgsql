--querying table
select * 
    from cities;
select city, temp_lo 
    from weather;

--AS clause is used to relabel the output column
select city, temp_lo+temo_hi/2 as temp_avg 
    from weather;

--A query can be qulified by 'where' clause that specifies which rows are wanted
--where clause can contain boolean expressions 
select * 
    from weather
        where city='san francisco' and prcp > 0.0;

--you can request the results of query be returned in sorted order
select * 
    from weather
         order by city, temo_hi;

--you can request that duplicate rows be removed from the result of a query
select distinct city 
    from weather;

--here, the result row ordering might vary. you can ensure consistent results
--by using distinct and order by together;
select distinct city    
    from weather order by city;

-- joins between tables
select * 
    from weather, cities
        where city = name;

--Since the columns  all had different names, the parser automatically 
--found which table they belong to. if there were duplicate column names
-- you need to qualify the names to show which one you meant, as in 
select weather.city, weather.temp_lo, weather.temo_hi, weather.prcp, 
        weather.date, cities.location
        from cities, weather
            where weather.city = cities.name;

--join queries of the kind seen thus far can also be written in this alternative form
select * 
    from weather inner join cities on(weather.city=cities.name);

--now we will figure out how we can get the hayword records back in
--what we want query to do is scan the weather table and for each row
--to find the matching cities rows. if no matching foudn we want some empty values
--to substitute cities's table columns. this kind of query is called an outer join

select * from weather left outer join cities on(weather.city = cities.name);

--this query is called left outer join because the the table mentioned on the left of the
--join operator will have each of its rows in the output atleast once
-- where as the table on the right will only have those rows output that match some rows of the left table.
--when ouputting a left table row for which there is no right table match

-- self join is a query in which table joined to itself. self joins useful for comparing values in a
-- column of rows with in the same table

select w1.city, w1.temp_lo as low, w1.temo_hi as high,
	w2.city, w2.temp_lo as low, w2.temo_hi as high
	from weather w1, weather w2
	where w1.temp_lo < w2.temp_lo
	and w1.temo_hi > w2.temo_hi;

-- here we relabeled the weather table as w1 and w2 to be able to 
-- distingush the left and right side of the join, you can also use these kinds of aliases
-- to save sometyping
select * from weather w , cities c
    where w.city = c.name;

--aggregate functions 
-- An aggregate funcition computes a single result from multiple input rows
-- some are count, sum, avg, max and min
select max(temp_lo) from weather;

--if wanted to know which city that reading occured
select city from weather
    where temp_lo = (select max(temp_lo) from weather);

-- this is ok but subquery is an independent computation that 
-- computes ite own aggregate function separately from what is happening in outer query
-- aggregate is also useful with group by clause
-- we can get the maximum low temperature in each city with
select city, max(temp_lo)
    from weather
    group by city;

-- it gives one output from each city. each aggreagate result is computed over the table rows matching that city
-- we can filter these grouped rows using having clause

select city, max(temp_lo)
    from weather 
    group by city 
    having max(temp_lo) > 40;

-- if we only care about cities whose names begin with s
select city, max(temp_lo)
    from  weather 
    where city like 'S%' or city like 's%'
    group by city
    having max(temp_lo) > 40;

--update the table columns
update weather
    set temo_hi = temo_hi-2, temp_lo = temp_lo-2
    where date > '1994-11-28';

select * from weather;


-- rows can be removed from the table using the Delete command.
delete from weather 
    where city='hayward';

select * 
    from weather;

-- one should be vary of the form
-- delete from tablename;

--suppose the the combined listing of weather records and city location is 
--particular interest to your application,but you do not want to type the query eah time
-- you need it, you can create a view over the query, which gives a name to the query that you can refer
-- to like an ordinary table

-- create view thisview as
--     select city, temp_lo, temo_hi, prcp, date, location
--         from weather, cities 
--         where city = name;

select * from myview;



--foreign keys 
-- you want to make sure that no one can insert rows in the weather table that do not have matching entry
-- in the cities table. this is called maintaining the referential intigrity of your data. in simplistic 
-- database systems this would be implemented by first looking at cities table to check if a matching record exist
-- and then inserting or rejecting the new weather records . this appraoch has number of problems and is very 
-- in convinent, so PostgreSQL can do this for you 
-- create table cities2(
--     city        varchar(80) primary key,
--     location    point
-- );

-- create table weather2(
--     city        varchar(80) references cities2(city),
--     temp_lo     int,
--     temp_hi     int,
--     prcp        real,
--     date        date
-- );
-- insert into cities2 values('berkely', '(193, 46)');
-- insert into weather2 values('berkely', 45, 53, 0.0, '1994-11-28'); 
--  you will get an error like insert or update on weather table
--  voilates foreign key constraint 

-- transactions are fundamental concept of all database systems
-- The essential point of transaction is that it bundles multiple
-- steps into a single, all or nothing operation
-- consider bank database that contains balances for various customer accounts
-- as well as total deposit balances for branches

-- there are several updates need to be made or nothing to made if one of that failed, if updates happen, or none of them happen
-- in PostgreSQL transaction is setup by surrounding SQL commands of the transaction with BEGIN and COMMIT 
-- commands so our bannking treansaction would be like this

create table accounts(
    name        varchar(80),
    branchname  varchar(80) references branches(name), 
    acno        int,
    balance     real references branches(balance)
);

create table branches(
    name varchar(80) primary key,
    acno  int,
    balance real primary key
);

insert into branches values('banglore', 112233, 1000.0);

-- insert into accounts? values('alice', 'banglore', 112233, 1000.0);
