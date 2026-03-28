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

    -- Procedure: merges FactRevenueAnalysis from staging; inserts new grain rows and updates measures on existing ones — no rows are ever deleted (Non-volatile)
    PROCEDURE sp_load_revenue_analysis IS
    BEGIN
        MERGE INTO FactRevenueAnalysis t
        USING (
            SELECT
                COALESCE(dd.DateKey, -1)                                        AS DateKey,
                COALESCE(dt.TourKey, -1)                                        AS TourKey,
                COALESCE(dc.CustomerKey, -1)                                    AS CustomerKey,
                COUNT(*)                                                        AS BookingCount,
                SUM(b.TotalPax)                                                 AS TotalPax,
                SUM(b.TotalAmount)                                              AS TotalRevenue,
                SUM(b.TotalAmount - (
                    NVL(tc.TotalTourCost, 0) / NULLIF(tp.TotalTourPax, 0) * b.TotalPax
                ))                                                              AS GrossProfit
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
                ON dd.FullDate = b.BookingDate
            GROUP BY COALESCE(dd.DateKey, -1), COALESCE(dt.TourKey, -1), COALESCE(dc.CustomerKey, -1)
        ) s
        ON (t.DateKey = s.DateKey AND t.TourKey = s.TourKey AND t.CustomerKey = s.CustomerKey)
        WHEN MATCHED THEN UPDATE SET
            t.BookingCount  = s.BookingCount,
            t.TotalPax      = s.TotalPax,
            t.TotalRevenue  = s.TotalRevenue,
            t.GrossProfit   = s.GrossProfit
        WHEN NOT MATCHED THEN INSERT (
            DateKey, TourKey, CustomerKey,
            BookingCount, TotalPax, TotalRevenue, GrossProfit
        ) VALUES (
            s.DateKey, s.TourKey, s.CustomerKey,
            s.BookingCount, s.TotalPax, s.TotalRevenue, s.GrossProfit
        );

    END sp_load_revenue_analysis;


    -- Procedure: merges FactTripPerformance from staging; inserts new grain rows and updates measures on existing ones — no rows are ever deleted (Non-volatile)
    PROCEDURE sp_load_trip_performance IS
    BEGIN
        MERGE INTO FactTripPerformance t
        USING (
            SELECT
                COALESCE(dd.DateKey, -1)                                    AS DateKey,
                COALESCE(dt.TourKey, -1)                                    AS TourKey,
                COALESCE(dg.GuideKey, -1)                                   AS GuideKey,
                COUNT(*)                                                    AS TotalTrips,
                SUM(NVL(Rev.SumPax, 0))                                    AS PaxPerTrip,
                SUM(NVL(Cost.SumCost, 0))                                  AS TotalTripCost,
                SUM(NVL(Rev.SumAmount, 0))                                 AS TotalTripRev,
                SUM(NVL(Rev.SumAmount, 0) - NVL(Cost.SumCost, 0))         AS TripProfit
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
                   AND b.BookingStatus NOT IN ('CANCELLED')
                GROUP BY bd.TourID
            ) Rev ON t.TourID = Rev.TourID
            LEFT JOIN (
                SELECT TourID,
                       MAX(GuideID)              AS MainGuideID,
                       SUM(FeeAmount * Quantity)  AS SumCost
                FROM STG_CostDetail
                GROUP BY TourID
            ) Cost ON t.TourID = Cost.TourID
            LEFT JOIN DimGuide dg ON Cost.MainGuideID = dg.GuideID AND dg.IsCurrent = 'Y'
            LEFT JOIN DimDate  dd ON dd.FullDate = t.StartDate
            GROUP BY COALESCE(dd.DateKey, -1), COALESCE(dt.TourKey, -1), COALESCE(dg.GuideKey, -1)
        ) s
        ON (t.DateKey = s.DateKey AND t.TourKey = s.TourKey AND t.GuideKey = s.GuideKey)
        WHEN MATCHED THEN UPDATE SET
            t.TotalTrips    = s.TotalTrips,
            t.PaxPerTrip    = s.PaxPerTrip,
            t.TotalTripCost = s.TotalTripCost,
            t.TotalTripRev  = s.TotalTripRev,
            t.TripProfit    = s.TripProfit
        WHEN NOT MATCHED THEN INSERT (
            DateKey, TourKey, GuideKey,
            TotalTrips, PaxPerTrip, TotalTripCost, TotalTripRev, TripProfit
        ) VALUES (
            s.DateKey, s.TourKey, s.GuideKey,
            s.TotalTrips, s.PaxPerTrip, s.TotalTripCost, s.TotalTripRev, s.TripProfit
        );

    END sp_load_trip_performance;
 


    -- Procedure: merges FactBookingStatus from staging; inserts new grain rows and updates measures on existing ones — no rows are ever deleted (Non-volatile)
    PROCEDURE sp_load_booking_status IS
    BEGIN
        MERGE INTO FactBookingStatus t
        USING (
            SELECT
                COALESCE(dd.DateKey, -1)                                            AS DateKey,
                COALESCE(dt.TourKey, -1)                                            AS TourKey,
                COALESCE(db.BookingKey, -1)                                         AS BookingMetaKey,
                COALESCE(dg.GuideKey, -1)                                           AS GuideKey,
                COUNT(*)                                                            AS TotalBookings,
                SUM(CASE WHEN b.BookingStatus = 'CANCELLED' THEN 1 ELSE 0 END)     AS CancelCount
            FROM STG_Booking b
            LEFT JOIN (
                SELECT BookingID, MIN(TourID) AS TourID
                FROM STG_BookingDetail
                GROUP BY BookingID
            ) bd ON b.BookingID = bd.BookingID
            LEFT JOIN DimBooking db ON b.BookingID = db.BookingID AND db.IsCurrent = 'Y'
            LEFT JOIN DimTour dt ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
            LEFT JOIN (
                SELECT TourID, MAX(GuideID) AS GuideID FROM STG_CostDetail GROUP BY TourID
            ) cd ON bd.TourID = cd.TourID
            LEFT JOIN DimGuide dg ON cd.GuideID = dg.GuideID AND dg.IsCurrent = 'Y'
            LEFT JOIN DimDate dd ON dd.FullDate = b.BookingDate
            GROUP BY COALESCE(dd.DateKey, -1), COALESCE(dt.TourKey, -1), COALESCE(db.BookingKey, -1), COALESCE(dg.GuideKey, -1)
        ) s
        ON (t.DateKey = s.DateKey AND t.TourKey = s.TourKey AND t.BookingMetaKey = s.BookingMetaKey AND t.GuideKey = s.GuideKey)
        WHEN MATCHED THEN UPDATE SET
            t.TotalBookings = s.TotalBookings,
            t.CancelCount   = s.CancelCount
        WHEN NOT MATCHED THEN INSERT (
            DateKey, TourKey, BookingMetaKey, GuideKey,
            TotalBookings, CancelCount
        ) VALUES (
            s.DateKey, s.TourKey, s.BookingMetaKey, s.GuideKey,
            s.TotalBookings, s.CancelCount
        );

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
