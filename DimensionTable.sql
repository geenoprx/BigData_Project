create table DimDate (
    DateKey NUMBER PRIMARY KEY,
    FullDate DATE NOT NULL,
    Day INT NOT NULL,
    Month INT NOT NULL,
    MonthName VARCHAR2(20),
    Quarter INT NOT NULL,
    Year NUMBER NOT NULL
);

create table DimBooking(
    BookingKey Number  Generated always AS IDENTITY PRIMARY KEY,
    BookingID VARCHAR2(8) NOT NULL,
    BookingStatus varchar2(20) not null,
    PaymentStatus varchar2(20) not null,
    paymentmethod varchar2(20) not null,
    EffectiveFrom TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null,
    EffectiveTo TIMESTAMP,
    IsCurrent CHAR(1) DEFAULT 'Y' NOT null,
    CONSTRAINT UQ_DimBooking_Current UNIQUE (BookingID, IsCurrent),
    CONSTRAINT CK_DimBooking_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

create table DimCustomer(
    CustomerKey Number Generated always AS IDENTITY PRIMARY KEY,
    CustomerID varchar2(8) NOT NULL,
    Name varchar2(200) NOT NULL,
    Nationality varchar2(80) not null,
    CustTypeID varchar2(5),
    CustTypeName varchar(100) not null,
    DiscountRate number(5,2),
    EffectiveFrom TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null,
    EffectiveTo  TIMESTAMP,
    IsCurrent CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimCustomer_Current UNIQUE (CustomerID, IsCurrent),
    CONSTRAINT CK_DimCustomer_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

create table DimTour(
    TourKey Number Generated always AS IDENTITY PRIMARY KEY,
    TourID varchar2(8) NOT NULL,
    TourCode varchar2(20) not null,
    Name varchar2(40) not null,
    CapacityPax NUMBER(2),
    StartDate DATE,
    EndDate DATE,
    TourStatus varchar2(10),
    TourTypeID  varchar2(8),
    TourTypeName varchar2(40),
    TourTypeDesc varchar2(100),
    BasePrice Number(10),
    DurationDays Number(3),
    ActiveFlag char(1),
    DestinationCountryID varchar2(8),
    DestinationCountryName varchar2(40),
    EffectiveFrom TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo TIMESTAMP,
    IsCurrent char(1) DEFAULT 'Y' not null,
    CONSTRAINT UQ_DimTour_Current UNIQUE (TourID, IsCurrent),
    CONSTRAINT UQ_DimTour_TourCode_Current UNIQUE (TourCode, IsCurrent),
    CONSTRAINT CK_DimTour_IsCurrent CHECK (IsCurrent in ('Y', 'N'))
);

create table DimPromotion(
    PromotionKey Number Generated always AS IDENTITY PRIMARY KEY,
    PromotionID varchar2(8) NOT NULL,
    Name varchar2(40) not null,
    minPax Number,
    DiscountValue number(2),
    startDate DATE,
    EndDate DATE,
    Status varchar2(10),
    EffectiveFrom TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo TIMESTAMP,
    IsCurrent char(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimPromo_Current UNIQUE (PromotionID, IsCurrent),
    CONSTRAINT CK_DimPromo_IsCurrent CHECK (IsCurrent IN ('Y', 'N'))
);

create table DimGuide(
    GuideKey Number Generated always AS IDENTITY PRIMARY KEY,
    GuideID Varchar2(8) not null,
    GuideName varchar2(40) not null,
    languageskills varchar2(20),
    GuideSpecialty varchar2(80),
    GuideStatus varchar2(10),
    GuideSalary Number(10,2),
    EffectiveFrom TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo TIMESTAMP,
    IsCurrent char(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimGuide_Current UNIQUE (GuideID, IsCurrent),
    CONSTRAINT CK_DimGuide_IsCurrent CHECK (IsCurrent IN ('Y', 'N')) 
);

create table DimCountry(
    CountryKey Number Generated always AS IDENTITY PRIMARY KEY,
    CountryID Varchar2(8) not null,
    CountryName varchar2(40) not null,
    RegionID varchar2(8),
    Region Varchar2(50),
    CONSTRAINT UQ_DimCountry_CountryID UNIQUE (CountryID),
    CONSTRAINT UQ_DimCountry_CountryName UNIQUE (CountryName)
);

create table DimItemCost(
    ItemCostKey Number Generated always AS IDENTITY PRIMARY KEY,
    ItemCostID varchar2(8) not null,
    ItemCostName varchar2(40) not null,
    RatePerUnit Number(10),
    ItemCostStatus char(1),
    CountryID varchar2(8),
    CountryName varchar2(40),
    CostTypeID varchar2(8),
    CostTypeName varchar2(40),
    EffectiveFrom TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EffectiveTo TIMESTAMP,
    IsCurrent char(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT UQ_DimCostItem_Current UNIQUE (ItemCostID, IsCurrent),
    CONSTRAINT CK_DimCostItem_IsCurrent CHECK (IsCurrent in ('Y', 'N'))
);