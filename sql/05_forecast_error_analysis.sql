USE electricity_project;
#1. Create actual demand vs forecast view
-- Purpose:
-- Combine actual demand (D) and day-ahead forecast (DF) by hour.
DROP VIEW IF EXISTS caiso_forecast_error_july2024;
CREATE VIEW caiso_forecast_error_july2024 AS
SELECT
    STR_TO_DATE(period, '%Y-%m-%dT%H') AS period_time_utc,
    DATE_SUB(STR_TO_DATE(period, '%Y-%m-%dT%H'), INTERVAL 7 HOUR) AS period_time_pdt,
    DATE(DATE_SUB(STR_TO_DATE(period, '%Y-%m-%dT%H'), INTERVAL 7 HOUR)) AS demand_date_pdt,
    HOUR(DATE_SUB(STR_TO_DATE(period, '%Y-%m-%dT%H'), INTERVAL 7 HOUR)) AS hour_pdt,
    respondent,
    respondent_name,

    MAX(CASE WHEN data_type = 'D' THEN value END) AS actual_demand_mwh,
    MAX(CASE WHEN data_type = 'DF' THEN value END) AS forecast_demand_mwh,

    MAX(CASE WHEN data_type = 'D' THEN value END)
    - MAX(CASE WHEN data_type = 'DF' THEN value END) AS forecast_error_mwh,

    ABS(
        MAX(CASE WHEN data_type = 'D' THEN value END)
        - MAX(CASE WHEN data_type = 'DF' THEN value END)
    ) AS abs_forecast_error_mwh,

    ROUND(
        ABS(
            MAX(CASE WHEN data_type = 'D' THEN value END)
            - MAX(CASE WHEN data_type = 'DF' THEN value END)
        ) / MAX(CASE WHEN data_type = 'D' THEN value END) * 100,
        2) AS abs_forecast_error_pct 
FROM eia_caiso_hourly_raw
WHERE data_type IN ('D', 'DF')
  AND period >= '2024-07-01T00'
  AND period < '2024-08-01T00'
GROUP BY period,respondent,respondent_name;
#2. Check forecast error view
-- Expected rows: 744
select count(*) from caiso_forecast_error_july2024 ;
select * from caiso_forecast_error_july2024;
#3. Top 10 highest absolute forecast errors
-- Purpose:
-- Identify hours when actual demand deviated most from day-ahead forecast.
SELECT
    period_time_utc,
    period_time_pdt,
    demand_date_pdt,
    hour_pdt,
    actual_demand_mwh,
    forecast_demand_mwh,
    forecast_error_mwh,
    abs_forecast_error_mwh,
    abs_forecast_error_pct
FROM caiso_forecast_error_july2024
ORDER BY abs_forecast_error_mwh DESC
LIMIT 10;
#4. Daily forecast error summary
-- Purpose:
-- Summarize average and maximum forecast error by local date.
SELECT
    demand_date_pdt,
    ROUND(AVG(forecast_error_mwh), 2) AS avg_forecast_error_mwh,
    ROUND(AVG(abs_forecast_error_mwh), 2) AS avg_abs_forecast_error_mwh,
    MAX(abs_forecast_error_mwh) AS max_abs_forecast_error_mwh,
    ROUND(AVG(abs_forecast_error_pct), 2) AS avg_abs_forecast_error_pct
FROM caiso_forecast_error_july2024
GROUP BY demand_date_pdt
ORDER BY avg_abs_forecast_error_mwh DESC;