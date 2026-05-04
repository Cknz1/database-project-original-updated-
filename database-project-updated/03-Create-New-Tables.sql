USE SkyTracke;
IF OBJECT_ID('FlightDelayLog', 'U') IS NOT NULL DROP TABLE FlightDelayLog;
IF OBJECT_ID('Baggage',        'U') IS NOT NULL DROP TABLE Baggage;
IF OBJECT_ID('Gate',           'U') IS NOT NULL DROP TABLE Gate;
IF OBJECT_ID('Airline',        'U') IS NOT NULL DROP TABLE Airline;

CREATE TABLE Airline (
    airline_id    INT           IDENTITY(1,1) PRIMARY KEY,
    iata_code     VARCHAR(3)    NOT NULL UNIQUE,
    name          VARCHAR(100)  NOT NULL UNIQUE,
    country       VARCHAR(100)  NOT NULL,
    contact_email VARCHAR(100)  NOT NULL UNIQUE
);

CREATE TABLE Gate (
    gate_id    INT         IDENTITY(1,1) PRIMARY KEY,
    gate_code  VARCHAR(10) NOT NULL,
    terminal   VARCHAR(50) NOT NULL,
    airport_id INT         NOT NULL,

    CONSTRAINT FK_Gate_Airport
        FOREIGN KEY (airport_id) REFERENCES Airport(AirportID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT UQ_Gate_Code_Airport
        UNIQUE (gate_code, airport_id)
);


CREATE TABLE Baggage (
    baggage_id INT           IDENTITY(1,1) PRIMARY KEY,
    tag_number VARCHAR(20)   NOT NULL UNIQUE,
    weight_kg  DECIMAL(5,2)  NOT NULL,
    type       VARCHAR(10)   NOT NULL,
    booking_id INT           NOT NULL,

    CONSTRAINT CHK_Baggage_Weight CHECK (weight_kg > 0),
    CONSTRAINT CHK_Baggage_Type   CHECK (type IN ('Cabin','Checked')),

    CONSTRAINT FK_Baggage_Booking
        FOREIGN KEY (booking_id) REFERENCES Booking(BookingID)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE FlightDelayLog (
    delay_id         INT          IDENTITY(1,1) PRIMARY KEY,
    reason           VARCHAR(255) NOT NULL,
    duration_minutes INT          NOT NULL,
    recorded_at      DATETIME     NOT NULL,
    flight_id        INT          NOT NULL,

    CONSTRAINT CHK_Delay_Duration CHECK (duration_minutes > 0),

    CONSTRAINT FK_DelayLog_Flight
        FOREIGN KEY (flight_id) REFERENCES Flight(FlightID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('Airline','Gate','Baggage','FlightDelayLog');
