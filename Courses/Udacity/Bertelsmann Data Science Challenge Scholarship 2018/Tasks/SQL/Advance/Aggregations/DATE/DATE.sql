/*
Questions: Working With DATEs
Use the SQL environment below to assist with answering the following questions. 
Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1. Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
Do you notice any trends in the yearly sales totals?

2. Which month did Parch & Posey have the greatest sales in terms of total dollars? 
Are all months evenly represented by the dataset?

3. Which year did Parch & Posey have the greatest sales in terms of total number of orders? 
Are all years evenly represented by the dataset?

4. Which month did Parch & Posey have the greatest sales in terms of total number of orders? 
Are all months evenly represented by the dataset?

5. In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/


# Solution 1
SELECT DATE_PART('year', occurred_at) ord_year,
		SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1t
ORDER BY 2 DESC


# Solution 2
SELECT DATE_PART('month', occurred_at) ord_month,
		SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC


# Solution 3
SELECT DATE_PART('year', occurred_at) ord_month,
		COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC


# Solution 4
SELECT DATE_PART('month', occurred_at) ord_month,
		COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC


# Solution 5
SELECT DATE_PART('month', o.occurred_at) ord_month,
		SUM(o.gloss_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1