USE electricity_project;
#1. Create demand-only view for July 2024
CREATE VIEW caiso_demand_july2024 AS
SELECT
    STR_TO_DATE(period, '%Y-%m-%dT%H') AS period_time,
    DATE(STR_TO_DATE(period, '%Y-%m-%dT%H')) AS demand_date,
    HOUR(STR_TO_DATE(period, '%Y-%m-%dT%H')) AS hour_of_day,
    respondent,
    respondent_name,
    value AS demand_mwh,
    value_units
FROM eia_caiso_hourly_raw
WHERE data_type = 'D'
  AND period >= '2024-07-01T00'
  AND period < '2024-08-01T00';
  #2.check the total number of rows in this view (expected 744=24(h)*31(days), deleting the time 2024-08-01T00)
  select
  count(*)
  from caiso_demand_july2024
