-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

-----------------------------------------------
/* ----------------   INDEX ---------------- */
-----------------------------------------------

/* 

==> SQL CREATION and MODIFYING TABLE

  /* --- 6. CREATION and MODIFYING TABLE --- */
  THEORETICAL CONCEPTS
  - DATA TYPE
  - PRIMARY and FOREIGN KEY
  - CONSTRAINTS
  STATEMENTS
  - CREATE
  - INSERT
  - UPDATE
  - DELETE
  - DROP/TRUNCATE 
  - ALTER
  
  IMPORT/EXPORT
  
*/


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


----------------------------------------------------------------------------------------------------------
/* ---------------------------------------  THEORETICAL CONCEPTS  ------------------------------------- */
----------------------------------------------------------------------------------------------------------


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
---------------  DATA TYPE  ---------------
-------------------------------------------


/*
- SQL supports following DataTypes -
  Common Ones
  - Boolean - True or false
  - Character - char, varchar or text
  - Numeric - integer and floating-point number
  - Temporal - Data, Time, Timestamp, Interval

  Non Common Ones - 
  - UUID - Universally Unique Identifiers - Algorithmically Unique Code to identify particular Row.
  - Arrays - Stores an Array of Strings, Numbers, etc.
  - JSON
  - HStore Key-Value Pair
  - Special Types - Network Address AND Geometric Data.

- Best practice to decide which datatype to used is "Always take a look online or at Documentation".
  Select the most convenient Primary data types and in those take a look at Doc as there are many secondary datatypes. 
- Refer to Documentation to see limitations of Data Types := postgresql.org/docs/current/datatype.html
- Eg. - For Phone number - Either Integer OR Char, and if integer then what type of integer, and if Char then what type of Char.  
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
------  PRIMARY KEY & FOREIGN KEY  --------
-------------------------------------------

/*
- Primary Keys are the fundamental concept for the table.
- Primary keys are the column which store the unique identifier or ID for the Rows of the particular Table.
  One can say it's the address for the particular Record or particular Row or particular Data Instance. 
- Every Table in the particular Database will necessarily have its own unique Primary key. 
- These Primary key are also useful for forming Relation or Schema between tables in the Particular Database. 
- Primary key must be integer and NOT NULL for the table. It is mentioned as [PK] in the PostgreSql pgadmin's constraint.
*/

/*
- Foreign keys are the fields which are the unique identifier column in a table for the another table.
  That is they uniquely identifies a row in the another table. 
- A Foreign Key is defined in a table as the reference to the primary key of the other table. 
  i.e, they refer to the primary key of other table.
  In a Nutshell, they are Primary keys of some other table.
- The table that contains the foreign key are called "Child Table" or "Referencing Table".
  The table they (foreign key) refers to are called "Parent Table" or "Referenced Table".

- A table can have multiple foreign keys depending on its relationships with other tables.   
- pgAdmin doesn't alert of a FK in a query call that is there is no special marker for foreign key in the Table like PK.
- We can specify Primary key OR attaching a Foreign Key relation to other table USING "CONSTRAINTS".
*/

/*
How to officially know which are Primary Key and Foreign Key. 
We can look this properties up in the SIDE PANEL. 
database --> Schema --> Tables --> particular_table --> constraint ==> keys
  - Golden key as PK AND Dual key as FK.
  - Another way is to select these keys in the constraints AND then open up 'Dependencies Tab' in the main Panel. 
	referenced_table_pkey AND referencing_table.column_name AND refernced_table.column_name.
  - Right Click on these keys and Select Properties, go to Column tab in the properties window. 
	There it will be mentioned, to which table it is referenced.
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
---------------  CONSTRAINT  --------------
-------------------------------------------

/*
- Constraint enforced the rules on table "Columns" or whole "Table" in general.
  Constraint on Columns are called "Column Constraints". Constraints on entire table are called "Table Constraints".
- They are used to prevent inconsistent or invalid data to be entered in the databases table.
  And use to make sure that the tables are consistent.
- Thus it ensures the reliability, accuracy and consistency of the data in database. 
*/

/*
Most Common "COLUMN CONSTRAINTS" Used:
- NOT NULL - Ensures that column cannot have a NULL value. 
- UNIQUE - Ensures that every value in the column are DISTINCT.
- PRIMARY KEY - uniquely identifies the row/record in the table.
- FOREIGN KEY - uniquely identifies the row/record in another table.
- CHECK - ensures that every values in the column must satisfy certain custom conditions (which are added additionally with CHECK).
- REFERENCES - to constraint the value in the column which must exist in a column of another table.
- EXCLUSION - ensure that if any two rows are compared on specified column or expression using the specified operator,
              not all of these comparisons will return TRUE.

Most Common "TABLE CONSTRAINTS” Used:
- CHECK(condition) - To check condition when inserting or updating data in a table.
- UNIQUE(column_list) - Values inside the listed column HAVE TO be unique within all the listed columns. 
- PRIMARY KEY(column_list) - Allows us to define the PRIMARY KEY consisting of a MULTIPLE COLUMNS.
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------






-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------


-----------------------------------*-----------------------------------------*----------------------------
/* --------------------------------*----  6. CREATION & MODIFYING TABLE  ----*------------------------- */
-----------------------------------*-----------------------------------------*----------------------------

/*
IMPORTANT COMMENT (Not a Note but Points to Bear in Mind for the following Sections)
- As we cannot Create, Insert, Update, Drop, i.e, Modify Table again and again. So all these piece of codes are
  one time executable. Thus, if we want to execute any piece of code, run it by selecting that specific part of a code.
  OR use "IF NOT EXISTS" Keyword after CREATE, INSERT, DROP, DELET, it it supports.   
*/

-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------






----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  CREATE  ----------------
-------------------------------------------

/*
- CREATE statement allows us to create TABLE.
- It creates the Table with "Table Structure" and not with the actual data. 
FULL GENERAL SYNTAX :-
				CREATE TABLE table_name (
				column_name_1 DATATYPE column_constraints, --# Generaly First Column is PRIMARY KEY column of Table.
				column_name_2 DATATYPE column_constraints,
				column_name_3 DATATYPE column_constraints,
				...
				table_constraints
				) INHERITS existing_table_name;
*/

/*
"SERIAL" = It is a special data type for Primary Key. 
- In postgreSQL, sequence is a special type of Object that generates sequence of Integers. And it is used as a Primary Key column in the table.
- SERIAL will create a sequence object and set the next value generated by the sequence as the DEFAULT VALUE in that column for that row.
- It is perfect for Primary Key, because it logs unique integer for us automatically upon insertion of new record.
  i.e, When we adds a new data/record or row in a table, we don't have to worry about providing unique integer for its identification.
  SERIAL object will do this automatically for us.
- If a row is later removed, Column with SERIAL object (which is nothing but Primary Key Column) will NOT adjust or update after deletion.
  Marking the fact that row with missing integer in a Sequence was deleted at some point of time.
  Eg. Column with SERIAL DT or sequence object = 1,2,4,5,6... . This notify us that Record with ID=3 was removed. 
*/

CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) NOT NULL UNIQUE,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) NOT NULL UNIQUE,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);


CREATE TABLE JOB (
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(250) NOT NULL UNIQUE
);


CREATE TABLE account_job(
	account_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hired_date TIMESTAMP
);

/* --- Multiple Comment for Above ---
- We want to create INTERMEDIARY TABLE for JOB and ACCOUNT to connect accounts to their specific job.
- This give us insight on how FOREIGN KEY are created and how it references to PRIMARY key from another table. 
- Note here that Datatype is INTEGER and Not SERIAL as it is not the Primary Key for this table, 
  and same person can hired for different job, so it need not be a sequence or unique.
- General Syntax := Foreign_Key_column INTEGER REFERENCES table_name(tables_PK_column_name)
*/


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  INSERT  ----------------
-------------------------------------------

/*
- CREATE statement only generates the table structure and we cannot add data with CREATE statement.
  For that we need to use another statement called INSERT.
- INSERT allows us to add data/record/rows into the TABLE.
- VALUES is used to construct a row of data. General Syntax :=
				INSERT INTO table_name (column_1,column_2,...)
  				VALUES
  					(value1, value2, ...),
					(value1, value2, ...),
					...;
- If we are providing data for every column, then specifying column name in the INSERT statement is Optional.
- Also, we must pass the values in row construct AS per the order of column mention in the INSERT phrase. 
  Though, we can mention column in any order in the INSERT phrase.
- 2 point to bear in mind.-
  - Inserted rows values must match up to the column for the table. and it should follow constraints.
  - In short, Rows added must be compatible with the table structure. 
  - SERIAL column do not need to be provided values.

- INSERT ... SELECT allows us to add data/record/rows into a table FROM another Table. General Syntax:=
  				INSERT INTO table_name (column_1,column_2,...)
  				SELECT column_1,column_2,... 
  				FROM another_table WHERE condition_if_any;

*/


INSERT INTO account(username,password,email,created_on)
VALUES
('Ashish','password','shisha@gmail.com',CURRENT_TIMESTAMP);
--# Verify => 						SELECT * FROM account
-- See that, we did not mention and added SERIAL column and unique identifier. 


INSERT INTO job(job_name)
VALUES
('Data Scientist'),
('Instructor/Teacher');
--# Verify =>						SELECT * FROM job


INSERT INTO account_job(account_id,job_id,hired_date)
VALUES
(1,2,CURRENT_DATE),
(2,1,'2024-01-01');
--#	Verify =>						SELECT * FROM account_job
--# If we try to insert record with foreign key value which does not exists in the Referenced Table,
--  it will results in Foreign Key Constraint Violation ERROR. 


---------------------------------------  CHECK CONSTRAINT  ---------------------------------------
--------------------------------
------  CHECK Constraint  ------
--------------------------------

/*
- CHECK Constraint allows us to create more CUSTOMIZED CONSTRAINTS that column values must adhere to.
- Eg. - Custom condition specifying 'Integer value range' or 'must be positive', etc.
      - Category value (numeric or text) must be from within the specified list.
- Syntax := CHECK constraint appears as "CHECK (conditions)" at the constraint place after the datatype in Column phrase.
  Eg. - age SMALLINT NOT NULL CHECK (age > 21),
      - parent_age SMALLINT CHECK (parent_age > age),
      - gender CHAR(1) NOT NULL CHECK (gender IN ('M','F','T'));
*/


CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL CHECK (gender IN ('M','F','T')),
	DOB DATE CHECK (DOB > '1900-01-01'),
	hired_date DATE CHECK (hired_date > DOB),
	salary INTEGER CHECK (salary > 0)
);

INSERT INTO employees(first_name, last_name, gender, DOB, hired_date, salary)
VALUES
	--#	('Jose','Portilla', 'M','1857-11-03','2010-01-01',100),   --# Will give error "employees_dob_check"
		('Jose','Portilla', 'M','1996-11-03','2010-01-01',100),
	--#	('Sammy','Smith', 'M','1996-11-03','2010-01-01',-120),  --# Will give error "employees_salary_check"
		('Sammy','Smith', 'M','1996-11-03','2010-01-01', 120),
	--#	('Karen','Pandey', 'O','1996-11-03','2010-01-01',50),  --# Will give error "employees_gender_check"
		('Sammy','Pandey', 'F','1996-11-03','2010-01-01', 50);
	
---------------------------------------  CHECK CONSTRAINT  ---------------------------------------


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  UPDATE  ----------------
-------------------------------------------


/*
- UPDATE allow for changing values or modifying values in the table columns. General Syntax :=
				UPDATE table_name
  				SET 
  					column_1 = value_1,
					column_2 = value_2,
					...                    --# Whatever column or attributes we have to change.
				WHERE 
  					condition;             --# And for Whatever Rows or Records we have to change.
	
- If we want to reset every record, remove the WHERE Clause in UPDATE statement.
*/

UPDATE account
SET 
	last_login = CURRENT_TIMESTAMP
WHERE last_login is NULL;



/*
Note 
- We can UPDATE 'multiple rows' of a column based on 'another list or column' as stated below. But for this, bear 2 points in mind 
  - list size should match on both side of "=" of SET. That means, it should be compatible.
  - values that we are updating in a column must follow all the constraints of a column.
  
- Update values (for all rows) based on another column value. Example :=
				UPDATE account
  				SET last_login = created_on;
			
- Update values (for conditional rows) based on another table's column value. This is also known as "UPDATE Join" though Join is not used in syntax. Syntax :=
  				UPDATE table_A
  				SET table_A.col = table_B.some_col
  				FROM table_B
  				WHERE table_A.id = Table_b.id;

-- FROM clause in UPDATE statement allows us to generate and retrieve values for use in the SET clause. 

- We can also return the selected columns of 'Affected or Updated Rows' in UPDATE statement using RETURNING keyword. 
  This is very useful as we don't have to run another SELECT statement to verify. Syntax :=
  				UPDATE account
  				SET last_login = created_on
  				RETURNING account_id,username,last_login;
*/

UPDATE account
SET last_login = created_on;
			
UPDATE account
SET created_on = account_job.hired_date
FROM account_job
WHERE account.user_id = account_job.account_id;

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING username, created_on, last_login;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------

/* --- Just to take a look at the result of above created DB using "CREATE, INSERT, UPDATE" --- */
SELECT username,job_name,hired_date 
FROM job AS J JOIN account_job AS A_J ON J.job_id = A_J.job_id 
JOIN account AS A ON A.user_id = A_J.account_id;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  DELETE  ----------------
-------------------------------------------

/*
- DELETE clause allows us to remove ROW or Records from the Table. Syntax := DELETE FROM table_name ...;
				
- We can Delete all ROWS/RECORDS by not specifying WHERE condition. Syntax :=
				DELETE FROM table_name;

- We can Delete specific ROWS/RECORDS by specifiying filtering condition with WHERE. Syntax :=
				DELETE FROM table_name
				WHERE condition(s);

- We can DELETE ROWS/RECORDS based on their existence in another table. This is same as INSERT Join or UPDATE join without the join keyword. Syntax := 
				DELETE FROM table_A
				USING table_B
				WHERE table_A.id = table_B.id;
				
				
				
- Similar to UPDATE command, we can use RETURNING keyword for Returning ROWS that were removed.
				DELETE FROM table_name
				WHERE conditions
				RETURNING;
*/

DELETE FROM job
WHERE job_name = 'Being Karen'
RETURNING *;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-------------  DROP/TRUNCATE  -------------
-------------------------------------------


/*
- DROP allows for complete removal of an Object in a Database. DROP OBJECT object_name;
- By Objects, we meant - Column, Table, Views
- We can drop TABLE,VIEW as well as COLUMN with DROP Statement.
- In PostgreSQL, it  removes column and its index, constraints. 
  But it doesn't remove dependencies based on this column. Like views, triggers, or stored procedures.
  To remove this dependencies we need the additional CASCADE clause.
- Syntax :=
				DROP TABLE table_name
				DROP VIEW view_name
				
				ALTER TABLE table_name
				DROP COLUMN column_name              --# Just to remove column and its content.
				--or--
				DROP COLUMN column_name CASCADE      --# To remove column and its content with its dependencies.
				--or--
				DROP COLUMN IF EXISTS col_name       --# Check for Existence to avoid error.
				--or--
				DROP COLUMN col_1                    --# To remove Multiple Columns.
				DROP COLUMN col_2

- TRUNCATE
  TRUNCATE is like DROP that Deletes all the DATA inside the Table, but the difference here is that it does it does not Delete the Whole Table
  That is to say, it preserves the Table and Table structure for further use. But Yes all the data inside it will get eliminated.
				TRUNCATE TABLE table_name;
*/

ALTER TABLE new_info
DROP COLUMN IF EXISTS people;


----------------------------------------------------------------------------------------------------------
-----------------------------------*--------------------*--------------------*----------------------------
----------------------------------------------------------------------------------------------------------


-------------------------------------------
-----------------  ALTER  -----------------
-------------------------------------------

/*
- ALTER Clause allows us to modify or bring change to an existing "TABLE STRUCTURE", such as - 
  - Rename Table.
  - Adding Column, Dropping Column, or Renaming Column.
  - Changing a Column's DATA TYPE.
  - SET or DROP column CONSTRAINTS (NOT NULL, UNIQUE, DEFAULT, KEYS)
  - Add or Modify CHECK constraints.
  
- General Syntax :=
				ALTER TABLE table_name 
				RENAME TO new_table_name;                           --# RENNAME Table
				
				
				ALTER TABLE table_name 
				ALTER COLUMN column_name
				"Action";
				
				---- "Action" comprises of ----
				ADD COLUMN column_name DATATYPE;           --# ADD Column 
				DROP COLUMN column_name;                            --# DROP Column
			    RENAME COLUMN col_name TO new_col_name;         --# RENAME Column
				SET constraint;                                     --# SET column Constraint
				DROP Constraint;                                    --# DROP Column Constraint
				ADD Constraint;                                     --# ADD Column Constraint
   			 	TYPE datatype;                                      --# Changing Column's DATATYPE
*/

/* --- Let's create a Demo Table for ALTERing. --- */
CREATE TABLE info(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
);
--# View the Demo Table.  			
SELECT * FROM info;    SELECT * FROM new_info;

/* --- RENAMING Table_name --- */
ALTER TABLE info
RENAME TO new_info;

/* --- RENAMING column_name --- */
ALTER TABLE new_info
RENAME COLUMN person to people;

/* --- ADD column --- */
ALTER TABLE new_info
ADD COLUMN age INTEGER;

/* --- DROP column --- */
ALTER TABLE new_info
DROP COLUMN age;

/* --- Modify DATATYPE of Column --- */
ALTER TABLE new_info
ALTER COLUMN age TYPE VARCHAR(2);

/* --- SET | DROP "NOT NULL" Constraint on Column --- */
ALTER TABLE info
ALTER COLUMN person 
DROP NOT NULL   --# Similarly, SET NOT NULL

/* --- ADD UNIQUE Constraint on Column --- */
ALTER TABLE info
ADD UNIQUE(title)

/* --- SET | DROP DEFAULT Value of Column --- */
ALTER TABLE new_info
ALTER COLUMN age 
SET DEFAULT 18  --# DROP Default 


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









-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------

-------------------------------------------
-------------  IMPORT/EXPORT  -------------
-------------------------------------------


/*
- IMPORT allows us to import DATA into the already EXISTING TABLE inside the PostgreSQL Database. 
- This is important to note as this tells us that IMPORT does not create the TABLE inside the DB.
- There are few alternate methods formulated by users to do this, but they are not the standard PostgreSQL command.
- IMPORTED DATA Must be compatible to the the table and column constraint in which we are importing to.
- We have to provide the complete path of the Data file to import it. 
*/

--# Creating a Simple Table to import Data to.
CREATE TABLE simple(
	a INTEGER,
	b INTEGER,
	c INTEGER
)            
SELECT * FROM simple;

/* 
Now hover over to created Table in the SIDE PANEL --> Right Click on it --> Click Import/Export. --> Import the CSV/Text File.  
We can choose which column to import. Can set some Column as NULL, if it contains empty value (otherwise it will be imported as blank text). 
Select the Header if the file consists of the column name already.
*/

SELECT * FROM simple;


-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
-----------------------------------*--------------------*--------------------*----------------------------
