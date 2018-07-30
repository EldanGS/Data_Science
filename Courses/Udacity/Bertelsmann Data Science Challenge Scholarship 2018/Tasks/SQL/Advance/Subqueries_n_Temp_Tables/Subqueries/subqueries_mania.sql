/*
More Subqueries Quizzes
Above is the ERD for the database again - it might come in handy as you tackle the quizzes below. 
You should write your solution as a subquery or subqueries, not by finding one solution and copying the output. 
The importance of this is that it allows your query to be dynamic in answering the question - even if the data changes, 
you still arrive at the right answer.

1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed? 

3. For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, 
how many accounts still had more in total purchases? 

4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, 
how many web_events did they have for each channel?

5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

6. What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all orders.
*/


# Solution 1.1
SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd)
FROM sales_reps as s
JOIN accounts as a
ON a.sales_rep_id = s.id
JOIN orders as o
ON o.account_id = a.id
JOIN region as r
ON s.region_id = r.id
GROUP BY 1, 2
ORDER BY 3 DESC


# Solution 1.2
SELECT region_name, MAX(total_amt) total_amt
  FROM (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
  FROM sales_reps as s
  JOIN accounts as a
  ON a.sales_rep_id = s.id
  JOIN orders as o
  ON o.account_id = a.id
  JOIN region as r
  ON s.region_id = r.id
  GROUP BY 1, 2) t1
GROUP BY 1


# Solution 1.3
SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;



# Solution 2.1
SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name;

# Solution 2.2
SELECT MAX(total_amt)
FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY r.name) sub;


# Solution 3.1
SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


# Solution 3.2
SELECT a.name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT total 
                  FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                        FROM accounts a
                        JOIN orders o
                        ON o.account_id = a.id
                        GROUP BY 1
                        ORDER BY 2 DESC
                        LIMIT 1) sub);


# Solution 4.1
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1

# Solution 4.2
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id
                     FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                           FROM orders o
                           JOIN accounts a
                           ON a.id = o.account_id
                           GROUP BY a.id, a.name
                           ORDER BY 3 DESC
                           LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;



# Solution 5.1
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 10

# Solution 5.2
SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;



# Solution 6.1
SELECT AVG(o.total_amt_usd) avg_all
FROM orders o
JOIN accounts a
ON a.id = o.account_id


# Solution 6.2
SELECT o.account_id, AVG(o.total_amt_usd)
FROM orders o
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                               FROM orders o
                               JOIN accounts a
                               ON a.id = o.account_id);

# Solution 6.3
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                               FROM orders o
                               JOIN accounts a
                               ON a.id = o.account_id)) temp_table;