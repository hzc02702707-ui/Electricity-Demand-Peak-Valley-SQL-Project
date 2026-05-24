-- =====================================================
-- 00 Database Setup and Import Check
-- Project: CAISO Electricity Demand Peak-Valley Analysis
-- Data Source: EIA Hourly Electric Grid Monitor
-- Period: 2024-07
-- Tool: MySQL Workbench
-- =====================================================


-- =====================================================
-- 1. Create and use database
-- =====================================================

CREATE DATABASE electricity_project;

USE electricity_project;

DROP TABLE IF EXISTS eia_caiso_alltypes_2024_07_clean;
DROP TABLE IF EXISTS eia_caiso_hourly_raw;
-- =====================================================
-- 2. Create raw data table
-- Note: CSV data is imported manually using MySQL Workbench
-- Table Data Import Wizard.
-- =====================================================
CREATE TABLE eia_caiso_hourly_raw (
    period VARCHAR(30),
    respondent VARCHAR(20),
    respondent_name VARCHAR(100),
    data_type VARCHAR(10),
    type_name VARCHAR(100),
    value DECIMAL(12,2),
    value_units VARCHAR(50)
);
-- =====================================================
-- 3. Check table structure
-- =====================================================
DESCRIBE eia_caiso_hourly_raw;
-- =====================================================
-- 4. Check total rows after import
-- Expected result: 2980 rows
-- =====================================================


SELECT COUNT(*) AS total_rows
FROM eia_caiso_hourly_raw;

-- =====================================================
-- 5. Check data categories
-- Expected categories:
-- D  = Demand
-- DF = Day-ahead demand forecast
-- NG = Net generation
-- TI = Total interchange
-- =====================================================



SELECT 
    data_type,
    type_name,
    value_units,
    COUNT(*) AS row_count,
    MIN(value) AS min_value,
    MAX(value) AS max_value
FROM eia_caiso_hourly_raw
GROUP BY data_type, type_name, value_units
ORDER BY data_type;

