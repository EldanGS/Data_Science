### OR
/*
Questions using the OR operator

3. Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', 
but it doesn't contain 'eana'.
*/

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND
	  (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND 
	  primary_poc NOT LIKE '%eana%'