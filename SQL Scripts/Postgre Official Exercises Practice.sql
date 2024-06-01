
------------------------------------------------------------------------------------------------------

/*
Practice Problems from Postgre Official ExerciseExercise
*/

/*
Note 
These queries will need the Postgre Exercise Database, which is not available to us.
Run these queries in the Postgre's own Exercise Website.
Database Schema is available there to get the gist of the used relational database.
*/
------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------
------------------------ BASIC and JOINS ------------------------ 
-----------------------------------------------------------------


/*
Postgre Exercise
https://pgexercises.com/questions/joins/threejoin2.html
New --> Use of CASE Statement in the WHERE Clause
If we have to apply different filtering condition on specific colum or based on specific column, use CASE in WHERE clause
*/
--1st Approach
SELECT m.firstname || ' ' || m.surname member, f.name facility,
	CASE 
		WHEN m.memid = 0 THEN b.slots*f.guestcost
		ELSE b.slots*f.membercost
	END AS cost
FROM cd.members m INNER JOIN cd.bookings b USING(memid)
	INNER JOIN cd.facilities f USING(facid)
WHERE b.starttime BETWEEN '2012-09-14' AND '2012-09-15' 
	AND ( (m.memid = 0 AND b.slots*f.guestcost > 30) OR
		  (m.memid !=0 AND b.slots*f.membercost > 30) )
ORDER BY cost DESC;

--2nd Approach
-- Using CASE statement in the WHERE clause
SELECT m.firstname || ' ' || m.surname member, f.name facility,
	CASE 
		WHEN m.memid = 0 THEN b.slots*f.guestcost
		ELSE b.slots*f.membercost
	END AS cost
FROM cd.members m INNER JOIN cd.bookings b USING(memid)
	INNER JOIN cd.facilities f USING(facid)
WHERE b.starttime BETWEEN '2012-09-14' AND '2012-09-15' AND
	CASE 
		WHEN m.memid = 0 THEN b.slots*f.guestcost > 30
		ELSE b.slots*f.membercost > 30
	END
ORDER BY cost DESC;


/*
Postgre Exercise
https://pgexercises.com/questions/joins/tjsub.html
Simplify above solution using subquery
New --> Use of Subquery or CTE to use the CONDITION on the newly created Column using CASE or by WINDOW FUNCTION. 
*/
-- 1st Approach (Subquery as CTE)
WITH m_b_f AS
(SELECT m.firstname || ' ' || m.surname member, f.name facility,
	CASE 
		WHEN m.memid = 0 THEN b.slots*f.guestcost
		ELSE b.slots*f.membercost
	END AS cost 
 FROM cd.members m INNER JOIN cd.bookings b USING(memid)
	INNER JOIN cd.facilities f USING(facid)
 WHERE starttime BETWEEN '2012-09-14' AND '2012-09-15')
SELECT * FROM m_b_f
WHERE cost > 30
ORDER BY cost DESC;
-- I've used CTE to declare the Table before and THEN use the "cost" column from there to directly filter the Rows,
-- without having to use the CASE statement again.
	

-- 2nd Approach Subquery directly within the FROM clause
SELECT member, facility, cost
FROM (SELECT m.firstname || ' ' || m.surname member, f.name facility,
		CASE 
			WHEN m.memid = 0 THEN b.slots*f.guestcost
			ELSE b.slots*f.membercost
		END AS cost 
 	  FROM cd.members m INNER JOIN cd.bookings b USING(memid)
		INNER JOIN cd.facilities f USING(facid)
	  WHERE starttime BETWEEN '2012-09-14' AND '2012-09-15') AS m_b_f
WHERE cost > 30
ORDER BY cost DESC;



/*
Postgre Exercise
https://pgexercises.com/questions/joins/sub.html
New --> Use of Subquery in SELECT clause
*/
SELECT DISTINCT mem.firstname || ' ' || mem.surname member,
 (SELECT rec.firstname || ' ' || rec.surname recommender FROM cd.members rec WHERE rec.memid = mem.recommendedby)
FROM cd.members mem
ORDER BY member, recommender;



------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------
--------------------------- AGGREGATES -------------------------- 
-----------------------------------------------------------------


/*
Postgre Exercise
https://pgexercises.com/questions/aggregates/facrev2.html
New --> Use of Subquery in FROM clause "for applying filtering condition on newly created Aggregated column Revenue"
*/
SELECT fb.name, revenue
FROM (SELECT f.name, SUM(CASE
							WHEN memid=0 THEN slots*guestcost
							WHEN memid!=0 THEN slots*membercost
						 END) AS revenue
	 FROM cd.bookings JOIN cd.facilities f USING(facid) 
	 GROUP BY f.name) AS fb
WHERE revenue < 1000
ORDER BY revenue;



SELECT facid, SUM(slots)
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) = (SELECT MAX(SUM(slots)) FROM cd.bookings GROUP BY facid);




/*
Postgre Exercise
https://pgexercises.com/questions/aggregates/nbooking.html
***New --> For the new thing for this problem, see after this solution
*/
SELECT surname, firstname, memid, MIN(starttime)
FROM cd.members m JOIN cd.bookings b USING(memid)
WHERE starttime > '2012-09-01'
GROUP BY surname, firstname, memid
ORDER BY memid;
/*
Now what if we also want to print number of slots booked for their earliest joindate in September.
(Basically, we want to SELECT the column, which is not used in grouping or aggregating call. How can we do so?)
We can't use column for retrieving which is not used in aggregating and grouping

SOLUTION
1st What I've done is, first i've found the normal aggregated result using GROUP BY, then I've joined this table
  	with another table that consists of the attribute that we want to retrieve. AND match this tables on the aggrgated result.
  	One important thing to note here is, we've to use all the common column in the matching condition 
  	in order for the correct mapping 
   (that is, apart from aggregated result, we've to use  combination of matching column to make it unique identifier.)

(BEST as per me)
2nd SELECT all the column, append the aggregated result as a colum at the end in all the records using WINDOW function (OVER())
	Then using above query, retrieve those records, in which aggregated result MATCHES the attribute value.
	This way, we've retain all the the other information of that aggregated record and, we don't have to use JOIN for this
	This logic is also easy to remember.

(Not so effective)
3rd SELECT all the column and append the aggregated result column at the end using WINDOW function. 
	Join this table with itself and use the aggregated result for amtching plus all the matching column for the unique identifier.
	This code is not efficient, is time taking, and not understandable.
*/
--1st Solution
WITH joindate AS
(SELECT surname, firstname, memid, MIN(starttime) starttime
FROM cd.members m JOIN cd.bookings b USING(memid)
WHERE starttime > '2012-09-01'
GROUP BY surname, firstname, memid)
SELECT j.surname, j.firstname, j.memid, b.memid, j.starttime, b.starttime, slots
FROM joindate j JOIN cd.bookings b ON j.memid=b.memid AND j.starttime=b.starttime
ORDER BY j.memid;
	
-- 2nd Solution (------- BEST APPROACH -------)
WITH cust_join AS
(SELECT surname, firstname, memid, starttime, slots,
	MIN(starttime) OVER(PARTITION BY surname, firstname, memid) min_starttime
FROM cd.members m JOIN cd.bookings b USING(memid)
WHERE starttime > '2012-09-01'
ORDER BY memid)
SELECT surname, firstname, memid, starttime, slots
FROM cust_join
WHERE starttime = min_starttime
ORDER BY memid;


-- 3rd SOlution (Not so effective One)
WITH joindate AS 
(SELECT DISTINCT surname, firstname, memid, starttime, MIN(starttime) OVER(PARTITION BY surname, firstname, memid) AS jointime, slots
FROM cd.members m JOIN cd.bookings b USING(memid)
WHERE starttime > '2012-09-01')
SELECT j1.surname, j1.firstname, j1.memid, j1.jointime, j1.slots 
FROM joindate j1 JOIN joindate j2 ON j1.memid=j2.memid AND j1.starttime=j2.jointime AND j1.starttime=j2.starttime
ORDER BY j1.memid;



/*
	Self Question (Problem for above Pattern. and Based on above logic.)
Find the Facility which has Maximum slots booked in each month. Retrieve month, facid, and slots
Steps ==>
	* First we Calculate the Total slots for each (month, facid) pair 
	* Second, We calculate the Max slots for each month from the first step, AND append it to end
	* Third, we display the Month with facility which has slots booking equal to maximum bookings

In second step, we use OVER() window function than group by, because if we use group by, 
	then we can't retrieve the facid column. Sql don't know which facid has these max slots.
	That's why we use OVER () Window function and then compare the bookings with max using WHERE.
	*/
WITH fac_slots AS
	(SELECT EXTRACT(MONTH FROM starttime) AS month, facid, SUM(slots) AS total_slots 
 	 FROM cd.bookings GROUP BY EXTRACT(MONTH FROM starttime), facid),
	fac_max_slots AS
	(SELECT month, facid, total_slots, MAX(total_slots) OVER(PARTITION BY month) max_slots FROM fac_slots)
SELECT month, facid, total_slots FROM fac_max_slots 
WHERE total_slots = max_slots
ORDER BY month;



/*
Postgre Exercise
https://pgexercises.com/questions/aggregates/payback.html
*/
-- Payback equation will be --> Avg_revenue*month = Inital Outlay + monthlymaintenance*x
-- Thus, x will be (Initial outlay/(avg_revenue-monthlymaintencance))

SELECT name, (initialoutlay/(monthlyrevenue-monthlymaintenance)) payback FROM
(SELECT name, initialoutlay, monthlymaintenance, SUM(CASE
					WHEN memid=0 THEN slots*guestcost
					WHEN memid!=0 THEN slots*membercost
				END)/3 AS monthlyrevenue
FROM cd.bookings JOIN cd.facilities f USING(facid)
GROUP BY f.facid) as fac_cost_revenue
ORDER BY name;
-- We have to use f.facid in group by. otherwise, facid would be ambiguous
-- If we use f.facid, we don't have to use name, initialoutlay, monthlymaintenance in group by as it is 1 to 1 mapping.




/*
Postgre Exercise
https://pgexercises.com/questions/aggregates/rollingavg.html
**NEW --> We get to know NEW STATEMENT for use of "ROLLING WINDOW with N PERIODS". 
		  That mean, WINDOW is now not from starting till current row. But N preceeding till current row.
*/
WITH daily_revenue AS
(SELECT DATE(starttime) date, SUM(CASE
			WHEN memid=0 THEN slots*guestcost
			WHEN memid!=0 THEN slots*membercost
		END) AS revenue
FROM cd.bookings JOIN cd.facilities f USING(facid) 
GROUP BY DATE(starttime))
SELECT  date, 
		AVG(revenue) OVER(ORDER BY date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW) revenue
FROM daily_revenue
WHERE date BETWEEN '2012-08-01' AND '2012-08-31'

------------------------------------------------------------------------------------------------------------

	

-----------------------------------------------------------------
----------------------------- DATES ----------------------------- 
-----------------------------------------------------------------

	
/*
POSTGRE EXERCISE
SECTION --> DATE
https://pgexercises.com/questions/date/
Note --> This would require their database to execute on this system
*/

/*
https://pgexercises.com/questions/date/timestamp.html
Produce a timestamp for 1 a.m. on the 31st of August 2012.
*/
-- Most Standard one
SELECT TIMESTAMP '2012-08-31 01:00:00';
SELECT TO_TIMESTAMP('2012 Aug 31 01', 'YYYY Mon DD HH');
SELECT '2012-08-31 01:00:00'::TIMESTAMP;
SELECT CAST('2012-08-31 01:00:00' AS TIMESTAMP);

/*
https://pgexercises.com/questions/date/interval.html
Find the result of subtracting the timestamp '2012-07-30 01:00:00' from the timestamp '2012-08-31 01:00:00'
*/
SELECT '2012-08-31 01:00:00'::TIMESTAMP - '2012-07-30 01:00:00'::TIMESTAMP as interval;
-- Note - Subtracting timestamps produyces an INTERVAL datatype. 


/*
INTERVAL datatype
- INTERVAL datatype is a special datatype that captures the difference between 2 timestamps.
- Incontrast, we can use this INTERVAL to add or subtract to any of the timestamp to generate desired result.
Subtracting and adding INTERVAL to timestamp
*/
SELECT NOW() - '2020-09-09';
SELECT timestamp '2000-09-09' + INTERVAL '25 YEARS';


/*
https://pgexercises.com/questions/date/series.html
Produce a list of all the dates in October 2012. They can be output as a timestamp (with time set to midnight) or a date.

There is a function called generate_series which does this.
It takes starting datetime, ending datetime, and interval 
*/
SELECT generate_series(timestamp '2012-10-01', timestamp '2012-10-31', INTERVAL '1 DAY') as ts;


/*
https://pgexercises.com/questions/date/interval2.html
Work out the number of seconds between the timestamps '2012-08-31 01:00:00' and '2012-09-02 00:00:00'
*/
-- TO extract seconds fropm Intereval, we need to use field name "epoch"
SELECT EXTRACT(EPOCH FROM (timestamp '2012-09-02 00:00:00' - timestamp '2012-08-31 01:00:00')); 
SELECT EXTRACT(EPOCH FROM INTERVAL '1 day');


/*
https://pgexercises.com/questions/date/daysinmonth.html
For each month of the year in 2012, output the number of days in that month. 
Format the output as an integer column containing the month of the year, and a second column containing an interval data type.
*/
SELECT EXTRACT(MONTH FROM date),  ((date + '1 Month') - date) AS length
FROM (SELECT generate_series(timestamp '2012-01-01', timestamp '2012-12-01', INTERVAL '1 MONTH'
	AS date) AS month_series;
-- This works, because subtracting two timestamps will always gives result in days to seconds format.


/*
https://pgexercises.com/questions/date/daysremaining.html
For any given timestamp, work out the number of days remaining in the month. The current day 
should count as a whole day, regardless of the time. Use '2012-02-11 01:00:00' as an example 
timestamp for the purposes of making the answer. Format the output as a single interval value.
*/
SELECT DATE_TRUNC('MONTH', ts) + '1 Month' - DATE_TRUNC('DAY', ts) AS remaining
	FROM (SELECT timestamp '2012-02-11 01:00:00' as ts) AS time;


/*
https://pgexercises.com/questions/date/endtimes.html
Return a list of the start and end time of the last 10 bookings (ordered by the time at which
they end, followed by the time at which they start) in the system.
*/
SELECT starttime, starttime + 0.5*slots * INTERVAL '1 hour' AS endtime FROM cd.bookings
ORDER BY endtime DESC, starttime DESC LIMIT 10;





/*
https://pgexercises.com/questions/date/utilisationpermonth.html
Work out the utilisation percentage for each facility by month, sorted by name and month, 
rounded to 1 decimal place. Opening time is 8am, closing time is 8.30pm. You can treat every month
as a full month, regardless of if there were some dates the club was not open.


We get to know some nice things with this problem
- We can use EXTRACT(epoch FROM INTERVAL) to convert any interval into seconds and then
  use that to transform it into any DATE fields with simple arithmetic. Eg. seconds/(60*60*24) for seconds to days
- To find the Days in month, simply add 1 month to starting_date and subtract it with starting_date. 
  As interval returns difference in terms of days and time only.  
*/

WITH fac_slots AS
(SELECT name, DATE_TRUNC('MONTH', starttime) AS month, SUM(slots) total_slots 
FROM cd.bookings b JOIN cd.facilities f USING(facid)
GROUP BY name, month)
SELECT name, month, ROUND(total_slots*30*100/
	((EXTRACT(HOURS FROM ('2012-07-01 20:30:00'::TIMESTAMP - '2012-07-01 08:00:00'::TIMESTAMP))*60 + 
	EXTRACT(MINUTES FROM ('2012-07-01 20:30:00'::TIMESTAMP - '2012-07-01 08:00:00'::TIMESTAMP)))
	*EXTRACT(DAYS FROM  (month + '1 month') - month)),1) AS utilisation
FROM fac_slots
ORDER BY name, month;



------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------
------------------------- RECURSIVE CTE ------------------------- 
-----------------------------------------------------------------


-- Basic Recursive statement example
WITH RECURSIVE increment(num) AS (
	SELECT 1
	UNION ALL
	SELECT num+1 FROM increment WHERE num < 5
) SELECT * FROM increment;

/*
Exercise - 
https://pgexercises.com/questions/recursive/getupward.html
Find the upward recommendation chain for member ID 27: that is, the member who recommended them,
and the member who recommended that member, and so on. Return member ID, first name, and surname.
Order by descending member id.
*/

WITH RECURSIVE recommendation(memid, recommender, firstname, surname, recommendedby) AS (
	SELECT m1.memid, m1.recommendedby, m2.firstname, m2.surname, m2.recommendedby
	FROM cd.members m1 JOIN cd.members m2 ON m1.recommendedby = m2.memid
	WHERE m1.memid=27
	
	UNION ALL

	SELECT r.recommender, r.recommendedby, m3.firstname, m3.surname, m3.recommendedby
	FROM recommendation r JOIN cd.members m3 ON r.recommendedby = m3.memid
)
SELECT recommender, firstname, surname FROM recommendation;


/*
https://pgexercises.com/questions/recursive/getdownward.html
Find the downward recommendation chain for member ID 1: that is, the members they recommended,
the members those members recommended, and so on. Return member ID and name, and order by ascending member id.
*/
WITH RECURSIVE reffered(memid, firstname, surname) AS (
  SELECT m1.memid, m1.firstname, m1.surname   FROM cd.members m1
  WHERE m1.recommendedby=1
  UNION ALL
  SELECT m2.memid, m2.firstname, m2.surname
  FROM cd.members m2 JOIN reffered r ON m2.recommendedby = r.memid)
SELECT * FROM reffered 
ORDER BY memid ;


-- From Documentation (Just for the insight purpose)
WITH RECURSIVE search_tree(id, link, data) AS (
    SELECT t.id, t.link, t.data
    FROM tree t
  UNION ALL
    SELECT t.id, t.link, t.data
    FROM tree t, search_tree st
    WHERE t.id = st.link
)
SELECT * FROM search_tree;


/*
https://pgexercises.com/questions/recursive/getupwardall.html
Produce a CTE that can return the upward recommendation chain for any member. You should be able to select
recommender from recommenders where member=x. Demonstrate it by getting the chains for members 12 and 22.
Results table should have member and recommender, ordered by member ascending, recommender descending.
*/
WITH RECURSIVE recommenders(member, recommender, firstname, surname, recommendedby) AS (
  SELECT m1.memid, m1.recommendedby, m2.firstname, m2.surname, m2.recommendedby
  FROM cd.members m1 JOIN cd.members m2 ON m1.recommendedby = m2.memid
  UNION ALL
  SELECT r.member, m3.memid, m3.firstname, m3.surname, m3.recommendedby
  FROM recommenders r JOIN cd.members m3 ON r.recommendedby = m3.memid
) 
SELECT member, recommender, firstname, surname  FROM recommenders WHERE member IN (12,22)
ORDER BY member, recommender DESC;



/*
MODIFYING DATABASE SECTION
https://pgexercises.com/questions/updates/updatecalculated.html
We want to alter the price of the second tennis court so that it costs 10% more than the first one.
Try to do this without using constant values for the prices, so that we can reuse the statement if we want to.
*/
--1st method
UPDATE cd.facilities AS f1
SET
	membercost = ROUND(1.10*f2.membercost,1),
	guestcost = ROUND(1.10*f2.guestcost,1)
FROM cd.facilities f2
WHERE f1.name = 'Tennis Court 2';
--2nd method
UPDATE cd.facilities facs
SET
        membercost = (SELECT membercost * 1.1 FROM cd.facilities WHERE facid = 0),
        guestcost = (SELECT guestcost * 1.1 FROM cd.facilities WHERE facid = 0)
WHERE facs.facid = 1; 


/*
This are some interesting Solutions from different exercises.
This provides some great insights for solving problems in different way.
This generates some new ideas, logic or pattern to solve the problem

Few Understanding from these Problems
- We cannot use column created by CASE statement for Filtering Condition in WHERE or HAVING clause. (unless it's 1 to 1 mapping)
  We can just use it in the ORDER BY Clause. To use it in the WHERE or HAVING clause, 
  we have to create it beforehand in subquery, then use it in the Main query's WHERE or HAVING clause.
- Postgre SQL does not allow use of Column ALIAS name in WHERE and HAVING clause.
- If we have to use many temporary tables, then use CTEs, otherwise simple subquery within FROM clause would suffice.
*/
