USE SkyTracke;

SELECT f.FlightNumber,
       al.name         AS AirlineName,
       ISNULL(g.gate_code, 'No Gate') AS GateCode,
       ISNULL(g.terminal,  'No Gate') AS Terminal
FROM Flight f
JOIN  Airline al ON f.airline_id = al.airline_id
LEFT JOIN Gate g ON f.gate_id   = g.gate_id;


SELECT b.tag_number, b.type, b.weight_kg,
       p.FullName    AS PassengerName,
       f.FlightNumber
FROM Baggage b
JOIN Booking   bk ON b.booking_id   = bk.BookingID
JOIN Passenger p  ON bk.PassengerID = p.PassengerID
JOIN Flight    f  ON bk.FlightID    = f.FlightID;

SELECT bk.BookingID,
       p.FullName            AS PassengerName,
       COUNT(b.baggage_id)   AS BaggageCount
FROM Booking bk
JOIN  Passenger p ON bk.PassengerID = p.PassengerID
LEFT JOIN Baggage b ON bk.BookingID = b.booking_id
GROUP BY bk.BookingID, p.FullName
ORDER BY BaggageCount DESC;

SELECT f.FlightNumber,
       al.name            AS AirlineName,
       d.reason,
       d.duration_minutes,
       d.recorded_at
FROM FlightDelayLog d
JOIN Flight  f  ON d.flight_id  = f.FlightID
JOIN Airline al ON f.airline_id = al.airline_id;

SELECT f.FlightNumber,
       SUM(b.weight_kg) AS TotalCheckedWeight
FROM Flight f
JOIN Booking bk ON f.FlightID   = bk.FlightID
JOIN Baggage b  ON bk.BookingID = b.booking_id
WHERE b.type = 'Checked'
GROUP BY f.FlightID, f.FlightNumber
ORDER BY TotalCheckedWeight DESC;

SELECT al.name           AS AirlineName,
       COUNT(f.FlightID) AS TotalFlights
FROM Airline al
LEFT JOIN Flight f ON al.airline_id = f.airline_id
GROUP BY al.airline_id, al.name
ORDER BY TotalFlights DESC;

SELECT f.FlightNumber,
       COUNT(d.delay_id) AS TotalDelays
FROM Flight f
JOIN FlightDelayLog d ON f.FlightID = d.flight_id
GROUP BY f.FlightID, f.FlightNumber
HAVING COUNT(d.delay_id) > 1;
