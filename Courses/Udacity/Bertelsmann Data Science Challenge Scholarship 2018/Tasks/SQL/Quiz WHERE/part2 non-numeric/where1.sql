### WHERE
/*
Practice Question Using WHERE with Non-Numeric Data
	Filter the accounts table to include the company name, website, 
	and the primary point of contact (primary_poc) for Exxon Mobil in the accounts table.
*/

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';