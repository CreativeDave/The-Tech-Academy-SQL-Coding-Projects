# The-Tech-Academy-SQL-Coding-Projects

!['image'](https://github.com/CreativeDave/The-Tech-Academy-SQL-Coding-Projects/blob/master/tta.PNG)


> A repository for my work at the Tech Academy 


We were assigned many SQL projects throughout my course of study at The Tech Academy. I only chose to post what I feel highlighted my achievements and demonstrated competency with MSSQL Server. In my career I have used SQL extensively to debug applications, but never to proactively create something fun. 

The [db_guitarplayers](https://github.com/CreativeDave/The-Tech-Academy-SQL-Coding-Projects/tree/master/db_Guitar_Players) creates a database in SQL Server, populates it with data, and prints out a simple message. I had envisioned eventually turning it into a web application that lets you search guitar players to see their equipment. 

Execution of this project is simple. It requires an instance of SQL Server 2016 to be running on your machine. When you run the code, the database is created and the tables populate. 

---

[db_Library_Admin](https://github.com/CreativeDave/The-Tech-Academy-SQL-Coding-Projects/tree/master/db_Library_Admin) is the final project for the SQL course. We were given a list of requirements and specific questions to answer, and we had to create a database and stored procedures to do it. 

For example, here is a sample question from the final, and my stored procedure response to it:
```
6) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than @loans number of books checked out.

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
CREATE PROC sp_BorrowerLoans
@loans INT
As
	SELECT br.Name, br.Address, COUNT(bl.CardNo) AS [Active Loans]
	FROM Book_Loans bl
	JOIN Borrower br ON br.CardNo = bl.CardNo
	WHERE bl.DateDue >= GETDATE()
	GROUP BY br.Name, br.Address, bl.Cardno
	HAVING
	COUNT(bl.Cardno) >= @loans
GO

EXECUTE sp_BorrowerLoans @loans = 5
GO
```

Finally, [Assorted_SP](https://github.com/CreativeDave/The-Tech-Academy-SQL-Coding-Projects/tree/master/Assorted_SP) is a collection of SQL I wrote while working through the Microsoft Virtual Academy tutorial. Its based on the AdventureWorks database, which I found to be a greate resource for learning SQL.
