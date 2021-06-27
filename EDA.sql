/*
Name: Connor Oakman
Date: 27/07/2021
Description: Data Exploration of StudentsPerformance table
*/

-- Rename table column to remove the slash character
ALTER TABLE StudentsPerformance
RENAME COLUMN "race/ethnicity"  TO race



-- Check table
SELECT *
FROM
	StudentsPerformance
LIMIT
	10




-- Compare average math reading and writing marks across genders
SELECT
	gender,
	round(avg(mathscore), 2) as [Average math mark],
	round(avg(readingscore), 2) as [Average reading mark],
	round(avg(writingscore), 2) as [Average writing mark]
FROM
	StudentsPerformance
GROUP BY
	gender




-- Average mark for each gender, race combination
-- Average mark in order from lowest to highest by race is A, B, C, D, E
SELECT
	gender,
	race,
	round(avg(mathscore), 2) as [Average math mark],
	round(avg(readingscore), 2) as [Average reading mark],
	round(avg(writingscore), 2) as [Average writing mark]
FROM
	StudentsPerformance
GROUP BY
	race, gender




-- Average mark depending on parents level of education
-- See average mark in all subjects generally increases with parents level of education
SELECT
	parentallevelofeducation,
	round(avg(mathscore), 2) as [Average math mark],
	round(avg(readingscore), 2) as [Average reading mark],
	round(avg(writingscore), 2) as [Average writing mark],
	round(avg((writingscore + mathscore + readingscore)/3), 2) as [Total Average]
FROM
	StudentsPerformance
GROUP BY
	parentallevelofeducation
ORDER BY
	[Total Average] DESC






-- Average mark for those that did and didn't take the test preparation course
SELECT
	testpreparationcourse,
	round(avg(mathscore), 2) as [Average math mark],
	round(avg(readingscore), 2) as [Average reading mark],
	round(avg(writingscore), 2) as [Average writing mark]
FROM
	StudentsPerformance
GROUP BY
	testpreparationcourse





-- Compare whether certain groups are more or less likely to take the test prep course
-- No significant difference between male and female
SELECT
	gender,
	testpreparationcourse,
	count(*) as [no. of students],
	(count(*)* 100 /(select count(*) from StudentsPerformance)) as [Percentage of total]
FROM
	StudentsPerformance
GROUP BY
	gender, testpreparationcourse




-- Group by race and testpreparationcourse,
-- Calculate total preparation course takers by race and proportions
-- Group E has highest proportion of preperation course takers, all others roughly equal
SELECT s.race, s.testpreparationcourse, count(*), round((0.0+ count(*))/rSum, 2) [Proportion/race group]
FROM StudentsPerformance as s
JOIN
	(
	select race, count(*) as rSum
	from StudentsPerformance
	group by race
	) as tmp on s.race=tmp.race
GROUP BY
	s.race, s.testpreparationcourse
