### AND BETWEEN
/*
Questions using AND and BETWEEN operators

2. Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.
*/

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s'
