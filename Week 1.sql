/* Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction (help)
Rename the new field with the Bank code 'Bank'. 
Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
Change the date to be the day of the week (help)
Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways (help):
1. Total Values of Transactions by each bank
2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
3. Total Values by Bank and Customer Code
Output each data file (help) */

use schema TIL_PLAYGROUND.PREPPIN_DATA_INPUTS

-- Week 1
select * 
from pd2023_wk01;

-- prep the data = split bank code, change to string person/in person/ change string date to dat and isolate weekdate 
select 
split_part(transaction_code, '-', 1) as Bank,
value,
customer_code,
(case online_or_in_person
when 1 then 'Online'
else 'In-person' end) as online_or_in_person,
decode(dayofweekiso(to_timestamp(transaction_date, 'DD/MM/YYYY HH24:MI:SS')),
    1, 'Monday',
    2, 'Tuesday',
    3, 'Wednesday',
    4, 'Thursday',
    5, 'Friday',
    6, 'Saturday',
    7, 'Sunday') as transaction_date
from pd2023_wk01;

-- Output 1
select 
split_part(transaction_code, '-', 1) as Bank,
sum(value) as Value
from pd2023_wk01
group by Bank ;

-- Output 2 
select 
split_part(transaction_code, '-', 1) as Bank,
sum(value) as Value,
(case online_or_in_person
when 1 then 'Online'
when 2 then 'In-Person' end) as online_or_in_person,
decode(dayofweekiso(to_timestamp(transaction_date, 'DD/MM/YYYY HH24:MI:SS')),
    1, 'Monday',
    2, 'Tuesday',
    3, 'Wednesday',
    4, 'Thursday',
    5, 'Friday',
    6, 'Saturday',
    7, 'Sunday') as transaction_date
from pd2023_wk01
group by 1, 3, 4;

--Output 3
select 
split_part(transaction_code, '-', 1) as Bank,
sum(value) as Value,
customer_code
from pd2023_wk01
group by Bank, customer_code;
