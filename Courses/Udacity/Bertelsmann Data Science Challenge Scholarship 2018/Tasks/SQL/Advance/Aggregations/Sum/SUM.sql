/*
Aggregation Questions
Use the SQL environment below to find the solution for each of the following questions. 
If you get stuck or want to check your answers, you can find the answers at the top of the next concept.

1. Find the total amount of poster_qty paper ordered in the orders table.

2. Find the total amount of standard_qty paper ordered in the orders table.

3. Find the total dollar amount of sales using the total_amt_usd in the orders table.

4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. 
This should give a dollar amount for each order in the table.

5. Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
*/

# Solution 1
SELECT SUM(poster_qty)
FROM orders
# out: 723646

# Soltuion 2
SELECT SUM(standard_qty)
FROM orders
# out: 1938346

# Solution 3
SELECT SUM(total_amt_usd)
FROM orders
# out: 23141511.83

# Solution 4
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders

# Solution 5
SELECT SUM(standard_amt_usd) / SUM(standard_qty) AS standard_price_per_unit
FROM orders
# out: standard_price_per_unit
#      4.9900000000000000

