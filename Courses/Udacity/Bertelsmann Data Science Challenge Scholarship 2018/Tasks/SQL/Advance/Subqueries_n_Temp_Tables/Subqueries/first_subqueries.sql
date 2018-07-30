/*
Tasks to complete.
Task List

Use the test environment below to find the number of events that occur for each day for each channel.

Quiz 1

Now create a subquery that simply provides all of the data from your first query.

Quiz 2

Now find the average number of events for each channel. Since you broke out by day earlier, this is giving you an average per day.

Quiz 3

*/

# Solution 1
SELECT DATE_TRUNC('day',occurred_at) AS day,
   channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC



# Solution 2
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
           channel, COUNT(*) as events
     FROM web_events 
     GROUP BY 1,2
     ORDER BY 3 DESC) sub


# Solution 3
SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC