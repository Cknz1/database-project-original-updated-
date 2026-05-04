USE SkyTracke
CREATE UNIQUE NONCLUSTERED INDEX IX_Flight_FlightNumber
ON Flight(FlightNumber);

CREATE NONCLUSTERED INDEX IX_Booking_FlightID
ON Booking(FlightID);


CREATE NONCLUSTERED INDEX IX_Booking_PassengerID
ON Booking(PassengerID);

CREATE NONCLUSTERED INDEX IX_Flight_Status
ON Flight(Status);

