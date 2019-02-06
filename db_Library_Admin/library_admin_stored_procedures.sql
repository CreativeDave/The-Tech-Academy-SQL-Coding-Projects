/*======================================================================
The following SQL creates and executes 7 basic stored procedures that 
gather certain data. For best results, execute each one individually by 
finding the commented 'EXECUTE STORED PROCEDURE' flag and highlighting 
the entire code below it. Stop at the next commented numbered question.
========================================================================*/




--1) How many copies of the book titled "@BookName" are owned by the library branch "@BranchName"?

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
USE [Library_Admin]
GO

CREATE PROC sp_FindCopyByBranch 
@BookName VARCHAR(50),
@BranchName VARCHAR(20)
AS
	SELECT NumberOfCopies AS [Copies], Title, BranchName AS [Library Branch]
	FROM Books b
	JOIN Book_Copies bc on bc.BookID = b.BookID
	JOIN Library_Branch l on l.BranchID = bc.BranchID
	WHERE b.title = @BookName
	AND l.BranchName = @BranchName
GO

EXEC sp_FindCopyByBranch @BookName = 'The lost tribe', @BranchName = 'sharpstown'
GO


--2) How many copies of the book titled "@BookName" are owned by each library branch?

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
CREATE PROC sp_FindAllCopies
@BookName VARCHAR(50)
AS
	SELECT NumberOfCopies AS [Copies], Title, BranchName AS [Library Branch]
	FROM Books b
	JOIN Book_Copies bc on bc.BookID = b.BookID
	JOIN Library_Branch l on l.BranchID = bc.BranchID
	WHERE b.Title = @BookName
GO

EXEC sp_FindAllCopies @BookName = 'The Lost Tribe'
GO


--3) Retrieve the names of all borrowers who do not have any books checked out (assuming all prior books returned at due date).

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
CREATE PROC sp_NoLoans  
AS
	SELECT DISTINCT bl.CardNo, b.Name AS [Borrower]
	FROM book_loans bl
	JOIN borrower b ON b.cardno = bl.cardno
	WHERE bl.CardNo NOT IN (
	SELECT cardno FROM book_loans WHERE GETDATE() <= datedue )
	GROUP BY bl.cardno, b.NAME
GO

EXEC sp_NoLoans
GO


--4) For each book that is loaned out from the @Branch location and whose due date is today, retrieve the book title, the borrower's name, and the borrower's address.

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
CREATE PROC sp_DueToday
@Branch VARCHAR(20)
AS
	SELECT lb.BranchName AS [Library Branch], b.Title, br.Name, br.Address, bl.DateDue AS [Date Due]
	FROM Book_Loans bl
	JOIN Borrower br ON br.CardNo = bl.CardNo
	JOIN Books b ON b.BookID = bl.BookID
	JOIN Library_Branch lb ON lb.BranchID = bl.BranchID
	WHERE DateDue = GETDATE()
	AND lb.BranchName = @Branch
GO

EXEC sp_DueToday @Branch = 'Sharpstown'
GO


--5) For each library branch, retrieve the branch name and the current number of books loaned out from that branch.

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
CREATE PROC sp_LoansByBranch
AS
	Select l.BranchName AS [Library Brach], Count(CardNo) AS [Current Loans]
	From Book_Loans b
	JOIN Library_Branch l on l.BranchID = b.BranchID 
	where DateDue >= GetDate()
	Group by b.BranchID, l.BranchName
GO

EXEC sp_LoansByBranch
GO

--6) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than @loans number of books checked out.

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

--7) For each book authored (or co-authored) by "@Author", retrieve the title and the number of copies owned by the library branch whose name is "@Branch".

/*=======================
EXECUTE STORED PROCEDURE 
=========================*/
CREATE PROC sp_CopiesByAuthor
@Author VARCHAR(50),
@Branch VARCHAR(20)
AS
	SELECT lb.BranchName AS [Library Branch], b.Title AS [Book Title], ba.AuthorName AS [Author], bc.NumberOfCopies AS [Total Copies]
	FROM Books b
	JOIN Book_Authors ba ON ba.BookID = b.BookID
	JOIN Book_Copies bc ON bc.BookID = b.BookID
	JOIN Library_Branch lb ON lb.BranchId = bc.BranchID
	WHERE ba.AuthorName LIKE '%' + @Author + '%'
	AND lb.BranchName = @Branch
GO

EXECUTE sp_CopiesByAuthor @Author = 'tephen Ki', @Branch = 'Central'
GO