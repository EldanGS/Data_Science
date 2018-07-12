### ORDER BY
/*
Practice
In order to gain some practice using ORDER BY:

Write a query to return the bottom 20 orders in terms of least total. 
Include the id, account_id, and total.
*/

SELECT id, occurred_at, total
FROM orders
ORDER BY total
LIMIT 20;
