--Department
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D001', 'IT Support', 10);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D002', 'Human Resource', 5);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D003', 'Accounting', 8);

--Employee
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status) VALUES ('E0001', 'Somchai', 'Jaidee', 'Manager', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'D001', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status) VALUES ('E0002', 'Somsak', 'Rakthai', 'Programmer', TO_DATE('2021-05-01', 'YYYY-MM-DD'), 'D001', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status) VALUES ('E0003', 'Manee', 'Meena', 'HR Officer', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 'D002', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status) VALUES ('E0004', 'Mana', 'Jaihan', 'Accountant', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'D003', 'A');

--TourPlan
INSERT INTO TourPlan (TourPlanID, Name, Description) VALUES ('TPJP6D01', 'JP 6D Tokyo-Osaka Sakura', 'Japan Tour 6 Days Tokyo-Osaka Sakura Season');
INSERT INTO TourPlan (TourPlanID, Name, Description) VALUES ('TPJP6D02', 'JP 6D Tokyo-Osaka Autumn', 'Japan Tour 6 Days Tokyo-Osaka Autumn Leaves');
INSERT INTO TourPlan (TourPlanID, Name, Description) VALUES ('TPCNX3D1', 'TH 3D Chiangmai Highlight', 'Chiang Mai 3 Days 2 Nights Doi Inthanon-Temples');
INSERT INTO TourPlan (TourPlanID, Name, Description) VALUES ('TPSG4D01', 'SG 4D Free & Easy', 'Singapore 4 Days Flight+Hotel Free & Easy');
INSERT INTO TourPlan (TourPlanID, Name, Description) VALUES ('TPKR5D01', 'KR 5D Seoul-Jeju', 'Korea 5 Days Seoul-Jeju Shopping+Nature');

--TourType
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag) VALUES ('TTDOM01', 'Domestic Pkg', 'Domestic Group Tour with Guide', 5900, 3, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag) VALUES ('TTINT01', 'Intl Short', 'International Short Haul Tour 4-6 Days', 29900, 6, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag) VALUES ('TTFNE01', 'Free', 'Flight+Hotel Package Free & Easy', 19900, 4, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag) VALUES ('TTINC01', 'Incentive', 'Corporate Incentive Tour', 15000, 3, 'N');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag) VALUES ('TTINT02', 'Intl Medium', 'International Medium Haul Tour 7-8 Days', 39900, 7, 'Y');

--Region
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG001', 'East Asia', 'East Asian countries (JP, KR, CN)');
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG002', 'ASEAN', 'Southeast Asian countries (TH, SG, VN)');
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG003', 'Europe', 'European countries');
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG004', 'Americas', 'North and South America');

--Country
INSERT INTO Country (CountryID, Name, Description, RegionID) VALUES ('CTY001', 'Thailand', 'Routes in Thailand', 'REG002');
INSERT INTO Country (CountryID, Name, Description, RegionID) VALUES ('CTY002', 'Japan', 'Routes in Japan Tokyo-Osaka', 'REG001');
INSERT INTO Country (CountryID, Name, Description, RegionID) VALUES ('CTY003', 'Korea', 'Routes in Seoul-Busan/Jeju', 'REG001');
INSERT INTO Country (CountryID, Name, Description, RegionID) VALUES ('CTY004', 'Singapore', 'Routes in Singapore', 'REG002');
INSERT INTO Country (CountryID, Name, Description, RegionID) VALUES ('CTY005', 'Vietnam', 'Routes in Hanoi-Ho Chi Minh', 'REG002');

--Tour
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID) 
VALUES ('T0001', 'JP-6D-TKS-01', 'TTINT01', 'JP Tokyo-Osaka', 30, DATE '2026-03-25', DATE '2026-03-30', 'OPEN', 'CTY002');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID) 
VALUES ('T0002', 'JP-6D-TKS-02', 'TTINT01', 'JP Tokyo-Osaka', 30, DATE '2026-04-10', DATE '2026-04-15', 'OPEN', 'CTY002');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID) 
VALUES ('T0003', 'TH-3D-CNX-01', 'TTDOM01', 'CNX Highlight', 25, DATE '2026-02-20', DATE '2026-02-22', 'CLOSED', 'CTY001');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID) 
VALUES ('T0004', 'SG-4D-FE-01', 'TTFNE01', 'SG FreeEzy', 20, DATE '2026-05-01', DATE '2026-05-04', 'OPEN', 'CTY004');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID) 
VALUES ('T0005', 'KR-5D-SJ-01', 'TTINT01', 'KR Seoul-Jeju', 32, DATE '2026-06-10', DATE '2026-06-14', 'OPEN', 'CTY003');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID) 
VALUES ('T0006', 'INC-3D-TH-01', 'TTINC01', 'Incentive TH', 40, DATE '2026-07-05', DATE '2026-07-07', 'DRAFT', 'CTY001');

--Promotion
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status) VALUES ('PRM0001', 'Early Bird 60 Days', 2, 0, DATE '2026-01-01', DATE '2026-03-31', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status) VALUES ('PRM0002', 'Group 10+ Discount', 10, 0, DATE '2026-01-01', DATE '2026-12-31', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status) VALUES ('PRM0003', 'New Year Flash Sale', 1, 50, DATE '2026-12-20', DATE '2026-12-31', 'PLANNED');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status) VALUES ('PRM0004', 'Repeat Cust Voucher', 1, 20, DATE '2026-02-01', DATE '2026-06-30', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status) VALUES ('PRM0005', 'Low Season Special', 2, 0, DATE '2026-05-01', DATE '2026-09-30', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status) VALUES ('PRM0006', 'Credit Card Bank X', 1, 0, DATE '2026-03-01', DATE '2026-08-31', 'ACTIVE');

--CostType
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT001', 'Hotel', 'Accommodation cost per night');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT002', 'Transport', 'Van / Bus / Coach cost');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT003', 'Meal', 'Food cost per meal');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT004', 'Attraction', 'Attraction entrance fee / Ticket');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT005', 'Guide', 'Local guide fee per day');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT006', 'Ground Operator', 'Ground operator service fee per group');

--ItemCost
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status) VALUES ('IC0001', 'CT001', 'CTY002', 'Tokyo Hotel Twin', 'sales@tokyohotel3.jp', 6500, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status) VALUES ('IC0002', 'CT002', 'CTY002', 'Coach 40 seats Tokyo', 'reserve@tokyobus.jp', 28000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status) VALUES ('IC0003', 'CT003', 'CTY002', 'Japanese set dinner', 'ops@localrest.jp', 950, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status) VALUES ('IC0004', 'CT004', 'CTY002', 'Fuji-Hakone pass', 'ticket@mtfujipass.jp', 3200, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status) VALUES ('IC0005', 'CT002', 'CTY001', '9 seats Chiangmai full day', 'booking@cmvan.th', 3500, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status) VALUES ('IC0006', 'CT006', 'CTY002', 'Japan handling fee /group', 'contract@jpground.jp', 18000, 'A');

--Guide
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary) VALUES ('G0001', 'Tanaka Hiroshi', 'tanaka.guide@jp.com', '1901111111', 'JP,EN', 'Tokyo city tour, culture', 'AVAILABLE', 15000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary) VALUES ('G0002', 'Sato Yumi', 'yumi.sato@jp.com', '1902222222', 'JP,EN,TH', 'Shopping, family group', 'AVAILABLE', 20000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary) VALUES ('G0003', 'Somchai Phumjai', 'somchai.guide@th.com', '6611234567', 'TH,EN', 'Northern region, Nature, Temples', 'AVAILABLE', 15000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary) VALUES ('G0004', 'Kim Minseo', 'minseo.kim@kr.com', '8107777777', 'KR,EN', 'Seoul city, K-pop', 'BUSY', 20000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary) VALUES ('G0005', 'Lim Wei', 'wei.lim@sg.com', '6591234567', 'EN,ZH', 'Singapore highlight, food', 'AVAILABLE', 20000);

--CustomerType
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM01', 'Individual', 0);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM02', 'Family', 3.0);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM03', 'Corporate', 5.0);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM04', 'Travel Agent', 8.0);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM05', 'VIP', 10.0);

--Customer
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB) VALUES ('CUS00001', 'CTM01', 'John Anderson', '+1-555-0101', '123 Maple Avenue, Springfield, IL, USA', 'A12345678', 'American', DATE '1980-05-15');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB) VALUES ('CUS00002', 'CTM02', 'Emma Charlotte', '+44-20-7946-0958', '45 Baker Street, London, UK', 'B98765432', 'British', DATE '1985-08-22');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB) VALUES ('CUS00003', 'CTM01', 'Liam O''Connor', '+353-1-234-5678', '88 Grafton St, Dublin, Ireland', 'C11223344', 'Irish', DATE '1992-11-30');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB) VALUES ('CUS00004', 'CTM03', 'Akira Tanaka', '+81-3-1234-5678', '1-1 Chiyoda, Tokyo, Japan', 'J55667788', 'Japanese', DATE '1978-03-10');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB) VALUES ('CUS00005', 'CTM03', 'Sofia Rodriguez', '+34-91-123-4567', 'Gran Via 22, Madrid, Spain', 'S99887766', 'Spanish', DATE '1988-07-19');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB) VALUES ('CUS00006', 'CTM04', 'Chen Wei', '+86-10-8888-8888', 'No. 5 Dongchang''an Ave, Beijing, China', 'C44332211', 'Chinese', DATE '1995-12-05');

--Booking
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount) VALUES ('BK0001', 'CUS00001', 'PRM0001', 'E0001', DATE '2024-03-15', 'CONFIRMED', 'PAID', 'CARD', 3, 4500.00);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount) VALUES ('BK0002', 'CUS00002', 'PRM0004', 'E0002', DATE '2024-04-01', 'COMPLETED', 'PAID', 'TRANSFER', 2, 5000.00);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount) VALUES ('BK0003', 'CUS00003', 'PRM0003', 'E0001', DATE '2024-05-20', 'PENDING', 'UNPAID', 'E-WALLET', 1, 1200.00);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount) VALUES ('BK0004', 'CUS00004', 'PRM0002', 'E0003', DATE '2024-02-10', 'CONFIRMED', 'PARTIAL', 'TRANSFER', 6, 20400.00);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount) VALUES ('BK0005', 'CUS00005', 'PRM0004', 'E0002', DATE '2024-08-01', 'CANCELLED', 'REFUNDED', 'CARD', 1, 1300.00);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount) VALUES ('BK0006', 'CUS00001', 'PRM0001', 'E0003', DATE '2024-09-05', 'CONFIRMED', 'PAID', 'CASH', 2, 3200.00);
