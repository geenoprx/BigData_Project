-- IoT Fact tables
DELETE FROM FactIoTReading;
DELETE FROM FactTouristMovement;

-- OLTP Fact tables
DELETE FROM FactRevenueAnalysis;
DELETE FROM FactTripPerformance;
DELETE FROM FactBookingStatus;



-- IoT Staging (MongoDB-sourced transaction tables)
DELETE FROM STG_IoTAlert;
DELETE FROM STG_IoTCheckIn;
DELETE FROM STG_IoTSensorReading;
DELETE FROM STG_IoTDeviceAssignment;

-- IoT Staging (Oracle OLTP-mirrored lookup tables)
DELETE FROM STG_IoTDevice;
DELETE FROM STG_IoTLocation;
DELETE FROM STG_ReadingType;
DELETE FROM STG_IoTDeviceType;

-- OLTP Staging (detail / child tables first)
DELETE FROM STG_BookingDetail;
DELETE FROM STG_CostDetail;
DELETE FROM STG_PromotionDetail;
DELETE FROM STG_TourDetail;
DELETE FROM STG_Booking;
DELETE FROM STG_Tour;
DELETE FROM STG_ItemCost;
DELETE FROM STG_Customer;
DELETE FROM STG_Employee;
DELETE FROM STG_Guide;
DELETE FROM STG_Country;
DELETE FROM STG_Promotion;
DELETE FROM STG_TourType;
DELETE FROM STG_CostType;
DELETE FROM STG_CustomerType;
DELETE FROM STG_TourPlan;
DELETE FROM STG_Region;
DELETE FROM STG_Department;


DELETE FROM DimLocation;       -- FK → DimCountry
DELETE FROM DimReadingType;
DELETE FROM DimDevice;
DELETE FROM DimBooking;
DELETE FROM DimCustomer;
DELETE FROM DimTour;
DELETE FROM DimPromotion;
DELETE FROM DimGuide;
DELETE FROM DimItemCost;
DELETE FROM DimCountry;        -- referenced by DimLocation (cleared above)
DELETE FROM DimDate;           -- referenced by all Fact tables (cleared above)


-- 4a. Detail / child tables (deepest children first)
DELETE FROM BookingDetail;     -- FK → Booking (CASCADE), Tour
DELETE FROM CostDetail;        -- FK → Tour, Guide, ItemCost
DELETE FROM PromotionDetail;   -- FK → Promotion (CASCADE), Tour
DELETE FROM TourDetail;        -- FK → Tour (CASCADE), TourPlan (CASCADE)

-- 4b. Transactional parent tables
DELETE FROM Booking;           -- FK → Customer, Employee, Promotion

-- 4c. IoT OLTP tables (before Country)
DELETE FROM IoTDevice;         -- FK → IoTDeviceType
DELETE FROM IoTLocation;       -- FK → Country

-- 4d. Tour and related cost tables (before Country, TourType)
DELETE FROM Tour;              -- FK → TourType, Country
DELETE FROM ItemCost;          -- FK → Country, CostType

-- 4e. Customer and employee tables
DELETE FROM Customer;          -- FK → CustomerType
DELETE FROM Employee;          -- FK → Department
DELETE FROM Guide;             -- referenced by CostDetail (cleared above)

-- 4f. Master / lookup tables (no more children)
DELETE FROM Country;           -- FK → Region; referenced by Tour, ItemCost, IoTLocation (cleared above)
DELETE FROM Promotion;         -- referenced by Booking (cleared above)
DELETE FROM TourType;          -- referenced by Tour (cleared above)
DELETE FROM CostType;          -- referenced by ItemCost (cleared above)
DELETE FROM CustomerType;      -- referenced by Customer (cleared above)
DELETE FROM TourPlan;          -- referenced by TourDetail (cleared above)
DELETE FROM Region;            -- referenced by Country (cleared above)
DELETE FROM Department;        -- referenced by Employee (cleared above)

-- 4g. IoT OLTP lookup tables
DELETE FROM ReadingType;       -- referenced by staging only (cleared above)
DELETE FROM IoTDeviceType;     -- referenced by IoTDevice (cleared above)

COMMIT;


-- Truncate Data in Fact tables
TRUNCATE TABLE FactRevenueAnalysis;
TRUNCATE TABLE FactTripPerformance;
TRUNCATE TABLE FactBookingStatus;