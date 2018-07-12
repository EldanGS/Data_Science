### NOT

/*
Questions using the NOT operator
We can pull all of the rows that were excluded from the queries in the previous two concepts with our new operator.

Use the accounts table to find:
*/

# All the companies whose names do not start with 'C'.

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%'


# All companies whose names do not contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%'


# All companies whose names do not end with 's'.

SELECT name
FROM accounts
WHERE name NOT LIKE '%s'
