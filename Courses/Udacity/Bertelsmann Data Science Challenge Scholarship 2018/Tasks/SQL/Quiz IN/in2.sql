### IN
/*
Questions using IN operator

*/

# Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')