/* netspark-data-platform
   001_create_schemas.sql
   Purpose: Create standard schemas for medallion + config + ops
*/

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'raw')    EXEC('CREATE SCHEMA raw');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver') EXEC('CREATE SCHEMA silver');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')   EXEC('CREATE SCHEMA gold');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'config') EXEC('CREATE SCHEMA config');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'ops')    EXEC('CREATE SCHEMA ops');
GO
