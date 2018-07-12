/* Questions

1. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.

2. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name. 

3. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.

4. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01). 

5. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 

6. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 

7. What are the different channels used by account id 1001.
Your final table should have only 2 columns: account name and the different channels. 
You can try SELECT DISTINCT to narrow down the results to only the unique values.

8. Find all the orders that occurred in 2015. 
Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
*/

/*
1. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT a.name account, r.name region, sr.name rep
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER by a.name


/*
2. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name. 
*/
SELECT a.name account, r.name region, sr.name rep
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id
WHERE sr.name LIKE 'S%' AND r.name = 'Midwest'
ORDER by a.name


/*
3. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT a.name account, r.name region, sr.name rep
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id
WHERE sr.name LIKE '% K%' AND r.name = 'Midwest'
ORDER by a.name


/*
4. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01). 
*/
SELECT a.name account, r.name region, o.total_amt_usd / (o.total + 0.01) unit_price
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id
JOIN orders as o
ON a.id = o.account_id
WHERE o.standard_qty > 100


/*
5. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 
*/
SELECT a.name account, r.name region, o.total_amt_usd / (o.total + 0.01) unit_price
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id
JOIN orders as o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price


/*
6. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 
*/
SELECT a.name account, r.name region, o.total_amt_usd / (o.total + 0.01) unit_price
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
JOIN accounts as a
ON sr.id = a.sales_rep_id
JOIN orders as o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC


/*
7. What are the different channels used by account id 1001.
Your final table should have only 2 columns: account name and the different channels. 
You can try SELECT DISTINCT to narrow down the results to only the unique values.
*/
SELECT DISTINCT a.name, w.channel
FROM accounts as a
JOIN web_events as w
ON a.id = w.account_id
WHERE a.id = '1001'

/*
8. Find all the orders that occurred in 2015. 
Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
*/
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;


