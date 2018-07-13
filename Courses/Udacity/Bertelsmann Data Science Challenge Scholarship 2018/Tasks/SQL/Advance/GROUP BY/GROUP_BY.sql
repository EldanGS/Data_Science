/*
GROUP BY Note
Now that you have been introduced to JOINs, GROUP BY, and aggregate functions, the real power of SQL starts to come to life. 
Try some of the below to put your skills to the test!

Questions: GROUP BY
1. Use the SQL environment below to assist with answering the following questions. 
Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

2. One part that can be difficult to recognize is when it might be easiest to use an aggregate or one of the other SQL functionalities. 
Try some of the below to see if you can differentiate to find the easiest solution.

3. Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

4. Find the total sales in usd for each account. You should include two columns 
- the total sales for each company's orders in usd and the company name.

5. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
Your query should return only three values - the date, channel, and account name.

6. Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the number of times the channel was used.

7. Who was the primary contact associated with the earliest web_event? 

8. What was the smallest order placed by each account in terms of total usd. 
Provide only two columns - the account name and the total usd. 
Order from smallest dollar amounts to largest.

9. Find the number of sales reps in each region. 
Your final table should have two columns - the region and the number of sales_reps. 
Order from fewest reps to most reps.

*/

# Solution 1
SELECT a.name, o.occurred_at
FROM orders as o
JOIN accounts as a
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1


# Solution 2
SELECT a.name, SUM(o.total_amt_usd) total_sales
FROM orders as o
JOIN accounts as a
ON a.id = o.account_id
GROUP BY a.name

# Solution 3
SELECT wb.channel, a.name, wb.occurred_at
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
ORDER BY wb.occurred_at DESC
LIMIT 1


# Solution 4
 SELECT wb.channel, COUNT(*)
 FROM web_events as wb
 GROUP BY wb.channel


# Solution 5
SELECT a.primary_poc
FROM accounts as a
JOIN web_events as wb
ON a.id = wb.account_id
ORDER BY wb.occurred_at 
LIMIT 1

# Solution 6
SELECT a.name, MIN(o.total_amt_usd) smallest_order
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order


# Solution 7
SELECT r.name, COUNT(*) num_reps
FROM sales_reps as sr
JOIN region as r
ON r.id = sr.region_id
GROUP BY r.name
ORDER BY num_reps




