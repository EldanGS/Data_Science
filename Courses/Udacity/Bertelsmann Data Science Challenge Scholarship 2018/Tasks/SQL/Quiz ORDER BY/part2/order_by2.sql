### ORDER BY
/*
Question
2. Write a query that returns the top 10 rows from orders ordered according to oldest to newest,
	but with the smallest total_amt_usd for each date listed first for each date. You will notice each of these dates shows up as unique because of the time element. 
	When you learn about truncating dates in a later lesson, you will better be able to tackle this question on a day, month, or yearly basis. 
*/

SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;