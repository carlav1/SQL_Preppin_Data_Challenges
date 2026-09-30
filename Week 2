/* In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string (hint)
Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account (hint)
Add a field for the Country Code (hint)
Hint: all these transactions take place in the UK so the Country Code should be GB
Create the IBAN as above (hint)
Hint: watch out for trying to combine sting fields with numeric fields - check data types
Remove unnecessary fields (hint)
Output the data */

use schema TIL_PLAYGROUND.PREPPIN_DATA_INPUTS

-- Week 2

-- replace dashes in sort code, join, and concat all columns together
select transaction_id,
CONCAT('GB', check_digits, swift_code, replace(sort_code, '-',''), account_number) as IBAN
from pd2023_wk02_transactions as a
inner join pd2023_wk02_swift_codes as b
on a.bank = b.bank;
