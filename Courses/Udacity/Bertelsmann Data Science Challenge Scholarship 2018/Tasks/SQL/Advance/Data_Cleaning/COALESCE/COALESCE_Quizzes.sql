/*
COALESCE Quizzes
In this quiz, we will walk through the previous example using the following task list. We will use the COALESCE function to complete the orders record for the row in the table output.
Tasks to complete:
Task List

1. Run the query entered below in the SQL workspace to notice the row with missing data.

2. Use COALESCE to fill in the accounts.id column with the account.id for the NULL value for the table in 1.

3. Use COALESCE to fill in the orders.account_id column with the account.id for the NULL value for the table in 1.

4. Use COALESCE to fill in each of the qty and usd columns with 0 for the table in 1.

5.Run the query in 1 with the WHERE removed and COUNT the number of ids .

6.Run the query in 5, but with the COALESCE function used in questions 2 through 4.
*/

# Solution 1
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL

# Solution 2
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL

# Solution 3
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL

# Solution 4
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

# Solution 5
SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

# Solution 6
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
COALESCE(o.account_id, a.id) account_id, o.occurred_at, 
COALESCE(o.standard_qty, 0) standard_qty, 
COALESCE(o.gloss_qty,0) gloss_qty, 
COALESCE(o.poster_qty,0) poster_qty, 
COALESCE(o.total,0) total, 
COALESCE(o.standard_amt_usd,0) standard_amt_usd, 
COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;
