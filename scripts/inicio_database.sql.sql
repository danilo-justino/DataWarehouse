/*
=============================================================
Create Database and Schemas
=============================================================

Objetivo do script:
 Esse script cria um novo banco de dados chamado 'DataWarehouse' depois de verificar se ele já existe. 
    Se o banco de dados existir, ele será descartado e recriado. Além disso, o script configura três esquemas 
 no banco de dados: “bronze”, ‘silver’ e “gold”.

 AVISO:
 A execução desse script eliminará todo o banco de dados 'DataWarehouse', se ele existir. 
    Todos os dados do banco de dados serão excluídos permanentemente. Proceda com cautela 
 e certifique-se de que você tenha backups adequados antes de executar esse script.

 */

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
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
GO