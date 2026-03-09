--รายงานยอดขายและจัดอันดับ ใช้ดูรายได้รวม, จัดอันดับทัวร์ขายดี, และจุดหมายปลายทาง
CREATE TABLE FactRevenueAnalysis (
    FactID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER,          -- วันที่จอง
    TourKey         NUMBER,          -- แพ็กเกจทัวร์ (ใช้ดูชื่อทัวร์, เส้นทาง, ประเทศ)
    CustomerKey     NUMBER,          -- ลูกค้า (ใช้ดูระดับลูกค้า, ประเทศต้นทาง)
    
    BookingCount    NUMBER,          -- จำนวน Booking
    TotalPax        NUMBER,          -- จำนวนคน (Volume)
    TotalRevenue    NUMBER(12,2),    -- รายได้รวม (Net Amount)
    GrossProfit     NUMBER(12,2),    -- กำไรขั้นต้น (Revenue - Cost)
    
    CONSTRAINT FK_Rev_Date FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Rev_Tour FOREIGN KEY (TourKey) REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Rev_Cust FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey)
);

--รายงานประสิทธิภาพต้นทุนและกำไรต่อทริป ใช้ดูว่าไกด์คนไหนทำกำไรดี, ทริปไหนต้นทุนบานปลาย
CREATE TABLE FactTripPerformance (
    FactID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER,          -- วันที่เดินทาง
    TourKey         NUMBER,          -- ทัวร์ (Package)
    GuideKey        NUMBER,          -- ไกด์ (Outsource/In-house)
    SupplierKey     NUMBER,          -- Ground Operator (ต้องสร้าง DimSupplier เพิ่ม)
    
    TotalTrips      NUMBER,          -- จำนวนรอบทริป
    PaxPerTrip      NUMBER,          -- จำนวนลูกทัวร์ในทริปนั้น
    TotalTripCost   NUMBER(12,2),    -- ต้นทุนรวมของทริป
    TotalTripRev    NUMBER(12,2),    -- รายได้รวมของทริป
    TripProfit      NUMBER(12,2),    -- กำไรสุทธิ (Rev - Cost)
    
    CONSTRAINT FK_Trip_Date  FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Trip_Tour  FOREIGN KEY (TourKey) REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Trip_Guide FOREIGN KEY (GuideKey) REFERENCES DimGuide(GuideKey)
    -- CONSTRAINT FK_Trip_Supp FOREIGN KEY (SupplierKey) REFERENCES DimSupplier(SupplierKey)
);

--รายงานสถานะการจอง ใช้ดูอัตราการยกเลิก (Cancel Rate) 
CREATE TABLE FactBookingStatus (
    FactID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER,
    TourKey         NUMBER,
    BookingMetaKey  NUMBER,          -- เชื่อม DimBooking เพื่อดู Status (Cancel/Confirm)
    GuideKey        NUMBER,
    
    -- Metrics for Report 4
    TotalBookings   NUMBER,          -- จำนวนการจองทั้งหมด
    CancelCount     NUMBER,          -- จำนวนที่ยกเลิก (1 ถ้า Cancel, 0 ถ้าไม่)
    
    CONSTRAINT FK_Stat_Date FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Stat_Tour FOREIGN KEY (TourKey) REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Stat_Meta FOREIGN KEY (BookingMetaKey) REFERENCES DimBooking(BookingKey),
    CONSTRAINT FK_Stat_Guide FOREIGN KEY (GuideKey) REFERENCES DimGuide(GuideKey)
);


CREATE OR REPLACE PACKAGE PKG_LOAD_FACT_REPORTS AS
    -- 1. Load สำหรับรายงาน Revenue (FactRevenueAnalysis)
    PROCEDURE sp_load_revenue_analysis;

    -- 2. Load สำหรับรายงาน Performance (FactTripPerformance)
    PROCEDURE sp_load_trip_performance;

    -- 3. Load สำหรับรายงาน Status (FactBookingStatus)
    PROCEDURE sp_load_booking_status;

    -- สั่งรันทั้งหมด
    PROCEDURE sp_run_all;
END PKG_LOAD_FACT_REPORTS;



CREATE OR REPLACE PACKAGE BODY PKG_LOAD_FACT_REPORTS AS

    -- ==========================================================
    -- 1. Load FactRevenueAnalysis
    -- ==========================================================
    PROCEDURE sp_load_revenue_analysis IS
    BEGIN
        -- ล้างข้อมูลเก่า
        EXECUTE IMMEDIATE 'TRUNCATE TABLE FactRevenueAnalysis';

        INSERT INTO FactRevenueAnalysis (
            DateKey, TourKey, CustomerKey,
            BookingCount, TotalPax, TotalRevenue, GrossProfit
        )
        SELECT 
            -- แปลงวันที่จองเป็น DateKey (YYYYMMDD)
            dd.DateKey,
            
            -- Lookup TourKey (ถ้าหาไม่เจอใส่ -1)
            dt.TourKey,
            
            -- Lookup CustomerKey
            dc.CustomerKey,
            
            -- Metrics
            1 AS BookingCount,                           -- 1 แถว คือ 1 Booking
            b.TotalPax AS TotalPax,                      -- จำนวนคนใน Booking นั้น
            b.TotalAmount AS TotalRevenue,               -- รายได้สุทธิ
            
            -- คำนวณกำไรเบื้องต้น (Revenue - Cost โดยประมาณ)
            -- หมายเหตุ: ในทางปฏิบัติควรรวม Cost จริง แต่ในที่นี้ใช้ (Revenue * 0.2) เป็นตัวอย่าง Margin 20%
            (b.TotalAmount * 0.2) AS GrossProfit
            
        FROM STG_Booking b
        -- Join เพื่อหา TourID ของ Booking นั้น
        LEFT JOIN (SELECT DISTINCT BookingID, TourID FROM STG_BookingDetail) bd 
            ON b.BookingID = bd.BookingID
        -- Lookup Dimensions
        LEFT JOIN DimTour dt 
            ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN DimCustomer dc 
            ON b.CustomerID = dc.CustomerID AND dc.IsCurrent = 'Y'
        LEFT JOIN DimDate dd
            ON dd.FullDate = b.BookingDate;  -- ใช้ date จริงมา lookup
        
        COMMIT;
    END sp_load_revenue_analysis;


    -- ==========================================================
    -- 2. Load FactTripPerformance
    -- เน้นดูต้นทุนและกำไรต่อทริป (Grain: 1 Tour)
    -- ==========================================================
    PROCEDURE sp_load_trip_performance IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE FactTripPerformance';

        INSERT INTO FactTripPerformance (
            DateKey, TourKey, GuideKey, -- SupplierKey ตัดออกก่อน
            TotalTrips, PaxPerTrip, TotalTripCost, TotalTripRev, TripProfit
        )
        SELECT 
            -- วันที่เริ่มเดินทาง
            dd.DateKey,
            
            -- TourKey
            dt.TourKey,
            
            -- GuideKey (หาจาก CostDetail ที่เป็นค่าไกด์ หรือถ้าไม่มีใส่ Unknown)
            dg.GuideKey,
            
            -- Metrics
            1 AS TotalTrips,                             -- 1 แถว คือ 1 ทริป
            
            -- นับจำนวนคนรวมทั้งหมดในทริปนั้น (จาก Booking)
            NVL(Rev.SumPax, 0) AS PaxPerTrip,
            
            -- ต้นทุนรวมของทริป (จาก CostDetail)
            NVL(Cost.SumCost, 0) AS TotalTripCost,
            
            -- รายได้รวมของทริป (จาก Booking)
            NVL(Rev.SumAmount, 0) AS TotalTripRev,
            
            -- กำไรสุทธิ (รายได้ - ต้นทุน)
            (NVL(Rev.SumAmount, 0) - NVL(Cost.SumCost, 0)) AS TripProfit

        FROM STG_Tour t
        -- Lookup DimTour
        LEFT JOIN DimTour dt ON t.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        
        -- Subquery 1: หายอดขายรวม และจำนวนคน ต่อทริป
        LEFT JOIN (
            SELECT bd.TourID, SUM(b.TotalPax) as SumPax, SUM(b.TotalAmount) as SumAmount
            FROM STG_Booking b
            JOIN STG_BookingDetail bd ON b.BookingID = bd.BookingID
            GROUP BY bd.TourID
        ) Rev ON t.TourID = Rev.TourID
        
        -- Subquery 2: หาต้นทุนรวม ต่อทริป และหา Guide คนหลัก
        LEFT JOIN (
            SELECT TourID, 
                   MAX(GuideID) as MainGuideID, -- สมมติเลือกไกด์คนหนึ่งเป็นตัวแทน
                   SUM(FeeAmount) as SumCost
            FROM STG_CostDetail
            GROUP BY TourID
        ) Cost ON t.TourID = Cost.TourID
        
        -- Lookup DimGuide
        LEFT JOIN DimGuide dg ON Cost.MainGuideID = dg.GuideID AND dg.IsCurrent = 'Y'
        LEFT JOIN DimDate dd ON dd.FullDate = t.StartDate;

        COMMIT;
    END sp_load_trip_performance;


    -- ==========================================================
    -- 3. Load FactBookingStatus
    -- เน้นดู Status การจอง และ Cancel Rate
    -- ==========================================================
    PROCEDURE sp_load_booking_status IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE FactBookingStatus';

        INSERT INTO FactBookingStatus (
            DateKey, TourKey, BookingMetaKey, GuideKey,
            TotalBookings, CancelCount
        )
        SELECT 
            dd.DateKey,
            dt.TourKey,
            db.BookingKey,
            
            -- GuideKey (อาจจะไม่มีในระดับ Booking ต้องวิ่งไปหาผ่าน Tour)
            dg.GuideKey,

            -- Metrics
            1 AS TotalBookings,
            
            -- Logic การนับ Cancel (ถ้า Status = Cancel ให้เป็น 1)
            CASE WHEN b.BookingStatus = 'Cancel' THEN 1 ELSE 0 END AS CancelCount

        FROM STG_Booking b
        -- Join หา Tour
        LEFT JOIN (SELECT DISTINCT BookingID, TourID FROM STG_BookingDetail) bd ON b.BookingID = bd.BookingID
        -- Join หา BookingMeta (Status Dimension)
        LEFT JOIN DimBooking db ON b.BookingID = db.BookingID AND db.IsCurrent = 'Y'
        -- Join หา Tour Dimension
        LEFT JOIN DimTour dt ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        
        -- Join หา Guide (ซับซ้อนหน่อย: Booking -> Tour -> CostDetail -> Guide)
        LEFT JOIN (
            SELECT TourID, MAX(GuideID) as GuideID FROM STG_CostDetail GROUP BY TourID
        ) cd ON bd.TourID = cd.TourID
        LEFT JOIN DimGuide dg ON cd.GuideID = dg.GuideID AND dg.IsCurrent = 'Y'
        LEFT JOIN DimDate dd ON dd.FullDate = b.BookingDate;
        
        COMMIT;
    END sp_load_booking_status;

    -- ==========================================================
    -- Master Runner
    -- ==========================================================
    PROCEDURE sp_run_all IS
    BEGIN
        sp_load_revenue_analysis;
        sp_load_trip_performance;
        sp_load_booking_status;
    END sp_run_all;

END PKG_LOAD_FACT_REPORTS;


BEGIN
    PKG_LOAD_FACT_REPORTS.sp_run_all;
END;
