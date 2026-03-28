-- Table: IoTDeviceType — IoT device type lookup
CREATE TABLE IoTDeviceType (
    DevTypeID   VARCHAR2(8)   CONSTRAINT PK_IoTDeviceType PRIMARY KEY,
    DevTypeName VARCHAR2(40)  NOT NULL,
    Description VARCHAR2(200),
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128)
);


-- Table: IoTLocation — named physical locations used as tour waypoints
CREATE TABLE IoTLocation (
    LocationID   VARCHAR2(10)  CONSTRAINT PK_IoTLocation PRIMARY KEY,
    LocationName VARCHAR2(100) NOT NULL,
    CountryID    VARCHAR2(8),
    ZoneType     VARCHAR2(20),
    Latitude     NUMBER(10,6),
    Longitude    NUMBER(10,6),
    Description  VARCHAR2(200),
    createdAt    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdBy    VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt    TIMESTAMP,
    updatedBy    VARCHAR2(128),
    CONSTRAINT FK_IoTLoc_Country  FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
    CONSTRAINT CK_IoTLoc_ZoneType CHECK (ZoneType IN ('ATTRACTION', 'HOTEL', 'TRANSPORT', 'AIRPORT'))
);


-- Table: IoTDevice — IoT device registry with type and status
CREATE TABLE IoTDevice (
    DeviceID    VARCHAR2(12)  CONSTRAINT PK_IoTDevice PRIMARY KEY,
    DevTypeID   VARCHAR2(8)   NOT NULL,
    DeviceName  VARCHAR2(60)  NOT NULL,
    Status      CHAR(1)       DEFAULT 'A',
    InstalledAt DATE,
    LastPingAt  TIMESTAMP,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128),
    CONSTRAINT FK_IoTDev_DevType FOREIGN KEY (DevTypeID) REFERENCES IoTDeviceType(DevTypeID),
    CONSTRAINT CK_IoTDev_Status  CHECK (Status IN ('A', 'I', 'M'))
);


-- Table: ReadingType — sensor reading category lookup
CREATE TABLE ReadingType (
    ReadingTypeID   VARCHAR2(8)   CONSTRAINT PK_ReadingType PRIMARY KEY,
    ReadingTypeName VARCHAR2(40)  NOT NULL,
    Unit            VARCHAR2(20),
    Description     VARCHAR2(200),
    createdAt       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdBy       VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt       TIMESTAMP,
    updatedBy       VARCHAR2(128)
);
