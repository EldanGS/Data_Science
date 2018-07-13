/*
Questions: GROUP BY Part II
Use the SQL environment below to assist with answering the following questions. 
Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1. For each account, determine the average amount of each type of paper they purchased across their orders. 
Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account. 

2. For each account, determine the average amount spent per order on each paper type. 
Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

3. Determine the number of times a particular channel was used in the web_events table for each sales rep. 
Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. 
Order your table with the highest number of occurrences first.

4. Determine the number of times a particular channel was used in the web_events table for each region. 
Your final table should have three columns - the region name, the channel, and the number of occurrences. 
Order your table with the highest number of occurrences first.
*/

# Solution 1
SELECT a.name, AVG(o.standard_qty) avg_std,
			   AVG(o.gloss_qty) avg_gloss,
               AVG(o.poster_qty) avg_poster
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name


# Solution 2
SELECT a.name, AVG(o.standard_amt_usd) avg_std,
			   AVG(o.gloss_amt_usd) avg_gloss,
               AVG(o.poster_amt_usd) avg_poster
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name


# Solution 3
SELECT sr.name, wb.channel, COUNT(*) num_events
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
JOIN sales_reps as sr
ON sr.id = a.sales_rep_id
GROUP BY sr.name, wb.channel
ORDER BY num_events DESC

# Solution 4
SELECT r.name, wb.channel, COUNT(*) num_events
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
JOIN sales_reps as sr
ON sr.id = a.sales_rep_id
JOIN region r
ON r.id = sr.region_id
GROUP BY r.name, wb.channel
ORDER BY num_events DESC

