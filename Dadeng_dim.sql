-- Dimension: DimDate — date attributes for time-based analysis
CREATE TABLE DimDate (
    DateKey     NUMBER PRIMARY KEY,
    FullDate    DATE NOT NULL,
    Day         INT NOT NULL,
    Month       INT NOT NULL,
    MonthName   VARCHAR2(20),
    Quarter     INT NOT NULL,
    Year        NUMBER NOT NULL
);

-- Dimension: DimBooking — SCD Type 2 tracking of booking status and payment changes
CREATE TABLE DimBooking (
    BookingKey      NUMBER PRIMARY KEY,
    BookingID       VARCHAR2(8) NOT NULL,
    BookingStatus   VARCHAR2(20) NOT NULL,
    PaymentStatus   VARCHAR2(20) NOT NULL,
    PaymentMethod   VARCHAR2(20) NOT NULL,
    EffectiveFrom   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo     TIMESTAMP,
    IsCurrent       CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimBooking_Current UNIQUE (BookingID, IsCurrent),
    CONSTRAINT CK_DimBooking_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_DimBooking START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimBooking_BI
BEFORE INSERT ON DimBooking
FOR EACH ROW
BEGIN
    IF :NEW.BookingKey IS NULL THEN
        SELECT SEQ_DimBooking.NEXTVAL INTO :NEW.BookingKey FROM DUAL;
    END IF;
END;
/

-- Dimension: DimCustomer — SCD Type 2 tracking of customer profile and type changes
CREATE TABLE DimCustomer (
    CustomerKey     NUMBER PRIMARY KEY,
    CustomerID      VARCHAR2(8) NOT NULL,
    Name            VARCHAR2(200) NOT NULL,
    Nationality     VARCHAR2(80) NOT NULL,
    CustTypeID      VARCHAR2(5),
    CustTypeName    VARCHAR2(100) NOT NULL,
    DiscountRate    NUMBER(5,2),
    EffectiveFrom   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo     TIMESTAMP,
    IsCurrent       CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimCustomer_Current UNIQUE (CustomerID, IsCurrent),
    CONSTRAINT CK_DimCustomer_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_DimCustomer START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimCustomer_BI
BEFORE INSERT ON DimCustomer
FOR EACH ROW
BEGIN
    IF :NEW.CustomerKey IS NULL THEN
        SELECT SEQ_DimCustomer.NEXTVAL INTO :NEW.CustomerKey FROM DUAL;
    END IF;
END;
/

-- Dimension: DimTour — SCD Type 2 tracking of tour package, type, and destination changes
CREATE TABLE DimTour (
    TourKey                 NUMBER PRIMARY KEY,
    TourID                  VARCHAR2(8) NOT NULL,
    TourCode                VARCHAR2(20) NOT NULL,
    Name                    VARCHAR2(40) NOT NULL,
    CapacityPax             NUMBER(2),
    StartDate               DATE,
    EndDate                 DATE,
    TourStatus              VARCHAR2(10),
    TourTypeID              VARCHAR2(8),
    TourTypeName            VARCHAR2(40),
    TourTypeDesc            VARCHAR2(100),
    BasePrice               NUMBER(10),
    DurationDays            NUMBER(3),
    ActiveFlag              CHAR(1),
    DestinationCountryID    VARCHAR2(8),
    DestinationCountryName  VARCHAR2(40),
    EffectiveFrom           TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo             TIMESTAMP,
    IsCurrent               CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimTour_Current UNIQUE (TourID, IsCurrent),
    CONSTRAINT UQ_DimTour_TourCode_Current UNIQUE (TourCode, IsCurrent),
    CONSTRAINT CK_DimTour_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_DimTour START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimTour_BI
BEFORE INSERT ON DimTour
FOR EACH ROW
BEGIN
    IF :NEW.TourKey IS NULL THEN
        SELECT SEQ_DimTour.NEXTVAL INTO :NEW.TourKey FROM DUAL;
    END IF;
END;
/

-- Dimension: DimPromotion — SCD Type 2 tracking of promotion rule changes
CREATE TABLE DimPromotion (
    PromotionKey    NUMBER PRIMARY KEY,
    PromotionID     VARCHAR2(8) NOT NULL,
    Name            VARCHAR2(40) NOT NULL,
    MinPax          NUMBER,
    DiscountValue   NUMBER(2),
    StartDate       DATE,
    EndDate         DATE,
    Status          VARCHAR2(10),
    EffectiveFrom   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo     TIMESTAMP,
    IsCurrent       CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimPromo_Current UNIQUE (PromotionID, IsCurrent),
    CONSTRAINT CK_DimPromo_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_DimPromotion START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimPromotion_BI
BEFORE INSERT ON DimPromotion
FOR EACH ROW
BEGIN
    IF :NEW.PromotionKey IS NULL THEN
        SELECT SEQ_DimPromotion.NEXTVAL INTO :NEW.PromotionKey FROM DUAL;
    END IF;
END;
/

-- Dimension: DimGuide — SCD Type 2 tracking of guide profile and status changes
CREATE TABLE DimGuide (
    GuideKey        NUMBER PRIMARY KEY,
    GuideID         VARCHAR2(8) NOT NULL,
    GuideName       VARCHAR2(40) NOT NULL,
    LanguageSkills  VARCHAR2(20),
    GuideSpecialty  VARCHAR2(80),
    GuideStatus     VARCHAR2(10),
    GuideSalary     NUMBER(10,2),
    EffectiveFrom   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo     TIMESTAMP,
    IsCurrent       CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimGuide_Current UNIQUE (GuideID, IsCurrent),
    CONSTRAINT CK_DimGuide_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_DimGuide START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimGuide_BI
BEFORE INSERT ON DimGuide
FOR EACH ROW
BEGIN
    IF :NEW.GuideKey IS NULL THEN
        SELECT SEQ_DimGuide.NEXTVAL INTO :NEW.GuideKey FROM DUAL;
    END IF;
END;
/

-- Dimension: DimCountry — static country and region lookup
CREATE TABLE DimCountry (
    CountryKey      NUMBER PRIMARY KEY,
    CountryID       VARCHAR2(8) NOT NULL,
    CountryName     VARCHAR2(40) NOT NULL,
    RegionID        VARCHAR2(8),
    Region          VARCHAR2(50),
    CONSTRAINT UQ_DimCountry_CountryID UNIQUE (CountryID),
    CONSTRAINT UQ_DimCountry_CountryName UNIQUE (CountryName)
);

CREATE SEQUENCE SEQ_DimCountry START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimCountry_BI
BEFORE INSERT ON DimCountry
FOR EACH ROW
BEGIN
    IF :NEW.CountryKey IS NULL THEN
        SELECT SEQ_DimCountry.NEXTVAL INTO :NEW.CountryKey FROM DUAL;
    END IF;
END;
/

-- Dimension: DimItemCost — SCD Type 2 tracking of cost item (supplier) rate and type changes
CREATE TABLE DimItemCost (
    ItemCostKey     NUMBER PRIMARY KEY,
    ItemCostID      VARCHAR2(8) NOT NULL,
    ItemCostName    VARCHAR2(40) NOT NULL,
    RatePerUnit     NUMBER(10),
    ItemCostStatus  CHAR(1),
    CountryID       VARCHAR2(8),
    CountryName     VARCHAR2(40),
    CostTypeID      VARCHAR2(8),
    CostTypeName    VARCHAR2(40),
    EffectiveFrom   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo     TIMESTAMP,
    IsCurrent       CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimCostItem_Current UNIQUE (ItemCostID, IsCurrent),
    CONSTRAINT CK_DimCostItem_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_DimItemCost START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_DimItemCost_BI
BEFORE INSERT ON DimItemCost
FOR EACH ROW
BEGIN
    IF :NEW.ItemCostKey IS NULL THEN
        SELECT SEQ_DimItemCost.NEXTVAL INTO :NEW.ItemCostKey FROM DUAL;
    END IF;
END;
/
