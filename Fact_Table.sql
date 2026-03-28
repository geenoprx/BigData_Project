-- Fact table: aggregates booking revenue, pax count, and gross profit per booking
CREATE TABLE FactRevenueAnalysis (
    FactID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER,
    TourKey         NUMBER,
    CustomerKey     NUMBER,
    BookingCount    NUMBER,
    TotalPax        NUMBER,
    TotalRevenue    NUMBER(12,2),
    GrossProfit     NUMBER(12,2),
    CONSTRAINT FK_Rev_Date FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Rev_Tour FOREIGN KEY (TourKey) REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Rev_Cust FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey)
);

-- Fact table: measures cost, revenue, and profit per tour trip with guide assignment
CREATE TABLE FactTripPerformance (
    FactID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER,
    TourKey         NUMBER,
    GuideKey        NUMBER,
    TotalTrips      NUMBER,
    PaxPerTrip      NUMBER,
    TotalTripCost   NUMBER(12,2),
    TotalTripRev    NUMBER(12,2),
    TripProfit      NUMBER(12,2),
    CONSTRAINT FK_Trip_Date  FOREIGN KEY (DateKey)  REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Trip_Tour  FOREIGN KEY (TourKey)  REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Trip_Guide FOREIGN KEY (GuideKey) REFERENCES DimGuide(GuideKey)
);

-- Fact table: tracks total bookings and cancellation count per booking record
CREATE TABLE FactBookingStatus (
    FactID          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateKey         NUMBER,
    TourKey         NUMBER,
    BookingMetaKey  NUMBER,
    GuideKey        NUMBER,
    TotalBookings   NUMBER,
    CancelCount     NUMBER,
    CONSTRAINT FK_Stat_Date FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Stat_Tour FOREIGN KEY (TourKey) REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Stat_Meta FOREIGN KEY (BookingMetaKey) REFERENCES DimBooking(BookingKey),
    CONSTRAINT FK_Stat_Guide FOREIGN KEY (GuideKey) REFERENCES DimGuide(GuideKey)
);


-- Package spec: declares ETL load procedures for all three fact tables
CREATE OR REPLACE PACKAGE PKG_LOAD_FACT_REPORTS AS
    PROCEDURE sp_load_revenue_analysis;
    PROCEDURE sp_load_trip_performance;
    PROCEDURE sp_load_booking_status;
    PROCEDURE sp_run_all;
END PKG_LOAD_FACT_REPORTS;



CREATE OR REPLACE PACKAGE BODY PKG_LOAD_FACT_REPORTS AS

    -- Procedure: truncates and reloads FactRevenueAnalysis from staging; calculates gross profit by allocating tour cost proportionally by pax
    PROCEDURE sp_load_revenue_analysis IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE FactRevenueAnalysis';

        INSERT INTO FactRevenueAnalysis (
            DateKey, TourKey, CustomerKey,
            BookingCount, TotalPax, TotalRevenue, GrossProfit
        )
        SELECT
            COALESCE(dd.DateKey, -1),
            COALESCE(dt.TourKey, -1),
            COALESCE(dc.CustomerKey, -1),
            1 AS BookingCount,
            b.TotalPax AS TotalPax,
            b.TotalAmount AS TotalRevenue,
            b.TotalAmount - (
                NVL(tc.TotalTourCost, 0) / NULLIF(tp.TotalTourPax, 0) * b.TotalPax
            ) AS GrossProfit
        FROM STG_Booking b
        LEFT JOIN (
            SELECT BookingID, MIN(TourID) AS TourID
            FROM STG_BookingDetail GROUP BY BookingID
        ) bd ON b.BookingID = bd.BookingID
        LEFT JOIN (
            SELECT TourID, SUM(FeeAmount * Quantity) AS TotalTourCost
            FROM STG_CostDetail
            GROUP BY TourID
        ) tc ON bd.TourID = tc.TourID
        LEFT JOIN (
            SELECT TourID, SUM(PaxAdult + PaxChild) AS TotalTourPax
            FROM STG_BookingDetail
            GROUP BY TourID
        ) tp ON bd.TourID = tp.TourID
        LEFT JOIN DimTour dt
            ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN DimCustomer dc
            ON b.CustomerID = dc.CustomerID AND dc.IsCurrent = 'Y'
        LEFT JOIN DimDate dd
            ON dd.FullDate = b.BookingDate;

        COMMIT;
    END sp_load_revenue_analysis;


    -- Procedure: truncates and reloads FactTripPerformance from staging; aggregates pax, revenue, and cost per tour trip with its primary guide
    PROCEDURE sp_load_trip_performance IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE FactTripPerformance';
 
        INSERT INTO FactTripPerformance (
            DateKey, TourKey, GuideKey,
            DateKey, TourKey, GuideKey,
            TotalTrips, PaxPerTrip, TotalTripCost, TotalTripRev, TripProfit
        )
        SELECT
            COALESCE(dd.DateKey, -1),
            COALESCE(dt.TourKey, -1),
            COALESCE(dg.GuideKey, -1),
            1 AS TotalTrips,
            NVL(Rev.SumPax, 0)                              AS PaxPerTrip,
            NVL(Cost.SumCost, 0)                            AS TotalTripCost,
            NVL(Rev.SumAmount, 0)                           AS TotalTripRev,
            (NVL(Rev.SumAmount, 0) - NVL(Cost.SumCost, 0)) AS TripProfit
        FROM STG_Tour t
        LEFT JOIN DimTour dt ON t.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN (
            SELECT
                bd.TourID,
                SUM(bd.PaxAdult + bd.PaxChild)  AS SumPax,
                SUM(bd.SubTotalAmount)           AS SumAmount
            FROM STG_BookingDetail bd
            JOIN STG_Booking b
                ON b.BookingID = bd.BookingID
               AND b.BookingStatus NOT IN ('CANCELLED')   -- ← กรองออก
            GROUP BY bd.TourID
        ) Rev ON t.TourID = Rev.TourID
        LEFT JOIN (
            SELECT TourID,
                   MAX(GuideID)             AS MainGuideID,
                   SUM(FeeAmount * Quantity) AS SumCost
            FROM STG_CostDetail
            GROUP BY TourID
        ) Cost ON t.TourID = Cost.TourID
        LEFT JOIN DimGuide dg ON Cost.MainGuideID = dg.GuideID AND dg.IsCurrent = 'Y'
        LEFT JOIN DimDate  dd ON dd.FullDate = t.StartDate;

        COMMIT;
    END sp_load_trip_performance;
 


    -- Procedure: truncates and reloads FactBookingStatus from staging; flags each booking as cancelled (1) or active (0)
    PROCEDURE sp_load_booking_status IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE FactBookingStatus';

        INSERT INTO FactBookingStatus (
            DateKey, TourKey, BookingMetaKey, GuideKey,
            TotalBookings, CancelCount
        )
        SELECT
            COALESCE(dd.DateKey, -1),
            COALESCE(dt.TourKey, -1),
            COALESCE(db.BookingKey, -1),
            COALESCE(dg.GuideKey, -1),
            1 AS TotalBookings,
            CASE WHEN b.BookingStatus = 'CANCELLED' THEN 1 ELSE 0 END AS CancelCount
        FROM STG_Booking b
        LEFT JOIN (
            SELECT BookingID, MIN(TourID) AS TourID
            FROM STG_BookingDetail
            GROUP BY BookingID
        ) bd ON b.BookingID = bd.BookingID
        LEFT JOIN DimBooking db ON b.BookingID = db.BookingID AND db.IsCurrent = 'Y'
        LEFT JOIN DimTour dt ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN (
            SELECT TourID, MAX(GuideID) as GuideID FROM STG_CostDetail GROUP BY TourID
        ) cd ON bd.TourID = cd.TourID
        LEFT JOIN DimGuide dg ON cd.GuideID = dg.GuideID AND dg.IsCurrent = 'Y'
        LEFT JOIN DimDate dd ON dd.FullDate = b.BookingDate;

        COMMIT;
    END sp_load_booking_status;

    -- Procedure: runs all three fact table load procedures in sequence
    PROCEDURE sp_run_all IS
    BEGIN
        sp_load_revenue_analysis;
        sp_load_trip_performance;
        sp_load_booking_status;
    END sp_run_all;

END PKG_LOAD_FACT_REPORTS;


-- Execute: runs the full ETL load for all fact tables
BEGIN
    PKG_LOAD_FACT_REPORTS.sp_run_all;
END;
