USE [master]
GO

	CREATE DATABASE [db_Guitar_Players]
	GO
	USE db_Guitar_Players

	CREATE TABLE tbl_guitarist (
		guitarist_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		guitarist_name VARCHAR(50) NOT NULL,
		guitarist_genre VARCHAR(50) NOT NULL
	);

	INSERT INTO tbl_guitarist
		(guitarist_name, guitarist_genre)
		VALUES
		('stevie ray vaughn', 'blues'),
		('george harrison', 'pop'),
		('jimmy page', 'rock'),
		('bob marley', 'reggae'),
		('jimi hendrix', 'rock'),
		('john mclaughlin', 'jazz')
	;

	CREATE TABLE tbl_model_guitar(
		model_guitar_id INT PRIMARY KEY NOT NULL IDENTITY (100,1),
		model_name VARCHAR(50) NOT NULL,
		guitar_manufacturer VARCHAR(50) NOT NULL
	);

	INSERT INTO tbl_model_guitar
		(model_name, guitar_manufacturer)
		VALUES
		('telecaster', 'fender'),
		('stratocaster', 'fender'),
		('les paul', 'gibson'),
		('345_bigsby', 'gibson')
	;

	CREATE TABLE tbl_guitarist_model_guitar_mapping (
		guitarist_id INT NOT NULL CONSTRAINT fk_guitarist_id FOREIGN KEY REFERENCES tbl_guitarist(guitarist_id) ON UPDATE CASCADE ON DELETE CASCADE,
		model_guitar_id INT NOT NULL CONSTRAINT fk_guitar_model_id FOREIGN KEY REFERENCES tbl_model_guitar(model_guitar_id) ON UPDATE CASCADE ON DELETE CASCADE,
	);

	INSERT INTO tbl_guitarist_model_guitar_mapping
		(guitarist_id, model_guitar_id)
		VALUES
		(1, 101),
		(2, 101),
		(2, 102),
		(3, 101),
		(3, 102),
		(4, 102),
		(5, 101),
		(6, 102),
		(6, 103)
	;

USE [db_guitar_players]
GO

/*======================================================================
	Below creates a stored procedure that queries a guitar player and 
	displays certain information in a complete sentance
  ======================================================================*/

CREATE PROC getGuitarist_Info
@guitarist VARCHAR(50) = ' ',
@model VARCHAR(50) OUT,
@genre VARCHAR(50) OUT,
@manufacturer VARCHAR(50) OUT,
@result VARCHAR(150) OUT
AS
BEGIN

	SELECT @guitarist = (
		SELECT g.guitarist_name 
		FROM tbl_guitarist g 
		WHERE g.guitarist_name = @guitarist
	)
	SELECT @model = ( 
		SELECT string_agg(m.model_name, ' and ') 
		FROM tbl_model_guitar m
		JOIN tbl_guitarist_model_guitar_mapping gm on m.model_guitar_id = gm.model_guitar_id
		JOIN tbl_guitarist g on gm.guitarist_id = g.guitarist_id
		WHERE g.guitarist_name = @guitarist 
	)
	SELECT @genre = (
		SELECT guitarist_genre 
		FROM tbl_guitarist g
		WHERE guitarist_name = @guitarist  
	)
	SELECT @manufacturer = (
		SELECT string_agg(m.guitar_manufacturer, ' and ')
		FROM tbl_model_guitar m
		JOIN tbl_guitarist_model_guitar_mapping gm on m.model_guitar_id = gm.model_guitar_id
		JOIN tbl_guitarist g on gm.guitarist_id = g.guitarist_id
		WHERE g.guitarist_name = @guitarist
	)
	
	SELECT @result = (@guitarist + ' is a ' + @genre + ' musician who plays a ' + @model + ' guitar made by ' + @manufacturer + '.') 

END
GO

DECLARE @guitarist VARCHAR(50)
DECLARE @model VARCHAR(50)
DECLARE @genre VARCHAR(50)
DECLARE @manufacturer VARCHAR(50)
DECLARE @result VARCHAR(150)
SET @guitarist = 'George Harrison'

EXEC dbo.getGuitarist_Info  @guitarist, @model OUT,  @genre OUT, @manufacturer OUT, @result OUT
PRINT @result
