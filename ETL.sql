--Load data from OLTP to Staging Areas
TRUNCATE TABLE STG_Booking;
INSERT INTO STG_Booking 
SELECT t.*, CURRENT_TIMESTAMP 
FROM Booking t;

TRUNCATE TABLE STG_BookingDetail;
INSERT INTO STG_BookingDetail 
SELECT t.*, CURRENT_TIMESTAMP 
FROM BookingDetail t; 

TRUNCATE TABLE STG_Customer;
INSERT INTO STG_Customer
SELECT t.*, CURRENT_TIMESTAMP
FROM Customer t;

TRUNCATE TABLE STG_CustomerType;
INSERT INTO STG_CustomerType
SELECT t.*, CURRENT_TIMESTAMP
FROM CustomerType t;

TRUNCATE TABLE STG_Tour;
INSERT INTO STG_Tour
SELECT t.*, CURRENT_TIMESTAMP
FROM Tour t;

TRUNCATE TABLE STG_TourType;
INSERT INTO STG_TourType
SELECT t.*, CURRENT_TIMESTAMP
FROM TourType t;

TRUNCATE TABLE STG_Promotion;
INSERT INTO STG_Promotion
SELECT t.*, CURRENT_TIMESTAMP
FROM Promotion t;

TRUNCATE TABLE STG_PromotionDetail;
INSERT INTO STG_PromotionDetail
SELECT t.*, CURRENT_TIMESTAMP
FROM PromotionDetail t;

TRUNCATE TABLE STG_Department;
INSERT INTO STG_Department
SELECT t.*, CURRENT_TIMESTAMP
FROM Department t;

TRUNCATE TABLE STG_Employee;
INSERT INTO STG_Employee
SELECT t.*, CURRENT_TIMESTAMP
FROM Employee t;

TRUNCATE TABLE STG_CostType;
INSERT INTO STG_CostType
SELECT t.*, CURRENT_TIMESTAMP
FROM CostType t;

TRUNCATE TABLE STG_ItemCost;
INSERT INTO STG_ItemCost
SELECT t.*, CURRENT_TIMESTAMP
FROM ItemCost t;

TRUNCATE TABLE STG_CostDetail;
INSERT INTO STG_CostDetail
SELECT t.*, CURRENT_TIMESTAMP
FROM CostDetail t;

TRUNCATE TABLE STG_TourPlan;
INSERT INTO STG_TourPlan
SELECT t.*, CURRENT_TIMESTAMP
FROM TourPlan t;

TRUNCATE TABLE STG_Region;
INSERT INTO STG_Region
SELECT t.*, CURRENT_TIMESTAMP
FROM Region t;

TRUNCATE TABLE STG_Country;
INSERT INTO STG_Country
SELECT t.*, CURRENT_TIMESTAMP
FROM Country t;

TRUNCATE TABLE STG_Guide;
INSERT INTO STG_Guide
SELECT t.*, CURRENT_TIMESTAMP
FROM Guide t;

TRUNCATE TABLE STG_TourDetail;
INSERT INTO STG_TourDetail
SELECT t.*, CURRENT_TIMESTAMP
FROM TourDetail t;
COMMIT;

--Load data into Dimension Table
create or replace PROCEDURE load_DimDate as
Begin 
    INSERT INTO DimDate(DateKey, FullDate, Day, Month, MonthName, Quarter, Year)
    SELECT DISTINCT
        TO_NUMBER(TO_CHAR(d, 'YYYYMMDD')) AS DateKey,
        d AS FullDate,
        TO_NUMBER(TO_CHAR(d, 'DD')),
        TO_NUMBER(TO_CHAR(d, 'MM')),
        TO_CHAR(d, 'Month'),
        TO_NUMBER(TO_CHAR(d, 'Q')),
        TO_NUMBER(TO_CHAR(d, 'YYYY'))
    FROM (
        SELECT bookingdate AS d FROM STG_Booking
        UNION
        SELECT servdatefrom FROM STG_BookingDetail
        UNION
        SELECT servdateto FROM STG_BookingDetail
        UNION
        SELECT startdate FROM STG_Tour        -- ← ใช้ใน FactTripPerformance
        UNION
        SELECT enddate FROM STG_Tour          -- ← เผื่อ lookup
        UNION
        SELECT startdate FROM STG_CostDetail  -- ← เผื่อ lookup
    ) x
    WHERE d IS NOT NULL AND NOT EXISTS (SELECT 1 FROM DimDate dd WHERE dd.FullDate = x.d);
end load_dimDate;

create or replace PROCEDURE load_DimBooking as
begin 
    UPDATE DimBooking d
    SET d.IsCurrent = 'N',
        d.EffectiveTo = CURRENT_TIMESTAMP
    WHERE d.IsCurrent = 'Y' AND EXISTS (
    SELECT 1 FROM STG_Booking s 
    WHERE s.BookingID = d.BookingID AND (
        NVL(d.BookingStatus, '~') <> NVL(s.BookingStatus, '~')
        OR NVL(d.PaymentStatus, '~') <> NVL(s.PaymentStatus, '~')
        OR NVL(d.PaymentMethod, '~') <> NVL(s.PaymentMethod, '~')
        )
    );

    INSERT INTO DimBooking (BookingID, BookingStatus, PaymentStatus, PaymentMethod, EffectiveFrom, EffectiveTo, IsCurrent)
    SELECT s.BookingID, s.BookingStatus, s.PaymentStatus, s.PaymentMethod, CURRENT_TIMESTAMP, NULL, 'Y'
    FROM STG_Booking s LEFT JOIN DimBooking d ON d.BookingID = s.BookingID
    AND d.IsCurrent = 'Y'
    WHERE d.BookingID IS NULL OR (
        NVL(d.BookingStatus, '~') <> NVL(s.BookingStatus, '~')
        OR NVL(d.PaymentStatus, '~') <> NVL(s.PaymentStatus, '~')
        OR NVL(d.PaymentMethod, '~') <> NVL(s.PaymentMethod, '~'));
end load_DimBooking;


create or replace PROCEDURE load_Customer as
begin 
    UPDATE DimCustomer d
    SET d.IsCurrent = 'N',
    d.EffectiveTo = CURRENT_TIMESTAMP
    WHERE d.IsCurrent = 'Y' AND EXISTS (SELECT 1 FROM STG_Customer c
    LEFT JOIN STG_CustomerType ct ON ct.CustTypeID = c.CustTypeID
    WHERE c.CustomerID = d.CustomerID AND 
    NVL(d.Name, '~') <> NVL(c.Name, '~') OR
    NVL(d.Nationality, '~') <> NVL(c.Nationality, '~') OR
    NVL(d.CustTypeID, '~') <> NVL(ct.CustTypeID, '~') OR
    NVL(d.CustTypeName, '~') <> NVL(ct.Name, '~') OR
    NVL(d.DiscountRate, -1) <> NVL(ct.DiscountRate, -1)
    );

    INSERT INTO DimCustomer(CustomerID, Name, Nationality, CusttypeID, CustTypeName, DiscountRate,EffectiveFrom, EffectiveTo, IsCurrent)
    SELECT c.CustomerID, c.Name, c.Nationality, c.CustTypeID, ct.Name, ct.DiscountRate, CURRENT_TIMESTAMP, NULL, 'Y'
    FROM STG_Customer c LEFT JOIN STG_CustomerType ct ON ct.CustTypeID = c.CustTypeID
    LEFT JOIN DimCustomer d ON d.CustomerID = c.CustomerID AND IsCurrent = 'Y' WHERE d.CustomerID IS NULL
    OR
    (NVL(d.Name, '~') <> NVL(c.Name, '~') OR
    NVL(d.Nationality, '~') <> NVL(c.Nationality, '~') OR
    NVL(d.CustTypeID, '~') <> NVL(c.CustTypeID, '~') OR
    NVL(d.CustTypeName, '~') <> NVL(ct.Name, '~') OR
    NVL(d.DiscountRate, -1) <> NVL(ct.DiscountRate, -1));
end load_customer;


create or replace PROCEDURE load_DimPromotion as
begin 
    UPDATE DimPromotion d
   SET d.IsCurrent   = 'N',
       d.EffectiveTo = CURRENT_TIMESTAMP
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_Promotion s
        WHERE s.PromotionID = d.PromotionID
            AND (
                NVL(d.Name,'~') <> NVL(s.Name,'~')
            OR NVL(d.MinPax,-1)         <> NVL(s.MinPax,-1)
            OR NVL(d.DiscountPercentage,-1)  <> NVL(s.DiscountValue,-1)
            OR NVL(TO_CHAR(d.StartDate,'YYYY-MM-DD'),'~') <> NVL(TO_CHAR(s.StartDate,'YYYY-MM-DD'),'~')
            OR NVL(TO_CHAR(d.EndDate,'YYYY-MM-DD'),'~')   <> NVL(TO_CHAR(s.EndDate,'YYYY-MM-DD'),'~')
            OR NVL(d.Status,'~')   <> NVL(s.Status,'~')
            )
    );

    INSERT INTO DimPromotion (
    PromotionID, Name, MinPax, DiscountPercentage, StartDate, EndDate, Status,
    EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT
    s.PromotionID,
    s.Name,
    s.MinPax,
    s.DiscountValue,
    s.StartDate,
    s.EndDate,
    s.Status,
    CURRENT_TIMESTAMP, NULL, 'Y'
    FROM STG_Promotion s
    LEFT JOIN DimPromotion d
    ON d.PromotionID = s.PromotionID
    AND d.IsCurrent   = 'Y'
    WHERE d.PromotionID IS NULL
    OR (
            NVL(d.Name,'~') <> NVL(s.Name,'~')
        OR NVL(d.MinPax,-1)         <> NVL(s.MinPax,-1)
        OR NVL(d.DiscountPercentage,-1)  <> NVL(s.DiscountValue,-1)
        OR NVL(TO_CHAR(d.StartDate,'YYYY-MM-DD'),'~') <> NVL(TO_CHAR(s.StartDate,'YYYY-MM-DD'),'~')
        OR NVL(TO_CHAR(d.EndDate,'YYYY-MM-DD'),'~')   <> NVL(TO_CHAR(s.EndDate,'YYYY-MM-DD'),'~')
        OR NVL(d.Status,'~')   <> NVL(s.Status,'~')
    );
end load_DimPromotion;


create or replace procedure load_DimTour AS
BEGIN
    UPDATE DimTour d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = CURRENT_TIMESTAMP
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_Tour t
        LEFT JOIN STG_TourType tt ON tt.TourTypeID = t.TourTypeID
        LEFT JOIN STG_Country  c  ON c.CountryID  = t.CountryID
        WHERE t.TourID = d.TourID
            AND (
                NVL(d.TourCode,'~')     <> NVL(t.TourCode,'~')
            OR NVL(d.Name,'~')     <> NVL(t.Name,'~')
            OR NVL(d.CapacityPax,-1)   <> NVL(t.CapacityPax,-1)
            OR NVL(TO_CHAR(d.StartDate,'YYYY-MM-DD'),'~') <> NVL(TO_CHAR(t.StartDate,'YYYY-MM-DD'),'~')
            OR NVL(TO_CHAR(d.EndDate,'YYYY-MM-DD'),'~')   <> NVL(TO_CHAR(t.EndDate,'YYYY-MM-DD'),'~')
            OR NVL(d.TourStatus,'~')   <> NVL(t.Status,'~')

            OR NVL(d.TourTypeID,'~')   <> NVL(t.TourTypeID,'~')
            OR NVL(d.TourTypeName,'~') <> NVL(tt.Name,'~')
            OR NVL(d.TourTypeDesc,'~') <> NVL(tt.Description,'~')
            OR NVL(d.BasePrice,-1)     <> NVL(tt.BasePrice,-1)
            OR NVL(d.DurationDays,-1)  <> NVL(tt.DurationDays,-1)
            OR NVL(d.ActiveFlag,'~')   <> NVL(tt.ActiveFlag,'~')

            OR NVL(d.DestinationCountryID,'~')   <> NVL(t.CountryID,'~')
            OR NVL(d.DestinationCountryName,'~') <> NVL(c.Name,'~')
            )
    );

    INSERT INTO DimTour (
    TourID, TourCode, Name, CapacityPax, StartDate, EndDate, TourStatus,
    TourTypeID, TourTypeName, TourTypeDesc, BasePrice, DurationDays, ActiveFlag,
    DestinationCountryID, DestinationCountryName,
    EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT
    t.TourID,
    t.TourCode,
    t.Name,
    t.CapacityPax,
    t.StartDate,
    t.EndDate,
    t.Status,

    t.TourTypeID,
    tt.Name,
    tt.Description,
    tt.BasePrice,
    tt.DurationDays,
    tt.ActiveFlag,

    t.CountryID,
    c.Name,

    CURRENT_TIMESTAMP, NULL, 'Y'
    FROM STG_Tour t
    LEFT JOIN STG_TourType tt ON tt.TourTypeID = t.TourTypeID
    LEFT JOIN STG_Country  c  ON c.CountryID  = t.CountryID
    LEFT JOIN DimTour d
    ON d.TourID    = t.TourID
    AND d.IsCurrent = 'Y'
    WHERE d.TourID IS NULL
    OR (
        NVL(d.TourCode,'~')     <> NVL(t.TourCode,'~')
        OR NVL(d.Name,'~')     <> NVL(t.Name,'~')
        OR NVL(d.CapacityPax,-1)   <> NVL(t.CapacityPax,-1)
        OR NVL(TO_CHAR(d.StartDate,'YYYY-MM-DD'),'~') <> NVL(TO_CHAR(t.StartDate,'YYYY-MM-DD'),'~')
        OR NVL(TO_CHAR(d.EndDate,'YYYY-MM-DD'),'~')   <> NVL(TO_CHAR(t.EndDate,'YYYY-MM-DD'),'~')
        OR NVL(d.TourStatus,'~')   <> NVL(t.Status,'~')

        OR NVL(d.TourTypeID,'~')   <> NVL(t.TourTypeID,'~')
        OR NVL(d.TourTypeName,'~') <> NVL(tt.Name,'~')
        OR NVL(d.TourTypeDesc,'~') <> NVL(tt.Description,'~')
        OR NVL(d.BasePrice,-1)     <> NVL(tt.BasePrice,-1)
        OR NVL(d.DurationDays,-1)  <> NVL(tt.DurationDays,-1)
        OR NVL(d.ActiveFlag,'~')   <> NVL(tt.ActiveFlag,'~')

        OR NVL(d.DestinationCountryID,'~')   <> NVL(t.CountryID,'~')
        OR NVL(d.DestinationCountryName,'~') <> NVL(c.Name,'~')
    );
END load_DimTour;


create or replace procedure load_DimItemCost AS
BEGIN
    UPDATE DimItemCost d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = CURRENT_TIMESTAMP
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_ItemCost ic
        LEFT JOIN STG_CostType ct ON ct.CostTypeID = ic.CostTypeID
        LEFT JOIN STG_Country  c  ON c.CountryID  = ic.CountryID
        WHERE ic.ItemCostID = d.ItemCostID
            AND (
            NVL(d.ItemCostName,'~') <> NVL(ic.Name,'~')
            OR NVL(d.RatePerUnit,-1)   <> NVL(ic.RatePerUnit,-1)
            OR NVL(d.ItemCostStatus,'~')   <> NVL(ic.Status,'~')

            OR NVL(d.CostTypeID,'~')   <> NVL(ic.CostTypeID,'~')
            OR NVL(d.CostTypeName,'~') <> NVL(ct.Name,'~')
            OR NVL(d.CountryID,'~')    <> NVL(ic.CountryID,'~')
            OR NVL(d.CountryName,'~')  <> NVL(c.Name,'~')
            )
    );

    INSERT INTO DimItemCost (
    ItemCostID, ItemCostName, RatePerUnit, ItemCostStatus,
    CostTypeID, CostTypeName,
    CountryID, CountryName,
    EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT
    ic.ItemCostID,
    ic.Name,
    ic.RatePerUnit,
    ic.Status,
    ic.CostTypeID,
    ct.Name,
    ic.CountryID,
    c.Name,
    CURRENT_TIMESTAMP, NULL, 'Y'
    FROM STG_ItemCost ic
    LEFT JOIN STG_CostType ct ON ct.CostTypeID = ic.CostTypeID
    LEFT JOIN STG_Country  c  ON c.CountryID  = ic.CountryID
    LEFT JOIN DimItemCost d
    ON d.ItemCostID = ic.ItemCostID
    AND d.IsCurrent  = 'Y'
    WHERE d.ItemCostID IS NULL
    OR (
            NVL(d.ItemCostName,'~') <> NVL(ic.Name,'~')
        OR NVL(d.RatePerUnit,-1)   <> NVL(ic.RatePerUnit,-1)
        OR NVL(d.ItemCostStatus,'~')   <> NVL(ic.Status,'~')
        OR NVL(d.CostTypeID,'~')   <> NVL(ic.CostTypeID,'~')
        OR NVL(d.CostTypeName,'~') <> NVL(ct.Name,'~')
        OR NVL(d.CountryID,'~')    <> NVL(ic.CountryID,'~')
        OR NVL(d.CountryName,'~')  <> NVL(c.Name,'~')
    );
END load_DimItemCost;

create or replace procedure load_DimGuide as
begin 
    UPDATE DimGuide d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = CURRENT_TIMESTAMP
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_Guide s
        WHERE s.GuideID = d.GuideID
            AND (
                NVL(d.GuideName,'~')          <> NVL(s.Name,'~')
            OR NVL(d.LanguageSkills,'~')     <> NVL(s.LanguageSkills,'~')
            OR NVL(d.GuideSpecialty,'~')     <> NVL(s.Specialty,'~')
            OR NVL(d.GuideStatus,'~')        <> NVL(s.Status,'~')
            OR NVL(d.GuideSalary,-1)         <> NVL(s.Salary,-1)
            )
    );

    INSERT INTO DimGuide (
    GuideID, GuideName, LanguageSkills, GuideSpecialty, GuideStatus, GuideSalary,
    EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT
    s.GuideID,
    s.Name,
    s.LanguageSkills,
    s.Specialty,
    s.Status,
    s.Salary,
    CURRENT_TIMESTAMP,
    NULL,
    'Y'
    FROM STG_Guide s
    LEFT JOIN DimGuide d
    ON d.GuideID   = s.GuideID
    AND d.IsCurrent = 'Y'
    WHERE d.GuideID IS NULL
    OR (
            NVL(d.GuideName,'~')          <> NVL(s.Name,'~')
        OR NVL(d.LanguageSkills,'~')     <> NVL(s.LanguageSkills,'~')
        OR NVL(d.GuideSpecialty,'~')     <> NVL(s.Specialty,'~')
        OR NVL(d.GuideStatus,'~')        <> NVL(s.Status,'~')
        OR NVL(d.GuideSalary,-1)         <> NVL(s.Salary,-1)
    );

end load_dimGuide;

create or replace procedure load_DimCountry as
begin 
    MERGE INTO DimCountry d
    USING (
    SELECT
        c.CountryID,
        c.Name      AS CountryName,
        c.RegionID,
        r.Name      AS Region
    FROM STG_Country c
    LEFT JOIN STG_Region r
        ON r.RegionID = c.RegionID
    ) s
    ON (d.CountryID = s.CountryID)
    WHEN MATCHED THEN
    UPDATE SET
        d.CountryName = s.CountryName,
        d.RegionID    = s.RegionID,
        d.Region      = s.Region
    WHEN NOT MATCHED THEN
    INSERT (CountryID, CountryName, RegionID, Region)
    VALUES (s.CountryID, s.CountryName, s.RegionID, s.Region);
end load_DimCountry;