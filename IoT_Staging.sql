-- Staging tables: mirror Oracle OLTP master/lookup data (CTAS, no constraints)
CREATE TABLE STG_IoTDeviceType AS SELECT * FROM IoTDeviceType WHERE 1=0;
CREATE TABLE STG_ReadingType   AS SELECT * FROM ReadingType   WHERE 1=0;
CREATE TABLE STG_IoTLocation   AS SELECT * FROM IoTLocation   WHERE 1=0;
CREATE TABLE STG_IoTDevice     AS SELECT * FROM IoTDevice     WHERE 1=0;

-- Alter: add ETL timestamp column to Oracle-sourced staging tables
ALTER TABLE STG_IoTDeviceType ADD (ETL_LoadedAt TIMESTAMP);
ALTER TABLE STG_ReadingType   ADD (ETL_LoadedAt TIMESTAMP);
ALTER TABLE STG_IoTLocation   ADD (ETL_LoadedAt TIMESTAMP);
ALTER TABLE STG_IoTDevice     ADD (ETL_LoadedAt TIMESTAMP);


-- Staging tables: transaction data from MongoDB (explicit schema, loaded by PySpark)
CREATE TABLE STG_IoTDeviceAssignment (
    DeviceID     VARCHAR2(12)  NOT NULL,
    SeqNo        NUMBER(3)     NOT NULL,
    TourID       VARCHAR2(8)   NOT NULL,
    AssignedFrom DATE          NOT NULL,
    AssignedTo   DATE,
    createdAt    TIMESTAMP,
    createdBy    VARCHAR2(128),
    ETL_LoadedAt TIMESTAMP
);

CREATE TABLE STG_IoTSensorReading (
    ReadingID     NUMBER,
    DeviceID      VARCHAR2(12)  NOT NULL,
    LocationID    VARCHAR2(10),
    ReadingTypeID VARCHAR2(8)   NOT NULL,
    ReadingValue  NUMBER(10,2)  NOT NULL,
    ReadingTime   TIMESTAMP     NOT NULL,
    ETL_LoadedAt  TIMESTAMP
);

CREATE TABLE STG_IoTCheckIn (
    CheckInID    NUMBER,
    DeviceID     VARCHAR2(12)  NOT NULL,
    BookingID    VARCHAR2(8)   NOT NULL,
    LocationID   VARCHAR2(10)  NOT NULL,
    CheckInTime  TIMESTAMP     NOT NULL,
    CheckOutTime TIMESTAMP,
    createdAt    TIMESTAMP,
    createdBy    VARCHAR2(128),
    ETL_LoadedAt TIMESTAMP
);

CREATE TABLE STG_IoTAlert (
    AlertID          NUMBER,
    DeviceID         VARCHAR2(12)  NOT NULL,
    TriggerReadingID NUMBER,
    AlertType        VARCHAR2(30)  NOT NULL,
    Severity         VARCHAR2(10)  NOT NULL,
    AlertTime        TIMESTAMP     NOT NULL,
    Message          VARCHAR2(300),
    IsResolved       CHAR(1),
    ResolvedAt       TIMESTAMP,
    createdAt        TIMESTAMP,
    createdBy        VARCHAR2(128),
    ETL_LoadedAt     TIMESTAMP
);
