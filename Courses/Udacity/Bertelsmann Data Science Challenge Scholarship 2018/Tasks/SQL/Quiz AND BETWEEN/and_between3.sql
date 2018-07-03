### AND BETWEEN
/*
Questions using AND and BETWEEN operators

3. Use the web_events table to find all information regarding individuals who were contacted via organic or adwords and started their account 
at any point in 2016 sorted from newest to oldest.
*/

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') 
			  AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC
