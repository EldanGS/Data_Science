### Arithmetic Operations

/*
Questions using Arithmetic Operations
Using the orders table:

Write a query that finds the percentage of revenue that comes from poster paper for each order. 
You will need to use only the columns that end with _usd. (Try to do this without using the total column). 
Include the id and account_id fields. NOTE - you will be thrown an error with the correct solution to this question. 
This is for a division by zero. You will learn how to get a solution without an error to this query when you learn about CASE statements in a later section. 
For now, you might just add some very small value to your denominator as a work around. 
*/

SELECT id, account_id, 
       poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders;