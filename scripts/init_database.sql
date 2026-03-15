/*
Create Database and Schemas

This script creates a new database named 'DataWarehouse' after checking if it already exists. 
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
within the database: 'bronze', 'silver', and 'gold'.

Warning: Running this script will drop the entire 'DataWarehouse' database if it exists. 
All data in the database will be permanently deleted. Ensure you have proper backup before running this script.

*/


USE master;
GO

  --Check if the database name already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

  -- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO

  -- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
