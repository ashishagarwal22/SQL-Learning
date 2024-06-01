-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

-----------------------------------------------
/* ----------------   INDEX ---------------- */
-----------------------------------------------

/* 

==> ADVANCED SQL QUERYING TOOLS

  /* --- 3. FUNCTIONS --- */
  'PRIMARY DATATYPE' FUNCTIONS
  - TIME FUNCTIONS (DATATYPE, INTERVAL, EXTRACT, DATE_TRUNC, AGE, TO_CHAR)
  - MATH FUNCTIONS
  - STRING FUNCTIONS
  - CAST FUNCTIONS ( Implicitly "CAST" | Explicitly "TO_DTNAME")
  'COLUMN' FUNCTIONS 
  - {"DISTINCT", "AGGREGRATE", "STRIN_AGG/ARRAY_AGG"}
  'SCALAR' FUNCTION
  - WINDOW FUNCTION { [AGGREGATE_FUN() | RANKING_FUN()] "OVER" (Partition) }
  - NULL FUNCTIONS {Related to NULL - "COALESCE", "NULLIF", NVL, NVL2, LNNVL, NANVL, DEOCDE}
  - CASE FUNCTION (Customized Function using LOGIC EXPRESSION)
  
  /* --- 4. JOINS --- */
  - "JOIN OVERVIEW" ('JOIN THEORY', 'JOIN TYPES', 'JOIN FORMS', "ON", "USING")
  - INNER JOIN
  - OUTER JOIN
  - OUTER JOIN except INTERSENT | INNER
  - LEFT JOIN
  - LEFT JOIN except INTERSENT | INNER
  - RIGHT JOIN
  - RIGHT JOIN except INTERSENT | INNER
  - SELF JOIN
  - 'SET OPERATIONS' {"UNION", "INTERSECT", "EXCEPT"/"MINUS"} 

*/


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


----------------------------------------------------------------------------------------------------------
/* -------------------------------------------  3. FUNCTIONS  ------------------------------------------ */
----------------------------------------------------------------------------------------------------------

/* These Functions which take single input instance, either from row or from user, and return single output
   for that instance are called "Scalar Functions".  */

-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-----------------------------------------  DATETIME DATATYPE  -----------------------------------------
-------------------------------------------
-----------  DATETIME DATATYPE  -----------
-------------------------------------------

/* LESSON
- Not Specific to SQL Functionality (of Data related). But gives general information about Time.
- It reports back general Time and Date Information.
- PostgreSQL have TIME, DATA, TIMESTAMP, TIMESTAMPTZ, INTERVAL datatypes for date related information. 
- Careful consideration in whether the TimeZone is required or not while creating a database.
  Also, like other data fields, time datas can not be added if not recorded historically.
*/


/*
 Queries shown below are useful mainly when creating our own table and database, rather than when querying a database.
*/

/* As per the Documentation --> Shows the value of a Run-Time Parameters. */
SHOW ALL; -- Show the Application and its settings and the description.

/* Shows the Current TIMEZONE in which we are operating. */
SHOW TIMEZONE; --Asia/Calcutta--

SELECT NOW();          --# Shows Timestamp with Time Zone w.r.t GMT.
SELECT TIMEOFDAY();    --# Same as NOW() but in more readable format as a text with Day and IST TZ. --
SELECT CURRENT_TIME;   --# Sub string of Above Function
SELECT CURRENT_DATE;   --# Sub String of Above Function
-----------------------------------------  DATETIME DATATYPE  -----------------------------------------


-------------------------------------------
-----------  DATETIME FUNCTION  -----------
-------------------------------------------

--------------------------------
----------  INTERVAL  ----------
--------------------------------


/*
- There are "TIME INTERVAL" "ADD | SUBTRACT" function to add or subtract time or date with Time Column.
- PostgreSQL provides easy Addition and subtraction with dates using INTERVAL datatype.
  Main advantage with Postgre's INTERVAL addition or subtraction is,
  we don't have to explicitly mention anything while adding or subtracting time with TIMESTAMP, not even 
  Datatype INTERVAL. Postgre understand that on its own.
*/


SELECT date '2001-09-28' + integer '7';
SELECT date '2001-09-28' + interval '1 hour';
SELECT interval '1 day' + interval '1 hour';
SELECT timestamp '2001-09-28 01:00' + interval '23 hours';
SELECT time '01:00' + interval '3 hours';
SELECT - interval '23 hours';
SELECT date '2001-10-01' - date '2001-09-28';
SELECT date '2001-10-01' - integer '7';
SELECT date '2001-09-28' - interval '1 hour';
SELECT time '05:00' - time '03:00';
SELECT time '05:00' - interval '2 hours';
SELECT 900 * interval '1 second';
SELECT 21 * interval '1 day';
	

--------------------------------
-----------  EXTRACT  ----------
--------------------------------

/*
- Allows us to 'extract' any attribute from DATETIME component. 
  Whether it be YEAR, MONTH, HOUR, SECXONDS, etc...
- Can Extract YEAR, MONTH, DAY, WEEK, QUARTER, DOW 
- It takes an datetime column and return an INTEGER value.
- Syntax :-  EXTRACT(DATE_ATTRIBUTE FROM column_name)
*/

SELECT EXTRACT(YEAR FROM payment_date) AS Payment_year FROM payment; 
SELECT EXTRACT(MINUTE FROM payment_date) AS Payment_year FROM payment; 
SELECT EXTRACT(YEAR FROM payment_date) AS pay_year, EXTRACT(MONTH FROM payment_date) AS pay_month FROM payment; 
-- Can Also make use of ALIAS function "AS" to Rename the Resultant Column of EXTRACT Function.

--------------------------------
---------  DATE_TRUNC  ---------
--------------------------------

/*
- It truncates the given TIMESTAMP to its given attribute's GRANULAR level.
  Meaning, if we give the attribute 'month', all the attribute after 'month' will set to their default state.
- It takes a timestamp and RETURN the timestamp.
- Syntax :- DATE_TRUNC("DATE_ATTRIBUTE", column_name) FROM table;
*/

SELECT DATE_TRUNC('MONTH', payment_date) AS month FROM payment;   -- Will truncate till MOMNTH 
SELECT DATE_TRUNC('DAY', payment_date) AS month FROM payment;     -- Will truncate till DAY
SELECT DATE_TRUNC('MINUTE', payment_date) AS month FROM payment;  -- Will truncate till MINUTES


--------------------------------
-------------  AGE  ------------
--------------------------------
/*
- Calculate and return the 'Current Age' from the given Timestamp.
- It includes days as well as time from the Timestamp till present time. 
- •	Syntax :- AGE(time_col)
*/

SELECT AGE(payment_date) FROM payment;

SELECT return_date - rental_date FROM rental;
-- If want to difference one day from another

--------------------------------
-----------  TO CHAR  ----------
--------------------------------

/*
- It is the general function to convert any data type to character/string or text datatype.
  But it’s very powerful with timestamp to string conversion.
- Here we are using it for converting TIMESTAMP DataType to CHARACTER DataType.
- Useful for TIME formatting, as PostgreSQL provide many different PATTERN FORMATTING to convert it into. 
  We can play with it and convert it to any Different Patterns as String code as listed out in the Documentation.
- It can also make use of ALIAS function "AS" to rename the resultant Column.
- It is a function and placed as column in the SELECT statement to be retrieved. 
- Syntax :- SELECT TO_CHAR(date_column, 'String_code_pattern') FROM table;
*/

SELECT TO_CHAR(payment_date, 'MONTH  YYYY') AS month_year FROM payment;
SELECT TO_CHAR(payment_date, 'mon/dd/YY') FROM payment;
SELECT TO_CHAR(payment_date, 'dd/mm/YY') AS indian_date FROM payment;

-- There are various number of Formats. So make sure to check out the documentation.

--------------------------------
---------  CHALLENGE  ----------
--------------------------------

-- Challenge 1 --> On which months the payments happened?
SELECT DISTINCT(TO_CHAR(payment_date,'MONTH')) FROM payment;

-- Challenge 2 --> How many payments has happened on Monday?
SELECT COUNT(TO_CHAR(payment_date,'Day')) FROM payment
WHERE TO_CHAR(payment_date,'Day') = 'Monday   ';  -- Postgre add whitespace to fill up to 0 characters.

--ALTERNATE WAY with EXTRACT-- 
SELECT COUNT(EXTRACT(dow FROM payment_date)) FROM Payment
WHERE EXTRACT(dow FROM payment_date) = 1;  -- PostgreSQL start from Sunday at indexed '0'.

--ALTERNATE WAY--
SELECT COUNT(*) FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1;




----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
---------  MATHEMATICAL FUNCTION  ---------
-------------------------------------------

/*
- There are many and almost all the mathematical operators or function available to us for being applied on numeric related Columns.
- Check out the Documentation Section 9.3 for all the Mathematical Function. Simple, Random, Trigonometric, advanced (log, Round, Abs, ...)
- Just apply Mathematical formula or function on columns in SELECT statement.
- Syntax :- SELECT Math_fun(columns/columns-formula) FROM table;

- List of few Mathematical Functions
  - SQRT(), PI(), SQUARE(), ROUND(), EXP(), LN/LOG2/LOG10(), GREATEST/LEAST(multiple columns),
    POWER(Column,n), CEILING()/FLOOR(), ABS(), Trigonometric()
*/

-- Math Functions + Arithmetic Operator
SELECT ROUND(rental_rate/replacement_cost*100,2) AS rental_pct FROM film;  


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------  STRING FUNCTIONS  ------------
-------------------------------------------

/*
- PostgreSQL provide many String function and operators to Edit, Combine, and Alter Text Data. Refer Documentation Section 9.4.
- Refer Documentation Section 9.7 for Regular Expression and Pattern Matching.
- Syntax :- SELECT String_fun(columns) FROM table;

- Some common functions
  LOWER(), UPPER(), CONCAT(), LENGTH(), LEFT(), RIGHT(), STRCMP(),  TRIM(), Paddings(),
  SUBSTR(str, starting_pos,end_pos), REPLACE(string,old_substring,new_substring)
*/

--# String Functions
SELECT LENGTH(first_name) FROM customer;

--# Concatenation operator := "||".
SELECT first_name || ' ' || last_name AS full_name FROM customer;   

--# Concatenation Operator, LITERALS and String Functions --> Making up our own string patterns AS new_column. 
SELECT upper(first_name) || ' ' || upper(last_name) AS full_name FROM customer;  
SELECT left(first_name,1) || '.' || last_name || '@pearls.com' AS employee_email FROM customer;  


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
------------  CAST FUNCTIONS  -------------
-------------------------------------------

/*
- CAST operator let us convert from one datatype to another. 
- Keep in mind, it must be reasonable to cast the datatype. Meaning it should be compatible.
  i.e. not every instance of data type can be casted.
  Eg. Text 'five' cannot be casted to INTEGER 5. But Text '5' can be casted.
- We can only cast whole column datatype in a table instead of specific instances of table.
- Syntax := CAST(col_name AS new_data_type) 
  PostgreSQL specialized CAST Operator  := SELECT YEAR::INTEGER.  --# "::" double colon here means "Casted as".
*/

SELECT CAST('5' AS INTEGER);
SELECT '5':: INTEGER;

--# Suppose here we want to find the length of inventory_id. We cannot do so for INTEGER Datatype.
--# So we cast it and then perform the String function for finding length.
SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR)) FROM rental;
SELECT CHAR_LENGTH(inventory_id::VARCHAR) FROM rental;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
------------  COLUMN FUNCTION  ------------
-------------------------------------------

/* 
Remember - 
- COLUMN FUNCTION are the function type, in terms that is not a scalar function, as it did not take an individual 
  Row value as an input and execute function to return an output.
- Instead, it take multiple value of specific Column as an Input and return some output for column itself.  
*/

--------------------------------
----------  DISTINCT  ----------
--------------------------------

/*
- Refer to DISTINCT Section in "BASIC SQL".
*/


--------------------------------
----  AGGREGATION FUNCTION  ----
--------------------------------

/* 
- Main idea behind an Aggregation Function is to take all the Inputs from the column and provide a Single value, known as 'MEASURE'.
  Mostly an output from a mathematical function.
- Aggregation Function to be applied, is placed in SELECT CLAUSE as Column to be Retrieved.
- SELECT AGG_FUN(col_name) FROM table_name;
- AGGREGATE FUNCTION LIST - MAX(), MIN(), AVG(), SUM(), COUNT(), FIRST(), LAST() 
*/

SELECT MAX(replacement_cost), MIN(replacement_cost), COUNT(replacement_cost),
	ROUND(AVG(replacement_cost),2) FROM film;



--------------------------------
-----  ARRAY_AGG FUNCTION  -----
--------------------------------

/* 
- STRING_AGG = String Aggregate Function concatenates the String from the given column in a single list, separated by comma
- It is important to remember here, That many a times it will give error as it is built on string datatype.
  So make sure to CAST it always as per required datatype.
  This is general problem for many function. So every time there is a hint of mismatch argument type, try executing after CASTing. 
  
- ARRAY_AGG = Array Aggregate Function combined all the column values and return it as a single Array.
  It does not depend on datatype, as it is storing field values as an element in an array, thus all datatypes are supported.
*/

--# Retrieve all the Genres|Category Type within Single Cell.
SELECT STRING_AGG (name::varchar, ', ' ORDER BY name) Genres FROM category;
SELECT ARRAY_AGG (DISTINCT name::varchar) Genres FROM category ;

--# Fetch all the movie names (in a single cell) in which the particular actor has worked in
SELECT first_name || ' ' || last_name actor_name, ARRAY_AGG(title::varchar) movies
FROM film f INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY actor_name;

--# Fetch all the Actors which had appeared in particular Film.
SELECT title movies, ARRAY_AGG(first_name || ' ' || last_name) actors
FROM film f INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY movies;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
------------  WINDOW FUNCTION  ------------
-------------------------------------------

/*
- WINDOW FUNCTION creates PARTITIONS "OVER" the set of records, separated by Category or classes of the given Column, to perform either 
  AGGREGATION FUNCTION or RANKING FUNCTION.
  It is just like GROUP BY in a sense, but execution and output is somewhat different.
- WINDOW FUNCTION partitions per category is exactly same as GROUP BY, when it creates PARTITIONS before performing 
  AGGREGATION FUNCTION.
- First difference of WINDOW FUNCTION with GROUP BY is in terms of output. It creates a new column and
  LOG the result of aggregation on each of the rows or records (for the respective partition).
  This is unlike GROUP BY, as it merge these records and just logs and display the Aggregated result with the respective category or class.
  i.e., if you remember that with GROUP BY we cannot SELECT column which are not in GROUP BY. But this is not the case with WINDOWS
- We have to select the type of function we are going to execute with WINDOW function or on a window.
- We use OVER() for WINDOW FUNCTION.

- Syntax := RANKING/AGGREGATION_FUN(col_name_2) OVER (PARTITION BY category_column_name ORDER BY col_name_3)
  IMPORTANT POINTS TO REMEMBER ==>
	- 'category_column_name' is the column by which we want to create partitions. Basically, it’s a grouping column.
	- 'col_name_2' is the column on which we want to apply WINDOW function
	- 'col_name_3' is the column by which we want to SORT on 'in these newly created partitions'.
  If we don't mention 'PARTITION BY category_col', WINDOW FUNCTION will consider whole table as one partition.
	- ORDER BY, i.e. Sorting is compulsory if we are applying RANKING FUNCTION, as logical.
- Keep in mind, it generates new column for the resultant outputs.
*/

/*
ORDER BY special Execution Flow
- ORDER BY changes the underlying way or logic or execution flowby which the aggregation function works on that column. 
	  	READ the following paragraph carefully.
	  	We should be careful when applying AGGREGATION FUNCTION as WINDOW "With ORDER BY". As Underlying Execution is somewhat different.
	  	First, It creates the partition; Second, sort on sorting column;
		Lastly, THEN apply AGG_FUN row by row, from first row, till the pointer row, and logs the result to that row.
		i.e., Aggregated result is not same for all the rows in a partition. 
		Aggregated Result for the pointer row is the Aggregation FROM 'the starting row' TO 'the pointer row' in the sorted row order.
		IN A SENSE, it is kind of ROLLING function.
	  	Eg. Suppose value in the Salary column are in the order as    - 50,70,120,80,..
          then the aggregated result (avg) column order will be 			- 50,60,80,80,...
	  GOT IT, Good!
*/

/*
Function that we can use with Window Function via OVER()
	- RANK(), DENSE_RANK(), ROW_NUMBER(), PERCENT_RANK(), CUME_DIST() 
	- LAG(), LEAD()
	- FIRST_VALUE(), LAST_VALUE(), NTH_VALUE(n)
	- NTILE(n) --> Classifies the Sets of records into n buckets
*/

/*
Rolling Window of n periods
***WINDOW FUNCTION special FUNCTIONALITY***
	Window function not only provide WINDOW for whole of the table TILL current row, 
	BUT it also provide WINDOW of specific number of rows from current ROW.
	We can do so by using 2 syntax
	1st --> OVER(PARTITION BNY column(s) ORDER BY column(s)   ROWS BETWEEN n PRECEDING AND CURRENT ROW)
	2nd --> OVER(PARTITION BNY column(s) ORDER BY column(s)   RANGE BETWEEN interval 'n days' PRECEDING AND CURRENT ROW)

Problem --> https://pgexercises.com/questions/aggregates/rollingavg.html
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
*/

--------------------------------------
-- AGGREGATING FUNCTION with WINDOW --
--------------------------------------

--# With the Help of GROUP BY
SELECT rating,ROUND(AVG(replacement_cost),2) from film
GROUP BY rating
ORDER BY AVG(replacement_cost);

--# With the Help of OVER (PARTITION BY)
SELECT title,rating, AVG(replacement_cost) OVER (PARTITION BY rating) AS avg_replacement_cost 
FROM film ORDER BY avg_replacement_cost;
--# "MAKE NOTE", How the Aggregated result is applied to all the records, instead of just combined category.
--# also we can SELECT title which is not possible with the GROUP BY call. 


SELECT title, length, rating, AVG(replacement_cost) OVER (PARTITION BY rating ORDER BY length ) AS avg_replacement_cost 
FROM film ORDER BY rating, length;
--# "MAKE NOTE", how the aggregated result value of AVG(replacement_cost) changes when we ORDER BY length
--# even though, they belong to same partition of Rating Category.


--------------------------------------
---  RANKING FUNCTION with WINDOW  ---
--------------------------------------

/* 
- It 'Ranks' or assign Serial Number to RECORDS/ROWS.
- ORDER BY or SORTING is necessary for Ranking Functions. Otherwise it won't make sense for RANKING.
- We'll look at three RANKING FUNCTION - RANK(), DENSE_RANK(), ROW_NUMBER()

/* -------- RANK()  -------- */
- It Assign Ranks to Rows.
- In case of ties, it assigns same rank. But when going to the next rank, it skips those many RANKS with same ranks.
  Eg. 1,1,1,4,4,6,...

/* ----- DENSE_RANK()  ----- */
- It Assign Ranks to Rows.
- In case of ties, it assigns same rank. But when going to next rank, it don't skip any RANKS with same ranks.
  Eg. 1,1,1,2,2,3,...

/* ----- ROW_NUMBER()  ----- */
- It Assigns Rank to Rows in SERIAL NUMBER. It Doesn't take account of TIES in this.
  Eg. 1,2,3,4,5,6,...
*/

SELECT first_name || ' ' || last_name full_name, ROUND(SUM(amount),0) total_payment,
RANK() OVER (ORDER BY ROUND(SUM(amount),0) DESC) AS rank,
DENSE_RANK() OVER (ORDER BY ROUND(SUM(amount),0) DESC) AS dense_rank,
ROW_NUMBER() OVER (ORDER BY ROUND(SUM(amount),0) DESC) AS row_number
FROM customer JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY full_name;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------  NULL/GENERAL FUNCTIONS  ---------
-------------------------------------------

/*
- When performing arithmetic or mathematical functions on NULL, it results in error or NULL ans.
- So it's good practice to use these NULL functions to solve around these NULLs or replace these NULLs using some technique.
- Few functions allows us to work around with NULL
  COALESCE(), NULLIF(), ...
*/


--------------------------------
-----------  COALESCE  ---------
--------------------------------

/*
- COALESCE function accepts an unlimited number of arguments. It returns the first argument among the argument
  list WHICH IS "NOT NULL". Eg. COALESCE (1,2,3) ==> 1, COALESCE (NULL, a*b, 10) ==> 10 if a*b is NULL.
- What this basically means is that it accepts an input, check if it is an NULL, if it is then replaces it
  with next argument, if that is also NULL, goes to next argument until NOT NULL value is found and then return it.
- If all the argument in the coalesce is NULL, its output will also be NULL.

- Now you are most probably wondering how it is used in Query call. It is the most common useful function when 
  querying a table using mathematical operator or function and it is consisting of NULL Values. As NULL datatype
  values is not compatible with INTEGER DATATYPE, it is replaced with next argument with the coalesce
  function. Thus our mathematical function/operator keeps on working and produced desired result for all record. 
- Syntax := COALESCE(column_name,arg_1,arg_2,...). What it will do is that for values of all the Rows/Record for
  that specified column is IF NULL then replace it with next argument without altering or affecting the original Table.
- Eg. (col_1 - COALESCE(col_2,0)) ==> (Price - COALESCE(Discount,0)). So while performing this mathematical 
  operation, if NULL is encountered in Discount Column, then in spite of giving result as NULL, it will go to next
  argument, which is 0 here, and continue to perform the math operation efficiently.
*/


--------------------------------
-----------  NULL IF  ----------
--------------------------------

/*
- NULL IF takes 2 value as an argument and returns NULL if both are equal otherwise returns first argument as output.
- Syntax := NULLIF (arg_1, arg_2) = NULL		--> If arg_1 = arg_2 return NULL;
			NULLIF (arg_1, arg_2) = arg_1		--> If arg_1 != arg_2 return arg_1;
			
- This became useful when NULL value would cause an error or undesired results.
- Example scenario, we can compare the column values with specific values to output NULL,
  instead of generating an error. NULLIF(col_name, 0), if we are using the specified column in denominator
  for arithmetic expression, then this keyword will save us from giving ‘divide by 0’ error.
*/

/*
For example, let us consider a scenario - we are calculating the Ratio of persons in Department A to Department B in some 
arbitary made up demo TABLE. In this, if person in Department B is 0. Then it will result in an error "/ by 0".
Here, we can use NULLIF to solve this problem. We will provide the denominator Value within NULLIF, and before
calculating directly, NULLIF will check IF it is equal to "0". If it isn't then value itself will passed, and if it 
is THEN it will replaced with NULL. Thus, instead of error it will result in "NULL".
IMPORTANT COMMENT  - If want to run below piece of code/query, run it in CREATE_DB Database or with its connection. 
					 There I've made up this arbitary Demo Table.

SELECT 
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/
NULLIF(SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END),0)
AS department_ratio
FROM depts;
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
------------  CASE FUNCTION  --------------
-------------------------------------------

/*
- CASE, in my words, is "Customized Scalar Function" based on logical expression. 
- CASE is analogous to IF/ELSE and SWITCH/CASE from any other programming language. That is, it generates result based on certain conditions
- There are two ways to use CASE - "general CASE" (analogous to IF/ELSE) or "CASE expression" (analogous to SWITCH).
  Both leads to same result.
- CASE is placed inside a SELECT phrase almost as it's an another column. Thus it outputs result in another separate column
- "General CASE" is same as IF/ELSE. It is more flexible and most used as any type of expression can be evaluated.  Syntax :=  
				SELECT 
				CASE
					WHEN condition_1 THEN result_1
					WHEN condition_2 THEN result_2
					ELSE some_other_result
				END
				FROM table_name;
- "CASE Expression" syntax is same as SWITCH/CASE. It first evaluates an expression then compares the result with each value in the WHEN clause Sequentially.
  It is not flexible and usually used for categorical columns. As it cannot evaluate any type of expression. Syntax :=		
				SELECT
				CASE expression
					WHEN value_1 THEN result_1
					WHEN value_2 THEN result_2
					ELSE some_other_value
				END
				FROM;
*/

/*
Few Case Example on use of CASE for customization function is -->
- Continuous Numerical to Discrete Categories.
  (SMALL, MEDIUM, LARGE), (RANK CATEGORIES), etc...

- Binary Classification 
  (Yes category AND NO Category) say (Yes Orange, No Orange), (value present, Value Absent)
  (1 or 0/T or F)for particular category/value.

- Lower Level Hierarchy to Upper Level Hierarchy
*/

SELECT customer_id, 
CASE
	WHEN (customer_id <= 100) THEN 'Platinum'
	WHEN (customer_id BETWEEN 101 AND 200) THEN 'Gold'
	WHEN (customer_id BETWEEN 201 AND 300) THEN 'Silver'
	ELSE 'Bronze'
END
AS customer_type
FROM customer;


SELECT customer_id,
CASE customer_id
	WHEN 1 THEN 'Gold Medal'
	WHEN 2 THEN 'Silver Medal'
	WHEN 3 THEN 'Bronze Medal'
	WHEN 4 THEN 'Certificate'
	WHEN 5 THEN 'Certificate'
	ELSE 'Participants'
END 
AS Reward
FROM customer WHERE customer_id < 10;

 
--# Use cases for this. Note here, though this can be done using another Operators or Keywords,
--# but this gives us more tool or variation to play with. And also we can play with formatting here. 
SELECT 
SUM (CASE rental_rate 
		WHEN 0.99 THEN 1
		ELSE 0
END) AS bargained_payments,
SUM (CASE rental_rate 
		WHEN 2.99 THEN 1
		ELSE 0
END) AS regular_payments,
SUM (CASE rental_rate 
		WHEN 4.99 THEN 1
		ELSE 0
END) AS overcharged_payments
FROM film;


---------  Challenge  ---------

-- Challenge 1 --> We want to know and compare the amount of films that we have per movie ratings. Use CASE.

SELECT 
SUM(CASE rating
		WHEN 'R' THEN 1 ELSE 0
	END) AS R,
SUM(CASE rating
		WHEN 'PG' THEN 1 ELSE 0
	END) AS PG,
SUM(CASE rating
		WHEN 'PG-13' THEN 1 ELSE 0
	END) AS PG_13
FROM film; 


/*
IMPORTANT --> CASE statement in the WHERE clause
We can also use the CASE statement in the WHERE clause for filtering the rows 'based on different filtering conditions from another column'
*/

-- Retrieve films whose Length corresponds to their rental rate. If 0.99 then less than 50 minutes, if 2.99 then between 50 and 100 and if 4.99 then greater than 100.
Select title, rental_rate, length FROM film
WHERE CASE
		WHEN rental_rate = 0.99 THEN length < 50
		WHEN rental_rate = 2.99 THEN length BETWEEN 50 AND 100
		WHEN rental_rate = 4.99 THEN length > 100
	   END;

/*
Exercise Question from PostgreSQL official website
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
*/ 



----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


----------------------------------------------------------------------------------------------------------
/* --------------------------------------------  4. JOINS  -------------------------------------------- */
----------------------------------------------------------------------------------------------------------


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-------------  JOIN OVERVIEW --------------
-------------------------------------------


/* 
			  				/* ------------- JOIN THEORY ------------- */

==> What is JOIN and Why it is Used.
- JOIN allows us to Combine or Join multiple tables together, as individual table consists of limited sets of information. 
- JOIN is used to execute 'Table Manipulation' by combining different Datasets or Tables. 
- With JOIN, we can access and analyse data which are stored across different tables in a database.
- JOIN connects columns (attributes) from one table to another tables using some relation or mapping.
- What is Mapping. We need some ways to connect information from one table to another table’s information. 
  It does not make sense to connect every data from one table to every data in another table.
  "Primary Key-Foreign key" relation allow us to do exactly that.
- Primary key is the unique identifier for a particular Table. Foreign Key are the Primary key from another table.
  Thus, Foreign key notifies the row, with which unique data it has connections to in the other table. 
- You'll find that this Primary Key and Foreign key are the "MATCHING COLUMN" between 2 tables.
  

==> GENERAL JOIN SYNTAX :=
	FROM left_Table JOIN_TPYE right_Table ON Conditon|Expression;		--# 2 Table Join
	FROM left_Table JOIN_TYPE right_Table ON Conditon|Expression JOIN another_right_Table ON Condition|Expression; --# 3 Table Join

	Analogy
	  left_Table is also reffered as Table A or Table 1.
	  right_table is also reffered as Table B or Table 2.
  
  
==> ON Phrase ==> CONSIDERATION FOR JOINING TABLE
- Now, There are two main things to CONSIDER for Joining Two Tables.
  First, we join Two Tables based on the "Matching Column (Same Attribute with Same Datatype)" 
  Second, we join Two tables with some "Condition | Expression" on "this Matching Column".
			(Though Mostly the Condition is Equality --> EQUI | NORMAL JOIN)
			(It can be Expression with any Condition and Logical Operator also --> CONDITIONAL JOIN)
- This is specified by "ON Clause of JOIN".			
- This Matching column is nothing but the Primary Key-Foreign Key relation.


==> INFO SETS in JOINED TABLE
- As there are two tables, there are 2 Sets of Information (Column or Attribute List) Available to us in the Joined Table.
  [A | Left] INFO SET ==> From the 'left_Table'
  [B | Right] INFO SET ==> From the 'right_Table'
- In Essence, There are three type of columns present in the "SELECT *" FROM Joined Table.
  - "Matching Column"
  - "Columns from Information Set A" or “A.cols”
  - "Columns from Information Set B" or “B.cols”


==> ROW COMPONENTS in JOINED TABLE	(Columns Available in Joined Table)
- After these consideration, we have to look at ROW COMPONENTS Present in the Joined Table.
  1st Row Constructs  (Component 1) - Those Records which are "Unique" to left_Table on the Matching Column.
  2nd Row Constructs  (Component 2) - Those Records which are "Common" to Both the Tables on the Matching Column.
  3rd Row Constructs  (Component 3) - Those Records which are "Unique" to right_Table on the Matching Column.
  IMPORTANT -->
  What do we mean by 'unique' to Left Table or Right Table --> While Joining Tables ON matching column, it may happen
  that some field value which are present in the Left Table ‘does not exist’ at all in the Right Table <and Vice Versa>.
  That means there is no mapping available to us for those records in the Right Table <and vice versa>.
  For those records, the information set from the right table will be set as NULL <and vice versa>.
  ***(We are defining UNIQUE or COMMON on the basis of Matching Column only, as this column is the one in the left 
           and right table, that we are using for MAPPING or connection of two tables.) ***
- Based on above Derived Components, we can make some LOGICAL STATEMENT on INFORMATION SETS available to us in the Joined Table.
  Logically,  
  Component 1 will only consist of records which are not present in the Right Table, i.e., "Records from the Left_Table only".
  		==>	so after joining, Component 1 will only have the “Left_Table Columns” with “Right_Table Columns set as NULL".
  Component 3 will only consist of records which are not present in the Left Table, i.e., "Records from the Right_Table only".
  		==>	so after Joining, Component 3 will only have the “Right_Table Columns” with “Left_Table Columns set as NULL".
  Component 2 will consist of records which are present in both the table, i.e., "Records common to BOTH the Table". 
  		==>	so after Joining, Component 3 will have “BOTH the Left and Right Table Columns available” with “NONE AS NULL”.
  ***(Again, relations like 'unique' and 'common' are on the basis of 'Matching column' from the left and right table.)***


==> Programming equivalent LOGIC CONDITION  (Useful for later sections) 
- Using the same Logic above (on basis of Column Sets Available) we can create its Programming Equivalent 
  Logic Condition (within WHERE CLASUE) to derive any bucket type of Row Components. Let’s see how:
		Row Component 1’s Logic Condition --> WHERE “b.info IS NULL”	(# Table B columns IS NULL)
		Row Component 3’s Logic Condition --> WHERE “a.info IS NULL”	(# Table A columns IS NULL)
		Row Component 2’s Logic Condition --> WHERE “a.info IS NOT NULL AND b.info IS NOT NULL”	(Both Table A cols and Table B cols IS NOT NULL)
  •	We can make any combination of Row Components using these Programming Logic Conditions.
  •	We’ll see how it is useful later in this section.


--------------------------------
-------------  ON  -------------
--------------------------------
/*
- We join the 2 Tables ON some "Matching Column" or Columns which contain same type of values.
- "ON" allows us to define on which column we are joining, and with which matching Condition or Expression.
- Use ON When, -
  - We are joining on same column type and with "Equality", but both column has different names.
    JOIN table_A JOIN_TYPE table_B ON table_A.matching_column_name_A = table_B.matching_column_name_B;
  - We are Joining on same column type but condition is "Not Equality", but some other "Expression".
    JOIN table_A JOIN_TYPE table_B ON EXPRESSION(table_A.matching_column comparison_operator table_B.matching_column);
	- Eg. = table_A.col_id > 4*table_B.col_id AND table_A.col_name != table_B.col_name
*/


--------------------------------
------------  USING  -----------
--------------------------------
/*
- Use USING, When - 
  - The matching column in both the table has same name.
    JOIN table_A JOIN_TYPE table_B USING(matching_column_name);
- It's Example are written in ALL TYPE OF JOINS. as an alternate form of writing JOIN.
*/

 
*/    
  
/* 
			  				/* ------------- JOIN TYPES ------------- */
==> JOIN TYPES
- INNER JOIN (Component = 2) ==> (Intersection Records in both the Table with both Info Sets Available)
- OUTER JOIN (Component = 1+3+2) ==>  (Unique Records from the Left Table + 
									  Unique Records from the Right Table +
									  Intersection Record from both the Table)
- OUTER JOIN without INNER (Component = 1+3) ==> (Unique Records from the Left Table +	
													Unique Records from the Right Table)
- LEFT JOIN (Component = 1+2) ==> (Unique Records from the Left Table +
								   Intersection Record from both the Table)
- LEFT JOIN without INNER (Component = 1) ==> (Unique Records from the Left Table)
- RIGHT JOIN (Component = 3+2) ==> (Unique Records from the Right Table +
								   Intersection Record from both the Table)
- RIGHT JOIN without INNER (Component = 3) ==> (Unique Records from the Right Table)
    (Again very Important Remembrance Point - All the Set Relation of Records are ON BASIS OF MATCHING COLUMN ONLY)


==> JOIN TYPES Derivation
- From above understanding of JOINS, We can Categorize Join into mainly Two Types and all the rest can be derived from it. 
  First, Records COMMON to both the Table.
  Second, Records UNIQUE to either of the table.
- If we are able to understand these 2 Components, we can understand any of the JOIN types; and can derive as per the situation.  
 - "INNER JOIN (2)" 
 - "OUTER JOIN without INNER (1+3)" 
 
 Derivation of All Join from above 2 Joins
  - INNER JOIN = INNER JOIN itself (2)
  - OUTER JOIN = OUTER with INNER (1+2+3)
  - LEFT JOIN = Left Part of OUTER with INNER (1+2)
  - RIGHT JOIN = Right Part of OUTER with INNER (3+2)
  - LEFT JOIN without INNER = Left Part of OUTER (1)
  - RIGHT JOIN without INNER = Right Part of OUTER (2)

 
==> Derivation of all Join through Query 
 Now to derive all joins through Query, use the LOGICAL CONDITION in WHERE CLAUSE.
 - INNER = INNER
 - OUTER = OUTER
 - LEFT = LEFT
 - RIGHT = RIGHT
 - OUTER except INNER = OUTER WHERE b.info is NULL AND a.info is NULL
 - LEFT except INNER = LEFT WHERE b.info is NULL		(OR WHERE a.info IS NOT NULL)
 - RIGHT except INNER = RIGHT WHERE a.info is NULL		(OR WHERE b.info IS NOT NULL)

 *********  It’s to understand whole JOIN Concept just with "3 ROW COMPONENTS and 2 COLUMN SETS"   *********
*/


/*
			  				/* ------------- JOIN FORMS ------------- */

- NORMAL JOIN		- When there is only one single matching column in both the Joining Tables, 
			  		  then the JOIN of two tables with "EQUALITY CONDITION" is Normal Join.
              		- In this Join type, the Two Tables can be joined without even mentioning Matching Condition
					  by naming join type as "NATURAL JOIN", as there is only one matching column and condition
					  is by default Equality. It should be avoided at all cost, when there is more than one
					  matching column, as it creates an unwanted result.
- EQUI JOIN   		- When there is more than one matching column in two tables, then the joining of two table 
					  on 'Equality Condition' is called “EQUI JOIN”.
 			  		- Equi Join is the very specific case of Normal Join. 
			  		- In this type of Join, two tables can be joined by 'Explicitly' mentioning matching column.
			    	  - Now, if the matching column name is same in both the table, we can use "USING" Keyword as
				  		USING(matching_column_name) to Join tables.
					  - But if matching column has different names in different tables, then we have to use "ON" Keyword
				  		to write the matching expression.
- CONDITIONAL JOIN  - When we have to join not based on Equality Condition then the joining is called Condition join.
					- We can use "ON" Keyword only with full expression, as USING use only Equality condition to join. 
- CROSS JOIN		- Cross Join joins every row of one table with every row of another table.
					- That is, it is resulting m*n rows. where 'm' and 'n' are the number of rows of each table.
					- It is used when we don't know the relation of two tables, 
					  and thus we join every record with every record of other table.  
					- It is also known as Cartesian Product or Cartesian Join.  
					- To CROSS JOIN, simply mention both "Table name separated by Comma".  
					
Everything else except the "Conditional Matching Condition/Expression" is clear from all the above theories.
IDEAS for COMPREHENDING the Conditional Matching [Condition | Expression].
- Generally, we perform join on "Primary Key" only so as to get additional information for Particular Record.
  And it is logical that for primary/foreign key we have to use Equi Join Form only.
- But when we want to compare two records on basis of some particular feature,
  then we have to first create pair for such comparison(=,>,<,!=) by executing  Join on that feature column.
- then we can filter it based on our requirement or specific analysis scenario.  
- This can be best understood through examples given in Self Join.
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------------  INNER JOIN  ---------------
-------------------------------------------

/*
- An INNER JOIN will result in retrieving of set of records that are COMMON on "Matching Column" in Both the tables.
- (Thus 2nd Component - Those Records which are present in both the Table with both Column sets of information available - A and B).
- i.e., Row Component "2". 
- By Default, JOIN means INNER JOIN. It is the most used JOIN for querying.
- Syntax :- SELECT * FROM table_A INNER JOIN table_B ON Table_A.col_match = Table_B.col_match
- Table order won't matter in INNER JOIN as it is symmetrical in nature. 
- One thing to bear in mind, that the Matching Column will appear twice in resultant Joined Tables, one from table A 
  and one from Table B, so to remove ambiguity, explicitly mention matching_column from any one of the table AS table_A.col
*/

SELECT * 
FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id;

SELECT payment_id, payment.customer_id, first_name
FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id;

SELECT customer.customer_id,first_name,last_name,address_id,staff_id,rental_id,amount,payment_date
FROM customer INNER JOIN payment ON customer.customer_id = payment.customer_id;  


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------------  OUTER JOIN  ---------------
-------------------------------------------

/*
- An FULL OUTER JOIN will result in ALL the Set of records that ARE ON "Matching Column" in Both the tables.
- Thus 2nd Component - those records which are present in both the tables with both set of informations available,
  + 1st Component - Data Records, unique to Table A ON "Matching Column", with A set of informations available and with B set of informations as NULLs,
  + 3rd Component - Data records, unique to Table B ON "Matching Column", with B set of informations available and with A set of informations as NULLs.  
- i.e., Row Component "1+2+3". 
- Syntax :- SELECT * FROM table_A FULL OUTER JOIN table_B ON Table_A.col_match = Table_B.col_match;
- Order Doesn't matter for Full Outer Join as it is also symmetry in nature.
*/

SELECT customer.customer_id,payment.customer_id,first_name,last_name,address_id,staff_id,rental_id,amount,payment_date
FROM customer FULL OUTER JOIN payment ON customer.customer_id = payment.customer_id;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-------  OUTER without INNER JOIN  --------
-------------------------------------------

/*
- It retrieve the data Records which are unique to each of the table ON "Matching Column".
- i.e., Row Component "1+3". 
- It is Mutually Exclusive Area of INNER JOIN.
- Syntax :- SELECT * FROM table_A FULL OUTER JOIN table_B ON Table_A.col_match = Table_B.col_match WHERE Table_B.col is NULL OR Table_A.col is NULL;

- 'Table_B.info is NULL' retrieves all the Records unique to Table A.,
  Similarly 'Table_A is NULL' retrieves all the Records unique to Table B. 
  As records unique to Table A contains B set of information as NULL and vice versa. (Explained above in Logical Statements)
- This is Complement of INNER JOIN as per the VENN Diagram. That is unique only to Table A or Table B. 
- It is also symmetrical in nature.
- Example Scenario - With 'customer.customer_id is NULL', I'm retrieving only those components which had made transaction
  with the store but are not present in the customer Table in the Database. Similarly, with 'payment.customer_id
  is NULL', I'm retrieving those components which had not made any transaction with the store but are present in the Customer Table in the Database. 
*/

SELECT customer.customer_id,payment.customer_id,first_name,last_name,address_id,staff_id,rental_id,amount,payment_date
FROM customer FULL OUTER JOIN payment ON customer.customer_id = payment.customer_id
WHERE customer.customer_id is NULL OR payment.customer_id is NULL;  


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------------  LEFT JOIN  ----------------
-------------------------------------------

/*
- A LEFT OUTER JOIN will result in set of records that ARE ON "Matching Column" in Both the tables AND unique to LEFT Table/Table A.
- Thus 2nd Component - those records which are present in both the tables with both set of informations available,
  as well as 1st Component - Data Records, unique to Table A ON "Matching Column", with A set of informations available and with B set of informations as NULLS,
  but excluding 3rd Component - that is unique to Table B ON "Matching Column".
- i.e., Row Component "1+2". 
- Syntax :- SELECT * FROM table_A LEFT OUTER JOIN table_B ON Table_A.col_match = Table_B.col_match;
- Order of tables Does Matter in LEFT JOIN as it is not Symmetry in nature.
- It is Symmetry to RIGHT JOIN mirrored around the INNER JOIN. 
  That is to say, On Applying RIGHT JOIN with Reversing the order, it will result in same DATA OUTPUT.  
- Example Scenario – Retrieve data for all the Customer and their payments. 
  It doesn’t matter whether they have made payment or not.
*/

SELECT *
FROM customer LEFT OUTER JOIN payment ON customer.customer_id = payment.customer_id;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------  LEFT without INNER JOIN  --------
-------------------------------------------

/*
- To Retrieve Records/Entries unique to Table A ON "Matching Column".
- i.e., Row Component "1".
- Syntax :- SELECT * FROM table_A LEFT OUTER JOIN table_B ON Table_A.col_match = Table_B.col_match WHERE Table_B.col is NULL;
- Condition 'Table_B.col is NULL' discard those records which are present in both the tables.
- Example Scenario - If we want to find the customers who are present in the Customer Dataset but NOT present in the Payment dataset. 
  That is to say that they never transacted with us yet they are in our customer dataset. So we may would like to remove these customers. 
*/

SELECT customer.customer_id,payment.customer_id,first_name,last_name,address_id,staff_id,rental_id,amount,payment_date
FROM customer LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE  payment.customer_id is NULL; 


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------------  RIGHT JOIN  ---------------
-------------------------------------------

/*
- RIGHT OUTER JOIN will result in set of records that ARE ON "Matching Column" in Both the tables AND unique to RIGHT Table/Table B.
- Thus 2nd Component - those records which are present in both the tables with both set of informations available,
  as well as 3rd Component - Data Records, unique to Table B ON "Matching Column", with B set of informations available and with A set of informations as NULLS,
  but excluding 1st Component - that is unique to Table A ON "Matching Column".
- i.e., Row Component "3+2". 
- Syntax :- SELECT * FROM table_A RIGHT OUTER JOIN table_B ON Table_A.col_match = Table_B.col_match;
- Order of tables Does Matter in RIGHT JOIN also as it is not Symmetry in nature.
- It is Symmetry to LEFT JOIN mirrored around the INNER JOIN. 
  That is to say, On Applying LEFT JOIN with Reversing the order, it will result in same DATA OUTPUT.
- Example Scenario – Retrieve all the payment details, whether or not their customer exists in the database.
*/

SELECT *
FROM customer RIGHT OUTER JOIN payment ON customer.customer_id = payment.customer_id;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------

-------------------------------------------
-------  RIGHT without INNER JOIN  --------
-------------------------------------------

/*
- To Retrieve Records/Entries unique to Table B ON "Matching Column".
- i.e., Row Component "3".
- Syntax :- SELECT * FROM table_A LEFT OUTER JOIN table_B ON Table_A.col_match = Table_B.col_match WHERE Table_A.col is NULL;
- Condition 'Table_A.col is NULL' discard those records which are present in both the tables.
- Example Scenario. - Suppose we have to find customer who had made transactions with us in the past and are present in the payment dataset,
  but not included or incorporated in the customer Dataset. So we may like to add these customers details in our Customer dataset.
*/

SELECT customer.customer_id,payment.customer_id,first_name,last_name,address_id,staff_id,rental_id,amount,payment_date
FROM customer FULL OUTER JOIN payment ON customer.customer_id = payment.customer_id
WHERE  customer.customer_id is NULL; 


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------------  SELF JOIN  ----------------
-------------------------------------------

/*
- Self-Join is a type of query in which 'Table is Joined to Itself' that is joined to its copy.
- It is useful for comparing values in a column within the same table or referring values to the same Table.
- Essentially, it is used when there is a self-relation (relation from table to itself in a Database Relational Diagram). That is when self-join is used.
- There is no special keyword for self-join. It is just a JOIN with itself.
  Any type of JOIN with itself will results in same output, as all the components of Venn diagram coincides.
- Also, when using Self-Join, it is necessary to use ALIAS for table to remove the ambiguity when using multiple times.  
- Syntax :- SELECT A.col, B.col FROM table AS A JOIN table AS B ON A.some_col = B.other_col; 
  
  Matching Criteria or Condition after ON can be any type of condition (Just like WHERE Conditions, 
  but for JOIN, tables column are present on either side of condition), not necessarily "Equals to"
- Example Scenario - Suppose if a table contain employee_id and report_id as to whom they report to, signifying referencing table relation to itself
  (A.emp_col (=) B.report_col) Relation is "employee to another employee" in a relational diagram.
  So to retrieving and analysing information relating to this we need to self join so that report_id relates to emp_id.
*/


/* --- Example for Problem - Retrieve the pair of films that have the same length. --- */
/* Solution Approach ==>
-- To perform this we have to join film with film itself, meaning self join film to relate one record's length to another records's length in same table.
-- To take idea of approach look at this query, we get 5 films with same length of 117:=	SELECT title, length FROM film WHERE length = 117;  
-- So I have to pair them with each other as per the problem.	
-- Here I can Match on length column (which is of attribute type)
-- (A.film_id != B.film_id) filters the resultant self joined table, to make sures the exclusivity of same movie pairs. 
-- Also it gives us insight on how we can play with matching condition.
*/
SELECT A.title, A.length, B.length, B.title                                        
FROM film AS A JOIN film AS B ON A.length = B.length AND A.filM_id != B.film_id;    


/* --- Example for Problem - Pair of films in which 1 film have greater than 4 times the length of another film. */
SELECT A.title, A.length, B.length, B.title                  
FROM film AS A JOIN film AS B ON A.length > 4*B.length; 

/* 
IDEAS for COMPREHENDING the "Conditional Matching Condition/Expression".
- Generally, we perform join on "Primary Key" only so as to get more information for Particular Record.
  And it is logical that for primary/foreign key we have to use EQUI Join Form .
- But when we want to compare two records on basis of some particular feature,
  then we have to first create pair for such comparison(=,>,<,!=) by performing Join on feature column.
- then we can filter it based on our requirement need or specific analysis scenario.  

- This can be best understood through this above examples.
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------


/* ------------------------  JOIN TYPES CONCLUSION with DIFFERNECE   ------------------------ */


--  INNER JOIN  --
--  Component "2"  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id;


--  FULL OUTER JOIN  --
--  Component "1+2+3"  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film FULL OUTER JOIN inventory ON film.film_id = inventory.film_id;


--  FULL OUTER JOIN without the intersection part  --
--  Component "1+3"  --
SELECT film.film_id,title,inventory_id,store_id  
FROM film FULL OUTER JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.film_id is NULL OR film.film_id is NULL;


--  LEFT JOIN  -- 
--  Component "1+2"  --
SELECT film.film_id,title,inventory_id,store_id  
FROM film LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id;


--  LEFT JOIN without the Intersection part  -- 
--  Component "1"  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory_id is NULL;


--  RIGHT JOIN  --
--  Component "3+2"  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film RIGHT OUTER JOIN inventory ON film.film_id = inventory.film_id;


--  RIGHT JOIN without the Intersection part  -- 
--  Component "3"  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film RIGHT OUTER JOIN inventory ON film.film_id = inventory.film_id
WHERE film.film_id is NULL;


--  SELF JOIN  -- 
SELECT A.title, A.length, B.length, B.title                  
FROM film AS A JOIN film AS B ON A.length > 4*B.length; 


----------------------------------------------------------------------------------------------------------


/* ------------------------  LEFT/RIGHT JOIN 'derived from' OUTER JOIN   ------------------------ */

/* 
LEFT JOIN can also be derived with the help of FULL OUTER JOIN. By Removing 3rd Component with WHERE Condition. As 
"WHERE Table A.ID/col_match is NOT NULL;". Similarly, RIGHT JOIN with the help of FULL OUTER JOIN can also be derived,
by adding condition, "WHERE Table B.ID/col_match is not NULL;". 
*/

--  LEFT JOIN  -- 
SELECT film.film_id,title,inventory_id,store_id  
FROM film LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id;

--  LEFT JOIN derived from FULL OUTER JOIN  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film FULL OUTER JOIN inventory ON film.film_id = inventory.film_id
WHERE film.film_id is NOT NULL;

--  RIGHT JOIN  --
SELECT film.film_id,title,inventory_id,store_id 
FROM film RIGHT OUTER JOIN inventory ON film.film_id = inventory.film_id;

--  RIGHT JOIN derived from FULL OUTER JOIN  -- 
SELECT film.film_id,title,inventory_id,store_id 
FROM film FULL OUTER JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.film_id is NOT NULL;

----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
--------------  CHALLENGE   ---------------
-------------------------------------------

-- Challenge 1 --> What are the emails of Customer who lives in California? 
/* California Sales Tax Laws have changed and we need to notify our California Customer to this through Email. */
SELECT customer_id,first_name,last_name,email,address_id FROM customer;
SELECT address_id,address,district FROM address;

SELECT customer_id,first_name,last_name,email,customer.address_id,district
FROM customer INNER JOIN address ON customer.address_id = address.address_id
WHERE district = 'California';
/* Can only Select these 2 coumn as per the answer "district, email" */

-- Challenge 2 --> Get a list of all movies starring "Nick Wahlberg".
/* A customer walks in who is a huge fan of the actor Nick Wahlberg and wants to know which movie he is in. */
SELECT actor_id,first_name,last_name FROM actor;
SELECT actor_id,film_id FROM film_actor;
SELECT film_id,title FROM film;

SELECT first_name,last_name,film_id
FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id;

SELECT film_actor.film_id, title
FROM film_actor INNER JOIN film ON film_actor.film_id = film.film_id;

SELECT first_name,last_name,title
FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
---------  TABLE SET OPERATIONS  ----------
-------------------------------------------

/*
<Note – These are Set Relations on “Whole Records” rather than on Matching Column.
		There are no as such “matching column” for Table Set Operations. >
*/

/* --- I've created two Table For performing Set Operations on Table --- */

--# Films whose rental rate is 0.99$. 
--# Resulting in 344 records/films
SELECT title,rental_rate,length FROM film  WHERE rental_rate = 0.99;

--# Films whose runtime is greater than 100 mins.
--# Resulting in 622 records/films
SELECT title,rental_rate,length FROM film WHERE length >= 100;


--------------------------------
------------  UNION  -----------
--------------------------------

/*
- It concatenates two Table on top of each other.
- It should be logical for this that, Selected columns should be same for both the TABLE. 
- Meaning Column Type and Order must be Compatible for both the Table
- Values for all records (rows) for one Table, and for the features (column) which is not present as per the another TABLE, would result in "NULL".

SELECT column_names FROM Table 1
UNION
SELECT column_names FROM table 2
*/

--# Retrieve those films whose rental_rate is Either 0.99$ or length is greater than 100 minutes.
SELECT title,rental_rate,length FROM film WHERE rental_rate = 0.99
UNION
SELECT title,rental_rate,length FROM film WHERE length >= 100;
--# Resulting in 757 Records


--------------------------------
-----------  EXCEPT  -----------
--------------------------------

/*
- It retrieves those records which are present in first query results "BUT" not exists in second query results.
- It should be logical for this that, Selected columns should be same for both the TABLE. 
- Meaning Column Type and Order must be Compatible for both the Table.
- MINUS operator is also same as EXCPET Operator.

SELECT column_names FROM Table 1
EXCEPT
SELECT column_names FROM table 2
*/

--# Retrieve Those films whose rental_rate = 0.99$ AND runtime is not greater than 100 minutes.
SELECT title,rental_rate,length FROM film WHERE rental_rate = 0.99
EXCEPT
SELECT title,rental_rate,length FROM film WHERE length >= 100;
--# Resulting in 135 Records


--------------------------------
----------  INTERSECT  ---------
--------------------------------

/*
- It retrieves those records which are present in first query results "AS WELL AS" exists in second query results.
- It should be logical for this that, Selected columns should be same for both the TABLE. 
- Meaning Column Type and Order must be Compatible for both the Table.

SELECT column_names FROM Table 1
INTERSECT
SELECT column_names FROM table 2
*/

--# Retrieve Those films whose rental_rate = 0.99$ AND runtime is greater than 100 minutes.
SELECT title,rental_rate,length FROM film WHERE rental_rate = 0.99
INTERSECT
SELECT title,rental_rate,length FROM film WHERE length >= 100;
--# Resulting in 206 Records


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

