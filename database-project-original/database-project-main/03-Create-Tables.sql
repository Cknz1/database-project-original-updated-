USE SkyTracke

IF OBJECT_ID('FlightCrew', 'U') IS NOT NULL DROP TABLE FlightCrew;
IF OBJECT_ID('Booking',    'U') IS NOT NULL DROP TABLE Booking;
IF OBJECT_ID('Flight',     'U') IS NOT NULL DROP TABLE Flight;
IF OBJECT_ID('Passenger',  'U') IS NOT NULL DROP TABLE Passenger;
IF OBJECT_ID('CrewMember', 'U') IS NOT NULL DROP TABLE CrewMember;
IF OBJECT_ID('Aircraft',   'U') IS NOT NULL DROP TABLE Aircraft;
IF OBJECT_ID('Airport',    'U') IS NOT NULL DROP TABLE Airport;

CREATE TABLE Airport
(
    AirportID   INT           IDENTITY(1,1)  NOT NULL,
    IATACode    VARCHAR(3)                   NOT NULL,
    Name        VARCHAR(100)                 NOT NULL,
    City        VARCHAR(100)                 NOT NULL,
    Country     VARCHAR(100)                 NOT NULL,

    CONSTRAINT PK_Airport
        PRIMARY KEY (AirportID),

    CONSTRAINT UQ_Airport_IATACode
        UNIQUE (IATACode)
);


CREATE TABLE Aircraft
(
    AircraftID          INT           IDENTITY(1,1)  NOT NULL,
    RegistrationNumber  VARCHAR(20)                  NOT NULL,
    Model               VARCHAR(50)                  NOT NULL,
    Manufacturer        VARCHAR(50)                  NOT NULL,
    Capacity            INT                          NOT NULL,
    YearOfManufacture   INT                          NULL,

    CONSTRAINT PK_Aircraft
        PRIMARY KEY (AircraftID),


    CONSTRAINT UQ_Aircraft_RegistrationNumber
        UNIQUE (RegistrationNumber),


    CONSTRAINT CHK_Aircraft_Capacity
        CHECK (Capacity > 0)
);


CREATE TABLE Flight
(
    FlightID              INT           IDENTITY(1,1)   NOT NULL,
    FlightNumber          VARCHAR(10)                   NOT NULL,
    DepartureDateTime     DATETIME                      NOT NULL,
    ArrivalDateTime       DATETIME                      NOT NULL,
    Status                VARCHAR(20)                   NOT NULL
                              CONSTRAINT DF_Flight_Status DEFAULT 'Scheduled',


    AircraftID            INT                           NOT NULL,
    OriginAirportID       INT                           NOT NULL,
    DestinationAirportID  INT                           NOT NULL,


    CONSTRAINT PK_Flight
        PRIMARY KEY (FlightID),


    CONSTRAINT UQ_Flight_FlightNumber
        UNIQUE (FlightNumber),

    CONSTRAINT CHK_Flight_Status
        CHECK (Status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),

    CONSTRAINT CHK_Flight_ArrivalAfterDeparture
        CHECK (ArrivalDateTime > DepartureDateTime),

    CONSTRAINT FK_Flight_Aircraft
        FOREIGN KEY (AircraftID)
        REFERENCES Aircraft (AircraftID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,


    CONSTRAINT FK_Flight_OriginAirport
        FOREIGN KEY (OriginAirportID)
        REFERENCES Airport (AirportID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    CONSTRAINT FK_Flight_DestinationAirport
        FOREIGN KEY (DestinationAirportID)
        REFERENCES Airport (AirportID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);


CREATE TABLE Passenger
(
    PassengerID  INT           IDENTITY(1,1)  NOT NULL,
    NationalID   VARCHAR(20)                  NOT NULL,
    FullName     VARCHAR(100)                 NOT NULL,
    Email        VARCHAR(100)                 NOT NULL,
    Phone        VARCHAR(20)                  NULL,
    Nationality  VARCHAR(50)                  NOT NULL,
    DateOfBirth  DATE                         NOT NULL,

    CONSTRAINT PK_Passenger
        PRIMARY KEY (PassengerID),

    CONSTRAINT UQ_Passenger_NationalID
        UNIQUE (NationalID),

    CONSTRAINT UQ_Passenger_Email
        UNIQUE (Email)
);


CREATE TABLE Booking
(
    BookingID    INT             IDENTITY(1,1)  NOT NULL,
    SeatNumber   VARCHAR(5)                     NOT NULL,
    Class        VARCHAR(10)                    NOT NULL,
    Price        DECIMAL(10, 2)                 NOT NULL,
    BookingDate  DATE                           NOT NULL
                     CONSTRAINT DF_Booking_BookingDate DEFAULT GETDATE(),


    PassengerID  INT                            NOT NULL,
    FlightID     INT                            NOT NULL,


    CONSTRAINT PK_Booking
        PRIMARY KEY (BookingID),


    CONSTRAINT CHK_Booking_Class
        CHECK (Class IN ('Economy', 'Business', 'First')),

    CONSTRAINT CHK_Booking_Price
        CHECK (Price > 0),


    CONSTRAINT FK_Booking_Passenger
        FOREIGN KEY (PassengerID)
        REFERENCES Passenger (PassengerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,


    CONSTRAINT FK_Booking_Flight
        FOREIGN KEY (FlightID)
        REFERENCES Flight (FlightID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE CrewMember
(
    CrewMemberID   INT           IDENTITY(1,1)  NOT NULL,
    FullName       VARCHAR(100)                 NOT NULL,
    Role           VARCHAR(20)                  NOT NULL,
    LicenseNumber  VARCHAR(20)                  NOT NULL,


    CONSTRAINT PK_CrewMember
        PRIMARY KEY (CrewMemberID),

    CONSTRAINT UQ_CrewMember_LicenseNumber
        UNIQUE (LicenseNumber),


    CONSTRAINT CHK_CrewMember_Role
        CHECK (Role IN ('Pilot', 'Co-Pilot', 'Flight Attendant', 'Engineer'))
);

CREATE TABLE FlightCrew
(

    FlightID      INT  NOT NULL,
    CrewMemberID  INT  NOT NULL,

    CONSTRAINT PK_FlightCrew
        PRIMARY KEY (FlightID, CrewMemberID),

    CONSTRAINT FK_FlightCrew_Flight
        FOREIGN KEY (FlightID)
        REFERENCES Flight (FlightID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_FlightCrew_CrewMember
        FOREIGN KEY (CrewMemberID)
        REFERENCES CrewMember (CrewMemberID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

SELECT
    t.TABLE_NAME                         AS [Table],
    c.COLUMN_NAME                        AS [Column],
    c.DATA_TYPE                          AS [Type],
    c.CHARACTER_MAXIMUM_LENGTH           AS [MaxLen],
    c.IS_NULLABLE                        AS [Nullable],
    ISNULL(c.COLUMN_DEFAULT, '-')        AS [Default]
FROM
    INFORMATION_SCHEMA.TABLES   t
    JOIN INFORMATION_SCHEMA.COLUMNS c
        ON t.TABLE_NAME = c.TABLE_NAME
WHERE
    t.TABLE_TYPE = 'BASE TABLE'
    AND t.TABLE_NAME IN
        ('Airport','Aircraft','Flight','Passenger',
         'Booking','CrewMember','FlightCrew')
ORDER BY
    t.TABLE_NAME,
    c.ORDINAL_POSITION;

SELECT
    tc.TABLE_NAME        AS [Table],
    tc.CONSTRAINT_TYPE   AS [Type],
    tc.CONSTRAINT_NAME   AS [ConstraintName]
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
WHERE
    tc.TABLE_NAME IN
        ('Airport','Aircraft','Flight','Passenger',
         'Booking','CrewMember','FlightCrew')
ORDER BY
    tc.TABLE_NAME,
    tc.CONSTRAINT_TYPE;