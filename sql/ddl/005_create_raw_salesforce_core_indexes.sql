/* ============================================================================
File: 005_create_raw_salesforce_core_indexes.sql
Purpose: Minimal, safe indexes for RAW Salesforce tables
============================================================================ */

-- raw.salesforce_opportunity indexes
IF OBJECT_ID('raw.salesforce_opportunity', 'U') IS NOT NULL
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity')
      AND name = 'IX_raw_sf_opp_opportunity_id'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_opp_opportunity_id
      ON raw.salesforce_opportunity (opportunity_id);
  END

  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity')
      AND name = 'IX_raw_sf_opp_ingestion_run_id'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_opp_ingestion_run_id
      ON raw.salesforce_opportunity (ingestion_run_id);
  END

  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity')
      AND name = 'IX_raw_sf_opp_extracted_at_utc'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_opp_extracted_at_utc
      ON raw.salesforce_opportunity (extracted_at_utc);
  END
END
GO

-- raw.salesforce_opportunity_line_item indexes
IF OBJECT_ID('raw.salesforce_opportunity_line_item', 'U') IS NOT NULL
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity_line_item')
      AND name = 'IX_raw_sf_oli_oli_id'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_oli_oli_id
      ON raw.salesforce_opportunity_line_item (opportunity_line_item_id);
  END

  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity_line_item')
      AND name = 'IX_raw_sf_oli_opportunity_id'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_oli_opportunity_id
      ON raw.salesforce_opportunity_line_item (opportunity_id);
  END

  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity_line_item')
      AND name = 'IX_raw_sf_oli_ingestion_run_id'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_oli_ingestion_run_id
      ON raw.salesforce_opportunity_line_item (ingestion_run_id);
  END

  IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('raw.salesforce_opportunity_line_item')
      AND name = 'IX_raw_sf_oli_extracted_at_utc'
  )
  BEGIN
    CREATE NONCLUSTERED INDEX IX_raw_sf_oli_extracted_at_utc
      ON raw.salesforce_opportunity_line_item (extracted_at_utc);
  END
END
GO
