USE SkyTracke
INSERT INTO Airport (IATACode, Name, City, Country) VALUES
('MCT', 'Muscat International Airport', 'Muscat', 'Oman'),
('DXB', 'Dubai International Airport',  'Dubai',  'UAE'),
('DOH', 'Hamad International Airport',  'Doha',   'Qatar'),
('CAI', 'Cairo International Airport',  'Cairo',  'Egypt'),
('LHR', 'Heathrow Airport',             'London', 'UK');

SELECT * FROM Airport;

INSERT INTO Aircraft (RegistrationNumber, Model, Manufacturer, Capacity, YearOfManufacture) VALUES
('A4O-AA', 'Boeing 737',   'Boeing',   150, 2015),
('A4O-BB', 'Airbus A320',  'Airbus',   180, 2017),
('A4O-CC', 'Boeing 787',   'Boeing',   250, 2019),
('A4O-DD', 'Airbus A380',  'Airbus',   500, 2018),
('A4O-EE', 'Embraer E175', 'Embraer',   80, 2020);

SELECT * FROM Aircraft;

INSERT INTO Flight
    (FlightNumber, DepartureDateTime, ArrivalDateTime,
     Status, AircraftID, OriginAirportID, DestinationAirportID)
VALUES
('SK101', '2025-06-01 08:00', '2025-06-01 10:00', 'Scheduled', 1, 1, 2),
('SK102', '2025-06-01 12:00', '2025-06-01 15:00', 'Delayed',   2, 2, 3),
('SK103', '2025-06-02 09:00', '2025-06-02 13:00', 'Cancelled', 3, 3, 4),
('SK104', '2025-06-02 14:00', '2025-06-02 20:00', 'Completed', 4, 1, 5),
('SK105', '2025-06-03 07:00', '2025-06-03 09:30', 'Scheduled', 5, 4, 1),
('SK106', '2025-06-03 11:00', '2025-06-03 14:00', 'Delayed',   1, 2, 4),
('SK107', '2025-06-04 06:00', '2025-06-04 10:00', 'Completed', 2, 5, 3),
('SK108', '2025-06-04 16:00', '2025-06-04 18:30', 'Cancelled', 3, 4, 2);

SELECT * FROM Flight;


INSERT INTO Passenger
    (NationalID, FullName, Email, Phone, Nationality, DateOfBirth)
VALUES
('OM001', 'Ahmed Al-Rashidi',    'ahmed@email.com',   '91234567',  'Omani',     '1990-05-15'),
('OM002', 'Fatima Al-Balushi',   'fatima@email.com',  '92345678',  'Omani',     '1995-08-20'),
('AE001', 'Mohammed Al-Maktoum','mohd@email.com',     '501234567', 'Emirati',   '1988-03-10'),
('QA001', 'Sara Al-Thani',       'sara@email.com',    '551234567', 'Qatari',    '1992-11-25'),
('EG001', 'Omar Hassan',         'omar@email.com',    '201234567', 'Egyptian',  '1985-07-30'),
('GB001', 'James Smith',         'james@email.com',   '447911123', 'British',   '1993-01-14'),
('JO001', 'Rania Khalid',        'rania@email.com',   '962791234', 'Jordanian', '1997-09-05'),
('SA001', 'Khalid Al-Saud',      'khalid@email.com',  '966501234', 'Saudi',     '1991-12-18');

SELECT * FROM Passenger;


INSERT INTO Booking (SeatNumber, Class, Price, PassengerID, FlightID) VALUES
('12A', 'Economy',   150.00, 1, 1),
('15B', 'Business',  400.00, 2, 1),
('1A',  'First',     800.00, 3, 2),
('20C', 'Economy',   120.00, 4, 2),
('8B',  'Business',  350.00, 5, 3),
('2A',  'First',     900.00, 6, 4),
('25D', 'Economy',   200.00, 7, 4),
('10A', 'Economy',   180.00, 8, 5),
('5B',  'Business',  420.00, 1, 6),
('3A',  'First',     850.00, 2, 7);

SELECT * FROM Booking;


INSERT INTO CrewMember (FullName, Role, LicenseNumber) VALUES
('Capt. Yousuf Al-Amri',    'Pilot',            'PLT-001'),
('Capt. Hamed Al-Farsi',    'Pilot',            'PLT-002'),
('Salim Nasser',            'Co-Pilot',         'CPL-001'),
('Tariq Al-Lawati',         'Engineer',         'ENG-001'),
('Noura Al-Hinai',          'Flight Attendant', 'FA-001'),
('Aisha Al-Zadjali',        'Flight Attendant', 'FA-002');

SELECT * FROM CrewMember;

INSERT INTO FlightCrew (FlightID, CrewMemberID) VALUES

(1, 1), (1, 3), (1, 5),

(2, 2), (2, 3), (2, 6),

(3, 1), (3, 4), (3, 5),

(4, 2), (4, 3), (4, 5), (4, 6),

(5, 1), (5, 3), (5, 5),

(6, 2), (6, 4), (6, 6),

(7, 1), (7, 3), (7, 5),

(8, 2), (8, 4), (8, 6);

SELECT * FROM FlightCrew;

SELECT 'Airport'   AS TableName, COUNT(*) AS TotalRows FROM Airport    UNION ALL
SELECT 'Aircraft',               COUNT(*)              FROM Aircraft   UNION ALL
SELECT 'Flight',                 COUNT(*)              FROM Flight     UNION ALL
SELECT 'Passenger',              COUNT(*)              FROM Passenger  UNION ALL
SELECT 'Booking',                COUNT(*)              FROM Booking    UNION ALL
SELECT 'CrewMember',             COUNT(*)              FROM CrewMember UNION ALL
SELECT 'FlightCrew',             COUNT(*)              FROM FlightCrew;
