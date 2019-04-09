USE master;
GO
--Delete the TestData database if it exists
IF EXISTS(SELECT * FROM sys.databases WHERE name='TestData')
BEGIN
	DROP DATABASE TestData;
END

--Create a new database called TestData
CREATE DATABASE TestData

USE TestData;
GO

CREATE TABLE dbo.Products
	(ProductID int PRIMARY KEY NOT NULL,
	ProductName varchar(25) NOT NULL,
	Price money NULL,
	ProductDescription text NULL)
GO

-- Standard Syntax
INSERT dbo.Products (ProductID, ProductName, Price, ProductDescription) VALUES (1, 'Clamp', 12.48, 'Workbench clamp')
GO

-- Changing the order of the columns
INSERT dbo.Products (ProductName, ProductID, Price, ProductDescription) VALUES ('Screwdriver', 50, 3.17, 'Flat head')
GO

-- Skipping the column list but keeping the values in order
INSERT dbo.Products VALUES (75, 'Tire Bar', NULL, 'Tool for changing tires')
GO

-- Dropping the optional dbo and dropping the ProductDescription column
INSERT Products (ProductID, ProductName, Price) VALUES (3000, '3mm Bracket', .52)
GO

UPDATE dbo.Products SET ProductName = 'Flat Head Screwdriver' WHERE ProductID = 50
GO

-- Create a view
CREATE VIEW vw_Names
	AS
	SELECT ProductName, Price FROM Products;
GO

-- Create a stored procedure that accepts an input parameter and
-- returns a list of products less than the specified price with
-- a statement printed at the beginning describing the result
CREATE PROCEDURE pr_Names @VarPrice money
	AS
	BEGIN
		-- The print statement returns text to the user
		PRINT 'Products less than ' + CAST(@VarPrice AS varchar(10));
		-- A second statement starts here
		SELECT ProductName, Price FROM vw_Names
			WHERE Price < @VarPrice;
	END
GO
