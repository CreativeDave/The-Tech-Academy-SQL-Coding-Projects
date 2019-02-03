/*
A stored procedure that returns a readable statement for the total amount due accross 
all accounts during a user specified date range. 
*/

USE AdventureWorks2014
GO

CREATE PROCEDURE dbo.uspSumTotalDue 
@Datefirst DATETIME = ' ', 
@Datelast DATETIME = ' ',
@Sum VARCHAR(12) OUTPUT
AS
SELECT @Sum = CONVERT(VARCHAR(20), SUM(TotalDue), 1)
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN @Datefirst AND @Datelast

GO

/*Input any dates between variables FirstDate and LastDate*/

DECLARE @Sum VARCHAR(12)
DECLARE @FirstDate DATETIME
DECLARE @LastDate DATETIME
SET @FirstDate='1/1/2012'
SET @LastDate='1/31/2012'

EXEC dbo.uspSumTotalDue @FirstDate, @LastDate, @Sum OUT
PRINT 'The total amount due accross all accounts between ' + convert(varchar(12), @FirstDate) + 'and ' + convert(varchar(12), @LastDate) + 'is ' + '$' + @Sum + '.'

