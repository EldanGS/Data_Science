/*
Quizzes POSITION & STRPOS
You will need to use what you have learned about LEFT & RIGHT, as well as what you know about POSITION or STRPOS to do the following quizzes.

1. Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc. 

2. Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
*/

# Solution 1
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) first_name, 
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts

                                  
# Solution 2
SELECT LEFT(name, STRPOS(name, ' ') - 1) first_name, 
RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps

