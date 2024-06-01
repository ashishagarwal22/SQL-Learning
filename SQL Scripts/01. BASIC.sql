-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

-----------------------------------------------
/* ----------------   INDEX ---------------- */
-----------------------------------------------

/*

==>FUNDAMENTAL QUERYING SQL TOOLS

  /* --- 1. CLAUSES --- */
  - SELECT ... FROM ... 
  - SELECT 'EXTENSIONS' {"DISTINCT", "COUNT"}
  - WHERE ...
  - ORDER BY ... LIMIT ...  
  - ORDER BY 'EXTENSIONS' {"OFFSET", "FETCH", "WITH TIES"}
  - GROUP BY ... HAVING ...
  - GROUP BY 'EXTENSIONS' {"GROUPING SET", "ROLLUP", "CUBE"}
  
  /* --- 2. OPERATOR --- */
  - ARITHMETIC OPERATOR
  - COMPARISON OPERATOR
  - LOGICAL OPERATOR
  - FILTERING OPERATORS {"BETWEEN", "IN", "LIKE", "ALL & ANY/SOME", "EXISTS", "[IS | IS NOT] NULL"}
  - SPECIAL OPERATOR {"ALIAS", "CONCATENATION", "WILDCARD"}
  
*/


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


----------------------------------------------------------------------------------------------------------
/* -------------------------------------------  1. CLAUSES  ------------------------------------------- */
----------------------------------------------------------------------------------------------------------


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  SELECT  ----------------
-------------------------------------------

/*
- SELECT is used to retrieve information i.e., Column features from the Dataset in Database.
- "*" is used to get all the columns in a Table. 
- While Specific columns separated with comma can be mentioned to retrieve specific column.
- SELECT FROM is the main Query Statement. We can say it is must for any of the SQL statement.
  It forms the base of SQL statement.
- FROM decides from which Table or the Dataset we want to retrieve the Columns.
- Syntax :- SELECT column_name(s) FROM table_name;
*/

SELECT * FROM actor;
SELECT first_name,last_name FROM actor;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------  SELECT EXTENSIONS  -----------
-------------------------------------------


--------------------------------
----------  DISTINCT  ----------
--------------------------------

/*
- Many a times Column contains duplicate values or table contains duplicate rows. 
  If we want to retrieve only distinct values from a column or a set of column,
  we use keyword DISTINCT.
- It is used in SELECT Statement before the column name to mention on which column we have to apply this function.
- Syntax :- SELECT DISTINCT column_name FROM table_name; SELECT DISTINCT(column_name) FROM table_name;
*/

SELECT DISTINCT rating FROM film;
SELECT DISTINCT(rating) FROM film;

--------------------------------
------------  COUNT  -----------
--------------------------------

/*
- COUNT returns the number of the records that matches the conditions in a column.
- We can apply COUNT on specific column or on the whole table. That is COUNT(*) or COUNT(column_name).
- COUNT is a column function. And it is used where the column_name is listed in the SELECT statement.
- Syntax :- SELECT COUNT(column_name) FROM table_name;
*/

SELECT COUNT(*) FROM film;
SELECT COUNT(title) FROM film;
SELECT COUNT(DISTINCT rating) FROM film;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  WHERE  -----------------
-------------------------------------------

/*
- WHERE is another most important Function in SQL which makes part of SELECT statement.
- WHERE apply the filtering condition on the data records or Rows and specify which rows to be retrieved
  i.e., on which basis we have to filter the data and retrieve it.
- We can apply the Arithmetic Operator for comapring Values. Like ">", "<", "=", "!=" 
- We can conjunct different condition using Logical Operator AND, OR or apply negation condition NOT.
- We can even compare it with the scalar result of Subquery. We'll see that later.
- It is places at the end of SELECT Clause. Syntax :- SELECT column_name FROM table_name WHERE condition(s).
*/

SELECT * FROM film
WHERE rating = 'R' AND replacement_cost >= 19.99 OR replacement_cost <= 10;


--------  Challenge  --------
-- Challenge 1 --> What is the email for the customer with name Nancy Thomas?
/* A customer forgot their wallet at the store! We need tot trach their email information to inform them. */
SELECT email FROM customer WHERE first_name = 'Nancy' AND last_name = 'Thomas';

-- Challenge 3 --> Retrieve the Phone number for the customer who lives at '259 Ipoh Drive'.
SELECT phone FROM address WHERE address = '259 Ipoh Drive';


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
----------------  ORDER BY  ---------------
-------------------------------------------

/*
- ORDER BY operator is used to "sort" the resultant output data based on column(s) value.
- We can also mention multiple column in specific order to sort the rows based on multiplt columns.
  In this way, it will sort first based on the first mentioned column and subsequently sort later column.
- Sorting can be done Either alphabetically or Numerically based on the column type.
- ASC and DESC can be used AFTER mentioning each column_name to specify whether we have to sort in ascending or Descending order for that column. Default is ASC.
- ORDER BY comes after SELECT Statement. Syntax :- SELECT FROM WHERE ORDER BY column_names(s) ASC/DESC LIMIT n;
*/

SELECT store_id, first_name, last_name FROM customer
ORDER BY first_name DESC;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;


--------------------------------
------------  LIMIT  -----------
--------------------------------


/*
- LIMIT is used to set hard limit of how many records we want to retrieve.
- It is useful for not returning every single row, but only view the top few rows to get an idea of table layout.
- It is pretty useful in combination with ORDER BY after sorting.
*/

SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date LIMIT 5;



-------  CHALLENGE  -------
-- Challenge 1 --> What are the customer ids of the first 10 customer who created a payment.
/* Our store completes 1 year of service and so we want to reward our first 10 customer. */
SELECT customer_id FROM payment 
ORDER BY payment_date ASC LIMIT 10;

-- Challenge 2 --> What are the title of the 5 shortest movies (in length of runtime)?
/* A customer wants to rent a film to quickly watch over the short break. */
SELECT title, length FROM film 
ORDER BY length ASC LIMIT 5;

-- Challenge 3 --> If the previous customer can watch any movie that is 50 minute or less, how many option does he have?
SELECT COUNT(title) FROM film
WHERE length <=50;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
----------  ORDER BY EXTENSIONS  ----------
-------------------------------------------


--------------------------------
-----------  OFFSET  -----------
--------------------------------

/*
- Skip first n_rows for Retrieving.
- Can only be placed at an end of Statement.
- Can be used Either 'Separately' or as an 'Extension of ORDER BY'
- Syntax := OFFSET n_rows.
*/
SELECT store_id, first_name, last_name FROM customer
OFFSET 5;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name OFFSET 5;

--------------------------------
-----------  FETCH  ------------
--------------------------------

/*
- Retrieve next n_rows only.
- Can only be placed at an end of Statement.
- Can be used Either 'Separately' or in 'Extension of ORDER BY'
- Syntax := FETCH FIRST n_rows ROWS ONLY;
*/
SELECT store_id, first_name, last_name FROM customer
FETCH FIRST 10 ROWS ONLY;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name FETCH FIRST 10 ROWS ONLY;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name OFFSET 5 FETCH FIRST 10 ROWS ONLY;

--------------------------------
---------  WITH TIES  ----------
--------------------------------

/*
- same as LIMIT, but also retrieve all records that ties with last sorted value on the sorting Column. 
- Syntax := ORDER BY salary WITH TIES 10;
            (will also fetch records whose value is same as that of nth record even though no of records go beyond n_rows.)
*/
SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name LIMIT 10 WITH TIES;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


------------------------------------
--------  GENERAL CHALLENGE  -------
------------------------------------

-- Challenge 1 --> How many actors have a first name that starts with the letter P?
SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';

-- Challenge 2 --> How many uniqe districts are our customers from?
SELECT COUNT(DISTINCT DISTRICT) FROM address;

-- Challenge 3 --> How many films have a Rating of 'R' and a replacement cost between $5 and $15?
SELECT COUNT(*) FROM film
WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

-- Challenge 4 --> List out the film that have the word Truman somewhere in the title.
SELECT title FROM film
WHERE Title LIKE '%Truman%';


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
----------------  GROUP BY  ---------------
-------------------------------------------

/*
- GROUP BY performs the aggregation function on column, based on per "Categorical Classes" of the grouping column. 
- Remember that Aggregation Function is must for GROUP BY Clause.
- If we want to sort based on the aggregation function result, 
  make sure to mention the whole aggregation function in the ORDER BY Clause. 
- GROUP BY clause must be placed after the SELECT FROM WHERE Statement. And Before Order By if Sorting. 
- Syntax :- SELECT col_name_for_grouping, AGG_FUN(col_name_for_agg_fun) FROM table_name GROUP BY col_name_for_grouping HAVING condition_on_agg_fun;

- Important Note --> We can only SELECT those columns for which we based our grouping on AND 
					 those columns on which we are applying our agg fun.
*/

SELECT staff_id,customer_id, SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY customer_id	  
LIMIT 10;

SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(AMOUNT) DESC
LIMIT 5;



---------  CHALLENGE  ---------
-- Challenge 1 --> How many Payments di each staff member handled and thus who gets the bonus?
/* We want to give bonus to the staff member who handled the most number of transactions. */
SELECT staff_id, COUNT(staff_id) FROM payment
GROUP BY staff_id;

-- Challenge 2 --> What is the Average replacement Cost per MPAA Rating?
/* Corporate HQ is conducting a study on the relationship between replacement cost and a movie MPAA Rating. */
SELECT rating,ROUND(AVG(replacement_cost),2) from film
GROUP BY rating
ORDER BY AVG(replacement_cost);



--------------------------------
-----------  HAVING  -----------
--------------------------------


/*
- Filtering Condition, same as Where Clause, but ON aggregated functions Results which has already taken place.
- Placed after the GROUP BY function in GROUPBY CLAUSE.
- Syntax :- SELECT  FROM  WHERE ...  GROUP BY  HAVING  ...  ORDER BY  LIMIT
*/

SELECT customer_id, SUM(amount), COUNT(amount) FROM payment
WHERE amount<5
GROUP BY customer_id
HAVING count(amount)<35      --Same as WHERE clause but for Aggregated Function columns 
ORDER BY SUM(amount) DESC
LIMIT 10;



------  CHALLENGE  ------
-- Challenge 1 --> 	What customer_ids are eligible for Platinum Status?
/* We are launching a Platinum Service for our most loyal customers. We will assign platinum Status to those customers that have had 40 or more transactions with us. */
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(amount)>=40
ORDER BY COUNT(amount);

-- Challenge 2 --> What are the Customer IDs of customer who have spent more than 100$ in paymen transactions with our staff ID 2? 
SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >=100;


--------------------------------------  IMPORTANT NOTE  --------------------------------------
/* 
Important Notes regarding GROUP BY with examples below - 
- Example 1, We can choose to display/SELECT all the grouped column in the SELECT statement. 
- Example 2, We can choose to NOT SELECT any grouped column as not to display them. 
  But it doesn't make sense as it isn't understandable or comprehensible. It should be done based on context. 
- Example 3, we CANNOT select those columns which we are not using as either grouping or for aggregating, just
  to retrieve/display it. Because it is grouped in the grouping column so logically it is not possible for it to
  be displayed individually. For Eg. - Take a look at below example, in this as we have grouped customer_id, we cannot SELECT 
  'staff_id' to retrieve as both Staff_id_1 & Staff_id_2 are grouped for any customer so logically it is not
  possible to display them individually.
*/   

-- Example 1 -- -- SELECT all the GROUPED column. usually what we should do. --
SELECT staff_id,customer_id, SUM(amount) FROM payment  
GROUP BY staff_id,customer_id
ORDER BY customer_id	  
LIMIT 10;  

-- Example 2 -- -- Choose to display either staff_id or customer_id based on context. --
SELECT customer_id, SUM(amount) FROM payment  
GROUP BY staff_id,customer_id
ORDER BY customer_id	  
LIMIT 10;

-- Example 3 -- -- We cannot SELECT other column which is not the Grouping column. --
--     i.e., SELECTED columns must either be in GROUP BY clause or in aggregation function. --
SELECT customer_id, SUM(amount) FROM payment  
GROUP BY customer_id
ORDER BY customer_id	  
LIMIT 10;
--------------------------------------  IMPORTANT NOTE  --------------------------------------


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------  GROUP BY EXTENSIONS ----------
-------------------------------------------


/*
Important Note - 
  - Below are the three extensions of GROUP BY for aggregating based on multiple possible combinations of Grouped Column(s).
  - All these Extensions allows us to perform Aggregation Function on ALL the "Possible Categories Combination" of 
    either some or all the "Possible Combination of SUBSETS from within the SUPER SET of Grouped Column(s)".
	rather than just the single one as in the case of simple GROUP BY. 
  - These are very useful Extensions for GROUP BY to simplify Complex Query and increase efficiency.
  - Remember - Those Column which are not used for aggregating in particular grouping/partitions, will be mention as "NULL"
    in the Data Output. So it's in the best practice to Replace it with some understandable text like "TOTAL" with COALESCE.
  
I've created the TEMPORARY TABLE | VIEW for This Purpose, to perform all the grouping extensions.
  - VIEW that shows "which film (and its detail with category name) was sold by which Staff_id".
  - I've stored the result of query as a temporary Table AS VIEW.
*/

CREATE VIEW staff_film AS
SELECT staff_id, film_id, title, rating, name AS category_name 
FROM rental JOIN inventory USING(inventory_id) JOIN 
(SELECT film_id, title, rating, name 
 FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)) USING(film_id);

SELECT * FROM staff_film;


--------------------------------
-------  GROUPING SETS  --------
--------------------------------

/*
- GROUPING SETS allows us to group any of the 'POSSIBLE COLUMN COMBINATION(s)' from our 'MULTIPLE GROUPING COLUMN'. 
  We can give our 'customize set of combinations' from GROUPING COLUMNS to execute grouping call.
- Eg. Let us say, we are performing GROUP BY on grouping set (c1, c2, c3);  With standard GROUP BY, we can perform GROUP BY
     on this "particular combination" only. But if we want to perform GROUP BY on different combination say (c1,c2)
	 (c3,c2), (c1), (c3), (), we need to UNION ALL this tables as a separate query. But that'll not be efficient.
     Instead, we can use GROUPING SET Keyword
- Look example for GROUP BY of (c1,c2) and GROUP BY of (c1,c2,c3) here - Syntax := 
			GROUP BY GROUING SET ((c1,c2), (c1,-), (-,c2), (-,-));
			GROUP BY GROUING SET ((c1,c2,c3), (c1,c2,-), (c1,c3,-), (-,c2,c3), (c1,-,-), (-,c2,-), (-,-,c3), (-,-,-));
  Note - I've mentioned all the combination just for understanding purpose. We can perform group by on the subset of this.
       - I've used "-" for understanding purpose. It is not needed in the actual syntax.
		  Only mention those column_order on which want to partition.
  
- In general, we can select from within the 2^n combinations for n mentioned column in Input Column(s). 			
- To retrieve all the possible combination, we can directly use CUBE (Refer lesson for CUBE after ROLLUP).
*/

/*
Example - Business Case Situation
Suppose company wants to know that how much each 'film_Rating' or each 'film_Category' movies was sold by either of the 'staffs'.
Also how much is the sale of particular 'film_Rating' or particular 'film_Category' to compare the staffs sales rep with total sales.
So how do we retrieve dataset for such scenario.
General and brute force method is to add all the GROUP BY combination using UNION. But then query will look overwhelming,
and it will create load duing the execution process. More efficient and easy method is to use GROUPING SET.
*/

--# First, We will run without GROUPING SET
(SELECT staff_id, NULL, category_name, COUNT(*) FROM staff_film
GROUP BY staff_id, category_name ORDER BY staff_id)
UNION ALL
(SELECT staff_id, rating, NULL, COUNT(*) FROM staff_film
GROUP BY staff_id, rating ORDER BY staff_id)
UNION ALL
(SELECT NULL, rating, NULL, COUNT(*) FROM staff_film
GROUP BY rating ORDER BY rating)
UNION ALL
(SELECT NULL, NULL, category_name, COUNT(*) FROM staff_film
GROUP BY category_name ORDER BY category_name);

--# As you can conclude, that only one combination is allowed to aggregate so we have to explicit UNION ALL each combinations.

--# Now, look at the convenience of above query with 'GROUPING SET'
SELECT staff_id, rating, category_name, COUNT(*) 
FROM staff_film
GROUP BY GROUPING SETS ( (staff_id, category_name), (staff_id, rating), (rating), (category_name))
ORDER BY staff_id, rating, category_name;
--# Same result but with much more simple Query AND Efficient Underlying Execution.


--------------------------------
------------  ROLLUP  ----------
--------------------------------

/*
- It allows us to perform Aggregation Function on all the Possible "Hierarchical Combinations"
  moving from Bottom Most to Top Order of Input Column(s) | Inner most to Outer Order.
  (c1,c2,c3) then (c1,c2,-) then (c1,-,-)
  Meaning, If we are ROLLING UP on multiple columns, ROLLUP will super aggregate moving from bottom most hierarchy to uppermost.
- That is to say 
  First, it results in an aggregation of all the outermost partitions grouped together. 
  Second, it results in one more row of result of 'super aggregated calculation' of its sub-partitions.
  Lastly, it results in one more row for result of 'super-super aggregated calculation' of above aggregation.
- ROLLUP considers a hierarchy on which order the column is mentioned. (c1, c2, c3) --> c1 > c2 > c3.
- Few Examples with 1 or 2 or 3 Column ROLLUP. Syntax :=
				GROUP BY ROLLUP(c1); --> {(c1), (c-)}
				GROUP BY ROLLUP(c1,c2); --> {(c1,c2), (c1,-), (-,-)}
				GROUP BY ROLLUP(c1,c2,c3); --> {(c1,c2,c3), (c1,c2,-), (c1,-,-), (-,-,-)}
				GROUP BY c1, ROLLUP (c2, c3); --> {(c1,c2,c3), (c1,c2,-), (c1,-,-)}         --# Partial ROLLUP.

- Remember - Specified Column Order in Input Column(s) for this function call is important as it creates Hierarchy based on it. 
- It is basically in literal terms UNIONing grouping on innermost to outermost based on hierarchy of mentioned order of set of columns.
*/

SELECT staff_id, rating, category_name, COUNT(*) 
FROM staff_film
GROUP BY ROLLUP (staff_id, rating, category_name)
ORDER BY staff_id, rating, category_name;
--# Look at how the different combination of aggregation from innermost to outermost hierarchy is returned.
--# staff_id, rating, name --> staff_id, rating, NULL ---> staff_id, NULL, NULL --> NULL, NULL, NULL.


--------------------------------
------------  CUBE  ------------
--------------------------------

/*
- CUBE is special case of GROUP BY's GROUPING SET. By default, it selects "ALL" the 'possible 2^n combination'
  in SUPER SET of Grouping Column(s), as mentioned above. Syntax := 
				GROUP BY CUBE(c1,c2,c3);
				GROUP BY c1, CUBE(c2,c3);      --# Partial CUBE. 

- It is a Shorthand for GROUPING SETS to select all combination.
*/

SELECT staff_id, rating, category_name, COUNT(*) 
FROM staff_film
GROUP BY CUBE (staff_id, rating, category_name)
ORDER BY staff_id, rating, category_name;
--# Look at how aggregation of 'ALL the 2^n possible combination' of (staff_id, rating, name) has been returend.

SELECT staff_id, rating, category_name, COUNT(*) 
FROM staff_film
GROUP BY staff_id, CUBE (rating, category_name)
ORDER BY staff_id, rating, category_name;
--# PARTIAL CUBE. Look at how it is giving us aggregation of all the possible combination of staff_id 
--# with either rating or with film_category. that is Staff,name,rating OR staff,name OR staffstaff-rating OR staff only.
--# Thus if we want to analyze how much either the particular 'film_rating' or the particular 'film_category' or with
--# both particular rating_category combination is sold by Either of the staff. We can use this.


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


-----------------------------------*-----------------------------------------*----------------------------
/* --------------------------------*----------  2. OPERATOR  ----------------*------------------------- */
-----------------------------------*-----------------------------------------*----------------------------


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
----------  ARITHMETIC OPERATOR  ----------
-------------------------------------------

/*
- There are 5 Arithmetic operator in SQL. SQL also follow BODMAS rule for complex formulas.
- "+", "-", "*", "/", "%", "BODMAS"
- Used to Perform Arithmetic Operations on Columns, whether in the SELECT or in the WHERE.
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
----------  COMPARISON OPERATOR  ----------
-------------------------------------------

/*
- There are 6 Comparison Operator in SQL.
- "=", "!= | <>", ">", "<", ">=", "<=" 
- Used to Compare Results in WHERE Statement Conditions.
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------  LOGICAL OPERATOR  ------------
-------------------------------------------

/*
- "AND", "OR", "NOT"
- Used to perform Logical Operators on the Conditions
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
----------  FILTERING OPERATOR  -----------
-------------------------------------------

/*
- "IS NULL", "BETWEEN", "IN", "LIKE/ILIKE", "ALL/ANY", "EXISTS"
- Very Important Note = All these special operators can be used with conjunction of Logical Operator "NOT".
  i.e., NOT IN, NOT BETWEEN, NOT LIKE, NOT EXISTS, NOT ALL/NOT ANY, IS NOT NULL.
*/


--------------------------------
-----------  IS NULL -----------
--------------------------------

/*
- “IS” is special Filtering Operator which can only be used with NULL predicate.
- Comparison Operator with NULL results in not True or False, BUT in NULL or Unknown.
  So "IS" allows us to compare if the value is NULL
- Syntax := IS NULL, IS NOT NULL  
*/
--------------------------------
----------  BETWEEN  -----------
--------------------------------

/*
- BETWEEN operator is used to match a column values against a range of values, in filtering condition.
- Syntax :- WHERE column_name BETWEEN low AND high.
- It automatically conjunct two filtering condition - Value greater than LOW AND less than HIGH both Inclusive.
- Can also be used as NOT BETWEEN low AND high. - Value less than LOW AND greater then HIGH both Exclusive.
- Can also be used with dates datatype. Dates should be in ISO 8601 or American format of YYYY-MM-DD.
*/

SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 and 9;

SELECT * FROM payment
WHERE payment_date BETWEEN '200-02-01' AND '2007-02-15';
/* Give Special note to inclusivity for the last date as PostgreSQL consider date starts form 00:00 hour. */



--------------------------------
-------------  IN  -------------
--------------------------------

/*
- Sometimes we have to check multi possible option for values in column. Its redundancy to use OR again and again.
- We can use IN operator to create a condition that checks if the values is IN or match to any of the options included in the list.
- It conjunct all the filtering conditions such as - value = 'A1' OR value = 'A2' OR value = 'A3' and so on....
- It is used in Filtering Condition as a list. Syntax :- WHERE column_name IN ('A1','A2','A3',...)
- We can also use NOT IN to specify that the value should not match to any of the options from the set.
*/

SELECT * FROM customer
WHERE first_name IN ('John','Jake','julie');

SELECT * FROM payment
WHERE amount NOT IN (0.99,1.98,1.99);



--------------------------------
------------  LIKE  ------------
--------------------------------

/*
- What if we want to match the value against the general pattern of a string. We can use LIKE operator to perform such functionality.
- LIKE uses wildcard characters to match against a general pattern as specified.
- "%" = Match against any number/sequence of characters(0 or more). "_" = Match against any single character. 
- LIKE is case sensitive. ILIKE is case insensitive. 
- It is like Regex in normal Programming language. And Postgre support full REGEX capabilities: https://www.postgresql.org/docs/12/function-matching.html
- Syntax = WHERE column_name LIKE 'Pattern' 
*/

SELECT COUNT(*) FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE '%e'; -- Name that start with "J" and ends with an "e".

SELECT first_name FROM customer
WHERE first_name NOT LIKE '%er%'; -- Name that not has an 'er' anywhere in the string.

SELECT first_name FROM customer
WHERE first_name LIKE '_her%'; -- Name that has 'her' at 2nd position. 



--------------------------------
------------  ALL  ------------
--------------------------------

/*
- ALL retrieve Data if it satisfies the 'Comparing Condition' with "ALL" the 'SET VALUES returned by Subquery'.
- It is succeeded by SUBQUERY or a LIST. 
- ALL Operator compare the field_value with all the values from the given 'SET'; AND, Retrieve it only when it 
  satisfies the specified condition with "EACH" value from the SET.
  'SET' --> (Either Mostly from "Column Output of Subquery Result" OR "explicit list").
- It must be preceded by comparison_operator for 'Comparing Condition'.
- It can be used in both the WHERE or HAVING clause
- Syntax := WHERE field_value any_comparison_operator ALL (SET from Subquery);
*/


/* --- Retrieve those Customer IDs whose Maximum payment amount among all their payments is NOT greater than
       Average amount of ALL the Customer's ID. --- */
SELECT customer_id, MAX(amount) AS max, MIN(amount) AS min, AVG(amount) AS avg, SUM(amount) AS sum
FROM payment GROUP BY customer_id
EXCEPT 
SELECT customer_id, MAX(amount) AS max, MIN(amount) AS min, AVG(amount) AS avg, SUM(amount) AS sum
FROM payment GROUP BY customer_id
HAVING MAX(amount) >= ALL (SELECT AVG(amount) FROM payment GROUP BY customer_id)


--------------------------------
----------  ANY/SOME  ----------
--------------------------------

/*
- ANY retrieves data if it satisfies the 'Comparing Condition' with "ANY" of the 'SET VALUES returned by subquery'.
- It is succeeded by SUBQUERY or a LIST. 
- ANY Operator compare the conditional field value with all the values from the given 'SET'; AND,  Retrieve it only when it 
  satisfies the condition with "ANY" value from the SET.
  SET --> (Either Mostly from "Column Output of Subquery Result" OR "explicit list").
- It must be preceded by comparison_operator for 'Comparing Condition'.
- It can be used in both the WHERE or HAVING clause
- Syntax := WHERE field_value any_comparison_operator ANY (SET from Subquery);
- "SOME" KEYWORD use case is same that of "ANY". they can use interchangeably.
*/

/* -Retrieve those customers whose MAX payment is less than "ANY" of the customer's Average Payment Amount - */
SELECT customer_id, MAX(amount) AS max, MIN(amount) AS min, AVG(amount) AS avg, SUM(amount) AS sum
FROM payment GROUP BY customer_id
HAVING MAX(amount) <= ANY (SELECT AVG(amount) FROM payment GROUP BY customer_id)



--------------------------------
-----------  EXISTS  -----------
--------------------------------

/*
- EXISTS keyword check for Existence of Rows or Records of Main query within the Subquery.
- It is succeeded by SUBQUERY. 
- It retrieves the record only if it is present in subquery. that is 'T' in subquery.
- Very Important point to remember here, for EXISTS we do not have to check all the columns of Main query within Subquery.
  We can check for existence of Row within the main query using ANY of the column(attribute) in Subquery
- Syntax := <MAIN QUERY> WHERE EXISTS(subquery)
- Check its example in the 'Subquery Section' from the 'Temporary Table' Part of the 'Advanced Script'.

-	Logical execution flow of EXISTS statement.
	•	First, it retrieves the single row in main query.
	•	Second, check for its existence in the subquery, using the column present in the subquery select statement.
	•	Third, if it is present in subquery, evaluate it as True and retrieve it; Otherwise evaluate it as False and skip it.
	•	<Do this for all the row, one by one>
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------  SPECIAL OPERATOR  ------------
-------------------------------------------

--------------------------------
----------  ALIAS  ----------
--------------------------------

/*
- ALIAS is used to rename column as to display it in the data output.
- ALIAS is also used to rename Table to refer it using alias in the other places of the querying statement.
- "AS" Keyword is used to rename the column or table. Syntax := old_name AS new_name. 
*/


--------------------------------
--------  CONCATENATION  -------
--------------------------------

/*
- "||" Double Pipe operator is used to Concatenate String/Text of columns
- Syntax := text_column_1 || text_column_2

- We can use LITERAL as ['literal_text'] also to concatenate specific text creating our own unique pattern.
- Syntax := text_column_1 || 'literal_text' || text_column_2. E.g. First_name || ‘ ‘ || Last_name
*/

--------------------------------
-------  REGEX|WILDCARD --------
--------------------------------

/*
- We can use WILDCARD operators {'%','_','-','[range]'} to create our very specific pattern matching
- It is REGEX that is Regular Expression Pattern Matching.

IMPORTANT 
To compare the STRING using Regular Expression, we have to use comparison operator tilde "~".
*/


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

