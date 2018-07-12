/*
Questions: MIN, MAX, & AVERAGE
Use the SQL environment below to assist with answering the following questions. 
Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1. When was the earliest order ever placed? You only need to return the date.

2. Try performing the same query as in question 1 without using an aggregation function. 

3. When did the most recent (latest) web_event occur?

4. Try to perform the result of the previous query without using an aggregation function.

5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

6. Via the video, you might be interested in how to calculate the MEDIAN. 
Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
*/

# Solution 1
SELECT MIN(occurred_at) as min_date
FROM orders

# Solution 2
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1

# Solution 3
SELECT MAX(occurred_at) as last_date
FROM web_events

# Solution 4
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1


# Solution 5
SELECT AVG(standard_qty) as mean_standard,
	   AVG(gloss_qty) as mean_gloss,
       AVG(poster_qty) as mean_poster,
       AVG(standard_amt_usd) as mean_standard_usd,
       AVG(gloss_amt_usd) as mean_gloss_usd,
       AVG(poster_amt_usd) as mean_poster_usd,
       AVG(total_amt_usd) as mean_total_usd
FROM orders


# Solution 6
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) as Table1
ORDER BY total_amt_usd DESC
LIMIT 2

