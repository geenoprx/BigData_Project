-- Dimension: DimReadingType — static lookup for sensor reading categories
CREATE TABLE DimReadingType (
    ReadingTypeKey  NUMBER          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ReadingTypeID   VARCHAR2(8)     NOT NULL,
    ReadingTypeName VARCHAR2(40)    NOT NULL,
    Unit            VARCHAR2(20),   -- e.g. '°C', '%', 'people'
    CONSTRAINT UQ_DimReadingType_ID UNIQUE (ReadingTypeID)
);


-- Dimension: DimDevice — SCD Type 2 for IoT device type and status changes
CREATE TABLE DimDevice (
    DeviceKey     NUMBER          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DeviceID      VARCHAR2(12)    NOT NULL,
    DevTypeName   VARCHAR2(40)    NOT NULL,
    DeviceName    VARCHAR2(60)    NOT NULL,
    Status        CHAR(1)         NOT NULL,
    EffectiveFrom TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo   TIMESTAMP,
    IsCurrent     CHAR(1)         DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimDevice_Current   UNIQUE (DeviceID, IsCurrent),
    CONSTRAINT CK_DimDevice_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

-- Dimension: DimLocation — static lookup for named tour waypoints and zones
CREATE TABLE DimLocation (
    LocationKey  NUMBER          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    LocationID   VARCHAR2(10)    NOT NULL,
    LocationName VARCHAR2(100)   NOT NULL,
    CountryID    VARCHAR2(8),
    CountryName  VARCHAR2(40),
    ZoneType     VARCHAR2(20)    NOT NULL,
    Latitude     NUMBER(10,6),
    Longitude    NUMBER(10,6),
    CONSTRAINT UQ_DimLocation_LocationID UNIQUE (LocationID),
    CONSTRAINT FK_DimLoc_Country         FOREIGN KEY (CountryID) REFERENCES DimCountry(CountryID)
);
