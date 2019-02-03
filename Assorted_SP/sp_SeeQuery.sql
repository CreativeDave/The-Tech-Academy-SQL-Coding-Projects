/*
This creates a simple stored procedure that prints the underlying SQL for views and other stored
prodecures. I put this together to practice SQL because it presents a neater view than sp_HelpText
for this purpose.
*/


USE AdventureWorks2014;   
GO 

CREATE PROC SeeQuery 
@Object varchar(max) 
AS
SELECT @Object = ( 
SELECT OBJECT_DEFINITION (OBJECT_ID(@Object)))   
PRINT @Object 
GO

EXEC SeeQuery @Object = '[Sales].[vSalesPerson]'

--Could alternatively be written as:

/*
CREATE PROC SeeQuery 
@Object varchar(max) 
AS
SELECT @Object = ( 
SELECT DEFINITION
FROM sys.sql_modules  
WHERE OBJECT_ID = OBJECT_ID(@view))
PRINT @Object
*/

--Compare the same query with sp_HelpText

/*
EXEC sp_helptext '[Sales].[vSalesPerson]'
*/  