/* For the transactions file:
Filter the transactions to just look at DSB (help)
These will be transactions that contain DSB in the Transaction Code field
Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
Change the date to be the quarter (help)
Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) (help)
For the targets file:
Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter (help)
 Rename the fields
Remove the 'Q' from the quarter field and make the data type numeric (help)
Join the two datasets together (help)
You may need more than one join clause!
Remove unnecessary fields
Calculate the Variance to Target for each row (help)
Output the data */

use schema TIL_PLAYGROUND.PREPPIN_DATA_INPUTS

-- Week 3

-- prepping the data, filtering to just DSB and turning date to quarter
with table_prep as (select 
split_part(transaction_code, '-', 1) as Bank,
(case online_or_in_person
when 1 then 'Online'
else 'In-Person' end) as online_or_in_person_prep,
quarter(date(transaction_date, 'DD/MM/YYYY HH24:MI:SS')) as quarter_date,
value
from pd2023_wk01
where Bank = 'DSB'),

-- grouping the value by online/in-person and value
group_table_prep as (
select
online_or_in_person_prep,
quarter_date,
sum(value) as total_value
from table_prep
group by 1,2),

-- unpivoting and string parse of results table
table_results as (
select 
online_or_in_person,
substr(target_quarter, 2, 1)::int as Quarter,
Quarterly_Targets
from pd2023_wk03_targets
unpivot(
Quarterly_Targets
for target_quarter in (Q1, Q2, Q3, Q4)) 

)

-- join both tables and calculate variance
select online_or_in_person,
Quarter,
total_value,
quarterly_targets,
(total_value- quarterly_targets) as Variance_to_Target
from group_table_prep as a 
inner join table_results b 
on a.online_or_in_person_prep = b. online_or_in_person and 
a.quarter_date = b.quarter;



