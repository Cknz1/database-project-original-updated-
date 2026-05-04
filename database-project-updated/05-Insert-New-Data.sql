USE SkyTracke;

INSERT INTO Airline (iata_code, name, country, contact_email) VALUES
('WY', 'Oman Air',       'Oman',  'ops@omanair.com'),
('EK', 'Emirates',       'UAE',   'ops@emirates.com'),
('QR', 'Qatar Airways',  'Qatar', 'ops@qatarairways.com'),
('MS', 'EgyptAir',       'Egypt', 'ops@egyptair.com');

SELECT * FROM Airline;

INSERT INTO Gate (gate_code, terminal, airport_id) VALUES
('A1', 'Terminal 1', 1),
('A2', 'Terminal 1', 1),
('A3', 'Terminal 2', 1),
('B1', 'Terminal 1', 2),
('B2', 'Terminal 2', 2),
('B3', 'Terminal 3', 2),
('C1', 'Terminal 1', 3),
('C2', 'Terminal 2', 3);

SELECT * FROM Gate;

UPDATE Flight SET airline_id = 1, gate_id = 1 WHERE FlightNumber = 'SK101';
UPDATE Flight SET airline_id = 2, gate_id = 4 WHERE FlightNumber = 'SK102';
UPDATE Flight SET airline_id = 3, gate_id = 7 WHERE FlightNumber = 'SK103';
UPDATE Flight SET airline_id = 1, gate_id = 2 WHERE FlightNumber = 'SK104';
UPDATE Flight SET airline_id = 4, gate_id = NULL WHERE FlightNumber = 'SK105';
UPDATE Flight SET airline_id = 2, gate_id = 5 WHERE FlightNumber = 'SK106';
UPDATE Flight SET airline_id = 3, gate_id = NULL WHERE FlightNumber = 'SK107';
UPDATE Flight SET airline_id = 4, gate_id = NULL WHERE FlightNumber = 'SK108';

SELECT FlightNumber, airline_id, gate_id FROM Flight;

INSERT INTO Baggage (tag_number, weight_kg, type, booking_id) VALUES
('TAG-001',  7.5, 'Cabin',   1),
('TAG-002', 23.0, 'Checked', 1),
('TAG-003',  8.0, 'Cabin',   2),
('TAG-004', 25.0, 'Checked', 2),
('TAG-005',  6.5, 'Cabin',   3),
('TAG-006', 20.0, 'Checked', 4),
('TAG-007', 22.0, 'Checked', 4),
('TAG-008',  7.0, 'Cabin',   5),
('TAG-009', 18.0, 'Checked', 6),
('TAG-010',  9.0, 'Cabin',   7);

SELECT * FROM Baggage;

INSERT INTO FlightDelayLog (reason, duration_minutes, recorded_at, flight_id) VALUES
('Air traffic congestion',  45,  '2025-06-01 11:30', 2),
('Mechanical issue',        90,  '2025-06-02 08:00', 3),
('Bad weather conditions',  60,  '2025-06-03 10:00', 6),
('Crew availability issue', 30,  '2025-06-03 10:45', 6),
('Airport security delay',  120, '2025-06-04 15:00', 8);

SELECT * FROM FlightDelayLog;
