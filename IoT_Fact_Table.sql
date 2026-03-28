-- FactIoTReading - hourly aggregated sensor readings per device, reading type, location, and date
CREATE TABLE FactIoTReading (
    FactID          NUMBER      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER      NOT NULL,   
    HourSlot        NUMBER(2)   NOT NULL,   
    DeviceKey       NUMBER      NOT NULL,
    TourKey         NUMBER      NOT NULL,
    ReadingTypeKey  NUMBER      NOT NULL,   
    LocationKey     NUMBER,                 

    ReadingCount    NUMBER      DEFAULT 0,  -- total readings in this hour
    AvgValue        NUMBER(10,2),           -- average reading value
    MaxValue        NUMBER(10,2),           -- peak reading value
    MinValue        NUMBER(10,2),           -- lowest reading value

    CONSTRAINT FK_IoTFact_Date        FOREIGN KEY (DateKey)        REFERENCES DimDate(DateKey),
    CONSTRAINT FK_IoTFact_Device      FOREIGN KEY (DeviceKey)      REFERENCES DimDevice(DeviceKey),
    CONSTRAINT FK_IoTFact_Tour        FOREIGN KEY (TourKey)        REFERENCES DimTour(TourKey),
    CONSTRAINT FK_IoTFact_ReadingType FOREIGN KEY (ReadingTypeKey) REFERENCES DimReadingType(ReadingTypeKey),
    CONSTRAINT FK_IoTFact_Location    FOREIGN KEY (LocationKey)    REFERENCES DimLocation(LocationKey)
);


-- FactTouristMovement - tourist check-in and dwell time summary per booking, location, and date
CREATE TABLE FactTouristMovement (
    FactID          NUMBER      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER      NOT NULL,   
    TourKey         NUMBER      NOT NULL,   
    CustomerKey     NUMBER      NOT NULL,   
    LocationKey     NUMBER      NOT NULL,   

    TotalCheckIns   NUMBER      DEFAULT 0,  -- number of scans at this location
    AvgDwellMins    NUMBER(10,2),           -- avg minutes spent, computed from CheckOut-CheckIn
    MissedCheckIns  NUMBER      DEFAULT 0,  -- tour capacity minus actual scans

    CONSTRAINT FK_IoTMov_Date     FOREIGN KEY (DateKey)     REFERENCES DimDate(DateKey),
    CONSTRAINT FK_IoTMov_Tour     FOREIGN KEY (TourKey)     REFERENCES DimTour(TourKey),
    CONSTRAINT FK_IoTMov_Customer FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT FK_IoTMov_Location FOREIGN KEY (LocationKey) REFERENCES DimLocation(LocationKey)
);


-- PKG_LOAD_IOT_FACTS - package to load IoT fact tables from staging data
CREATE OR REPLACE PACKAGE PKG_LOAD_IOT_FACTS AS
    PROCEDURE sp_load_iot_reading;
    PROCEDURE sp_load_tourist_movement;
    PROCEDURE sp_run_all;
END PKG_LOAD_IOT_FACTS;
/


CREATE OR REPLACE PACKAGE BODY PKG_LOAD_IOT_FACTS AS

    -- sp_load_iot_reading - load hourly aggregated sensor readings into FactIoTReading
    -- Non-volatile: uses MERGE to insert new records and update existing ones; never deletes
    PROCEDURE sp_load_iot_reading IS
    BEGIN
        MERGE INTO FactIoTReading tgt
        USING (
            SELECT
                TO_NUMBER(TO_CHAR(TRUNC(r.ReadingTime), 'YYYYMMDD')) AS DateKey,
                EXTRACT(HOUR FROM r.ReadingTime)                      AS HourSlot,
                dd.DeviceKey,
                dt.TourKey,
                drt.ReadingTypeKey,
                dl.LocationKey,
                COUNT(*)                                              AS ReadingCount,
                ROUND(AVG(r.ReadingValue), 2)                        AS AvgValue,
                MAX(r.ReadingValue)                                   AS MaxValue,
                MIN(r.ReadingValue)                                   AS MinValue
            FROM STG_IoTSensorReading r
            JOIN DimDevice dd
                ON dd.DeviceID = r.DeviceID
                AND dd.IsCurrent = 'Y'
            JOIN STG_IoTDeviceAssignment sda
                ON sda.DeviceID = r.DeviceID
                AND sda.AssignedTo IS NULL
            JOIN DimTour dt
                ON dt.TourID = sda.TourID
                AND dt.IsCurrent = 'Y'
            JOIN DimReadingType drt
                ON drt.ReadingTypeID = r.ReadingTypeID
            LEFT JOIN DimLocation dl
                ON dl.LocationID = r.LocationID
            GROUP BY
                TO_NUMBER(TO_CHAR(TRUNC(r.ReadingTime), 'YYYYMMDD')),
                EXTRACT(HOUR FROM r.ReadingTime),
                dd.DeviceKey,
                dt.TourKey,
                drt.ReadingTypeKey,
                dl.LocationKey
        ) src
        ON (
            tgt.DateKey        = src.DateKey
            AND tgt.HourSlot       = src.HourSlot
            AND tgt.DeviceKey      = src.DeviceKey
            AND tgt.TourKey        = src.TourKey
            AND tgt.ReadingTypeKey = src.ReadingTypeKey
            AND (tgt.LocationKey   = src.LocationKey OR (tgt.LocationKey IS NULL AND src.LocationKey IS NULL))
        )
        WHEN MATCHED THEN
            UPDATE SET
                tgt.ReadingCount = src.ReadingCount,
                tgt.AvgValue     = src.AvgValue,
                tgt.MaxValue     = src.MaxValue,
                tgt.MinValue     = src.MinValue
        WHEN NOT MATCHED THEN
            INSERT (DateKey, HourSlot, DeviceKey, TourKey, ReadingTypeKey, LocationKey,
                    ReadingCount, AvgValue, MaxValue, MinValue)
            VALUES (src.DateKey, src.HourSlot, src.DeviceKey, src.TourKey, src.ReadingTypeKey, src.LocationKey,
                    src.ReadingCount, src.AvgValue, src.MaxValue, src.MinValue);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END sp_load_iot_reading;


    -- sp_load_tourist_movement - load tourist check-in movement summary into FactTouristMovement
    -- Non-volatile: uses MERGE to insert new records and update existing ones; never deletes
    PROCEDURE sp_load_tourist_movement IS
    BEGIN
        MERGE INTO FactTouristMovement tgt
        USING (
            SELECT
                TO_NUMBER(TO_CHAR(TRUNC(ci.CheckInTime), 'YYYYMMDD'))          AS DateKey,
                dt.TourKey,
                dc.CustomerKey,
                dl.LocationKey,
                COUNT(*)                                                        AS TotalCheckIns,
                ROUND(AVG((CAST(ci.CheckOutTime AS DATE) - CAST(ci.CheckInTime AS DATE)) * 1440), 2) AS AvgDwellMins,
                GREATEST(0, dt.CapacityPax - COUNT(*))                         AS MissedCheckIns
            FROM STG_IoTCheckIn ci
            JOIN STG_Booking sb
                ON sb.BookingID = ci.BookingID
            JOIN DimCustomer dc
                ON dc.CustomerID = sb.CustomerID
                AND dc.IsCurrent = 'Y'
            JOIN STG_IoTDeviceAssignment sda
                ON sda.DeviceID = ci.DeviceID
                AND sda.AssignedTo IS NULL
            JOIN DimTour dt
                ON dt.TourID = sda.TourID
                AND dt.IsCurrent = 'Y'
            JOIN DimLocation dl
                ON dl.LocationID = ci.LocationID
            GROUP BY
                TO_NUMBER(TO_CHAR(TRUNC(ci.CheckInTime), 'YYYYMMDD')),
                dt.TourKey,
                dc.CustomerKey,
                dl.LocationKey,
                dt.CapacityPax
        ) src
        ON (
            tgt.DateKey     = src.DateKey
            AND tgt.TourKey     = src.TourKey
            AND tgt.CustomerKey = src.CustomerKey
            AND tgt.LocationKey = src.LocationKey
        )
        WHEN MATCHED THEN
            UPDATE SET
                tgt.TotalCheckIns  = src.TotalCheckIns,
                tgt.AvgDwellMins   = src.AvgDwellMins,
                tgt.MissedCheckIns = src.MissedCheckIns
        WHEN NOT MATCHED THEN
            INSERT (DateKey, TourKey, CustomerKey, LocationKey,
                    TotalCheckIns, AvgDwellMins, MissedCheckIns)
            VALUES (src.DateKey, src.TourKey, src.CustomerKey, src.LocationKey,
                    src.TotalCheckIns, src.AvgDwellMins, src.MissedCheckIns);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END sp_load_tourist_movement;


    -- sp_run_all - execute all IoT fact load procedures in order
    PROCEDURE sp_run_all IS
    BEGIN
        sp_load_iot_reading;
        sp_load_tourist_movement;
    END sp_run_all;

END PKG_LOAD_IOT_FACTS;
/
