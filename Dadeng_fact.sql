-- Grain: 1 row per booking | Tracks revenue, pax, and gross profit
CREATE TABLE FactRevenueAnalysis (
    FactID          NUMBER PRIMARY KEY,
    DateKey         NUMBER,          -- Booking date
    TourKey         NUMBER,          -- Tour package
    CustomerKey     NUMBER,          -- Customer
    PromotionKey    NUMBER,          -- Applied promotion (NULL if none)

    BookingCount    NUMBER,          -- Always 1 (one row = one booking)
    TotalPax        NUMBER,          -- Number of passengers
    TotalRevenue    NUMBER(12,2),    -- Net booking amount
    GrossProfit     NUMBER(12,2),    -- Revenue - Cost

    CONSTRAINT FK_Rev_Date  FOREIGN KEY (DateKey)      REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Rev_Tour  FOREIGN KEY (TourKey)      REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Rev_Cust  FOREIGN KEY (CustomerKey)  REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT FK_Rev_Promo FOREIGN KEY (PromotionKey) REFERENCES DimPromotion(PromotionKey)
);

CREATE SEQUENCE SEQ_FactRevenueAnalysis START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_FactRevenueAnalysis_BI
BEFORE INSERT ON FactRevenueAnalysis
FOR EACH ROW
BEGIN
    IF :NEW.FactID IS NULL THEN
        SELECT SEQ_FactRevenueAnalysis.NEXTVAL INTO :NEW.FactID FROM DUAL;
    END IF;
END;
/

-- Grain: 1 row per tour | Tracks cost, revenue, and profit per trip
CREATE TABLE FactTripPerformance (
    FactID          NUMBER PRIMARY KEY,
    DateKey         NUMBER,          -- Tour start date
    TourKey         NUMBER,          -- Tour package
    GuideKey        NUMBER,          -- Assigned guide

    TotalTrips      NUMBER,          -- Always 1 (one row = one tour)
    PaxPerTrip      NUMBER,          -- Total passengers on this tour
    TotalTripCost   NUMBER(12,2),    -- Sum of all cost items (CostDetail)
    TotalTripRev    NUMBER(12,2),    -- Revenue from non-cancelled bookings
    TripProfit      NUMBER(12,2),    -- TotalTripRev - TotalTripCost

    CONSTRAINT FK_Trip_Date  FOREIGN KEY (DateKey)  REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Trip_Tour  FOREIGN KEY (TourKey)  REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Trip_Guide FOREIGN KEY (GuideKey) REFERENCES DimGuide(GuideKey)
);

CREATE SEQUENCE SEQ_FactTripPerformance START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_FactTripPerformance_BI
BEFORE INSERT ON FactTripPerformance
FOR EACH ROW
BEGIN
    IF :NEW.FactID IS NULL THEN
        SELECT SEQ_FactTripPerformance.NEXTVAL INTO :NEW.FactID FROM DUAL;
    END IF;
END;
/

-- Grain: 1 row per booking | Tracks booking status and cancellation
CREATE TABLE FactBookingStatus (
    FactID          NUMBER PRIMARY KEY,
    DateKey         NUMBER,          -- Booking date
    TourKey         NUMBER,          -- Tour package
    BookingMetaKey  NUMBER,          -- Links to DimBooking for status details
    GuideKey        NUMBER,          -- Assigned guide

    TotalBookings   NUMBER,          -- Always 1 (one row = one booking)
    CancelCount     NUMBER,          -- 1 if cancelled, 0 otherwise

    CONSTRAINT FK_Stat_Date  FOREIGN KEY (DateKey)        REFERENCES DimDate(DateKey),
    CONSTRAINT FK_Stat_Tour  FOREIGN KEY (TourKey)        REFERENCES DimTour(TourKey),
    CONSTRAINT FK_Stat_Meta  FOREIGN KEY (BookingMetaKey) REFERENCES DimBooking(BookingKey),
    CONSTRAINT FK_Stat_Guide FOREIGN KEY (GuideKey)       REFERENCES DimGuide(GuideKey)
);

CREATE SEQUENCE SEQ_FactBookingStatus START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_FactBookingStatus_BI
BEFORE INSERT ON FactBookingStatus
FOR EACH ROW
BEGIN
    IF :NEW.FactID IS NULL THEN
        SELECT SEQ_FactBookingStatus.NEXTVAL INTO :NEW.FactID FROM DUAL;
    END IF;
END;
/


-- Package declaration
CREATE OR REPLACE PACKAGE PKG_LOAD_FACT_REPORTS AS
    PROCEDURE sp_load_revenue_analysis;
    PROCEDURE sp_load_trip_performance;
    PROCEDURE sp_load_booking_status;
    PROCEDURE sp_run_all;
END PKG_LOAD_FACT_REPORTS;
/


CREATE OR REPLACE PACKAGE BODY PKG_LOAD_FACT_REPORTS AS
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
            1          AS BookingCount,
            b.TotalPax AS TotalPax,
            b.TotalAmount AS TotalRevenue,
            -- Proportional cost allocation: booking's pax share of total tour cost
            b.TotalAmount
                - (NVL(tc.TourCost, 0) * (b.TotalPax / NULLIF(tp.TourTotalPax, 0)))
                AS GrossProfit

        FROM STG_Booking b
        LEFT JOIN (
            -- One primary TourID per booking
            SELECT BookingID, MIN(TourID) AS TourID
            FROM STG_BookingDetail
            GROUP BY BookingID
        ) bd ON b.BookingID = bd.BookingID
        LEFT JOIN DimTour dt
            ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN DimCustomer dc
            ON b.CustomerID = dc.CustomerID AND dc.IsCurrent = 'Y'
        LEFT JOIN DimDate dd
            ON dd.FullDate = b.BookingDate
        LEFT JOIN DimPromotion dp
            ON b.PromotionID = dp.PromotionID AND dp.IsCurrent = 'Y'
        LEFT JOIN (
            -- Total cost of the tour from all cost line items
            SELECT TourID, SUM(FeeAmount * Quantity) AS TourCost
            FROM STG_CostDetail
            GROUP BY TourID
        ) tc ON bd.TourID = tc.TourID
        LEFT JOIN (
            -- Total pax on the tour across all bookings (used as the denominator)
            SELECT TourID, SUM(PaxAdult + PaxChild) AS TourTotalPax
            FROM STG_BookingDetail
            GROUP BY TourID
        ) tp ON bd.TourID = tp.TourID

        WHERE dd.DateKey > v_last_date_key;

        COMMIT;
    END sp_load_revenue_analysis;


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
            1                                               AS TotalTrips,
            NVL(Rev.SumPax,    0)                           AS PaxPerTrip,
            NVL(Cost.SumCost,  0)                           AS TotalTripCost,
            NVL(Rev.SumAmount, 0)                           AS TotalTripRev,
            NVL(Rev.SumAmount, 0) - NVL(Cost.SumCost, 0)   AS TripProfit

        FROM STG_Tour t

        LEFT JOIN DimDate dd
            ON dd.FullDate = t.StartDate
        LEFT JOIN DimTour dt
            ON t.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN (
            -- Revenue: sum pax and amount from non-cancelled bookings only
            SELECT bd.TourID,
                   SUM(bd.PaxAdult + bd.PaxChild) AS SumPax,
                   SUM(b.TotalAmount)              AS SumAmount
            FROM STG_BookingDetail bd
            JOIN STG_Booking b
                ON b.BookingID = bd.BookingID
               AND b.BookingStatus NOT IN ('CANCELLED')
            GROUP BY bd.TourID
        ) Rev ON t.TourID = Rev.TourID
        LEFT JOIN (
            -- Guide: pick one guide per tour
            SELECT TourID, MAX(GuideID) AS MainGuideID
            FROM STG_CostDetail
            WHERE GuideID IS NOT NULL
            GROUP BY TourID
        ) Guide ON t.TourID = Guide.TourID
        LEFT JOIN (
            -- Cost: sum all cost line items regardless of type
            SELECT TourID, SUM(FeeAmount * Quantity) AS SumCost
            FROM STG_CostDetail
            GROUP BY TourID
        ) Cost ON t.TourID = Cost.TourID
        LEFT JOIN DimGuide dg
            ON Guide.MainGuideID = dg.GuideID AND dg.IsCurrent = 'Y'

        WHERE dd.DateKey > v_last_date_key;

        COMMIT;
    END sp_load_trip_performance;

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
            -- One primary TourID per booking
            SELECT BookingID, MIN(TourID) AS TourID
            FROM STG_BookingDetail
            GROUP BY BookingID
        ) bd ON b.BookingID = bd.BookingID
        LEFT JOIN DimBooking db
            ON b.BookingID = db.BookingID AND db.IsCurrent = 'Y'
        LEFT JOIN DimTour dt
            ON bd.TourID = dt.TourID AND dt.IsCurrent = 'Y'
        LEFT JOIN (
            -- Guide: pick one guide per tour
            SELECT TourID, MAX(GuideID) AS GuideID
            FROM STG_CostDetail
            WHERE GuideID IS NOT NULL
            GROUP BY TourID
        ) cd ON bd.TourID = cd.TourID
        LEFT JOIN DimGuide dg
            ON cd.GuideID = dg.GuideID AND dg.IsCurrent = 'Y'
        LEFT JOIN DimDate dd
            ON dd.FullDate = b.BookingDate

        WHERE dd.DateKey > v_last_date_key;

        COMMIT;
    END sp_load_booking_status;


    -- Runs all three load procedures in sequence
    PROCEDURE sp_run_all IS
    BEGIN
        sp_load_revenue_analysis;
        sp_load_trip_performance;
        sp_load_booking_status;
    END sp_run_all;

END PKG_LOAD_FACT_REPORTS;
/


BEGIN
    PKG_LOAD_FACT_REPORTS.sp_run_all;
END;
/
