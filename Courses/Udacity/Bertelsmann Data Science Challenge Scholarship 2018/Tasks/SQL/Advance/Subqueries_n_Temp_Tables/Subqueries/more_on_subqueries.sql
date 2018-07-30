/*
Tasks to complete:
Task List

Use DATE_TRUNC to pull month level information about the first order ever placed in the orders table.

Quiz 1

Use the result of the previous query to find only the orders that took place in the same month and year as the first order, and then pull the average for each type of paper qty in this month.

Quiz 2
*/

# Solution 1.1
SELECT DATE_TRUNC('month', occurred_at) as month
FROM orders
GROUP BY 1
ORDER BY 1 
LIMIT 1;

# Solution 1.2
SELECT DATE_TRUNC('month', MIN(occurred_at)) 
FROM orders;


# Solution 2
SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

