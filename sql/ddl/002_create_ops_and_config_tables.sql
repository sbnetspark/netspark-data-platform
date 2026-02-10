/* ============================================================================
File: 002_create_ops_and_config_tables.sql
Purpose: Create foundational ops + config tables for governance and operations
Database: netspark_data_platform (Azure SQL)
============================================================================ */

-- =========================
-- OPS TABLES
-- =========================

IF OBJECT_ID('ops.ingestion_run', 'U') IS NULL
BEGIN
  CREATE TABLE ops.ingestion_run (
    ingestion_run_id BIGINT IDENTITY(1,1) NOT NULL,
    source_system    NVARCHAR(100) NOT NULL,
    dataset_name     NVARCHAR(200) NOT NULL,
    started_at_utc   DATETIME2(3) NOT NULL CONSTRAINT DF_ops_ingestion_run_started DEFAULT (SYSUTCDATETIME()),
    ended_at_utc     DATETIME2(3) NULL,
    status           NVARCHAR(50)  NOT NULL CONSTRAINT DF_ops_ingestion_run_status DEFAULT ('started'),
    rows_inserted    BIGINT NULL,
    rows_updated     BIGINT NULL,
    rows_rejected    BIGINT NULL,
    message          NVARCHAR(2000) NULL,
    CONSTRAINT PK_ops_ingestion_run PRIMARY KEY CLUSTERED (ingestion_run_id)
  );
END
GO

IF OBJECT_ID('ops.data_quality_issue', 'U') IS NULL
BEGIN
  CREATE TABLE ops.data_quality_issue (
    dq_issue_id      BIGINT IDENTITY(1,1) NOT NULL,
    ingestion_run_id BIGINT NULL,
    source_system    NVARCHAR(100) NOT NULL,
    dataset_name     NVARCHAR(200) NOT NULL,
    severity         NVARCHAR(20)  NOT NULL, -- info/warn/error
    issue_type       NVARCHAR(100) NOT NULL,
    issue_detail     NVARCHAR(2000) NULL,
    record_key       NVARCHAR(500) NULL,
    created_at_utc   DATETIME2(3) NOT NULL CONSTRAINT DF_ops_dq_created DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_ops_data_quality_issue PRIMARY KEY CLUSTERED (dq_issue_id)
  );
END
GO

-- =========================
-- CONFIG TABLES
-- =========================

IF OBJECT_ID('config.customer_alias_map', 'U') IS NULL
BEGIN
  -- NOTE: This table will be "fixed" in 003 to move away from long clustered keys.
  CREATE TABLE config.customer_alias_map (
    customer_alias NVARCHAR(500) NOT NULL,
    canonical_customer_name NVARCHAR(255) NOT NULL,
    created_at_utc DATETIME2(3) NOT NULL CONSTRAINT DF_cfg_cam_created DEFAULT (SYSUTCDATETIME()),
    created_by     NVARCHAR(255) NULL,
    CONSTRAINT PK_customer_alias_map PRIMARY KEY CLUSTERED (customer_alias)
  );
END
GO
