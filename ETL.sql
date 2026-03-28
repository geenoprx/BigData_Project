--Load data from OLTP to Staging Areas
CREATE OR REPLACE PROCEDURE load_Staging AS
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
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

-- Run Staging Insert Procedure
BEGIN
    load_Staging;
    COMMIT;
END;

--Load data into Dimension Table
create or replace PROCEDURE load_DimDate as
Begin 
    INSERT INTO DimDate(DateKey, FullDate, Day, Month, MonthName, Quarter, Year)
    SELECT DISTINCT
        TO_NUMBER(TO_CHAR(d, 'YYYYMMDD')) AS DateKey,
        d AS FullDate,
        EXTRACT(DAY FROM d) AS Day,
        EXTRACT(MONTH FROM d) AS Month,
        TO_CHAR(d, 'Month'),
        TO_NUMBER(TO_CHAR(d, 'Q')),
        EXTRACT(YEAR FROM d) AS Year
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
end load_DimDate;

create or replace PROCEDURE load_DimBooking as
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
begin 
    UPDATE DimBooking d
    SET d.IsCurrent = 'N',
        d.EffectiveTo = v_now
    WHERE d.IsCurrent = 'Y' AND EXISTS (
    SELECT 1 FROM STG_Booking s 
    WHERE s.BookingID = d.BookingID AND (
        NVL(d.BookingStatus, '~') <> NVL(s.BookingStatus, '~')
        OR NVL(d.PaymentStatus, '~') <> NVL(s.PaymentStatus, '~')
        OR NVL(d.PaymentMethod, '~') <> NVL(s.PaymentMethod, '~')
        )
    );

    INSERT INTO DimBooking (BookingID, BookingStatus, PaymentStatus, PaymentMethod, EffectiveFrom, EffectiveTo, IsCurrent)
    SELECT s.BookingID, s.BookingStatus, s.PaymentStatus, s.PaymentMethod, v_now, NULL, 'Y'
    FROM STG_Booking s LEFT JOIN DimBooking d ON d.BookingID = s.BookingID
    AND d.IsCurrent = 'Y'
    WHERE d.BookingID IS NULL OR (
        NVL(d.BookingStatus, '~') <> NVL(s.BookingStatus, '~')
        OR NVL(d.PaymentStatus, '~') <> NVL(s.PaymentStatus, '~')
        OR NVL(d.PaymentMethod, '~') <> NVL(s.PaymentMethod, '~'));

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
end load_DimBooking;


create or replace PROCEDURE load_DimCustomer as
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
begin 
    UPDATE DimCustomer d
    SET d.IsCurrent = 'N',
    d.EffectiveTo = v_now
    WHERE d.IsCurrent = 'Y' AND EXISTS (SELECT 1 FROM STG_Customer c
    LEFT JOIN STG_CustomerType ct ON ct.CustTypeID = c.CustTypeID
    WHERE c.CustomerID = d.CustomerID 
    AND (                                   
              NVL(d.Name,        '~') <> NVL(c.Name,         '~')
           OR NVL(d.Nationality, '~') <> NVL(c.Nationality,  '~')
           OR NVL(d.CustTypeID,  '~') <> NVL(ct.CustTypeID,  '~')
           OR NVL(d.CustTypeName,'~') <> NVL(ct.Name,        '~')
           OR NVL(d.DiscountRate, -1) <> NVL(ct.DiscountRate, -1)
        )                                      
    );

    INSERT INTO DimCustomer(CustomerID, Name, Nationality, CusttypeID, CustTypeName, DiscountRate,EffectiveFrom, EffectiveTo, IsCurrent)
    SELECT c.CustomerID, c.Name, c.Nationality, c.CustTypeID, ct.Name, ct.DiscountRate, v_now, NULL, 'Y'
    FROM STG_Customer c LEFT JOIN STG_CustomerType ct ON ct.CustTypeID = c.CustTypeID
    LEFT JOIN DimCustomer d ON d.CustomerID = c.CustomerID AND IsCurrent = 'Y' WHERE d.CustomerID IS NULL
    OR (                                           
        NVL(d.Name,        '~') <> NVL(c.Name,         '~')
     OR NVL(d.Nationality, '~') <> NVL(c.Nationality,  '~')
     OR NVL(d.CustTypeID,  '~') <> NVL(c.CustTypeID,   '~')
     OR NVL(d.CustTypeName,'~') <> NVL(ct.Name,        '~')
     OR NVL(d.DiscountRate, -1) <> NVL(ct.DiscountRate, -1)
    );
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
end load_DimCustomer;


create or replace PROCEDURE load_DimPromotion as
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
begin 
    UPDATE DimPromotion d
   SET d.IsCurrent   = 'N',
       d.EffectiveTo = v_now
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_Promotion s
        WHERE s.PromotionID = d.PromotionID
            AND (
                NVL(d.Name,'~') <> NVL(s.Name,'~')
            OR NVL(d.MinPax,-1)         <> NVL(s.MinPax,-1)
            OR NVL(d.DiscountPercentage,-1)  <> NVL(s.DiscountValue,-1)
            OR NVL(d.StartDate, DATE '1900-01-01') <> NVL(s.StartDate, DATE '1900-01-01')
            OR NVL(d.EndDate, DATE '1900-01-01') <> NVL(s.EndDate, DATE '1900-01-01')
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
    v_now, NULL, 'Y'
    FROM STG_Promotion s
    LEFT JOIN DimPromotion d
    ON d.PromotionID = s.PromotionID
    AND d.IsCurrent   = 'Y'
    WHERE d.PromotionID IS NULL
    OR (
            NVL(d.Name,'~') <> NVL(s.Name,'~')
        OR NVL(d.MinPax,-1)         <> NVL(s.MinPax,-1)
        OR NVL(d.DiscountPercentage ,-1)  <> NVL(s.DiscountValue,-1)
        OR NVL(d.StartDate, DATE '1900-01-01') <> NVL(s.StartDate, DATE '1900-01-01')
        OR NVL(d.EndDate, DATE '1900-01-01') <> NVL(s.EndDate, DATE '1900-01-01')
        OR NVL(d.Status,'~')   <> NVL(s.Status,'~')
    );
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
end load_DimPromotion;


create or replace procedure load_DimTour AS
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    UPDATE DimTour d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = v_now
    WHERE d.IsCurrent = 'Y'
    AND EXISTS (
        SELECT 1
        FROM STG_Tour t
        LEFT JOIN STG_TourType tt ON tt.TourTypeID = t.TourTypeID
        LEFT JOIN STG_Country  c  ON c.CountryID   = t.CountryID  
        WHERE t.TourID = d.TourID
            AND (
              NVL(d.TourCode,   '~') <> NVL(t.TourCode,   '~')
           OR NVL(d.Name,       '~') <> NVL(t.Name,       '~')
           OR NVL(d.CapacityPax, -1) <> NVL(t.CapacityPax, -1)
           OR NVL(d.StartDate, DATE '1900-01-01') <> NVL(t.StartDate, DATE '1900-01-01')
           OR NVL(d.EndDate, DATE '1900-01-01') <> NVL(t.EndDate, DATE '1900-01-01')
           OR NVL(d.TourStatus, '~') <> NVL(t.Status,     '~')
           OR NVL(d.TourTypeID, '~') <> NVL(t.TourTypeID, '~')
           OR NVL(d.TourTypeName,'~')<> NVL(tt.Name,      '~')
           OR NVL(d.TourTypeDesc,'~')<> NVL(tt.Description,'~')
           OR NVL(d.BasePrice,   -1) <> NVL(tt.BasePrice,  -1)
           OR NVL(d.DurationDays,-1) <> NVL(tt.DurationDays,-1)
           OR NVL(d.ActiveFlag, '~') <> NVL(tt.ActiveFlag, '~')
           OR NVL(d.DestinationCountryID,  '~') <> NVL(t.CountryID, '~') 
           OR NVL(d.DestinationCountryName,'~') <> NVL(c.Name,      '~')
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

    v_now, NULL, 'Y'
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
        OR NVL(d.StartDate, DATE '1900-01-01') <> NVL(t.StartDate, DATE '1900-01-01')
        OR NVL(d.EndDate, DATE '1900-01-01') <> NVL(t.EndDate, DATE '1900-01-01')
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
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimTour;


create or replace procedure load_DimItemCost AS
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    UPDATE DimItemCost d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = v_now
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
    v_now, NULL, 'Y'
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
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END load_DimItemCost;

create or replace procedure load_DimGuide as
    v_now TIMESTAMP := CURRENT_TIMESTAMP;
begin 
    UPDATE DimGuide d
    SET d.IsCurrent   = 'N',
        d.EffectiveTo = v_now
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
    v_now,
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
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
end load_dimGuide;

create or replace procedure load_DimCountry as
begin
    MERGE INTO DimCountry tgt
    USING (
        SELECT c.CountryID,
               c.Name    AS CountryName,
               c.RegionID,
               r.Name    AS Region
        FROM STG_Country c
        LEFT JOIN STG_Region r ON r.RegionID = c.RegionID
    ) src ON (tgt.CountryID = src.CountryID)
    WHEN MATCHED THEN
        UPDATE SET tgt.CountryName = src.CountryName,
                   tgt.RegionID    = src.RegionID,
                   tgt.Region      = src.Region
    WHEN NOT MATCHED THEN
        INSERT (CountryID, CountryName, RegionID, Region)
        VALUES (src.CountryID, src.CountryName, src.RegionID, src.Region);
end load_DimCountry;

-- Master ETL runner — executes all stages in dependency order
CREATE OR REPLACE PROCEDURE run_ETL AS
BEGIN
    -- Stage 1: Load all OLTP data into staging
    load_Staging;

    -- Stage 2: Independent dimensions
    load_DimDate;
    load_DimCountry;
    load_DimPromotion;
    load_DimGuide;

    -- Stage 3: Dimensions depending on Country
    load_DimItemCost;
    load_DimTour;

    -- Stage 4: Dimensions depending on others
    load_DimCustomer;

    -- Stage 5: Booking dimension (depends on Customer, Promotion, Tour, Guide)
    load_DimBooking;

    PKG_LOAD_FACT_REPORTS.sp_run_all;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END run_ETL;