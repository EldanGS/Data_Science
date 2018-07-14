/*
Questions: HAVING
Use the SQL environment below to assist with answering the following questions. 
Whether you get stuck or you just want to double check your solutions, 
my answers can be found at the top of the next concept.

1. How many of the sales reps have more than 5 accounts that they manage?

2. How many accounts have more than 20 orders?

3. Which account has the most orders?

4. How many accounts spent more than 30,000 usd total across all orders?

5. How many accounts spent less than 1,000 usd total across all orders?

6. Which account has spent the most with us?

7. Which account has spent the least with us?

8. Which accounts used facebook as a channel to contact customers more than 6 times?

9. Which account used facebook most as a channel? 

10. Which channel was most frequently used by most accounts?
*/

# Solution 1
SELECT sr.id, sr.name, COUNT(*) as num_accounts
FROM accounts as a
JOIN sales_reps as sr
ON sr.id = a.sales_rep_id
GROUP BY sr.id, sr.name
HAVING COUNT(*) > 5
ORDER BY num_accounts

# Solution 2
SELECT a.id, a.name, COUNT(*) as num_orders
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders

# Solution 3
SELECT a.id, a.name, COUNT(*) as num_orders
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1

# Solution 4
SELECT a.id, a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent

# Solution 5
SELECT a.id, a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent

# Solution 6
SELECT a.id, a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC 
LIMIT 1

# Solution 7
SELECT a.id, a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent 
LIMIT 1

# Solution 8
SELECT a.id, a.name, wb.channel, COUNT(*) as use_of_channel
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
GROUP BY a.id, a.name, wb.channel
HAVING COUNT(*) > 6 and wb.channel = 'facebook'
ORDER BY use_of_channel

# Solution 9
SELECT a.id, a.name, wb.channel, COUNT(*) as use_of_channel
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
WHERE wb.channel = 'facebook'
GROUP BY a.id, a.name, wb.channel
ORDER BY use_of_channel DESC 
LIMIT 1

# Solution 10
SELECT a.id, a.name, wb.channel, COUNT(*) as use_of_channel
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
GROUP BY a.id, a.name, wb.channel
ORDER BY use_of_channel DESC 
LIMIT 10
