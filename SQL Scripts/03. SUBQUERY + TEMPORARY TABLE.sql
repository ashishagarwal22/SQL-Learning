-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

-----------------------------------------------
/* ----------------   INDEX ---------------- */
-----------------------------------------------

/*

==> SUBQUERY && Query Output Table ASSIGNMENT to Temporary Table (Virtually, Physically)

  /* --- 5. TEMPORARY TABLE --- */
  SUBQUERY (Independent & Correlated)
  TEMPORARY TABLE 
  - VIEW
  - CREATE TABLE AS
  - SELECT INTO
  - CTEs
  - Recursive CTEs
 
*/


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

-----------------------------------*-----------------------------------------*----------------------------
/* --------------------------------*-------  5. TEMPORARY TABLE  ------------*------------------------- */
-----------------------------------*-----------------------------------------*----------------------------

-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
---------------  SUB QUERY  ---------------
-------------------------------------------

/* BRIEF LESSON
SUBQUERY are of two types, Independent and Correlated.
Independent Subquery don’t depend on the Main query.
While, Correlated Subquery have somewhat connection to main query and cannot execute on its own.

INDEPENDENT SUBQUERY can result in three type of Output, Namely =
  1. Table (Nested Subquery) => Used in the FROM Clause Only as 'Temporary Result Table'. Identification Syntax :=
  									... FROM (Subquery_Table) ...;
										
  2. Single Value => Used in the WHERE or HAVING Clause only. Compulsory preceded by comparion_operator. Suntax :=
  									... WHERE column_value comparion_operator (Subquery_SingleValue) ...;
  							
  3. Single Column (SET VALUE) => 2 Cases, As per my current knowledge,--> 
									First, It can be used in 'SELECT' clause for 'printing column from another table without using JOIN'.
									... SELECT t1.c1, (SELECT t2.c2 FROM t2 WHERE matching_condition) FROM t1
									Second, Used in the 'WHERE' or 'HAVING' Clause for comparison purpose.  
  								  	used with 3 Special Filtering_Operator ("IN", "ANY | ALL")
									... WHERE column_value IN (subquery_Column_SetValues) ...;
									... WHERE column_value comparison_operator ALL|ANY () (subquery_Column_SetValue) ...;
 									... WHERE EXISTS (subquery_Column_SetValue) ...;
										
CORRELATED SUBQUERY results in mostly TABLE and are used mostly in WHERE/HAVING Clause with EXISTS, This is special case as
In this it is not used as the Result but as a 'Boolean Function' to evaluate the Outer Query Records.
									... WHERE EXISTS (subquery_Column_Table) ...;
*/


/* DETAILED LESSON 
- What if we have to perform a query on the result of the another query. We may need to store query
  results as a variable and then can we use it, right no! But what If SQL provides a way to simplify 
  this by directly taking the use of query results as a sub-query in the main query.
- Essentially, we are replacing any temporary variable directly with subquery. 
- Parentheses are compulsory for SUBQUERY.

- Three type of output are possible with Subquery - "SINGLE VALUE" or "SINGLE COLUMN as SET VALUE" or "TABLE".

- There are two type of Subqueries. "Independent" aka "NESTED" or "CO-RELATED". 
  INDEPENDENT/NESTES = If the Execution of Inner Query is INDEPENDENT of Outer Query.
  				       Inner Query Get executed first and then Outer Query.
  CO-RELATED  = If the Execution of Inner|Sub Query is DEPENDENT on Outer|Main Query.
                Inner|Sub Query GET data(column/row) from Outer|Main Query "Row by Row", perform Execution.
				Then, its Results are used for Outer|Main Query to execute.

- There are three places where it can be used. - "WHERE/HAVING" Clause or "FROM" Clause or "SELECT Clause".

- Syntax :- Just replace the variable (which is nothing but output of another query) with subquery
  (of which it is output of) in the parentheses inside the main query.
  
  There is no particular SYNTAX for SUBQUERY but most common used case is  ==> 
  SUBQUERY within "WHERE" or "HAVING" CLAUSE - 
				SELECT column_name FROM table_name WHERE column_name EXPRESSION_OPERATOR (SUBQUERY).
						Eg.	 - WHERE salary > (Subquery_SingleValue); 
       						   ==> WHERE grade > 70;
							 - WHERE student IN (Subquery_SetValue); 
	     					   ==> WHERE cousins IN ('Ashish','Rishav','Monu','Mayur');
							 - WHERE salary > ALL|ANY (Subquery_SetValue);
							   ==> WHERE salary > ALL|ANY (70000,80000,110000,150000,250000,500000);
							 - WHERE EXISTS (Subquery_Table);
							   ==> WHERE EXISTS T's/F's;
  
  SUBQUERY within "FROM" CLAUSE - . It is executed first for this case and is stored as TEMPORARY TABLE.
				SELECT column(s) FROM (Subquery_Table);
				SELECT column(s) FROM (Subquery_Table) as table_1, table_2 WHERE condition(s);			
*/

----------------------------------------------------------------------------------------------------------
/* --- If a subquery results in a ""Single Value"" output then we can use it with comparison operator. --- */
/* Example for Problem - Retrieve Movie Titles whose Rental Rate is more than average Rental Rate. */
SELECT title, rental_rate FROM film 
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
/*Return Film name with its corresponding Category, WITHOUT using JOIN*/
SELECT f.title, 
	(SELECT
		(SELECT c.name FROM category c WHERE f_c.category_id = c.category_id)
	FROM film_category f_c WHERE f.film_id = f_c.film_id)
FROM film f;


/* ---- If a subquery results in a ""Column/LIST"" output then we can use it with 'IN', 
        'ALL|ANY' or with 'EXISTS' function to check its existence. ---- */

/* 1st Example for Problem - Retrieve Full name of customers who had made atleast a single payment of more than 10$. */
SELECT first_name || ' ' || last_name FROM customer AS c
WHERE EXISTS(SELECT * FROM payment AS p WHERE amount > 10 AND p.customer_id = c.customer_id);
-- Helps in elimination of Join.


/* 2nd Example for Problem (using Multiple Approach)- Retrieve Records of Film title of rents, where return date is 29th May 2005. */

---- 1st Approach through "SUBQUERY" with "IN", (Helps in elimination of 1 JOIN) ----
--# Take Note at how SUBQUERY at different places result in same answer with different logic.
SELECT film.film_id, inventory_id, title 
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id 
WHERE inventory_id IN (SELECT inventory_id FROM rental WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30');

             /* --- OR ---- */
			 
SELECT film_id,title FROM film WHERE film_id IN 
(SELECT inventory.film_id FROM rental INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30') ORDER BY film_id;


---- 2nd Approach through "SUBQUERY" with "EXISTS" ---- 

SELECT inventory_id, title
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id 
WHERE EXISTS(SELECT inventory_id FROM rental WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30');
--# Correcting above solution with addition of "Matching Condition". THIS IS IMPORTANT (for complete explanation, refer EXISTS from below)
SELECT inventory_id, title
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id 
WHERE EXISTS(SELECT inventory_id FROM rental WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'
			                                       AND rental.inventory_id = inventory.inventory_id);
												   
---- 3rd Approach through "MULTIPLE JOINS" only ----
SELECT rental_id,customer_id,rental_date,return_date,inventory.inventory_id,film.film_id,title
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id 
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30';



------------------------------------------------  EXISTS  ------------------------------------------------
/* 
"EXISTS"
- EXISTS is very special type of operator. Its underlying execution process is also completely different.
  For EXISTS(Subquery_statement), first the main_query is get executed, then those rows existence are tested in subquery statement.
  If the Row/Record from the main_query is present in the subquery, then it is retrieved.
- i.e., If a Row from outer query "Evalutes to TRUE or satisfies the condition" of Subquery | inner query, then only it is retrieved.

- Basically, Main query doesn't compare subquery result with anything. Meaning it don't require columns value to compare to.
  Instead, main query just check for presence of its rows inside the Subquery.
  
- EXISTS function is used to test for the presence of rows in the Suquery.
- EXISTS is acting like a boolean function, which gives T or F as an output. Meaning, instead of using subquery's role directly,
  we are using it as a parameter of EXISTS function to check for outer rows existence.
  
  Scenario Eg. - SELECT student,grade FROM test_score WHERE EXISTS(SELECT student FROM x_table);
			- Here we are retriving those students only and their grades who are present in x_table.
			  If they are not present in X_table, they will evaluate to False and will not be retrieved.

Remember - Subquery parameter for EXISTS function will definitely be a "CORRELATED SUBQUERY", otherwise how will we check for outer rows
			within the Subquery. There should be some relation of outer with inner. If not, then all the records of outer table will be retrieved

Independent to Correlated ==>
For eg. look at 2nd approach for solving 2nd Example Situation through EXISTS, when we replace IN with EXISTS,
our solution is correct, but still it retrieves every records, so to correct this, we have to modify our answer little bit
by adding MATCHING CONDITION on Matching column in WHERE clause. 
i.e., Matching column here is "Inventory_id" from 'rental of Subquery' and from 'film JOIN inventory of Mainquery.'
*/		

/*
- EXISTS keyword check for Existence of Rows/Records of Main query within the Subquery.
- It is succedded by SUBQUERY. 
- It evaluates the every record of Nested Query and give result of it as True or False.
- It retrieves the record only if it is present in subquery. that is 'T' in subquery.
- Very Important point to remember here, for EXISTS we do not have to match all the columns of nested query with main query.
  We have to match the record using only matching column or SELECT those column only in the nested query which are a subset of Main query.

- Syntax := WHERE EXISTS(subquery)
- Check its example in the 'Subqery Section' from the 'Temporary Table' Part of the 'Advanced Script'.
*/
------------------------------------------------  EXISTS  ------------------------------------------------


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


------------------------------------------------------------
--------------------  INDEPENDENT TABLE  -------------------
------------------------------------------------------------

/*
- We often have to refer to same 'Resultant Table' of some 'Complex Query' (with Joins and conditions)
  again and again. Instead of calling this query again and again as a Starting Point, we can assign its result as
  either "Virtual" or "Physical" Table; And, then can directly access this specific table without writing query again as starting point .
- It's like assignment of output/resultant/retrieved table in Python or R.
- Virtual Table is like Imaginary table, which are not actually stored in the DATABASE, but either in the working memory 
  or as a shorthand for query.
- We can Update and Alter existing Temporary Table {Virtual or Physical} also.

- There are mainly five ways to create Temporary Table. Namely-
  VIEW, CREATE TABLE AS, SELECT INTO, CTE.
  
  Main DIFFERENCES Between this are 
  - VIEW only create Virtual, while CREATE and SELECT create both VIRTUAL AND PHYSICAL table.
  - We have more functionality with CREATE TABLE AS than SELECT.
  - CTEs are temporarily created Virtual Table Within the Main Query itself, which disappear after main_query executes.
  
In 'CONCLUSION', Use this as per the situation - 
  - Independent SUBQUERY can be used when we don't have to refer Temporary Table again and again for the FROM clause only. 
  - VIEW are better option for creating VIRTUAL TABLE.
  - CREATE TABLE AS are better option for creating PHYSICAL TABLE as it provides more functionality.
*/

/* --- We will assign these Query Result into Temporary Table. --- */ 

/* 1st - It consists of two columns (Genre, movie). I've use this for the VIEW and SELECT INTO. */
SELECT name genre, title movie
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
ORDER BY genre;

/* 2nd - It consists of two column (full_name, address). I've use this for the CREATE TABLE AS. */
SELECT first_name || ' ' || last_name full_name, address 
FROM customer JOIN address USING(address_id)
ORDER BY full_name; 


-------------------------------------------
----------  Independent SUBQUERY  ---------
-------------------------------------------

/*
Complete details mentioned above in the Subquery section. This is only for Table result of Subquery.
- Independent Subquery are the type of Temporary Table Result that executes within the main query itself,
  give its output to outer or main query and disappear by itself.
- It doesn't have any special "Syntax" as such, as it can be used directly where the need for Subquery arises.
- It is what make simple query complex, as we sometime need to make use of manipulated data table in other queries.
- It is also this subquery itself that we replace with other type of Simplifying Temporary Table Result
  like VIEWs, CTEs, Physical Table by CREATE TABLE AS or SELECT INTO.
  
- As for Nested Query, it can be used in two places,
  FROM Clause - SUBQUERY Table Result as - 'Table' "in place of table_name".
									SELECT ... FROM (subquery_table_table) OTHER_CLAUSES...;
*/


-------------------------------------------
------------------  VIEW  -----------------
-------------------------------------------

/*
- It is the Clause for assigning Query result into TABLE.
- It will create "Virtual Table" only.
- View clause is placed at the starting of the statement.
- Syntax :=
				CREATE VIEW view_name AS 
				QUERY;
				
- We can use "CREATE VIEW "IF NOT EXISTS"" to check whether the VIEW has already been created before.
  It allows us to bypass the Error if executed again and log it as a message. 
				CREATE VIEW IF NOT EXISTS view_name AS QUERY;
*/


CREATE VIEW film_category_view AS
SELECT name genre, title movie
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
ORDER BY genre; 

SELECT * FROM film_category_view;

--# Altering this view is very simple. CREATE OR REPLACE VIEW view_name AS
CREATE OR REPLACE VIEW film_category_view AS
SELECT name genre, title movie
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
WHERE name = 'Action'; 

--# Renaming VIEW is also same as Physical Table. 
ALTER VIEW film_category_view RENAME TO view_film_category;

--# Dropping VIEW is also same as Physical Table.
DROP VIEW IF EXISTS view_film_category;


-------------------------------------------
------------  CREATE TABLE AS  ------------
-------------------------------------------

/*
- It is the Clause for assigning Query result into TABLE.
- IT will create either "Physical Table" or "Virtual Table" with TEMP.
- This clause is placed at the starting of the statement.
- Syntax :=
				CREATE [TEMP] TABLE new_table_name AS 
				QUERY;

Additional functionalities with CREATE TABLE AS. Note - These are not available in SELECT INTO Clause.
- We can use "CREATE TABLE "IF NOT EXISTS"" to check whether the Table has already been created before.
  It allows us to bypass the Error if executed again and log it as a message. 
				CREATE TABLE IF NOT EXISTS new_table_name AS QUERY;
- The name and the datatype of the newly created table will be the same as of the column(s) selected in the query.
  Eg. if normal selection then same, if aggregation manipulation then integer, or array.
  - To Overwrite the column name we can explicitly write the new_column_name_list by 
				CREATE TABLE new_table_name(new_column_name_list) AS QUERY;
*/

CREATE TEMP TABLE customer_address_virtual AS
SELECT first_name || ' ' || last_name full_name, address 
FROM customer JOIN address USING(address_id)
ORDER BY full_name; 

CREATE TABLE customer_address_physical AS
SELECT first_name || ' ' || last_name full_name, address 
FROM customer JOIN address USING(address_id)
ORDER BY full_name; 

SELECT * FROM customer_address_virtual;
SELECT * FROM customer_address_physical;
--# Modifying for this Tables are exactly as same as other Table in the Dataabase, 
--  because now, they are also the Physical Table.

DROP TABLE IF EXISTS customer_address_physical;
--# We will Delete the Physical table as we don't want to modify our DVDRENTAL DataBase. 

/*
- We can create Copy of Table using "CREATE TABLE AS", with variations-
  - TABLE STRUCURE with TABLE DATA.
  - TABLE STRUCTURE only meaning without TABLE DATA.
  - TABLE STRUCTRE with PARTIAL TABLE DATA.
*/

--# We can copy the Table Structure with its Data, as - 
CREATE TEMP TABLE staff_copy AS
TABLE staff

--# We can copy just the Table Structure also without its Data, as -
CREATE TEMP TABLE staff_structure_copy AS
TABLE staff
WITH NO DATA;

--# We can copy Table with partial Data, as (Basically applying Predicate with WHERE) - 
CREATE TEMP TABLE staff_partial_copy AS
SELECT * FROM staff WHERE staff_id = 1;

-------------------------------------------
--------------  SELECT INTO  --------------
-------------------------------------------

/*
- It is the Clause for assigning Query result into TABLE.
- IT will create either "Physical Table" or "Virtual Table" with TEMP.
- INTO clause is placed between SELECTED column(s) list and FROM table_name WHERE predicate ...;
- We can use all the basic SQL Querying tools such as Clauses, Operators Functions, Joins for the SELECT INTO.

- SELECT ... INTO [TEMP | TEMPORARY] ==> also allows us to create temporary table which we can access further directly in other queries.
- SELECT ... INTO ==> Without the Optional Keyword TEMP or TEMPORARY, Physical Table will create instead of Virtual.
- Syntax :=
				SELECT column(s) INTO [TEMP|TEMPORARY] temp_table_name FROM ...;
*/

SELECT name genre, title movie 
INTO TEMP film_category_virtual
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
ORDER BY genre;

SELECT name genre, title movie
INTO film_category_physical
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
ORDER BY genre;

SELECT * FROM film_category_virtual;
SELECT * FROM film_category_physical;
--# Modifying for this Tables are exactly as same as other Table in the Database,
--  because now, they are also the Physical Table.

DROP TABLE IF EXISTS film_category_physical;
--# We will Delete the Physical table as we don't want to modify our DVDRENTAL DataBase. 


-------------------------------------------
------------------  CTEs  -----------------
-------------------------------------------

/*
- 'CTEs or Common Table Expressions' are exactly like VIEWs, which create Virtual Table, but "Temporarily".
- Now the main difference between CTEs and VIEW are, that the CTEs are created temporarily for the main query,
  and at the starting position within the main query itself.
- That is to say, it disappears after the main query finishes execution.
- Syntax := 
				WITH cte_1_name(column_list) AS (QUERY),
				     cte_2_name(column_list) AS (QUERY),
					 ...
				MAIN_QUERY;                                  --# Main Query referencing CTE(s).

- It is optional to mention 'column_list' explicitly. We write this to overwrite the column_name
  from SELECT clause of cte_query
- Now the execution Step/Process is such that -
  1 - the CTE mentioned by WITH Clause are executed first and creates the virtual table(s).
  2 - Main query reference these Virtual Table(s) and Execute itself.
  3 - Virtual Table created by CTE disappears after the query execution.
  4 - Data Retrieved is displayed to the user.

- Note that through this steps, Logically cte_query cannot refer or be related to the Main query statement.
  Meaning it is Independent.
- This is also why and how it different from Nested Subquery.
*/


/*
-- Situation - Display each movie's genre and its Cast.
-- What I've Done is basically I've created two temorary CTE table with WITH  -
     One for retrieving 'Genre' from simple join of film with category. 
	 And second for retrieving 'CAST' from simple join of film with actor 
     (by aggregating all the actors in single cell as array); 
	 And, then I've joined these two tables in main query with film_id. 
*/

WITH 
cte_film_category(film_id, movie, genre) AS 
(SELECT film_id, title, name 
 FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)),
cte_film_actor(film_id, movie, actors) AS 
(SELECT film_id, title, ARRAY_AGG(first_name::varchar || ' ' || last_name::varchar)
 FROM film JOIN film_actor USING(film_id) JOIN actor USING(actor_id) GROUP BY film_id,title)
SELECT f_c.film_id, f_c.movie,f_c.genre,f_a.actors 
FROM cte_film_category f_c JOIN cte_film_actor f_a USING(film_id)
ORDER BY film_id;


-------------------------------------------
-------------  Recursive CTEs  ------------
-------------------------------------------

/*
- If we want to use the one's own query result within the query call, we can do so using recursive CTE.
- Recursive CTE use keyword "WITH CTE" which consist of two statements. 
  First, Initial Statement, which generates the Initial data or Table.
  Second, Recursive Statement, which calls its own query output table.
  Lastly, we append the records from each query execution to its self-output table.
- Thus, it allows us to work even further (again and again) on the result that it itself has already produced.

General Flow and logic of the WITH RECURSIVE
- It needs an initial statement to generate the first sets of records (on which we want to work further on)
- Second, it needs an recursive statement, which will call its own "previous run output" 
  and further executes on it. (Note, recursive statement has access to those records only which are output
  of the last iteration and not the whole table.)
- Recursive cte will end either 'by itself, if the recursive statement hits null
  or 'if we add any stoppage condition in the WHERE clause of the recursive statement'.
- Lastly, it needs an "UNION ALL" to append the records retrieved in the recursive queries in one single table.

-- It's basic structure and syntax is
		WITH RECURSIVE table_name(column(s)) AS(
			<initial statement>
			UNION ALL
			<recursive statement>
		) Main_Query;

- Keep note, that the column structure should be compatible in the initial statement and the recursive statement
*/

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

