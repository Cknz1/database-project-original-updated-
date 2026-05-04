USE SkyTracke
SELECT FlightNumber,
       Status,
       DepartureDateTime,
       ArrivalDateTime
FROM Flight
ORDER BY DepartureDateTime ASC;

SELECT PassengerID,
       FullName,
       Nationality,
       Email
FROM Passenger
ORDER BY FullName ASC;

SELECT RegistrationNumber,
       Model,
       Manufacturer,
       Capacity
FROM Aircraft
ORDER BY Capacity DESC;


SELECT DISTINCT Class
FROM Booking;


SELECT FlightNumber,
       Status,
       DepartureDateTime
FROM Flight
WHERE Status IN ('Delayed', 'Cancelled');


SELECT FullName,
       NationalID,
       Email,
       Phone
FROM Passenger
WHERE Nationality = 'Omani';

SELECT IATACode,
       Name,
       City,
       Country
FROM Airport
ORDER BY Country ASC;
