--1. Write a query that allows you to inspect the schema of the naep table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep'; 

--2.Write a query that returns the first 50 records of the naep table.
SELECT *
FROM naep
LIMIT 50; 

--3. Write a query that returns summary statistics for avg_math_4_score by state. 
--Make sure to sort the results alphabetically by state name
SELECT state, ROUND(AVG (avg_math_4_score)) AS avgmath4score, MAX(avg_math_4_score)AS maxmath4score, MIN(avg_math_4_score)AS minmath4score
FROM naep
GROUP BY state
ORDER BY state; 

--4. Write a query that alters the previous query so that it returns 
--only the summary statistics for avg_math_4_score by state 
--with differences in max and min values that are greater than 30.
SELECT state, ROUND(AVG (avg_math_4_score),2) AS avgmathscore, MAX(avg_math_4_score)AS maxmath4score, MIN(avg_math_4_score)AS minmath4score
FROM naep 
GROUP BY state
HAVING (MAX(avg_math_4_score) - MIN (avg_math_4_score)>30)
ORDER BY state; 

--5. returns a field called bottom_10_states. 
--This field should list the states in the bottom 10 for avg_math_4_score in the year 2000.
SELECT state, avg_math_4_score AS bottom_10_states
FROM naep
WHERE year = 2000
	AND avg_math_4_score IS NOT NULL
GROUP BY state, avg_math_4_score
ORDER BY avg_math_4_score 
LIMIT 10; 


--6. calculates the average avg_math_4_score, rounded to the nearest two decimal places, 
--over all states in the year 2000.

SELECT ROUND(AVG(avg_math_4_score), 2) AS average4mathscore
FROM naep
WHERE year = 2000;
--224.80


--7. returns a field called below_average_states_y2000. 
--This field should list all states with an avg_math_4_score less than the average over all states in the year 2000. 
SELECT state, ROUND(AVG(avg_math_4_score), 2) AS below_average_states_y2000
FROM naep
WHERE year = 2000
	AND avg_math_4_score < 224.80
GROUP BY state, avg_math_4_score
ORDER BY avg_math_4_score;

--8. Write a query that returns a field called scores_missing_y2000 
--that lists any states with missing values in the avg_math_4_score column of the naep table for the year 2000
SELECT state AS scores_missing_y2000 
FROM naep
WHERE year = 2000
	AND avg_math_4_score IS NULL
GROUP BY state, avg_math_4_score
ORDER BY avg_math_4_score;



--9. returns, for the year 2000, the state, avg_math_4_score, and total_expenditure from the naep table, 
--joined using the LEFT OUTER JOIN clause with the finance table. 
--Use id as the key and order the output by total_expenditure from greatest to least. 
--Make sure to round avg_math_4_score to the nearest two decimal places, and 
--then filter out NULL values in avg_math_4_scores in order to see any correlation more clearly.
SELECT n.state, ROUND(avg_math_4_score, 2), f.total_expenditure
FROM naep AS n
	LEFT OUTER JOIN finance AS f
		ON n.id = f.id
WHERE n.year = 2000
	AND avg_math_4_score IS NOT NULL
GROUP BY n.state, avg_math_4_score, f.total_expenditure
ORDER BY f.total_expenditure DESC;