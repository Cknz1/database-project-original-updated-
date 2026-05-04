USE SkyTracke;

SELECT al.name                      AS AirlineName,
       COUNT(DISTINCT f.FlightID)   AS TotalFlights,
       COUNT(DISTINCT bk.BookingID) AS TotalPassengers,
       COALESCE(SUM(bk.Price), 0)   AS TotalRevenue
FROM Airline al
LEFT JOIN Flight  f  ON al.airline_id = f.airline_id
LEFT JOIN Booking bk ON f.FlightID    = bk.FlightID
GROUP BY al.airline_id, al.name
ORDER BY TotalRevenue DESC;

SELECT TOP 1
    g.gate_code,
    g.terminal,
    a.Name            AS AirportName,
    COUNT(f.FlightID) AS FlightCount
FROM Gate g
JOIN Airport a ON g.airport_id = a.AirportID
JOIN Flight  f ON g.gate_id    = f.gate_id
GROUP BY g.gate_id, g.gate_code, g.terminal, a.Name
ORDER BY FlightCount DESC;

SELECT f.FlightNumber,
       al.name                 AS AirlineName,
       COUNT(d.delay_id)       AS TotalDelays,
       SUM(d.duration_minutes) AS TotalDelayMinutes
FROM Flight f
JOIN Airline        al ON f.airline_id = al.airline_id
JOIN FlightDelayLog d  ON f.FlightID   = d.flight_id
GROUP BY f.FlightID, f.FlightNumber, al.name
ORDER BY TotalDelayMinutes DESC;

SELECT p.FullName,
       SUM(CASE WHEN b.type = 'Cabin'   THEN 1 ELSE 0 END) AS CabinItems,
       SUM(CASE WHEN b.type = 'Checked' THEN 1 ELSE 0 END) AS CheckedItems,
       COUNT(b.baggage_id)                                  AS TotalItems
FROM Passenger p
JOIN Booking bk ON p.PassengerID = bk.PassengerID
JOIN Baggage b  ON bk.BookingID  = b.booking_id
GROUP BY p.PassengerID, p.FullName
ORDER BY TotalItems DESC;

SELECT f.FlightNumber,
       orig.Name                   AS OriginAirport,
       dest.Name                   AS DestinationAirport,
       COALESCE(SUM(bk.Price), 0)  AS TotalRevenue
FROM Flight f
JOIN Airline al   ON f.airline_id           = al.airline_id
JOIN Airport orig ON f.OriginAirportID      = orig.AirportID
JOIN Airport dest ON f.DestinationAirportID = dest.AirportID
LEFT JOIN Booking bk ON f.FlightID          = bk.FlightID
WHERE al.country = 'Oman'
GROUP BY f.FlightID, f.FlightNumber, orig.Name, dest.Name;

SELECT
    f.FlightNumber,
    al.name                              AS AirlineName,
    ISNULL(g.gate_code, 'No Gate')       AS GateCode,
    orig.City                            AS OriginCity,
    dest.City                            AS DestinationCity,
    COUNT(DISTINCT bk.BookingID)         AS TotalPassengers,
    COUNT(DISTINCT b.baggage_id)         AS TotalBaggage,
    COALESCE(SUM(DISTINCT d.duration_minutes), 0) AS TotalDelayMinutes,
    COALESCE(SUM(DISTINCT bk.Price), 0)  AS TotalRevenue
FROM Flight f
JOIN  Airline  al   ON f.airline_id           = al.airline_id
JOIN  Airport  orig ON f.OriginAirportID      = orig.AirportID
JOIN  Airport  dest ON f.DestinationAirportID = dest.AirportID
LEFT JOIN Gate          g  ON f.gate_id       = g.gate_id
LEFT JOIN Booking       bk ON f.FlightID      = bk.FlightID
LEFT JOIN Baggage       b  ON bk.BookingID    = b.booking_id
LEFT JOIN FlightDelayLog d  ON f.FlightID     = d.flight_id
GROUP BY
    f.FlightID,  f.FlightNumber,
    al.name,     g.gate_code,
    orig.City,   dest.City
ORDER BY TotalRevenue DESC;
