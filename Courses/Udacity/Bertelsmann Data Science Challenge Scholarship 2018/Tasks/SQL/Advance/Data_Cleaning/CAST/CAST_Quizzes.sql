/*
CAST Quizzes
For this set of quiz questions, you are going to be working with a single table in the environment below. This is a different dataset than Parch & Posey, as all of the data in that particular dataset were already clean.
Tasks to complete:
Task List

1. Write a query to look at the top 10 rows to understand the columns and the raw data in the dataset called sf_crime_data.

2. Remembering back to the lesson on dates, use the Quiz Question at the bottom of this page to make sure you remember the format that dates should use in SQL.

3. Look at the date column in the sf_crime_data table. Notice the date is not in the correct format.

4. Write a query to change the date into the correct SQL date format. You will need to use at least SUBSTR and CONCAT to perform this operation.

5. Once you have created a column in the correct format, use either CAST or :: to convert this to a date.

*/


# Solution 1 
SELECT *
FROM sf_crime_data
LIMIT 10


# Solution 2
-- yyy-mm-ddd

# Solution 3-4
SELECT date original_date, 
(SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data


# Solution 5
SELECT date original_date, 
(SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data

