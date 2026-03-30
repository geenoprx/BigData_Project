-- Tour Profitability Ranking
-- Which tours are making us the most money?
SELECT
    dt.TourCode,
    dt.Name                                         AS TourName,
    dt.DestinationCountryName                       AS Destination,
    dt.DurationDays,
    COUNT(ftp.FactID)                               AS TotalTripsRun,
    SUM(ftp.PaxPerTrip)                             AS TotalPassengers,
    ROUND(AVG(ftp.PaxPerTrip), 1)                   AS AvgPaxPerTrip,
    dt.CapacityPax,
    ROUND(AVG(ftp.PaxPerTrip) / NULLIF(dt.CapacityPax, 0) * 100, 1)
                                                    AS AvgFillRate_Pct,
    ROUND(SUM(ftp.TotalTripRev), 2)                 AS TotalRevenue,
    ROUND(SUM(ftp.TotalTripCost), 2)                AS TotalCost,
    ROUND(SUM(ftp.TripProfit), 2)                   AS TotalProfit,
    ROUND(SUM(ftp.TripProfit) / NULLIF(SUM(ftp.TotalTripRev), 0) * 100, 1)
                                                    AS ProfitMargin_Pct
FROM FactTripPerformance ftp
JOIN DimTour dt ON ftp.TourKey = dt.TourKey
GROUP BY
    dt.TourCode, dt.Name, dt.DestinationCountryName,
    dt.DurationDays, dt.CapacityPax
ORDER BY TotalProfit DESC;


-- Guide Performance Leaderboard
-- Which guides run the most profitable trips?
SELECT
    dg.GuideName,
    dg.GuideSpecialty,
    dg.languageskills,
    COUNT(ftp.FactID)                               AS TotalTripsLed,
    SUM(ftp.PaxPerTrip)                             AS TotalPassengersServed,
    ROUND(SUM(ftp.TotalTripRev), 2)                 AS TotalRevenue,
    ROUND(SUM(ftp.TotalTripCost), 2)                AS TotalCost,
    ROUND(SUM(ftp.TripProfit), 2)                   AS TotalProfit,
    ROUND(SUM(ftp.TripProfit) / NULLIF(SUM(ftp.TotalTripRev), 0) * 100, 1)
                                                    AS ProfitMargin_Pct,
    ROUND(AVG(ftp.TripProfit), 2)                   AS AvgProfitPerTrip
FROM FactTripPerformance ftp
JOIN DimGuide dg ON ftp.GuideKey = dg.GuideKey
GROUP BY
    dg.GuideName, dg.GuideSpecialty, dg.languageskills
ORDER BY TotalProfit DESC;


-- Monthly Revenue & Profit Trend
-- Is our business growing month over month?
SELECT
    dd.Year,
    dd.Month,
    dd.MonthName,
    COUNT(fra.FactID)                               AS TotalBookings,
    SUM(fra.TotalPax)                               AS TotalPassengers,
    ROUND(SUM(fra.TotalRevenue), 2)                 AS TotalRevenue,
    ROUND(SUM(fra.GrossProfit), 2)                  AS TotalGrossProfit,
    ROUND(SUM(fra.GrossProfit) / NULLIF(SUM(fra.TotalRevenue), 0) * 100, 1)
                                                    AS GrossMargin_Pct,
    ROUND(AVG(fra.TotalRevenue), 2)                 AS AvgRevenuePerBooking,
    ROUND(AVG(fra.GrossProfit), 2)                  AS AvgProfitPerBooking
FROM FactRevenueAnalysis fra
JOIN DimDate dd ON fra.DateKey = dd.DateKey
GROUP BY
    dd.Year, dd.Month, dd.MonthName
ORDER BY
    dd.Year, dd.Month;


-- Promotion ROI Analysis
-- Are our discounts actually worth it?
-- Compares profit margin between promoted vs. non-promoted bookings.
SELECT
    NVL(dp.Name, '(No Promotion)')                 AS PromotionName,
    NVL(TO_CHAR(dp.DiscountValue) || '%', '-')      AS DiscountRate,
    dp.minPax                                       AS MinPaxRequired,
    COUNT(fra.FactID)                               AS TotalBookings,
    SUM(fra.TotalPax)                               AS TotalPassengers,
    ROUND(SUM(fra.TotalRevenue), 2)                 AS TotalRevenue,
    ROUND(SUM(fra.GrossProfit), 2)                  AS TotalGrossProfit,
    ROUND(SUM(fra.GrossProfit) / NULLIF(SUM(fra.TotalRevenue), 0) * 100, 1)
                                                    AS GrossMargin_Pct,
    ROUND(AVG(fra.TotalRevenue), 2)                 AS AvgRevenuePerBooking
FROM FactRevenueAnalysis fra
LEFT JOIN DimPromotion dp ON fra.PromotionKey = dp.PromotionKey
GROUP BY
    dp.Name, dp.DiscountValue, dp.minPax
ORDER BY TotalRevenue DESC;


-- Cancellation Rate by Tour
-- Which tours have the worst cancellation problem?
SELECT
    dt.TourCode,
    dt.Name                                         AS TourName,
    dt.DestinationCountryName                       AS Destination,
    COUNT(fbs.FactID)                               AS TotalBookings,
    SUM(fbs.CancelCount)                            AS TotalCancellations,
    ROUND(SUM(fbs.CancelCount) / NULLIF(COUNT(fbs.FactID), 0) * 100, 1)
                                                    AS CancelRate_Pct,
    COUNT(fbs.FactID) - SUM(fbs.CancelCount)        AS ConfirmedBookings
FROM FactBookingStatus fbs
JOIN DimTour dt ON fbs.TourKey = dt.TourKey
GROUP BY
    dt.TourCode, dt.Name, dt.DestinationCountryName
ORDER BY CancelRate_Pct DESC;


-- Monthly Cancellation Trendc
-- Is our cancellation rate getting better or worse over time?
SELECT
    dd.Year,
    dd.Month,
    dd.MonthName,
    COUNT(fbs.FactID)                               AS TotalBookings,
    SUM(fbs.CancelCount)                            AS TotalCancellations,
    COUNT(fbs.FactID) - SUM(fbs.CancelCount)        AS ConfirmedBookings,
    ROUND(SUM(fbs.CancelCount) / NULLIF(COUNT(fbs.FactID), 0) * 100, 1)
                                                    AS CancelRate_Pct
FROM FactBookingStatus fbs
JOIN DimDate dd ON fbs.DateKey = dd.DateKey
GROUP BY
    dd.Year, dd.Month, dd.MonthName
ORDER BY
    dd.Year, dd.Month;
