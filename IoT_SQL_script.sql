
-- Daily Sensor Summary
-- Total readings, avg/max/min per reading type per day
SELECT
    dd.FullDate,
    dd.Year,
    dd.Month,
    dd.MonthName,
    drt.ReadingTypeName,
    drt.Unit,
    SUM(f.ReadingCount) AS TotalReadings,
    ROUND(AVG(f.AvgValue), 2) AS DailyAvgValue,
    MAX(f.MaxValue) AS DailyMaxValue,
    MIN(f.MinValue) AS DailyMinValue
FROM FactIoTReading f
JOIN DimDate        dd  ON dd.DateKey        = f.DateKey
JOIN DimReadingType drt ON drt.ReadingTypeKey = f.ReadingTypeKey
GROUP BY
    dd.FullDate, dd.Year, dd.Month, dd.MonthName,
    drt.ReadingTypeName, drt.Unit
ORDER BY
    dd.FullDate, drt.ReadingTypeName;


-- Hourly Trend by Reading Type
-- Identify peak hours for each sensor category
SELECT
    f.HourSlot,
    drt.ReadingTypeName,
    drt.Unit,
    SUM(f.ReadingCount) AS TotalReadings,
    ROUND(AVG(f.AvgValue), 2) AS HourlyAvgValue,
    MAX(f.MaxValue) AS HourlyMaxValue,
    MIN(f.MinValue) AS HourlyMinValue
FROM FactIoTReading f
JOIN DimReadingType drt ON drt.ReadingTypeKey = f.ReadingTypeKey
GROUP BY
    f.HourSlot, drt.ReadingTypeName, drt.Unit
ORDER BY
    drt.ReadingTypeName, f.HourSlot;


-- IoT Tourist Movement — Core Analysis Queries

--  Location Hotspot — Engagement & Dwell Time per Location
SELECT
    dl.LocationName,
    dl.ZoneType,
    dl.CountryName,
    SUM(f.TotalCheckIns)                        AS TotalVisits,
    ROUND(AVG(f.AvgDwellMins), 2)               AS AvgDwellMins,
    MAX(f.AvgDwellMins)                         AS MaxDwellMins,
    SUM(f.MissedCheckIns)                       AS TotalMissedCheckIns,
    ROUND(
        SUM(f.MissedCheckIns) * 100.0
        / NULLIF(SUM(f.TotalCheckIns) + SUM(f.MissedCheckIns), 0)
    , 2)                                        AS MissedCheckInPct
FROM FactTouristMovement f
JOIN DimLocation dl ON dl.LocationKey = f.LocationKey
GROUP BY
    dl.LocationName, dl.ZoneType, dl.CountryName
ORDER BY
    TotalVisits DESC, AvgDwellMins DESC;


-- Tour Participation Quality Summary
SELECT
    dt.TourCode,
    dt.Name AS TourName,
    dt.TourTypeName,
    dt.DestinationCountryName,
    dt.CapacityPax,
    SUM(f.TotalCheckIns) AS TotalCheckIns,
    SUM(f.MissedCheckIns) AS TotalMissedCheckIns,
    ROUND(AVG(f.AvgDwellMins), 2) AS AvgDwellMins,
    ROUND(
        SUM(f.MissedCheckIns) * 100.0 / NULLIF(SUM(f.TotalCheckIns) + SUM(f.MissedCheckIns), 0), 2) AS MissedCheckInPct,
    RANK() OVER (
        ORDER BY SUM(f.MissedCheckIns) * 100.0 / NULLIF(SUM(f.TotalCheckIns) + SUM(f.MissedCheckIns), 0) ASC) AS EngagementRank
FROM FactTouristMovement f
JOIN DimTour dt ON dt.TourKey = f.TourKey
GROUP BY
    dt.TourCode, dt.Name, dt.TourTypeName,
    dt.DestinationCountryName, dt.CapacityPax
ORDER BY
    EngagementRank;


