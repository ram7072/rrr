create or replace view dm_datascience.v_noaa_weather_daily
as
select * from warehouse.noaa_weather_daily;