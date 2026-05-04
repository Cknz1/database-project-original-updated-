USE SkyTracke

UPDATE Flight SET Status = 'Completed'
WHERE FlightNumber = 'SK101';
 

UPDATE Flight SET Status = 'Cancelled'
WHERE FlightNumber = 'SK102';
 

UPDATE Booking SET Price = Price * 1.10
WHERE Class = 'Economy';
 

UPDATE Passenger SET Phone = '99999999'
WHERE NationalID = 'OM001';
 

UPDATE CrewMember SET Role = 'Co-Pilot'
WHERE LicenseNumber = 'ENG-001';

SELECT * FROM Flight WHERE FlightNumber = 'SK103';
DELETE FROM Flight WHERE FlightNumber = 'SK103';

SELECT * FROM Booking
WHERE FlightID = (SELECT FlightID FROM Flight WHERE FlightNumber = 'SK108');
 
DELETE FROM Booking
WHERE FlightID = (SELECT FlightID FROM Flight WHERE FlightNumber = 'SK108');

SELECT * FROM Passenger WHERE NationalID = 'AE001';
DELETE FROM Passenger WHERE NationalID = 'AE001';
 
