create view Route_wise_Flight_analysis as 
SELECT 
    f.ORIGIN_AIRPORT_ID,
    f.DEST_AIRPORT_ID,
    a1.CITY_NAME AS ORIGIN_CITY,
    a2.CITY_NAME AS DEST_CITY,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS
FROM Flight f
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID
JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID
GROUP BY f.ORIGIN_AIRPORT_ID, f.DEST_AIRPORT_ID
ORDER BY TOTAL_PASSENGERS DESC
limit 10;
select * from Route_wise_Flight_analysis;




create view Total_Passengers_Served as 
SELECT 
    f.YEAR,
    f.MONTH,
    round(SUM(fm.PASSENGERS)/1000000,2) AS TOTAL_PASSENGERS
FROM Flight f
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
GROUP BY f.YEAR, f.MONTH
ORDER BY f.YEAR, f.MONTH;
select * from Total_Passengers_Served;

create view flight_frequency_and_identify_high_traffic_corridors as 
SELECT 
    f.ORIGIN_AIRPORT_ID,
    f.DEST_AIRPORT_ID,
    a1.CITY_NAME AS ORIGIN_CITY,
    a2.CITY_NAME AS DEST_CITY,
    COUNT(*) AS FLIGHT_COUNT
FROM Flight f
JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID
JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID
GROUP BY f.ORIGIN_AIRPORT_ID, f.DEST_AIRPORT_ID
ORDER BY FLIGHT_COUNT DESC
limit 10;

select * from flight_frequency_and_identify_high_traffic_corridors;





-- stored procedures 
Delimiter //
create procedure Route()
begin 
SELECT 
    f.ORIGIN_AIRPORT_ID,
    f.DEST_AIRPORT_ID,
    a1.CITY_NAME AS ORIGIN_CITY,
    a2.CITY_NAME AS DEST_CITY,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS
FROM Flight f
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID
JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID
GROUP BY f.ORIGIN_AIRPORT_ID, f.DEST_AIRPORT_ID
ORDER BY TOTAL_PASSENGERS DESC
limit 10;
end //

call Route();

Delimiter //
create procedure state_level_route_analysis(in state varchar(30))
begin 
SELECT 
    f.ORIGIN_AIRPORT_ID,
    f.DEST_AIRPORT_ID,
    a1.CITY_NAME AS ORIGIN_CITY,
    a2.CITY_NAME AS DEST_CITY,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS
FROM Flight f
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID
JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID
GROUP BY f.ORIGIN_AIRPORT_ID, f.DEST_AIRPORT_ID
ORDER BY TOTAL_PASSENGERS DESC
limit 10;
end //

call state_level_route_analysis("Chicago")

