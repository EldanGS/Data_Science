### NOT

/*
Questions using the NOT operator
We can pull all of the rows that were excluded from the queries in the previous two concepts with our new operator.
*/

# Use the web_events table to find all information regarding individuals who were contacted via any method except 
# using organic or adwords methods.

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

