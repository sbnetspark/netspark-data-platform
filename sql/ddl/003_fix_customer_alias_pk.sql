/* ============================================================================
File: 003_fix_customer_alias_pk.sql
Purpose: Fix config.customer_alias_map by introducing surrogate PK and unique alias
============================================================================ */

-- Add surrogate key column if missing
IF COL_LENGTH('config.customer_alias_map', 'customer_alias_id') IS NULL
BEGIN
  ALTER TABLE config.customer_alias_map
    ADD customer_alias_id BIGINT IDENTITY(1,1) NOT NULL;
END
GO

-- Drop existing PK if it exists (name may vary; handle known default)
IF EXISTS (
  SELECT 1
  FROM sys.key_constraints kc
  JOIN sys.tables t ON t.object_id = kc.parent_object_id
  JOIN sys.schemas s ON s.schema_id = t.schema_id
  WHERE kc.type = 'PK'
    AND s.name = 'config'
    AND t.name = 'customer_alias_map'
)
BEGIN
  DECLARE @pkName SYSNAME;
  SELECT TOP 1 @pkName = kc.name
  FROM sys.key_constraints kc
  JOIN sys.tables t ON t.object_id = kc.parent_object_id
  JOIN sys.schemas s ON s.schema_id = t.schema_id
  WHERE kc.type = 'PK'
    AND s.name = 'config'
    AND t.name = 'customer_alias_map';

  EXEC('ALTER TABLE config.customer_alias_map DROP CONSTRAINT ' + QUOTENAME(@pkName) + ';');
END
GO

-- Create new clustered PK on surrogate key if missing
IF NOT EXISTS (
  SELECT 1
  FROM sys.key_constraints kc
  JOIN sys.tables t ON t.object_id = kc.parent_object_id
  JOIN sys.schemas s ON s.schema_id = t.schema_id
  WHERE kc.type = 'PK'
    AND kc.name = 'PK_customer_alias_map'
    AND s.name = 'config'
    AND t.name = 'customer_alias_map'
)
BEGIN
  ALTER TABLE config.customer_alias_map
    ADD CONSTRAINT PK_customer_alias_map
      PRIMARY KEY CLUSTERED (customer_alias_id);
END
GO

-- Create unique index on customer_alias if missing
IF NOT EXISTS (
  SELECT 1
  FROM sys.indexes i
  JOIN sys.tables t ON t.object_id = i.object_id
  JOIN sys.schemas s ON s.schema_id = t.schema_id
  WHERE s.name = 'config'
    AND t.name = 'customer_alias_map'
    AND i.name = 'UX_customer_alias_map_customer_alias'
)
BEGIN
  CREATE UNIQUE NONCLUSTERED INDEX UX_customer_alias_map_customer_alias
    ON config.customer_alias_map (customer_alias);
END
GO
