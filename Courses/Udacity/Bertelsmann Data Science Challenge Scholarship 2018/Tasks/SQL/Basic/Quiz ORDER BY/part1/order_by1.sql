### ORDER BY
/*
Practice
In order to gain some practice using ORDER BY:

1 Write a query to return the 10 earliest orders in the orders table. 
Include the id, occurred_at, and total_amt_usd.
*/

SELECT id, occurred_at, total_amt_usd
FROM orders
LIMIT 10;
