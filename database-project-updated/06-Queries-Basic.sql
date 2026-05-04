USE SkyTracke;


SELECT name AS AirlineName, country, iata_code, contact_email
FROM Airline
ORDER BY name ASC;

SELECT g.gate_code, g.terminal,
       a.Name AS AirportName, a.City
FROM Gate g
JOIN Airport a ON g.airport_id = a.AirportID;

SELECT baggage_id, tag_number, type, weight_kg
FROM Baggage
ORDER BY weight_kg DESC;

SELECT d.delay_id, f.FlightNumber,
       d.reason, d.duration_minutes, d.recorded_at
FROM FlightDelayLog d
JOIN Flight f ON d.flight_id = f.FlightID
ORDER BY d.recorded_at ASC;

SELECT FlightNumber, Status, DepartureDateTime
FROM Flight
WHERE gate_id IS NULL;
