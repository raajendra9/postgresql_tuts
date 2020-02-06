create table test(pri integer primary key,
                    testing smallint,
                    bignumber bigint,
                    numericdatatype numeric, --with numeric we can add point numbers like 2.3434, 5454.5454
                    realdata real, -- with this data type we can add number with upto four decimal points
                    doubleprecision double precision, --with this we can use updo 15 decimal points
                    smallserials smallserial); -- it will auto increament the value
