/*
COUNT the Number of Rows in a Table
Try your hand at finding the number of rows in each table. 
Here is an example of finding all the rows in the accounts table.
*/


SELECT COUNT(*)
FROM accounts;


# But we could have just as easily chosen a column to drop into the aggregation function:

SELECT COUNT(accounts.id)
FROM accounts;
