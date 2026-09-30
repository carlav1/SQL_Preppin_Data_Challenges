/* 

We want to stack the tables on top of one another, since they have the same fields in each sheet. We can do this one of 2 ways (help):
Drag each table into the canvas and use a union step to stack them on top of one another
Use a wildcard union in the input step of one of the tables
Some of the fields aren't matching up as we'd expect, due to differences in spelling. Merge these fields together
Make a Joining Date field based on the Joining Day, Table Names and the year 2023
Now we want to reshape our data so we have a field for each demographic, for each new customer (help)
Make sure all the data types are correct for each field
Remove duplicates (help)
If a customer appears multiple times take their earliest joining date */

-- Create the joining date for each table and union them all together

use schema TIL_PLAYGROUND.PREPPIN_DATA_INPUTS

with table_union as (

select id,
demographic,
value,
to_date(concat(joining_day,'/',01,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_january

union all

select id,
demographic,
value,
to_date(concat(joining_day,'/',02,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_february

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',03,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_march

union all

select id,
demographic,
value,
to_date(concat(joining_day,'/',04,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_april

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',05,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_may

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',06,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_june

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',07,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_july

union all 

select id,
demographiic,
value,
to_date(concat(joining_day,'/',08,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_august

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',09,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_september

union all 

select id,
demagraphic,
value,
to_date(concat(joining_day,'/',10,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_october

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',11,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_november 

union all 

select id,
demographic,
value,
to_date(concat(joining_day,'/',12,'/', 2023), 'DD/MM/YYYY') as Joining_Date
from pd2023_wk04_december

),

-- pivot the table (rows to column)

pivot_table as (

select *
from table_union
pivot(max(value)
for demographic in ('Ethnicity', 'Account Type', 'Date of Birth')

)
),

-- create the rank

rank_table as (
select
id,
Joining_Date,
"'Account Type'" as Account_Type,
to_date("'Date of Birth'", 'MM/DD/YYYY') as Date_of_Birth, 
"'Ethnicity'" as Ethnicity,
row_number() over (partition by id order by Joining_Date ASC) as row_num
from pivot_table

)

-- removing duplicates and selecting final fields

select id,
Joining_Date,
Account_Type,
Date_of_Birth,
Ethnicity
from rank_table 
where row_num =1;

