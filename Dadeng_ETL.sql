-- ============================================================
-- ETL Stored Procedures  (Oracle 10g)
-- Surrogate keys populated via SEQUENCE + BEFORE INSERT trigger
-- (GENERATED ALWAYS AS IDENTITY is 12c+; not used here)
-- ============================================================

-- ============================================================
-- STAGE 1: Load all OLTP tables into Staging Area
-- ============================================================
CREATE OR REPLACE PROCEDURE load_Staging AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    -- STG_Booking
    DELETE FROM STG_Booking;
    INSERT INTO STG_Booking (
        BookingID, CustomerID, PromotionID, EmpNo,
        BookingDate, BookingStatus, PaymentStatus, PaymentMethod,
        TotalPax, TotalAmount,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.BookingID, t.CustomerID, t.PromotionID, t.EmpNo,
        t.BookingDate, t.BookingStatus, t.PaymentStatus, t.PaymentMethod,
        t.TotalPax, t.TotalAmount,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Booking t;

    -- STG_BookingDetail
    DELETE FROM STG_BookingDetail;
    INSERT INTO STG_BookingDetail (
        BookingID, SeqNo, TourID,
        ServDateFrom, ServDateTo,
        PaxAdult, PaxChild, UnitPrice, SubTotalAmount,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.BookingID, t.SeqNo, t.TourID,
        t.ServDateFrom, t.ServDateTo,
        t.PaxAdult, t.PaxChild, t.UnitPrice, t.SubTotalAmount,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM BookingDetail t;

    -- STG_Customer
    DELETE FROM STG_Customer;
    INSERT INTO STG_Customer (
        CustomerID, CustTypeID, Name, Phone, Address,
        PassportNo, Nationality, DOB,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.CustomerID, t.CustTypeID, t.Name, t.Phone, t.Address,
        t.PassportNo, t.Nationality, t.DOB,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Customer t;

    -- STG_CustomerType
    DELETE FROM STG_CustomerType;
    INSERT INTO STG_CustomerType (
        CustTypeID, Name, DiscountRate,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.CustTypeID, t.Name, t.DiscountRate,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM CustomerType t;

    -- STG_Tour
    DELETE FROM STG_Tour;
    INSERT INTO STG_Tour (
        TourID, TourCode, TourTypeID, Name, CapacityPax,
        StartDate, EndDate, Status, CountryID,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.TourID, t.TourCode, t.TourTypeID, t.Name, t.CapacityPax,
        t.StartDate, t.EndDate, t.Status, t.CountryID,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Tour t;

    -- STG_TourType
    DELETE FROM STG_TourType;
    INSERT INTO STG_TourType (
        TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.TourTypeID, t.Name, t.Description, t.BasePrice, t.DurationDays, t.ActiveFlag,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM TourType t;

    -- STG_Promotion
    DELETE FROM STG_Promotion;
    INSERT INTO STG_Promotion (
        PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.PromotionID, t.Name, t.MinPax, t.DiscountValue, t.StartDate, t.EndDate, t.Status,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Promotion t;

    -- STG_PromotionDetail
    DELETE FROM STG_PromotionDetail;
    INSERT INTO STG_PromotionDetail (
        PromotionID, SeqNo, TourID, DiscountPercent,
        StartDate, EndDate, ExtraCondition, MinBookAmount,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.PromotionID, t.SeqNo, t.TourID, t.DiscountPercent,
        t.StartDate, t.EndDate, t.ExtraCondition, t.MinBookAmount,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM PromotionDetail t;

    -- STG_Department
    DELETE FROM STG_Department;
    INSERT INTO STG_Department (
        DeptCode, DeptName, TotalEmp,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.DeptCode, t.DeptName, t.TotalEmp,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Department t;

    -- STG_Employee
    DELETE FROM STG_Employee;
    INSERT INTO STG_Employee (
        EmpNo, FName, LName, Position, StartDate, ResignDate, DeptCode, Status,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.EmpNo, t.FName, t.LName, t.Position, t.StartDate, t.ResignDate, t.DeptCode, t.Status,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Employee t;

    -- STG_CostType
    DELETE FROM STG_CostType;
    INSERT INTO STG_CostType (
        CostTypeID, Name, Description,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.CostTypeID, t.Name, t.Description,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM CostType t;

    -- STG_ItemCost
    DELETE FROM STG_ItemCost;
    INSERT INTO STG_ItemCost (
        ItemCostID, Name, Email, RatePerUnit, Status,
        createdAt, createdBy, updatedAt, updatedBy,
        CountryID, CostTypeID,
        ETL_LoadedAt
    )
    SELECT
        t.ItemCostID, t.Name, t.Email, t.RatePerUnit, t.Status,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        t.CountryID, t.CostTypeID,
        v_now
    FROM ItemCost t;

    -- STG_CostDetail
    DELETE FROM STG_CostDetail;
    INSERT INTO STG_CostDetail (
        TourID, SeqNo, GuideID, ItemCostID,
        FeeAmount, Quantity, Note, StartDate, EndDate,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.TourID, t.SeqNo, t.GuideID, t.ItemCostID,
        t.FeeAmount, t.Quantity, t.Note, t.StartDate, t.EndDate,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM CostDetail t;

    -- STG_TourPlan
    DELETE FROM STG_TourPlan;
    INSERT INTO STG_TourPlan (
        TourPlanID, Name, Description,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.TourPlanID, t.Name, t.Description,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM TourPlan t;

    -- STG_Region
    DELETE FROM STG_Region;
    INSERT INTO STG_Region (
        RegionID, Name, Description,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.RegionID, t.Name, t.Description,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Region t;

    -- STG_Country
    DELETE FROM STG_Country;
    INSERT INTO STG_Country (
        CountryID, Name, Description, RegionID,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.CountryID, t.Name, t.Description, t.RegionID,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Country t;

    -- STG_Guide
    DELETE FROM STG_Guide;
    INSERT INTO STG_Guide (
        GuideID, Name, Email, LanguageSkills, Phone, Specialty, Salary, Status,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.GuideID, t.Name, t.Email, t.LanguageSkills, t.Phone, t.Specialty, t.Salary, t.Status,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM Guide t;

    -- STG_TourDetail
    DELETE FROM STG_TourDetail;
    INSERT INTO STG_TourDetail (
        TourID, DayNo, TourPlanID, Title, Description,
        Meal, HotelName, TransportNote,
        createdAt, createdBy, updatedAt, updatedBy,
        ETL_LoadedAt
    )
    SELECT
        t.TourID, t.DayNo, t.TourPlanID, t.Title, t.Description,
        t.Meal, t.HotelName, t.TransportNote,
        t.createdAt, t.createdBy, t.updatedAt, t.updatedBy,
        v_now
    FROM TourDetail t;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_Staging;
/

-- Run Staging load
BEGIN
    load_Staging;
    COMMIT;
END;
/


-- ============================================================
-- STAGE 2: Load Dimension Tables
-- ============================================================

-- DimDate: collects all relevant dates from staging into the date dimension
CREATE OR REPLACE PROCEDURE load_DimDate AS
BEGIN
    INSERT INTO DimDate (DateKey, FullDate, Day, Month, MonthName, Quarter, Year)
    SELECT DISTINCT
        TO_NUMBER(TO_CHAR(d, 'YYYYMMDD'))   AS DateKey,
        d                                    AS FullDate,
        EXTRACT(DAY   FROM d)                AS Day,
        EXTRACT(MONTH FROM d)                AS Month,
        TO_CHAR(d, 'Month')                  AS MonthName,
        TO_NUMBER(TO_CHAR(d, 'Q'))           AS Quarter,
        EXTRACT(YEAR  FROM d)                AS Year
    FROM (
        SELECT BookingDate  AS d FROM STG_Booking
        UNION
        SELECT ServDateFrom AS d FROM STG_BookingDetail
        UNION
        SELECT ServDateTo   AS d FROM STG_BookingDetail
        UNION
        SELECT StartDate    AS d FROM STG_Tour
        UNION
        SELECT EndDate      AS d FROM STG_Tour
        UNION
        SELECT StartDate    AS d FROM STG_CostDetail
    ) x
    WHERE d IS NOT NULL
      AND NOT EXISTS (
          SELECT 1 FROM DimDate dd WHERE dd.FullDate = x.d
      );
END load_DimDate;
/

-- DimBooking: SCD Type 2 — expire changed rows, insert new version
CREATE OR REPLACE PROCEDURE load_DimBooking AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    -- Expire rows whose tracked attributes changed
    UPDATE DimBooking d
    SET    d.IsCurrent  = 'N',
           d.EffectiveTo = v_now
    WHERE  d.IsCurrent = 'Y'
      AND  EXISTS (
               SELECT 1 FROM STG_Booking s
               WHERE  s.BookingID = d.BookingID
                 AND (   NVL(d.BookingStatus,  '~') <> NVL(s.BookingStatus,  '~')
                      OR NVL(d.PaymentStatus,  '~') <> NVL(s.PaymentStatus,  '~')
                      OR NVL(d.PaymentMethod,  '~') <> NVL(s.PaymentMethod,  '~')
                     )
           );

    -- Insert new current version for new or changed bookings
    INSERT INTO DimBooking (
        BookingID, BookingStatus, PaymentStatus, PaymentMethod,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT s.BookingID, s.BookingStatus, s.PaymentStatus, s.PaymentMethod,
           v_now, NULL, 'Y'
    FROM   STG_Booking s
    LEFT   JOIN DimBooking d
           ON  d.BookingID  = s.BookingID
           AND d.IsCurrent  = 'Y'
    WHERE  d.BookingID IS NULL
       OR (   NVL(d.BookingStatus, '~') <> NVL(s.BookingStatus, '~')
           OR NVL(d.PaymentStatus, '~') <> NVL(s.PaymentStatus, '~')
           OR NVL(d.PaymentMethod, '~') <> NVL(s.PaymentMethod, '~')
          );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimBooking;
/

-- DimCustomer: SCD Type 2 — denormalises CustomerType into the customer row
CREATE OR REPLACE PROCEDURE load_DimCustomer AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    UPDATE DimCustomer d
    SET    d.IsCurrent   = 'N',
           d.EffectiveTo = v_now
    WHERE  d.IsCurrent = 'Y'
      AND  EXISTS (
               SELECT 1
               FROM   STG_Customer c
               LEFT   JOIN STG_CustomerType ct ON ct.CustTypeID = c.CustTypeID
               WHERE  c.CustomerID = d.CustomerID
                 AND (   NVL(d.Name,         '~') <> NVL(c.Name,          '~')
                      OR NVL(d.Nationality,  '~') <> NVL(c.Nationality,   '~')
                      OR NVL(d.CustTypeID,   '~') <> NVL(ct.CustTypeID,   '~')
                      OR NVL(d.CustTypeName, '~') <> NVL(ct.Name,         '~')
                      OR NVL(d.DiscountRate,  -1) <> NVL(ct.DiscountRate,  -1)
                     )
           );

    INSERT INTO DimCustomer (
        CustomerID, Name, Nationality,
        CustTypeID, CustTypeName, DiscountRate,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT c.CustomerID, c.Name, c.Nationality,
           c.CustTypeID, ct.Name, ct.DiscountRate,
           v_now, NULL, 'Y'
    FROM   STG_Customer c
    LEFT   JOIN STG_CustomerType ct ON ct.CustTypeID = c.CustTypeID
    LEFT   JOIN DimCustomer d
           ON  d.CustomerID = c.CustomerID
           AND d.IsCurrent  = 'Y'
    WHERE  d.CustomerID IS NULL
       OR (   NVL(d.Name,         '~') <> NVL(c.Name,          '~')
           OR NVL(d.Nationality,  '~') <> NVL(c.Nationality,   '~')
           OR NVL(d.CustTypeID,   '~') <> NVL(c.CustTypeID,    '~')
           OR NVL(d.CustTypeName, '~') <> NVL(ct.Name,         '~')
           OR NVL(d.DiscountRate,  -1) <> NVL(ct.DiscountRate,  -1)
          );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimCustomer;
/

-- DimPromotion: SCD Type 2
-- NOTE: DimPromotion column is DiscountValue (not DiscountPercentage)
CREATE OR REPLACE PROCEDURE load_DimPromotion AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    UPDATE DimPromotion d
    SET    d.IsCurrent   = 'N',
           d.EffectiveTo = v_now
    WHERE  d.IsCurrent = 'Y'
      AND  EXISTS (
               SELECT 1 FROM STG_Promotion s
               WHERE  s.PromotionID = d.PromotionID
                 AND (   NVL(d.Name,          '~')              <> NVL(s.Name,          '~')
                      OR NVL(d.MinPax,         -1)              <> NVL(s.MinPax,         -1)
                      OR NVL(d.DiscountValue,  -1)              <> NVL(s.DiscountValue,  -1)
                      OR NVL(d.StartDate, DATE '1900-01-01')    <> NVL(s.StartDate, DATE '1900-01-01')
                      OR NVL(d.EndDate,   DATE '1900-01-01')    <> NVL(s.EndDate,   DATE '1900-01-01')
                      OR NVL(d.Status,        '~')              <> NVL(s.Status,        '~')
                     )
           );

    INSERT INTO DimPromotion (
        PromotionID, Name, MinPax, DiscountValue,
        StartDate, EndDate, Status,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT s.PromotionID, s.Name, s.MinPax, s.DiscountValue,
           s.StartDate, s.EndDate, s.Status,
           v_now, NULL, 'Y'
    FROM   STG_Promotion s
    LEFT   JOIN DimPromotion d
           ON  d.PromotionID = s.PromotionID
           AND d.IsCurrent   = 'Y'
    WHERE  d.PromotionID IS NULL
       OR (   NVL(d.Name,          '~')              <> NVL(s.Name,          '~')
           OR NVL(d.MinPax,         -1)              <> NVL(s.MinPax,         -1)
           OR NVL(d.DiscountValue,  -1)              <> NVL(s.DiscountValue,  -1)
           OR NVL(d.StartDate, DATE '1900-01-01')    <> NVL(s.StartDate, DATE '1900-01-01')
           OR NVL(d.EndDate,   DATE '1900-01-01')    <> NVL(s.EndDate,   DATE '1900-01-01')
           OR NVL(d.Status,        '~')              <> NVL(s.Status,        '~')
          );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimPromotion;
/

-- DimTour: SCD Type 2 — denormalises TourType and Country into the tour row
CREATE OR REPLACE PROCEDURE load_DimTour AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    UPDATE DimTour d
    SET    d.IsCurrent   = 'N',
           d.EffectiveTo = v_now
    WHERE  d.IsCurrent = 'Y'
      AND  EXISTS (
               SELECT 1
               FROM   STG_Tour t
               LEFT   JOIN STG_TourType tt ON tt.TourTypeID = t.TourTypeID
               LEFT   JOIN STG_Country  c  ON c.CountryID   = t.CountryID
               WHERE  t.TourID = d.TourID
                 AND (   NVL(d.TourCode,              '~')           <> NVL(t.TourCode,             '~')
                      OR NVL(d.Name,                  '~')           <> NVL(t.Name,                 '~')
                      OR NVL(d.CapacityPax,            -1)           <> NVL(t.CapacityPax,           -1)
                      OR NVL(d.StartDate, DATE '1900-01-01')         <> NVL(t.StartDate, DATE '1900-01-01')
                      OR NVL(d.EndDate,   DATE '1900-01-01')         <> NVL(t.EndDate,   DATE '1900-01-01')
                      OR NVL(d.TourStatus,             '~')          <> NVL(t.Status,                '~')
                      OR NVL(d.TourTypeID,             '~')          <> NVL(t.TourTypeID,            '~')
                      OR NVL(d.TourTypeName,           '~')          <> NVL(tt.Name,                 '~')
                      OR NVL(d.TourTypeDesc,           '~')          <> NVL(tt.Description,          '~')
                      OR NVL(d.BasePrice,               -1)          <> NVL(tt.BasePrice,             -1)
                      OR NVL(d.DurationDays,            -1)          <> NVL(tt.DurationDays,          -1)
                      OR NVL(d.ActiveFlag,             '~')          <> NVL(tt.ActiveFlag,            '~')
                      OR NVL(d.DestinationCountryID,   '~')          <> NVL(t.CountryID,             '~')
                      OR NVL(d.DestinationCountryName, '~')          <> NVL(c.Name,                  '~')
                     )
           );

    INSERT INTO DimTour (
        TourID, TourCode, Name, CapacityPax, StartDate, EndDate, TourStatus,
        TourTypeID, TourTypeName, TourTypeDesc, BasePrice, DurationDays, ActiveFlag,
        DestinationCountryID, DestinationCountryName,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT t.TourID, t.TourCode, t.Name, t.CapacityPax, t.StartDate, t.EndDate, t.Status,
           t.TourTypeID, tt.Name, tt.Description, tt.BasePrice, tt.DurationDays, tt.ActiveFlag,
           t.CountryID, c.Name,
           v_now, NULL, 'Y'
    FROM   STG_Tour t
    LEFT   JOIN STG_TourType tt ON tt.TourTypeID = t.TourTypeID
    LEFT   JOIN STG_Country  c  ON c.CountryID   = t.CountryID
    LEFT   JOIN DimTour d
           ON  d.TourID    = t.TourID
           AND d.IsCurrent = 'Y'
    WHERE  d.TourID IS NULL
       OR (   NVL(d.TourCode,              '~')        <> NVL(t.TourCode,             '~')
           OR NVL(d.Name,                  '~')        <> NVL(t.Name,                 '~')
           OR NVL(d.CapacityPax,            -1)        <> NVL(t.CapacityPax,           -1)
           OR NVL(d.StartDate, DATE '1900-01-01')      <> NVL(t.StartDate, DATE '1900-01-01')
           OR NVL(d.EndDate,   DATE '1900-01-01')      <> NVL(t.EndDate,   DATE '1900-01-01')
           OR NVL(d.TourStatus,             '~')       <> NVL(t.Status,                '~')
           OR NVL(d.TourTypeID,             '~')       <> NVL(t.TourTypeID,            '~')
           OR NVL(d.TourTypeName,           '~')       <> NVL(tt.Name,                 '~')
           OR NVL(d.TourTypeDesc,           '~')       <> NVL(tt.Description,          '~')
           OR NVL(d.BasePrice,               -1)       <> NVL(tt.BasePrice,             -1)
           OR NVL(d.DurationDays,            -1)       <> NVL(tt.DurationDays,          -1)
           OR NVL(d.ActiveFlag,             '~')       <> NVL(tt.ActiveFlag,            '~')
           OR NVL(d.DestinationCountryID,   '~')       <> NVL(t.CountryID,             '~')
           OR NVL(d.DestinationCountryName, '~')       <> NVL(c.Name,                  '~')
          );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimTour;
/

-- DimItemCost: SCD Type 2 — denormalises CostType and Country
CREATE OR REPLACE PROCEDURE load_DimItemCost AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    UPDATE DimItemCost d
    SET    d.IsCurrent   = 'N',
           d.EffectiveTo = v_now
    WHERE  d.IsCurrent = 'Y'
      AND  EXISTS (
               SELECT 1
               FROM   STG_ItemCost ic
               LEFT   JOIN STG_CostType ct ON ct.CostTypeID = ic.CostTypeID
               LEFT   JOIN STG_Country  c  ON c.CountryID   = ic.CountryID
               WHERE  ic.ItemCostID = d.ItemCostID
                 AND (   NVL(d.ItemCostName,   '~') <> NVL(ic.Name,        '~')
                      OR NVL(d.RatePerUnit,      -1) <> NVL(ic.RatePerUnit,  -1)
                      OR NVL(d.ItemCostStatus,  '~') <> NVL(ic.Status,      '~')
                      OR NVL(d.CostTypeID,      '~') <> NVL(ic.CostTypeID,  '~')
                      OR NVL(d.CostTypeName,    '~') <> NVL(ct.Name,        '~')
                      OR NVL(d.CountryID,       '~') <> NVL(ic.CountryID,   '~')
                      OR NVL(d.CountryName,     '~') <> NVL(c.Name,         '~')
                     )
           );

    INSERT INTO DimItemCost (
        ItemCostID, ItemCostName, RatePerUnit, ItemCostStatus,
        CostTypeID, CostTypeName,
        CountryID, CountryName,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT ic.ItemCostID, ic.Name, ic.RatePerUnit, ic.Status,
           ic.CostTypeID, ct.Name,
           ic.CountryID, c.Name,
           v_now, NULL, 'Y'
    FROM   STG_ItemCost ic
    LEFT   JOIN STG_CostType ct ON ct.CostTypeID = ic.CostTypeID
    LEFT   JOIN STG_Country  c  ON c.CountryID   = ic.CountryID
    LEFT   JOIN DimItemCost d
           ON  d.ItemCostID = ic.ItemCostID
           AND d.IsCurrent  = 'Y'
    WHERE  d.ItemCostID IS NULL
       OR (   NVL(d.ItemCostName,   '~') <> NVL(ic.Name,        '~')
           OR NVL(d.RatePerUnit,      -1) <> NVL(ic.RatePerUnit,  -1)
           OR NVL(d.ItemCostStatus,  '~') <> NVL(ic.Status,      '~')
           OR NVL(d.CostTypeID,      '~') <> NVL(ic.CostTypeID,  '~')
           OR NVL(d.CostTypeName,    '~') <> NVL(ct.Name,        '~')
           OR NVL(d.CountryID,       '~') <> NVL(ic.CountryID,   '~')
           OR NVL(d.CountryName,     '~') <> NVL(c.Name,         '~')
          );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimItemCost;
/

-- DimGuide: SCD Type 2
CREATE OR REPLACE PROCEDURE load_DimGuide AS
    v_now TIMESTAMP := SYSTIMESTAMP;
BEGIN
    UPDATE DimGuide d
    SET    d.IsCurrent   = 'N',
           d.EffectiveTo = v_now
    WHERE  d.IsCurrent = 'Y'
      AND  EXISTS (
               SELECT 1 FROM STG_Guide s
               WHERE  s.GuideID = d.GuideID
                 AND (   NVL(d.GuideName,       '~') <> NVL(s.Name,           '~')
                      OR NVL(d.LanguageSkills,  '~') <> NVL(s.LanguageSkills, '~')
                      OR NVL(d.GuideSpecialty,  '~') <> NVL(s.Specialty,      '~')
                      OR NVL(d.GuideStatus,     '~') <> NVL(s.Status,         '~')
                      OR NVL(d.GuideSalary,      -1) <> NVL(s.Salary,          -1)
                     )
           );

    INSERT INTO DimGuide (
        GuideID, GuideName, LanguageSkills, GuideSpecialty, GuideStatus, GuideSalary,
        EffectiveFrom, EffectiveTo, IsCurrent
    )
    SELECT s.GuideID, s.Name, s.LanguageSkills, s.Specialty, s.Status, s.Salary,
           v_now, NULL, 'Y'
    FROM   STG_Guide s
    LEFT   JOIN DimGuide d
           ON  d.GuideID   = s.GuideID
           AND d.IsCurrent = 'Y'
    WHERE  d.GuideID IS NULL
       OR (   NVL(d.GuideName,       '~') <> NVL(s.Name,           '~')
           OR NVL(d.LanguageSkills,  '~') <> NVL(s.LanguageSkills, '~')
           OR NVL(d.GuideSpecialty,  '~') <> NVL(s.Specialty,      '~')
           OR NVL(d.GuideStatus,     '~') <> NVL(s.Status,         '~')
           OR NVL(d.GuideSalary,      -1) <> NVL(s.Salary,          -1)
          );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimGuide;
/

-- DimCountry: Type 1 (overwrite) via MERGE
CREATE OR REPLACE PROCEDURE load_DimCountry AS
BEGIN
    MERGE INTO DimCountry tgt
    USING (
        SELECT c.CountryID,
               c.Name     AS CountryName,
               c.RegionID,
               r.Name     AS Region
        FROM   STG_Country c
        LEFT   JOIN STG_Region r ON r.RegionID = c.RegionID
    ) src ON (tgt.CountryID = src.CountryID)
    WHEN MATCHED THEN
        UPDATE SET tgt.CountryName = src.CountryName,
                   tgt.RegionID    = src.RegionID,
                   tgt.Region      = src.Region
    WHEN NOT MATCHED THEN
        INSERT (CountryID, CountryName, RegionID, Region)
        VALUES (src.CountryID, src.CountryName, src.RegionID, src.Region);
END load_DimCountry;
/


-- ============================================================
-- STAGE 3: Load Fact Tables (package)
-- ============================================================

CREATE OR REPLACE PACKAGE PKG_LOAD_FACT_REPORTS AS
    PROCEDURE sp_load_revenue_analysis;
    PROCEDURE sp_load_trip_performance;
    PROCEDURE sp_load_booking_status;
    PROCEDURE sp_run_all;
END PKG_LOAD_FACT_REPORTS;
/

CREATE OR REPLACE PACKAGE BODY PKG_LOAD_FACT_REPORTS AS

    -- -------------------------------------------------------
    -- Appends new bookings to FactRevenueAnalysis (high-watermark).
    -- GrossProfit = TotalRevenue - (TourCost * booking pax share).
    -- -------------------------------------------------------
    PROCEDURE sp_load_revenue_analysis IS
        v_last_date_key NUMBER;
    BEGIN
        SELECT NVL(MAX(DateKey), 0) INTO v_last_date_key FROM FactRevenueAnalysis;

        INSERT INTO FactRevenueAnalysis (
            DateKey, TourKey, CustomerKey, PromotionKey,
            BookingCount, TotalPax, TotalRevenue, GrossProfit
        )
        SELECT
            dd.DateKey,
            dt.TourKey,
            dc.CustomerKey,
            dp.PromotionKey,
            1             AS BookingCount,
            b.TotalPax    AS TotalPax,
            b.TotalAmount AS TotalRevenue,
            b.TotalAmount
                - (NVL(tc.TourCost, 0) * (b.TotalPax / NULLIF(tp.TourTotalPax, 0)))
                          AS GrossProfit
        FROM STG_Booking b
        LEFT JOIN (
            SELECT BookingID, MIN(TourID) AS TourID
            FROM   STG_BookingDetail
            GROUP  BY BookingID
        ) bd ON b.BookingID = bd.BookingID
        LEFT JOIN DimTour dt
            ON  bd.TourID   = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN DimCustomer dc
            ON  b.CustomerID = dc.CustomerID AND dc.IsCurrent = 'Y'
        LEFT JOIN DimDate dd
            ON  dd.FullDate  = b.BookingDate
        LEFT JOIN DimPromotion dp
            ON  b.PromotionID = dp.PromotionID AND dp.IsCurrent = 'Y'
        LEFT JOIN (
            SELECT TourID, SUM(FeeAmount * Quantity) AS TourCost
            FROM   STG_CostDetail
            GROUP  BY TourID
        ) tc ON bd.TourID = tc.TourID
        LEFT JOIN (
            SELECT TourID, SUM(PaxAdult + PaxChild) AS TourTotalPax
            FROM   STG_BookingDetail
            GROUP  BY TourID
        ) tp ON bd.TourID = tp.TourID
        WHERE dd.DateKey > v_last_date_key;

        COMMIT;
    END sp_load_revenue_analysis;


    -- -------------------------------------------------------
    -- Appends new tours to FactTripPerformance (high-watermark).
    -- Revenue excludes CANCELLED bookings.
    -- -------------------------------------------------------
    PROCEDURE sp_load_trip_performance IS
        v_last_date_key NUMBER;
    BEGIN
        SELECT NVL(MAX(DateKey), 0) INTO v_last_date_key FROM FactTripPerformance;

        INSERT INTO FactTripPerformance (
            DateKey, TourKey, GuideKey,
            TotalTrips, PaxPerTrip, TotalTripCost, TotalTripRev, TripProfit
        )
        SELECT
            dd.DateKey,
            dt.TourKey,
            dg.GuideKey,
            1                                             AS TotalTrips,
            NVL(Rev.SumPax,    0)                         AS PaxPerTrip,
            NVL(Cost.SumCost,  0)                         AS TotalTripCost,
            NVL(Rev.SumAmount, 0)                         AS TotalTripRev,
            NVL(Rev.SumAmount, 0) - NVL(Cost.SumCost, 0) AS TripProfit
        FROM STG_Tour t
        LEFT JOIN DimDate dd
            ON  dd.FullDate = t.StartDate
        LEFT JOIN DimTour dt
            ON  t.TourID    = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN (
            SELECT bd.TourID,
                   SUM(bd.PaxAdult + bd.PaxChild) AS SumPax,
                   SUM(b.TotalAmount)              AS SumAmount
            FROM   STG_BookingDetail bd
            JOIN   STG_Booking b
                   ON  b.BookingID     = bd.BookingID
                   AND b.BookingStatus NOT IN ('CANCELLED')
            GROUP  BY bd.TourID
        ) Rev ON t.TourID = Rev.TourID
        LEFT JOIN (
            SELECT TourID, MAX(GuideID) AS MainGuideID
            FROM   STG_CostDetail
            WHERE  GuideID IS NOT NULL
            GROUP  BY TourID
        ) Guide ON t.TourID = Guide.TourID
        LEFT JOIN (
            SELECT TourID, SUM(FeeAmount * Quantity) AS SumCost
            FROM   STG_CostDetail
            GROUP  BY TourID
        ) Cost ON t.TourID = Cost.TourID
        LEFT JOIN DimGuide dg
            ON  Guide.MainGuideID = dg.GuideID AND dg.IsCurrent = 'Y'
        WHERE dd.DateKey > v_last_date_key;

        COMMIT;
    END sp_load_trip_performance;


    -- -------------------------------------------------------
    -- Appends new bookings to FactBookingStatus (high-watermark).
    -- CancelCount = 1 when BookingStatus = 'CANCELLED'.
    -- -------------------------------------------------------
    PROCEDURE sp_load_booking_status IS
        v_last_date_key NUMBER;
    BEGIN
        SELECT NVL(MAX(DateKey), 0) INTO v_last_date_key FROM FactBookingStatus;

        INSERT INTO FactBookingStatus (
            DateKey, TourKey, BookingMetaKey, GuideKey,
            TotalBookings, CancelCount
        )
        SELECT
            dd.DateKey,
            dt.TourKey,
            db.BookingKey,
            dg.GuideKey,
            1 AS TotalBookings,
            CASE WHEN b.BookingStatus = 'CANCELLED' THEN 1 ELSE 0 END AS CancelCount
        FROM STG_Booking b
        LEFT JOIN (
            SELECT BookingID, MIN(TourID) AS TourID
            FROM   STG_BookingDetail
            GROUP  BY BookingID
        ) bd ON b.BookingID = bd.BookingID
        LEFT JOIN DimBooking db
            ON  b.BookingID  = db.BookingID AND db.IsCurrent = 'Y'
        LEFT JOIN DimTour dt
            ON  bd.TourID    = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN (
            SELECT TourID, MAX(GuideID) AS GuideID
            FROM   STG_CostDetail
            WHERE  GuideID IS NOT NULL
            GROUP  BY TourID
        ) cd ON bd.TourID = cd.TourID
        LEFT JOIN DimGuide dg
            ON  cd.GuideID   = dg.GuideID AND dg.IsCurrent = 'Y'
        LEFT JOIN DimDate dd
            ON  dd.FullDate  = b.BookingDate
        WHERE dd.DateKey > v_last_date_key;

        COMMIT;
    END sp_load_booking_status;


    -- Runs all three fact loads in sequence
    PROCEDURE sp_run_all IS
    BEGIN
        sp_load_revenue_analysis;
        sp_load_trip_performance;
        sp_load_booking_status;
    END sp_run_all;

END PKG_LOAD_FACT_REPORTS;
/


-- ============================================================
-- Master ETL runner — executes all stages in dependency order
-- ============================================================
CREATE OR REPLACE PROCEDURE run_ETL AS
BEGIN
    -- Stage 1: OLTP → Staging
    load_Staging;

    -- Stage 2: Independent dimensions
    load_DimDate;
    load_DimCountry;
    load_DimPromotion;
    load_DimGuide;

    -- Stage 3: Dimensions that depend on Country
    load_DimItemCost;
    load_DimTour;

    -- Stage 4: Dimensions that depend on others
    load_DimCustomer;

    -- Stage 5: Booking dimension (depends on Customer, Promotion, Tour, Guide)
    load_DimBooking;

    -- Stage 6: Fact tables
    PKG_LOAD_FACT_REPORTS.sp_run_all;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END run_ETL;
/

-- Execute full ETL
BEGIN
    run_ETL;
END;
/
