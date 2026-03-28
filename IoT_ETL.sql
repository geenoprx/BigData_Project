-- Procedure: load_IoT_Staging — full reload of IoT Oracle master/lookup data into staging
CREATE OR REPLACE PROCEDURE load_IoT_Staging AS
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    DELETE FROM STG_IoTDeviceType;
    INSERT INTO STG_IoTDeviceType (
        DevTypeID, DevTypeName, Description,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.DevTypeID, t.DevTypeName, t.Description,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM IoTDeviceType t;

    DELETE FROM STG_ReadingType;
    INSERT INTO STG_ReadingType (
        ReadingTypeID, ReadingTypeName, Unit, Description,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.ReadingTypeID, t.ReadingTypeName, t.Unit, t.Description,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM ReadingType t;

    DELETE FROM STG_IoTLocation;
    INSERT INTO STG_IoTLocation (
        LocationID, LocationName, CountryID, ZoneType,
        Latitude, Longitude, Description,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.LocationID, t.LocationName, t.CountryID, t.ZoneType,
        t.Latitude, t.Longitude, t.Description,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM IoTLocation t;

    DELETE FROM STG_IoTDevice;
    INSERT INTO STG_IoTDevice (
        DeviceID, DevTypeID, DeviceName, Status,
        InstalledAt, LastPingAt,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.DeviceID, t.DevTypeID, t.DeviceName, t.Status,
        t.InstalledAt, t.LastPingAt,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM IoTDevice t;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_IoT_Staging;
/


-- Procedure: load_DimReadingType — insert new ReadingType records into DimReadingType
CREATE OR REPLACE PROCEDURE load_DimReadingType AS
BEGIN
    INSERT INTO DimReadingType (ReadingTypeID, ReadingTypeName, Unit)
    SELECT
        sr.ReadingTypeID,
        sr.ReadingTypeName,
        sr.Unit
    FROM STG_ReadingType sr
    WHERE NOT EXISTS (
        SELECT 1 FROM DimReadingType dr
        WHERE dr.ReadingTypeID = sr.ReadingTypeID
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimReadingType;
/


-- Procedure: load_DimLocation — insert new locations into DimLocation with country lookup
CREATE OR REPLACE PROCEDURE load_DimLocation AS
BEGIN
    INSERT INTO DimLocation (
        LocationID, LocationName, CountryID, CountryName, ZoneType, Latitude, Longitude
    )
    SELECT
        sl.LocationID,
        sl.LocationName,
        sl.CountryID,
        sc.Name     AS CountryName,
        sl.ZoneType,
        sl.Latitude,
        sl.Longitude
    FROM STG_IoTLocation sl
    LEFT JOIN STG_Country sc
        ON sc.CountryID = sl.CountryID
    WHERE NOT EXISTS (
        SELECT 1 FROM DimLocation dl WHERE dl.LocationID = sl.LocationID
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimLocation;
/


-- Procedure: load_DimDevice — SCD Type 2 load for device type, name, and status changes
CREATE OR REPLACE PROCEDURE load_DimDevice AS
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    UPDATE DimDevice d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = v_now
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_IoTDevice sd
        JOIN STG_IoTDeviceType sdt
            ON sdt.DevTypeID = sd.DevTypeID
        WHERE sd.DeviceID = d.DeviceID
        AND (
            NVL(d.DevTypeName, '~') <> NVL(sdt.DevTypeName, '~')
         OR NVL(d.DeviceName,  '~') <> NVL(sd.DeviceName,   '~')
         OR NVL(d.Status,      '~') <> NVL(sd.Status,        '~')
        )
    );

    INSERT INTO DimDevice (
        DeviceID, DevTypeName, DeviceName, Status,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT
        sd.DeviceID,
        sdt.DevTypeName,
        sd.DeviceName,
        sd.Status,
        v_now, NULL, 'Y'
    FROM STG_IoTDevice sd
    JOIN STG_IoTDeviceType sdt
        ON sdt.DevTypeID = sd.DevTypeID
    LEFT JOIN DimDevice d
        ON d.DeviceID = sd.DeviceID
        AND d.IsCurrent = 'Y'
    WHERE d.DeviceID IS NULL
    OR (
        NVL(d.DevTypeName, '~') <> NVL(sdt.DevTypeName, '~')
     OR NVL(d.DeviceName,  '~') <> NVL(sd.DeviceName,   '~')
     OR NVL(d.Status,      '~') <> NVL(sd.Status,        '~')
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimDevice;
/


-- Procedure: run_IoT_ETL — master runner executing all IoT ETL stages in order
CREATE OR REPLACE PROCEDURE run_IoT_ETL AS
BEGIN
    load_IoT_Staging;

    INSERT INTO DimDate (DateKey, FullDate, Day, Month, MonthName, Quarter, Year)
    SELECT DISTINCT
        TO_NUMBER(TO_CHAR(d, 'YYYYMMDD'))  AS DateKey,
        d                                  AS FullDate,
        EXTRACT(DAY   FROM d)              AS Day,
        EXTRACT(MONTH FROM d)              AS Month,
        TO_CHAR(d, 'Month')                AS MonthName,
        TO_NUMBER(TO_CHAR(d, 'Q'))         AS Quarter,
        EXTRACT(YEAR  FROM d)              AS Year
    FROM (
        SELECT TRUNC(ReadingTime)  AS d FROM STG_IoTSensorReading
        UNION
        SELECT TRUNC(CheckInTime)  AS d FROM STG_IoTCheckIn
        UNION
        SELECT TRUNC(CheckOutTime) AS d FROM STG_IoTCheckIn
        WHERE CheckOutTime IS NOT NULL
    ) x
    WHERE d IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM DimDate dd WHERE dd.FullDate = x.d);

    load_DimReadingType;
    load_DimLocation;
    load_DimDevice;

    PKG_LOAD_IOT_FACTS.sp_run_all;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END run_IoT_ETL;
/


BEGIN
    run_IoT_ETL;
    COMMIT;
END;
/