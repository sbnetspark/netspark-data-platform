/* ============================================================================
File: 004_create_raw_salesforce_core_tables.sql
Purpose: Create first RAW landing tables for Salesforce Opportunities + Line Items
============================================================================ */

IF OBJECT_ID('raw.salesforce_opportunity', 'U') IS NULL
BEGIN
  CREATE TABLE raw.salesforce_opportunity (
    raw_id            BIGINT IDENTITY(1,1) NOT NULL,
    ingestion_run_id  BIGINT NULL,
    source_system     NVARCHAR(50) NOT NULL CONSTRAINT DF_raw_sf_opp_source DEFAULT ('salesforce'),
    extracted_at_utc  DATETIME2(3) NOT NULL CONSTRAINT DF_raw_sf_opp_extracted DEFAULT (SYSUTCDATETIME()),

    opportunity_id    NVARCHAR(50) NULL,
    account_id        NVARCHAR(50) NULL,
    owner_id          NVARCHAR(50) NULL,

    opportunity_name  NVARCHAR(255) NULL,
    stage_name        NVARCHAR(100) NULL,
    close_date        DATE NULL,
    amount            DECIMAL(18,2) NULL,
    probability       DECIMAL(5,2) NULL,
    created_date_utc  DATETIME2(3) NULL,
    last_modified_utc DATETIME2(3) NULL,

    raw_payload_json  NVARCHAR(MAX) NULL,

    CONSTRAINT PK_raw_salesforce_opportunity PRIMARY KEY CLUSTERED (raw_id)
  );
END
GO

IF OBJECT_ID('raw.salesforce_opportunity_line_item', 'U') IS NULL
BEGIN
  CREATE TABLE raw.salesforce_opportunity_line_item (
    raw_id                   BIGINT IDENTITY(1,1) NOT NULL,
    ingestion_run_id         BIGINT NULL,
    source_system            NVARCHAR(50) NOT NULL CONSTRAINT DF_raw_sf_oli_source DEFAULT ('salesforce'),
    extracted_at_utc         DATETIME2(3) NOT NULL CONSTRAINT DF_raw_sf_oli_extracted DEFAULT (SYSUTCDATETIME()),

    opportunity_line_item_id NVARCHAR(50) NULL,
    opportunity_id           NVARCHAR(50) NULL,
    product2_id              NVARCHAR(50) NULL,
    pricebook_entry_id       NVARCHAR(50) NULL,

    product_name             NVARCHAR(255) NULL,
    quantity                 DECIMAL(18,4) NULL,
    unit_price               DECIMAL(18,4) NULL,
    total_price              DECIMAL(18,4) NULL,
    service_start_date       DATE NULL,
    service_end_date         DATE NULL,

    raw_payload_json         NVARCHAR(MAX) NULL,

    CONSTRAINT PK_raw_salesforce_opportunity_line_item PRIMARY KEY CLUSTERED (raw_id)
  );
END
GO
