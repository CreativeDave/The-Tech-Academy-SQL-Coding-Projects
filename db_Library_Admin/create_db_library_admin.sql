USE [master]
GO

CREATE DATABASE Library_Admin
GO

USE Library_Admin

CREATE TABLE Library_Branch (
	BranchID INT IDENTITY (100,1) NOT NULL,
	BranchName VARCHAR(20) NOT NULL, 
	Address	VARCHAR(50) NOT NULL
	CONSTRAINT PK_Library_Branch_BranchID PRIMARY KEY CLUSTERED (BranchID)
);

INSERT INTO Library_Branch
	(BranchName, Address)
	VALUES
	('Sharpstown', '308 Poppy Street, Sharpstown, TX 77036'),
	('Central', '421 Sidney St, Houston, TX 77003'),
	('Pasadena', '9738 Jennifer Way, Pasadena, TX 77504'),
	('Northline', '6101 Airline Dr, Houston, TX 77076')

CREATE TABLE Publisher (
	PublisherName NVARCHAR(100) NOT NULL, 
	Address VARCHAR(100) NULL,
	Phone NVARCHAR(15)
	CONSTRAINT PK_Publisher_PublisherName PRIMARY KEY CLUSTERED (PublisherName)
);

INSERT INTO Publisher
	(PublisherName, Address, Phone)
	VALUES
	('Hachette Livre', '763 Chris Collinsworth Ct, Albury, MN 82930', '2223456789'),
	('Doubleday', '8756 Samual Jackson Dr, Sansbury, OR, 98374', '3338746578'),
	('Grant Richards', '424 Gandalf LN, Mooresville, OR, 98374', '33374685975'),
	('The Russian Messenger', '4 St. Petersburg St, St. Petersburg, Russia', '+43 23456543298'),
	('Sylvia Beach', '1 Gregory Place, Lanesville Dr, Orlando, FL, 873639', '4447876567'),
	('John Murray II', 'Worcester Place Suite A, York, England, 7878373', '+44 987875609'),
	('Grasset', 'Maybury Block B, Bath, England, 3874389', '+44 768723629'),
	('Editorial Sudamericana', '456 South Rucker Pl, Jamestown, VA, 48576', '6665554440'),
	('Charles Scribners Sons', 'Avenue A Fourth Shire Bend, Crainestown, Scotland, 7638493', '+55 665456598'),
	('Hogarth Press', '42 Hogarth Ministry, Stratford-Upon-Avon, Middelsex, England, 93847378', '+44 768765454'),
	('Revue de Paris', '9910 Paris Ln, Paris, France, 90909', '+99 8787656'),
	('Chapman & Hall', '88 Yeomans Bluff, Rainsville, NC, 373642', '9898772673'),
	('Chatto & Windus', '757 Golf Ln, Mission Hill, NC, 37364', '9897654323'),
	('G. P. Putnam''s Sons''', '989 North Wind St, Austin, TX, 78735', '5128987656'),
	('Jonathan Cape and Harrison Smith', '87 Cape Pl, Johannesburg, VA, 87245', '4445678997'),
	('Little, Brown and Company', '4 Market St, Seattle, WA, 98765', '7876546354'),
	('Penguin', '987 Ninety nine Pl, New York, NY, 89465', '331445645')
;

CREATE TABLE Books (
	BookID INT IDENTITY (1000,100) NOT NULL,
	Title VARCHAR(100) NOT NULL,
	PublisherName NVARCHAR(100)
	CONSTRAINT PK_Books_BookID PRIMARY KEY CLUSTERED (BookID),
	CONSTRAINT FK_Books_Publisher FOREIGN KEY (PublisherName)
		REFERENCES Publisher (PublisherName)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


INSERT INTO Books
	(Title, PublisherName)
	VALUES
	('The Lost Tribe', 'Hachette Livre'),
	('The Shining', 'Doubleday'),
	('Carrie', 'Doubleday'),
	('Dubliners', 'Grant Richards'),
	('Anna Karenina', 'The Russian Messenger'),
	('Ulysses', 'Sylvia Beach'),
	('Emma', 'John Murray II'),
	('In Search Of Lost Time', 'Grasset'),
	('One Hundred Years of Solitude', 'Editorial Sudamericana'),
	('The Great Gatsby', 'Charles Scribners Sons'),
	('To The Lighthouse', 'Hogarth Press'),
	('Great Expectations', 'Chapman & Hall'),
	('Madame Bovary', 'Revue de Paris'),
	('War and Peace', 'The Russian Messenger'),
	('The Adventures of Huckleberry Finn', 'Chatto & Windus'),
	('Pale Fire', 'G. P. Putnam''s Sons'''),
	('Crime And Punishment', 'The Russian Messenger'),
	('The Sound and the Fury', 'Jonathan Cape and Harrison Smith'),
	('Twilight', 'Little, Brown and Company'),
	('Stories of Anton Chekhov', 'Penguin')
;
	
CREATE TABLE Book_Authors (
	BookID INT NOT NULL,
	AuthorName VARCHAR(50) NOT NULL,
	CONSTRAINT FK_Book_Authors_BookID FOREIGN KEY (BookID)
		REFERENCES Books (BookID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO Book_Authors 
	(BookID, AuthorName)
	VALUES
	(1000, 'Ben E. King'),
	(1100, 'Stephen King'),
	(1200, 'Stephen King'),
	(1300, 'James Joyce'),
	(1400, 'Leo Tolstoy'),
	(1500, 'James Joyce'),
	(1600, 'Jane Austin'),
	(1700, 'Marcel Proust'),
	(1800, 'Gabriel Garcia Marquez'),
	(1900, 'F. Scott Fitzgerald'),
	(2000, 'Virginia Woolf'),
	(2100, 'Charles Dickens'),
	(2200, 'Gustave Flaubert'),
	(2300, 'Leo Tolstoy'),
	(2400, 'Mark Twain'),
	(2500, 'Vladimir Nabokov'),
	(2600, 'Fyodor Dostoevski'),
	(2700, 'William Faulkner'),
	(2800, 'Stephenie Meyer'),
	(2900, 'Anton Checkhov')
;

CREATE TABLE Book_Copies (
	BookID INT NOT NULL,
	BranchID INT NOT NULL,
	NumberOfCopies INT NOT NULL
	CONSTRAINT FK_Book_Copies_Book FOREIGN KEY (BookID)
		REFERENCES Books (BookID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Book_Copies_Branch FOREIGN KEY (BranchID)
		REFERENCES Library_Branch (BranchID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO Book_Copies
	(BookID, BranchID, NumberOfCopies)
	VALUES
	(1000, 100, 8),
	(1100, 100, 7),
	(1200, 100, 2),
	(1300, 100, 2),
	(1400, 100, 9),
	(1500, 100, 3),
	(1600, 100, 10),
	(1700, 100, 9),
	(1800, 100, 3),
	(1900, 100, 2),
	(2000, 100, 4),
	(2100, 100, 2),
	(2200, 100, 12),
	(2300, 100, 10),
	(2400, 100, 11),
	(2500, 100, 12),
	(2600, 100, 13),
	(2700, 100, 15),
	(2800, 100, 15),
	(2900, 100, 3),
	(1000, 101, 9),
	(1100, 101, 7),
	(1200, 101, 2),
	(1300, 101, 2),
	(1400, 101, 9),
	(1500, 101, 3),
	(1600, 101, 10),
	(1700, 101, 9),
	(1800, 101, 3),
	(1900, 101, 2),
	(2000, 101, 4),
	(2100, 101, 2),
	(2200, 101, 12),
	(2300, 101, 10),
	(2400, 101, 11),
	(2500, 101, 12),
	(2600, 101, 13),
	(2700, 101, 15),
	(2800, 101, 15),
	(2900, 101, 3),
	(1000, 102, 4),
	(1100, 102, 7),
	(1200, 102, 2),
	(1300, 102, 2),
	(1400, 102, 9),
	(1500, 102, 3),
	(1600, 102, 10),
	(1700, 102, 9),
	(1800, 102, 3),
	(1900, 102, 2),
	(2000, 102, 4),
	(2100, 102, 2),
	(2200, 102, 12),
	(2300, 102, 10),
	(2400, 102, 11),
	(2500, 102, 12),
	(2600, 102, 13),
	(2700, 102, 15),
	(2800, 102, 15),
	(2900, 102, 3),
	(1000, 103, 9),
	(1100, 103, 7),
	(1200, 103, 2),
	(1300, 103, 2),
	(1400, 103, 9),
	(1500, 103, 3),
	(1600, 103, 10),
	(1700, 103, 9),
	(1800, 103, 3),
	(1900, 103, 2),
	(2000, 103, 4),
	(2100, 103, 2),
	(2200, 103, 12),
	(2300, 103, 10),
	(2400, 103, 11),
	(2500, 103, 12),
	(2600, 103, 13),
	(2700, 103, 15),
	(2800, 103, 15),
	(2900, 103, 3)
;

CREATE TABLE Borrower (
	CardNo INT NOT NULL IDENTITY (55553, 1),
	Name VARCHAR (50) NOT NULL,
	Address VARCHAR (100) NOT NULL,
	Phone VARCHAR(15)
	CONSTRAINT PK_Borrower_CardNo PRIMARY KEY CLUSTERED (CardNo)
);

INSERT INTO Borrower
(Name, Address, Phone)
	VALUES
	('Jamual L Saxon', '765 Cloverdale st, Seattle, WA, 87898', '2227876765'),
	('Turk Farrough', '787 S Dale Ln, Dallas, TX, 78765', '8987876765'),
	('Fredrick N', 'Common Box B, Sauntersville, TX, 765432', '3334566544'),
	('David Blaine', '765 S Hampton Ct, Hunstville, AL, 787878', '7654321234'),
	('Smaerty Payntz', '627 Ramburn Rd, Ramburn TX, 876544', '4099878765'),
	('Christopher Jenkins', '363 S Florida Dr, Houston, TX, 78440', '4909878989'),
	('Brittany Shapirez', '001 Commonwealth, Sugar Land, TX, 78659', '4099877876'),
	('Marcus Golden', '9 Trapeze Ct, Houston, TX, 78765', '4098786542')
;

CREATE TABLE Book_Loans (
	BookID INT NOT NULL,
	BranchID INT NOT NULL,
	CardNo INT NOT NULL,
	DateOut DATE NOT NULL,
	DateDue DATE NOT NULL,
	CONSTRAINT FK_Book_Loans_Book FOREIGN KEY (BookID)
		REFERENCES Books (BookID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Book_Loans_Branch FOREIGN KEY (BranchID)
		REFERENCES Library_Branch (BranchID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Book_Loans_Card FOREIGN KEY (CardNo)
		REFERENCES Borrower (CardNo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO Book_Loans
(BookID, BranchID, CardNo, DateOut, DateDue)
	VALUES
	(1000, 100, 55553, '2/2/2019', '5/2/2019'),
	(1100, 100, 55553, '2/2/2019', '5/2/2019'),
	(2200, 100, 55553, '2/2/2019', '3/2/2019'),
	(2300, 100, 55553, '2/2/2019', '3/2/2019'),
	(1400, 100, 55553, '2/3/2019', '3/3/2019'),
	(1500, 101, 55554, '2/4/2019', '3/4/2019'),
	(1600, 102, 55554, '2/4/2019', '3/4/2019'),
	(2700, 103, 55554, '2/4/2019', '3/4/2019'),
	(1800, 102, 55554, '2/5/2019', '3/2/2019'),
	(2900, 103, 55554, '2/3/2019', '3/3/2019'),
	(1300, 102, 55555, '6/2/2018', '7/2/2018'),
	(1500, 101, 55555, '6/2/2018', '7/2/2018'),
	(1700, 100, 55555, '6/2/2018', '7/2/2018'),
	(1900, 100, 55555, '6/2/2018', '7/2/2018'),
	(2000, 102, 55555, '6/2/2018', '7/2/2018'),
	(2100, 103, 55555, '6/2/2018', '7/2/2018'),
	(2300, 101, 55555, '6/2/2018', '7/2/2018'),
	(2400, 102, 55555, '6/2/2018', '7/2/2018'),
	(2500, 100, 55555, '6/2/2018', '7/2/2018'),
	(2600, 103, 55555, '6/2/2017', '7/2/2017'),
	(2700, 103, 55555, '6/2/2017', '7/2/2017'),
	(2800, 100, 55555, '6/2/2017', '7/2/2017'),
	(2900, 100, 55555, '6/2/2017', '7/2/2017'),
	(1000, 100, 55555, '6/2/2017', '7/2/2017'),
	(1100, 100, 55555, '6/2/2017', '7/2/2017'),
	(1200, 102, 55555, '11/2/2017', '12/2/2017'),
	(2200, 101, 55555, '11/2/2018', '12/2/2019'),
	(2400, 100, 55556, '11/2/2018', '12/2/2019'),
	(1200, 100, 55556, '1/2/2019', '2/2/2019'),
	(1400, 103, 55556, '1/2/2019', '2/2/2019'),
	(1600, 102, 55556, '1/2/2019', '2/2/2019'),
	(1800, 102, 55556, '1/2/2019', '2/2/2019'),
	(1900, 102, 55556, '1/2/2019', '2/2/2019'),
	(2300, 100, 55556, '3/12/2018', '4/12/2018'),
	(2500, 103, 55556, '3/12/2018', '4/12/2018'),
	(2400, 103, 55556, '3/12/2018', '4/12/2018'),
	(1800, 103, 55556, '3/12/2018', '4/12/2018'),
	(2200, 103, 55556, '3/12/2018', '4/12/2018'),
	(2800, 103, 55556, '3/12/2018', '4/12/2018'),
	(1800, 103, 55556, '3/12/2018', '4/12/2018'),
	(1700, 100, 55556, '3/12/2018', '4/12/2018'),
	(2000, 101, 55556, '3/12/2018', '4/12/2018'),
	(2300, 101, 55560, '3/12/2018', '4/12/2018'),
	(1600, 102, 55557, '1/2/2018', '2/2/2019'),
	(1700, 102, 55557, '1/2/2017', '2/2/2019'),
	(1800, 100, 55558, '1/2/2019', '2/2/2019'),
	(1900, 100, 55558, '1/2/2019', '2/2/2019'),
	(2000, 100, 55558, '1/2/2019', '2/2/2019'),
	(1000, 100, 55558, '1/2/2019', '2/2/2019'),
	(2900, 101, 55559, '1/2/2019', '2/2/2019')
;

GO




