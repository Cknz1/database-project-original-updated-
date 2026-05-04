USE SkyTracke
SELECT f.FlightNumber,
       orig.Name          AS OriginAirport,
       dest.Name          AS DestinationAirport,
       ac.Model           AS AircraftModel,
       COUNT(b.BookingID) AS TotalPassengers
FROM Flight f
JOIN  Airport  orig ON f.OriginAirportID      = orig.AirportID
JOIN  Airport  dest ON f.DestinationAirportID = dest.AirportID
JOIN  Aircraft ac   ON f.AircraftID           = ac.AircraftID
LEFT JOIN Booking b ON f.FlightID             = b.FlightID
GROUP BY f.FlightID, f.FlightNumber,
         orig.Name, dest.Name, ac.Model;

SELECT FullName,
       Email,
       Nationality
FROM Passenger
WHERE PassengerID NOT IN (
    SELECT DISTINCT PassengerID FROM Booking
);

SELECT f.FlightNumber,
       SUM(b.Price) AS TotalRevenue
FROM Flight f
JOIN Booking b ON f.FlightID = b.FlightID
GROUP BY f.FlightID, f.FlightNumber
HAVING SUM(b.Price) > 500
ORDER BY TotalRevenue DESC;


SELECT cm.FullName,
       cm.Role,
       COUNT(fc.FlightID) AS TotalFlights
FROM CrewMember cm
JOIN FlightCrew fc ON cm.CrewMemberID = fc.CrewMemberID
GROUP BY cm.CrewMemberID, cm.FullName, cm.Role
HAVING COUNT(fc.FlightID) > 1;

SELECT f.FlightNumber,
       ROUND(AVG(b.Price), 2) AS AvgPrice
FROM Flight f
JOIN Booking b ON f.FlightID = b.FlightID
GROUP BY f.FlightID, f.FlightNumber
HAVING AVG(b.Price) > (
    SELECT AVG(Price) FROM Booking
);


SELECT TOP 1
    f.FlightNumber,
    orig.Name          AS Origin,
    dest.Name          AS Destination,
    COUNT(b.BookingID) AS TotalBookings
FROM Flight f
JOIN Airport orig ON f.OriginAirportID      = orig.AirportID
JOIN Airport dest ON f.DestinationAirportID = dest.AirportID
JOIN Booking b    ON f.FlightID             = b.FlightID
GROUP BY f.FlightID, f.FlightNumber, orig.Name, dest.Name
ORDER BY TotalBookings DESC;

SELECT Class,
       SUM(Price)           AS TotalRevenue,
       COUNT(*)             AS NumberOfBookings,
       ROUND(AVG(Price), 2) AS AveragePrice,
       MAX(Price)           AS HighestPrice,
       MIN(Price)           AS LowestPrice
FROM Booking
GROUP BY Class;

SELECT p.FullName,
       f.FlightNumber,
       b.BookingDate
FROM Passenger p
JOIN Booking b ON p.PassengerID = b.PassengerID
JOIN Flight  f ON b.FlightID    = f.FlightID
WHERE f.Status = 'Cancelled';


SELECT f.FlightNumber,
       COUNT(fc.CrewMemberID) AS TotalCrew,
       f.DepartureDateTime
FROM Flight f
JOIN FlightCrew fc ON f.FlightID      = fc.FlightID
JOIN CrewMember cm ON fc.CrewMemberID = cm.CrewMemberID
GROUP BY f.FlightID, f.FlightNumber, f.DepartureDateTime
HAVING
    SUM(CASE WHEN cm.Role = 'Pilot'            THEN 1 ELSE 0 END) >= 1
AND SUM(CASE WHEN cm.Role = 'Flight Attendant' THEN 1 ELSE 0 END) >= 1;


SELECT f.FlightNumber,
       orig.City                        AS OriginCity,
       dest.City                        AS DestinationCity,
       ac.Model                         AS AircraftModel,
       ac.Manufacturer,
       COUNT(DISTINCT b.BookingID)      AS TotalPassengers,
       COUNT(DISTINCT fc.CrewMemberID)  AS TotalCrew,
       COALESCE(SUM(b.Price), 0)        AS TotalRevenue
FROM Flight f
JOIN  Airport    orig ON f.OriginAirportID      = orig.AirportID
JOIN  Airport    dest ON f.DestinationAirportID = dest.AirportID
JOIN  Aircraft   ac   ON f.AircraftID           = ac.AircraftID
LEFT JOIN Booking    b  ON f.FlightID           = b.FlightID
LEFT JOIN FlightCrew fc ON f.FlightID           = fc.FlightID
GROUP BY f.FlightID, f.FlightNumber,
         orig.City,  dest.City,
         ac.Model,   ac.Manufacturer
ORDER BY TotalRevenue DESC;