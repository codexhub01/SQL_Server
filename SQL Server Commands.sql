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