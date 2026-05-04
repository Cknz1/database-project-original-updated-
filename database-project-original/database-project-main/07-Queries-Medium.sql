USE SkyTracke
SELECT f.FlightNumber,
       orig.Name AS OriginAirport,
       dest.Name AS DestinationAirport
FROM Flight f
JOIN Airport orig ON f.OriginAirportID      = orig.AirportID
JOIN Airport dest ON f.DestinationAirportID = dest.AirportID;

SELECT b.BookingID,
       p.FullName      AS PassengerName,
       f.FlightNumber,
       b.SeatNumber,
       b.Class,
       b.Price
FROM Booking b
JOIN Passenger p ON b.PassengerID = p.PassengerID
JOIN Flight    f ON b.FlightID    = f.FlightID;

SELECT cm.FullName,
       cm.Role
FROM CrewMember cm
JOIN FlightCrew fc ON cm.CrewMemberID = fc.CrewMemberID
JOIN Flight     f  ON fc.FlightID     = f.FlightID
WHERE f.FlightNumber = 'SK101';

SELECT f.FlightNumber,
       f.DepartureDateTime,
       f.ArrivalDateTime,
       ac.Model AS AircraftModel
FROM Flight f
JOIN Aircraft ac ON f.AircraftID = ac.AircraftID
WHERE f.Status = 'Completed';

SELECT p.FullName,
       COUNT(b.BookingID) AS TotalBookings
FROM Passenger p
LEFT JOIN Booking b ON p.PassengerID = b.PassengerID
GROUP BY p.PassengerID, p.FullName
ORDER BY TotalBookings DESC;

SELECT Class,
       SUM(Price) AS TotalRevenue
FROM Booking
GROUP BY Class;

SELECT ac.RegistrationNumber,
       ac.Model,
       COUNT(f.FlightID) AS TotalFlights
FROM Aircraft ac
LEFT JOIN Flight f ON ac.AircraftID = f.AircraftID
GROUP BY ac.AircraftID, ac.RegistrationNumber, ac.Model;

SELECT f.FlightNumber,
       COUNT(b.BookingID) AS BookingCount
FROM Flight f
JOIN Booking b ON f.FlightID = b.FlightID
GROUP BY f.FlightID, f.FlightNumber
HAVING COUNT(b.BookingID) > 1;

SELECT p.FullName        AS PassengerName,
       f.FlightNumber,
       orig.Name         AS OriginAirport,
       dest.Name         AS DestinationAirport,
       b.Class,
       b.Price
FROM Booking b
JOIN Passenger p  ON b.PassengerID           = p.PassengerID
JOIN Flight    f  ON b.FlightID              = f.FlightID
JOIN Airport orig ON f.OriginAirportID       = orig.AirportID
JOIN Airport dest ON f.DestinationAirportID  = dest.AirportID;
