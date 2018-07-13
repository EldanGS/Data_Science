/*
Questions: DISTINCT
Use the SQL environment below to assist with answering the following questions. 
Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1. Use DISTINCT to test if there are any accounts associated with more than one region.

2. Have any sales reps worked on more than one account?
*/

# Solution 1
SELECT DISTINCT id, name
FROM accounts

# hard way
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;


# Solution 2
SELECT DISTINCT id, name
FROM sales_reps

# hard way 
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;