/*

Select :-

-> Used to retrieve data from tables or databases

*/

select * from Employees


/*

Order By :-

-> Used to sort the result of query based on one or more columns

-> By defauult sorting is done in ascending order ( ASC )

-> You can also use descending order ( DESC )

*/

select FirstName , Salary from Employees order by Salary desc

select FirstName , Salary from Employees order by Salary asc


/*

Select Top :-

-> Top is only used to return a specified number of percentage of rows from the result


Offset Fetch :-

-> Used to skip number of rows and then return a specified number of rows , this is commonly used for pagination

-> We used this when we need to retrieve data page by page instead everything at once

*/

select top(5) firstname , Salary from Employees order by Salary desc

select EmployeeId , FirstName from Employees order by EmployeeId desc offset 5 rows fetch next 10 rows only


/*

Distinct :-

-> Removes duplicate value from the query result

Where :-

-> It filters rows based on condition

And :-

-> It combines multiple condition and all conditions must be true

OR :-

-> It combines multiple conditions where at least one condition must be true

IN :-

-> It checks whether a value matches any value in specified list

Between :-

-> checks whether a value falls withn in a specified range & between is inclusive

Like :-

-> Its used to search for a value that matches a specific pattern

-> % :- any number of characters

-> _ :- exactly one character

Column & Table Aliases :-

-> An alias gives a temporary name to column or table within a query

*/

select distinct EmployeeId from Employees

select * from Employees where EmployeeId>100

select * from Employees where EmployeeId>100 and Salary>10000

select * from Employees where EmployeeId>8167 or Salary>5000

select * from Employees where DepartmentId in ( 100 , 104 , 186 , 1004 )

select * from Employees where Salary between 8000 and 50000 

select * from Employees where FirstName like 'A%'

select FirstName as PhelaNaam from Employees


/*

Joins :- 

-> It combines rows from different tables using a related column

-> These are main type of joins :-

1. Inner Join
2. Left Join
3. Right Join
4. Full Outer Join
5. Cross Join
6. Self Join

Inner Join :-

-> It returns only the rows where both tables have a matching value

Left Join :-

-> It returns all rows from left table & matching rows from right table

Right Join :-

-> It returns all rows from right table & matching rows from left table

Full Outer Join :-

-> It returns matching rows from both tables & unmatched rows from left table & unmatched rows from right table

Cross Join :-

-> It creates cartesian product

-> This means every row from first table combines with every row from second table

Self Join :-

-> It means a table join with itself

-> It's not a special join , we simply use normal join keyword and give the same table two different alias
*/

select * from employees as e
inner join departments as d
on e.DepartmentId = d.DepartmentId

select * from employees as e
left join departments as d
on e.DepartmentId = d.DepartmentId

select * from employees as e
right join departments as d
on e.DepartmentId = d.DepartmentId

select * from employees as e
full outer join departments as d
on e.DepartmentId = d.DepartmentId

select * from employees as e
cross join departments as d

select * from employees as e
join employees as e1
on e.DepartmentId = e1.DepartmentId


/*

-> Grouping means putting rows with same value into a groups and then usually performing an aggregate calculation on each group

Group By :-

-> It group rows that have the same value in one or more columns

-> It's commonly used with aggregate functions such as Count() , SUM() , AVG() , MIN() , MAX()

Having :-

-> It's used to filter groups created by group by

-> Where filters individual rows , while having filters groups or aggregate results

Grouping Sets :-

-> It allows us to perform multiple different group by operations in single query

-> When we want multiple levels of grouped summaries from the same data

* CUBE & ROLLUP

*/

select DepartmentId , COUNT(*) as employeecount from Employees group by DepartmentId

select DepartmentId , count(*) as employeecount from Employees group by DepartmentId having count(*) > 2

select DepartmentId , sum(salary) as TotalSalary from Employees group by GROUPING sets ( (DepartmentId) , (Gender))


/*

-> Subquery is simply a query written inside another query

-> One query use result of another query


Correlated Subquery :-

-> Its a subquery that depends on the current row of the outer query

-> When the condition inside the subquery needs information from the current row of the outer query

Exist :-

-> It checks wheteher a subquery returns at least one row

Any :-

-> It compares a value with the values returned by a subquery

All :-

-> It compares a value with all values returned by a subquery

* Cross Apply & Outer Apply

*/

select  * from Employees where Salary > ( select AVG(salary) from Employees )

select e.FirstName , e.Salary , e.DepartmentId from Employees as e
where e.Salary > ( select avg(e2.salary) from Employees as e2 where e2.DepartmentId = e.DepartmentId )

select c.CustomerName from Customers as c
where exists ( select 1 from orders as o where o.CustomerId = c.CustomerId )

select FirstName , Salary from Employees
where Salary > ANY ( select Salary from Employees where DepartmentId > 2 )

select FirstName , Salary from Employees WHERE Salary > all ( SELECT Salary from Employees where DepartmentId > 2 )


/*

Set Operators :-

-> Its used to combine the reults of multiple select queries

Union :-

-> It combines the results set of two or more select queries into a single result & remove duplicates

Intersect :-

-> It returns only the rows that are present in both result sets

Except :- It returns rows from the first query that are not present in a second query

*/

select * from Employees where DepartmentId = 1
union
select * from Employees where DepartmentId = 2

select * from Employees where DepartmentId = 1
intersect
select * from Employees where Salary > 6000

select * from Employees where DepartmentId = 1
except
select * from Employees where Salary > 70000


/*

CTE :-

-> Its a temprorary named result set that u can use withnin a single sql statement

-> The main purpose is to make complex queries easier to read & organize

-> Instead of putting a complicated query directly inside another query , we can intermediate result a name and then query it

*Recursive CTE

*/

WITH HighSalaryEmployees AS
(
    SELECT EmployeeId, FirstName, Salary
    FROM Employees
    WHERE Salary > 70000
)
SELECT *
FROM HighSalaryEmployees

/*

*Pivot :-

-> Used to convert rows into columns and summarize the data 



*/


/*

DML Operations :- Insert , Update & Delete

Insert :-

-> To add new rows into a table

-> We insert members or data which we get from select query too

Update :-

-> To modify existing data in a table

Update Join :-

-> To update one table using information from another table

Delete :-

-> Used to remove one or more rows from a table

Merge :-

-> Which can perform insert , update & delete operations based on whether matching records exist

Transaction :-

-> Its a group of database operations treated as unit of work

-> The main commands are Begin Transaction , Commit & Rollback

-> We use it when multiple operations must either all succed or all be undone

*/

INSERT INTO Employees
    (EmployeeId, FirstName, LastName, Email, Salary, DepartmentId, JoiningDate, IsActive)
VALUES
    (116, 'Ravi', 'Kumar', 'ravi.kumar@company.com', 65000, 1, '2026-10-05', 1);

    INSERT INTO Departments (DepartmentId, DepartmentName, Location)
VALUES
    (7, 'Support', 'Noida'),
    (8, 'Legal', 'Delhi');

    UPDATE Employees
SET Salary = 90000
WHERE EmployeeId = 101;

--MERGE Employees AS T
--USING EmployeeUpdates AS S
--    ON T.EmployeeId = S.EmployeeId

--WHEN MATCHED THEN
--    UPDATE SET T.Salary = S.Salary

--WHEN NOT MATCHED THEN
--    INSERT (EmployeeId, FirstName, Salary, DepartmentId, JoiningDate, IsActive)
--    VALUES (S.EmployeeId, S.FirstName, S.Salary, S.DepartmentId, S.JoiningDate, S.IsActive);

--BEGIN TRANSACTION;

--UPDATE Accounts
--SET Balance = Balance - 10000
--WHERE AccountId = 1;

--UPDATE Accounts
--SET Balance = Balance + 10000
--WHERE AccountId = 2;

--COMMIT;

/*

DML :- 

-> Works with data inside tables

DDL :-

-> Works with structure or objects

Create :-

-> Create a new db , table , procedure or anything 

Drop :- 

-> It permanently removes a database

Create Schema :-

-> Its a logical container used to organize objects such as tables , view and etc

Alter Schema :-

-> Moves an object from one schema to another

Identity Column :-

-> It automatically generates numeric values for a column when a new row is inserted

Computed Column :-

-> When a column whose value is calculated automatically from other columns

Truncate Table :-

-> Which only removes all rows from a table while keeping table structure

Rename Table :-

-> To rename table name

Temporary Table :-

-> Its use to storeemproray data a session or procedure

-> Theyare defined using #

Synonym :-

-> Its an alternative name(alias) for a database object

*/

Create database SAMPLE_DB

Drop database SAMPLE_DB

--CREATE SCHEMA Sales;

--ALTER SCHEMA NewSchema
--TRANSFER OldSchema.ObjectName;

CREATE TABLE SampleTable
(
    EmployeeId INT IDENTITY(1,1),
    FirstName VARCHAR(50)
);

CREATE TABLE Product_table
(
    Price DECIMAL(10,2),
    Quantity INT,
    TotalAmount AS (Price * Quantity)
);

exec sp_rename 'mytable1' , 'mytable2'

CREATE TABLE #HighSalaryEmployees
(
    EmployeeId INT,
    Salary DECIMAL(12,2)
);
CREATE SYNONYM Emp
FOR dbo.Employees;


/*

Constraints :- Rules which applied to a table columns to control what data can be stored

-> Main constraints are :- Primary Key , Foreign key , Not null , unique , check
    
Primary key :-

-> Its uniquely identifies each row in a table

-> A primary has :-

1. Must be unique 
2. Can not contain Null
3. A table can have only one primary key ( It  can contain multiple columns as a composite key )


Foreign key :-

-> Creates a relationship between two tables by referencing a key into another table

-> We use this to main refrential integrity - preventing invalid refrences between related tables

Not Null :-

-> It ensures that a column must have  a value

Unique :-

-> It ensuresthat a column does not contain dupplicate values

Check :-

-> It ensures that a ue satifies a specified condition before it can stored
*/

CREATE TABLE newtable
(
    EmployeeId INT PRIMARY KEY,
    FirstName VARCHAR(50)
);

CREATE TABLE newtable2
(
    EmployeeId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    DepartmentId INT,

    FOREIGN KEY (DepartmentId)
        REFERENCES newtable4(DepartmentId)
);

CREATE TABLE newtable3
(
    EmployeeId INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL
);

CREATE TABLE newtable4
(
    EmployeeId INT PRIMARY KEY,
    Email VARCHAR(150) UNIQUE
);

CREATE TABLE newtable5
(
    EmployeeId INT PRIMARY KEY,
    Salary DECIMAL(12,2)
        CHECK (Salary > 0)
);


/*

Expression :- It allows us to add logic & null handling directly inside sql queries

Case :-

-> It allows us to implemenet If-else logic inside a sql query

Coalesce :-

-> return the first non-null value from the values provided

NUllIf :-

-> returns null if two expressions are equal , otherwise it returnsthe rst expression


*/

SELECT FirstName, Salary,
       CASE
           WHEN Salary >= 80000 THEN 'High Salary'
           ELSE 'Normal Salary'
       END AS SalaryCategory
FROM Employees;

SELECT FirstName,
       COALESCE(ManagerId, 0) AS ManagerId
FROM Employees;

SELECT ProductName,
       NULLIF(StockQuantity, 0) AS StockQuantity
FROM Products;


/*

Views :- It save sql query that can be used like a virtual table

Creating View:-

-> It creates a view based on select query
-> A view generally does not store a seprate copy of the data , It stores the query definition
-> Saved select query that behaves like a virtual table


*/

CREATE VIEW EmployeeSalaryView
AS
SELECT EmployeeId, FirstName, Salary
FROM Employees;

SELECT * -- To get list of views
FROM sys.views;

EXEC sp_rename --To rename view name
    'EmployeeSalaryView',
    'EmployeeSalaryReport';

EXEC sp_helptext 'EmployeeSalaryView'; -- to get view information


/*

**Indexes :-

-> Its a datastructure that helps sql server finds rows fatsre instead of having to search the entire column

Clustered Index :-

-> Determines the physical order in which the rows of table are sorted

-> A table can have only one clustered index because the rows can only have one physical ordering

-> By default, SQL Server commonly creates a clustered index for a primary key unless another clustered index already exists



*/

CREATE CLUSTERED INDEX IX_Employees_EmployeeId
ON Employees(EmployeeId);

EXEC sp_rename --To rename index
    'Employees.IX_Employees_Email',
    'IX_Employees_EmailAddress',
    'INDEX';

ALTER INDEX IX_Employees_Email -- To disable index
ON Employees
DISABLE;

/*

Stored Procedure :-

-> Its a predefined group of sql statements stored in sql server that can be executed whenever needed

-> Parameters allows us to pass value into a stored procedure


Variables :-

-> Temprorarily stores a value while store procedure is executing


Output Parameters :-

-> It allow a stored procedure to return a value through a parameter to the calling code

Control of flow statements :-

-> Begin .... End

Cursor :-

-> It processes a query results row by row

-> Instead of processing the entire result set together , sql server moves through individual rows

Exception Handling :-

-> Try - Catch handles run time errors

Dynamic sql :-

-> Means building sql statemenet at runtime & then executing it
*/


CREATE PROCEDURE GetAllEmployees --creating a procedure
AS
BEGIN
    SELECT *
    FROM Employees;
END;

exec GetAllEmployees -- executing procedure

CREATE PROCEDURE GetEmployeeByDepartment --creating a procedure and passing values through arguments
    @DepartmentId INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentId = @DepartmentId;
END;

DECLARE @TotalEmployees INT; --variable which is going to store a value

SET @TotalEmployees = 15;

SELECT @TotalEmployees;


CREATE PROCEDURE GetEmployeeCount -- creating procedure which will return some soutput using output parameter
    @DepartmentId INT,
    @EmployeeCount INT OUTPUT
AS
BEGIN
    SELECT @EmployeeCount = COUNT(*)
    FROM Employees
    WHERE DepartmentId = @DepartmentId;
END;

DECLARE @Count INT; -- calling above procedure

EXEC GetEmployeeCount
    @DepartmentId = 2,
    @EmployeeCount = @Count OUTPUT;

SELECT @Count;

DECLARE EmployeeCursor CURSOR FOR -- using cursor
SELECT EmployeeId, FirstName
FROM Employees;

OPEN EmployeeCursor;

FETCH NEXT FROM EmployeeCursor;

-- Process rows

CLOSE EmployeeCursor;
DEALLOCATE EmployeeCursor;

BEGIN TRY -- Try - Catch

    SELECT 10 / 0;

END TRY
BEGIN CATCH

    SELECT ERROR_MESSAGE() AS ErrorMessage;

END CATCH;


/*

UserDefined Functions :-

-> A scalara function which accepts input parameter and returns a single value

Table Variables :-

-> Its a variable that temmporarily stores rows & columns

Table Valued Function :-

-> Its a user defined function that returns a table instead of single value

*/

CREATE FUNCTION GetAnnualSalary -- userdefined function
(
    @MonthlySalary DECIMAL(10,2)
)
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END;

DECLARE @HighSalaryEmployees TABLE -- Table variable 
(
    EmployeeId INT,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO @HighSalaryEmployees
SELECT EmployeeId, FirstName, Salary
FROM Employees
WHERE Salary > 70000;

SELECT *
FROM @HighSalaryEmployees;

CREATE FUNCTION GetEmployeesByDepartment -- Inline Table valued function 
(
    @DepartmentId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT EmployeeId, FirstName, Salary
    FROM Employees
    WHERE DepartmentId = @DepartmentId
);

CREATE FUNCTION FunctionName -- Multistatement table valued function
(
    @Parameter INT
)
RETURNS @Result TABLE
(
    EmployeeId INT,
    FirstName VARCHAR(50)
)
AS
BEGIN

    INSERT INTO @Result
    SELECT EmployeeId, FirstName
    FROM Employees
    WHERE DepartmentId = @Parameter;

    RETURN;
END;