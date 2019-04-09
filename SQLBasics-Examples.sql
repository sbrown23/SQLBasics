SELECT ProductName, Price, .07 AS Tax, Price * 1.07 AS CustomerPays
	FROM dbo.Products
GO

-- Create a new login for a Windows account on the database
-- server. Despite the default db being set, this doesn't 
-- provide access to the database.
CREATE LOGIN [sql1\sqluser] 
	FROM WINDOWS 
	WITH DEFAULT_DATABASE = [TestData]
GO

-- After the login has been created, create a database user
-- to provide access to the database
USE [TestData];
GO

CREATE USER [sqluser] FOR LOGIN [sql1\sqluser];
GO

-- Provide access to db user to stored proc
-- Does not provide access to SELECT, etc. on tables
GRANT EXECUTE ON pr_Names TO sqluser;
GO

-- Execute the stored proc with money parameter
EXECUTE pr_Names 10.00

-- Provide access to db user to execute select statements 
-- against a view
GRANT SELECT ON vw_Names TO sqluser;
GO

-- Revoke access to db user to execute select statements
-- against a view
REVOKE SELECT ON vw_Names FROM sqluser;
GO

-- Drop all the object previously created, first make sure
-- in the correct database
USE TestData;
GO

DROP USER sqluser;
GO

DROP LOGIN [sql1\sqluser];
GO

DROP PROC pr_Names;
GO

DROP VIEW vw_Names;
GO

DELETE FROM Products;
GO

DROP TABLE Products;
GO

-- Cannot remove database while in the database, so switch
-- context to another db then drop
USE MASTER;
GO
DROP DATABASE TestData;
GO