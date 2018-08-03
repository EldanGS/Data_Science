/*
Above is the ERD for the database again - it might come in handy as you tackle the quizzes below. 
You should write your solution as using a WITH statement, not by finding one solution and copying the output. 
The importance of this is that it allows your query to be dynamic in answering the question - even if the data changes, you still arrive at the right answer.

1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

2. For the region with the largest sales total_amt_usd, how many total orders were placed? 

3. For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases? 

4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

6. What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all accounts.
*/


# Solution 1
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
  FROM sales_reps s
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  JOIN region r
  ON r.id = s.region_id
  GROUP BY 1, 2
  ORDER BY 3 DESC),
t2 AS(
  SELECT region_name, MAX(total_amt) total_amt
  FROM t1
  GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;


# Solution 2
WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name), 
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);


# Solution 3
WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1), 
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;


# Solution 4
WITH t1 AS(
  SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1, 2
  ORDER BY 3 DESC
  LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id and a.id = (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC


# Solution 5
WITH t1 AS(
  SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1, 2
  ORDER BY 3 DESC
  LIMIT 10)
SELECT AVG(total_spent)
FROM t1


# Solution 6
WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;


