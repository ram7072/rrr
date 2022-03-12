create or replace view dm_datascience.v_noaa_weather_monthly
as
select 
station,
year,
month,
round(avg(nwd.temp_f),1) as temp_f,
count(nwd.temp_f) as count_temp,
round(avg(nwd.dewp_f),1) as dewp_f,
count(nwd.dewp_f) as count_dewp,
round(avg(nwd.slp)) as slp,
count(nwd.slp) as count_slp,
round(avg(nwd.stp)) as stp,
count(nwd.slp) as count_stp,
round(avg(nwd.visib)) as visib,
count(nwd.visib) as count_visib,
round(avg(nwd.wdsp)) as wdsp,
count(nwd.wdsp) as count_wdsp,
max(nwd.wdsp) as mxpsd,
max(nwd.gust) as gust,
max(nwd.temp_f) as max_temp,
min(nwd.temp_f) as min_temp,
max(nwd.prcp) as prcp,
max(nwd.sndp) as sndp,
nvl(max(nwd.fog),0) as fog,
nvl(max(nwd.rain_drizzle),0) as rain_drizzle,
nvl(max(nwd.snow_ice_pellets),0) as snow_ice_pellets,
nvl(max(nwd.hail),0) as hail,
nvl(max(nwd.thunder),0) as thunder,
nvl(max(nwd.tornado_funnel_cloud),0) as tornado_funnel_cloud
from warehouse.noaa_weather_daily nwd 
group by
station,
year,
month
order by year,month,station;