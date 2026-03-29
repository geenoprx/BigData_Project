SET DEFINE OFF;

-- -------------------------------------------------------
-- Department
-- -------------------------------------------------------
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D001', 'Sales & Marketing', 8);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D002', 'Tour Operation',    6);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D003', 'Accounting',        4);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D004', 'Human Resource',    3);

-- -------------------------------------------------------
-- Employee
-- -------------------------------------------------------
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0001', 'Somchai',   'Jaidee',    'Sales Manager',       TO_DATE('2019-03-01','YYYY-MM-DD'), 'D001', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0002', 'Nattaya',   'Srisuk',    'Sales Executive',     TO_DATE('2021-06-15','YYYY-MM-DD'), 'D001', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0003', 'Piyaporn',  'Meena',     'Tour Coordinator',    TO_DATE('2020-08-01','YYYY-MM-DD'), 'D002', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0004', 'Wanchai',   'Rattana',   'Operation Supervisor',TO_DATE('2018-05-10','YYYY-MM-DD'), 'D002', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, ResignDate, DeptCode, Status)
  VALUES ('E0005', 'Malee',     'Jaihan',    'Accountant',          TO_DATE('2020-01-15','YYYY-MM-DD'),
          TO_DATE('2024-12-31','YYYY-MM-DD'), 'D003', 'R');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0006', 'Thanaporn', 'Sukjai',    'Accountant',          TO_DATE('2025-01-10','YYYY-MM-DD'), 'D003', 'A');

-- -------------------------------------------------------
-- TourPlan
-- -------------------------------------------------------
INSERT INTO TourPlan (TourPlanID, Name, Description)
  VALUES ('TPJP6D01', 'JP 6D Tokyo-Osaka Sakura',
          'Japan 6D5N Tokyo-Hakone-Osaka, Sakura Season Mar-Apr');
INSERT INTO TourPlan (TourPlanID, Name, Description)
  VALUES ('TPJP6D02', 'JP 6D Tokyo-Osaka Autumn',
          'Japan 6D5N Tokyo-Nikko-Osaka, Autumn Leaves Oct-Nov');
INSERT INTO TourPlan (TourPlanID, Name, Description)
  VALUES ('TPCNX3D1', 'TH 3D Chiang Mai Highlight',
          'Chiang Mai 3D2N Doi Inthanon-Doi Suthep-Warorot Market');
INSERT INTO TourPlan (TourPlanID, Name, Description)
  VALUES ('TPSG4D01', 'SG 4D Free & Easy',
          'Singapore 4D3N Flight+Hotel, USS Sentosa, Free & Easy');
INSERT INTO TourPlan (TourPlanID, Name, Description)
  VALUES ('TPKR5D01', 'KR 5D Seoul-Jeju',
          'Korea 5D4N Seoul-Jeju, Palace-K-pop-Nature');

-- -------------------------------------------------------
-- TourType
-- -------------------------------------------------------
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTDOM01', 'Domestic Package',  'กรุ๊ปทัวร์ในประเทศพร้อมไกด์',          5900,  3, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTINT01', 'Intl Short Haul',   'ทัวร์ต่างประเทศระยะใกล้ 4-6 วัน',      29900, 6, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTFNE01', 'Free & Easy',       'แพ็กเกจตั๋ว+โรงแรม อิสระท่องเที่ยว',  19900, 4, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTINC01', 'Incentive Tour',    'ทัวร์ Incentive สำหรับองค์กร',          15000, 3, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTINT02', 'Intl Medium Haul',  'ทัวร์ต่างประเทศระยะกลาง 7-8 วัน',     39900, 7, 'Y');

-- -------------------------------------------------------
-- Region
-- -------------------------------------------------------
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG001', 'East Asia',  'ญี่ปุ่น เกาหลี จีน');
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG002', 'ASEAN',      'ไทย สิงคโปร์ เวียดนาม มาเลเซีย');
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG003', 'Europe',     'ยุโรปตะวันตกและตะวันออก');
INSERT INTO Region (RegionID, Name, Description) VALUES ('REG004', 'Americas',   'อเมริกาเหนือและใต้');

-- -------------------------------------------------------
-- Country
-- -------------------------------------------------------
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY001', 'Thailand',   'เส้นทางในไทย (BKK, CNX, HKT, KBI)',   'REG002');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY002', 'Japan',      'เส้นทางญี่ปุ่น (TYO, OSA, NGO, FUK)', 'REG001');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY003', 'Korea',      'เส้นทางเกาหลี (SEL, CJU, PUS)',        'REG001');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY004', 'Singapore',  'เส้นทางสิงคโปร์ (SIN)',                'REG002');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY005', 'Vietnam',    'เส้นทางเวียดนาม (HAN, SGN, DAD)',      'REG002');

-- -------------------------------------------------------
-- CostType
-- -------------------------------------------------------
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT001', 'Hotel',           'ค่าที่พักต่อห้องต่อคืน');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT002', 'Transport',       'ค่ารถโค้ช/รถตู้/รถไฟ');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT003', 'Meal',            'ค่าอาหารต่อที่/มื้อ');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT004', 'Attraction',      'ค่าบัตรเข้าสถานที่/กิจกรรม');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT005', 'Guide Fee',       'ค่าไกด์ท้องถิ่นต่อวัน');
INSERT INTO CostType (CostTypeID, Name, Description) VALUES ('CT006', 'Ground Operator', 'ค่า Ground Operator ต่อกรุ๊ป');

-- -------------------------------------------------------
-- ItemCost — Japan (CTY002)
-- -------------------------------------------------------
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0001', 'CT001', 'CTY002', 'Tokyo Business Hotel (Twin)',        'sales@tokyohotel3.jp',  6500,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0002', 'CT002', 'CTY002', 'Coach 40 seats Japan (per day)',     'reserve@tokyobus.jp',   28000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0003', 'CT003', 'CTY002', 'Japanese Set Meal (per person)',     'ops@localrest.jp',      950,   'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0004', 'CT004', 'CTY002', 'Fuji-Hakone 1-Day Pass',             'ticket@mtfujipass.jp',  3200,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0005', 'CT005', 'CTY002', 'Japan Local Guide (per day)',        'guide@jpstaff.jp',      15000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0006', 'CT006', 'CTY002', 'Japan Ground Operator (per group)', 'contract@jpground.jp',  18000, 'A');

-- ItemCost — Thailand / Chiang Mai (CTY001)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0007', 'CT001', 'CTY001', 'Chiang Mai 4* Hotel (Twin)',         'rsvn@cmhotel.th',       2800,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0008', 'CT002', 'CTY001', 'Van 9 seats Chiang Mai (per day)',   'booking@cmvan.th',      3500,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0009', 'CT003', 'CTY001', 'Thai Set Meal CNX (per person)',     'ops@cmlocalfood.th',    400,   'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0010', 'CT004', 'CTY001', 'Doi Inthanon Park Entrance',         'doi@dnp.th',            300,   'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0011', 'CT005', 'CTY001', 'Thai Local Guide CNX (per day)',     'guide@cntourism.th',    3500,  'A');

-- ItemCost — Thailand / Bangkok Incentive (CTY001)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0012', 'CT001', 'CTY001', 'Bangkok 5* Hotel Incentive (Twin)', 'incentive@tarag.th',    9500,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0013', 'CT002', 'CTY001', 'VIP Coach 45 seats Bangkok (per day)','ops@vipcoach.th',     35000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0014', 'CT003', 'CTY001', 'Gala Dinner BKK (per person)',       'banquet@cegrand.th',   1800,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0015', 'CT004', 'CTY001', 'Wat Phra Kaew Entrance (per person)','ticket@finearts.th',   500,   'A');

-- ItemCost — Singapore (CTY004)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0016', 'CT001', 'CTY004', 'Singapore 4* Hotel (Twin)',                  'rsvn@sghotel.com.sg',    7200,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0017', 'CT002', 'CTY004', 'Coach SG (per day)',                          'ops@sgbus.com.sg',       22000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0018', 'CT003', 'CTY004', 'Meal SG (per person per meal)',               'ops@restaurant.sg',      750,   'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0019', 'CT004', 'CTY004', 'Universal Studios Singapore (per person)',    'ticket@uss.com.sg',      3200,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0020', 'CT005', 'CTY004', 'Singapore Local Guide (per day)',             'guide@stb.com.sg',       4000,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0021', 'CT006', 'CTY004', 'Singapore Ground Operator (per group)',       'contract@ground.sg',     18000, 'A');

-- ItemCost — Korea (CTY003)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0022', 'CT001', 'CTY003', 'Seoul Business Hotel (Twin)',                'rsvn@seoulhotel.kr',     5500,  'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0023', 'CT002', 'CTY003', 'Coach KR (per day)',                          'ops@krbus.kr',           26000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0024', 'CT003', 'CTY003', 'Korean Set Meal (per person)',                'ops@krfood.kr',          900,   'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0025', 'CT004', 'CTY003', 'Songsan Ichulbong Entrance (per person)',     'ticket@seongsan.kr',     800,   'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0026', 'CT005', 'CTY003', 'Korea Local Guide (per day)',                'guide@visitkorea.kr',    5000,  'A');

-- -------------------------------------------------------
-- Guide
-- -------------------------------------------------------
INSERT INTO Guide (GuideID, Name, Email, LanguageSkills, Phone, Specialty, Salary, Status)
  VALUES ('G0001', 'Tanaka Hiroshi', 'tanaka.guide@jp.com', 'JP,EN',
          '+81-90-1111-2222', 'Tokyo city tour, Temples, Culture', 15000, 'AVAILABLE');
INSERT INTO Guide (GuideID, Name, Email, LanguageSkills, Phone, Specialty, Salary, Status)
  VALUES ('G0002', 'Sato Yumi', 'yumi.sato@jp.com', 'JP,EN,TH',
          '+81-90-2222-3333', 'Shopping, Family group, Osaka area', 15000, 'AVAILABLE');
INSERT INTO Guide (GuideID, Name, Email, LanguageSkills, Phone, Specialty, Salary, Status)
  VALUES ('G0003', 'Somchai Phumjai', 'somchai.guide@th.com', 'TH,EN',
          '+66-81-234-5678', 'Northern Thailand, Nature, Temples', 3500, 'AVAILABLE');
INSERT INTO Guide (GuideID, Name, Email, LanguageSkills, Phone, Specialty, Salary, Status)
  VALUES ('G0004', 'Kim Minseo', 'minseo.kim@kr.com', 'KR,EN',
          '+82-10-7777-8888', 'Seoul city, K-pop, Jeju Island', 5000, 'BUSY');
INSERT INTO Guide (GuideID, Name, Email, LanguageSkills, Phone, Specialty, Salary, Status)
  VALUES ('G0005', 'Lim Wei', 'wei.lim@sg.com', 'EN,ZH,MS',
          '+65-9123-4567', 'Singapore highlights, Food tour, Sentosa', 4000, 'AVAILABLE');

-- -------------------------------------------------------
-- CustomerType
-- -------------------------------------------------------
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM01', 'Individual',   0.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM02', 'Family',        3.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM03', 'Corporate',     5.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM04', 'Travel Agent',  8.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM05', 'VIP Member',   10.00);

-- -------------------------------------------------------
-- Customer
-- -------------------------------------------------------
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00001', 'CTM01', 'John Anderson',        '+1-555-0101',        '123 Maple Avenue, Springfield, IL 62701, USA',      'A12345678', 'American',    TO_DATE('1980-05-15','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00002', 'CTM02', 'Emma Charlotte Davies','+44-20-7946-0958',   '45 Baker Street, Marylebone, London W1U 8EW, UK',   'B98765432', 'British',     TO_DATE('1985-08-22','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00003', 'CTM01', 'Liam O''Connor',       '+353-1-234-5678',    '88 Grafton Street, Dublin 2, D02 ET79, Ireland',    'C11223344', 'Irish',       TO_DATE('1992-11-30','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00004', 'CTM03', 'Akira Tanaka',          '+81-3-1234-5678',   '1-1 Chiyoda, Chiyoda-ku, Tokyo 100-0001, Japan',    'JP5566778', 'Japanese',    TO_DATE('1978-03-10','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00005', 'CTM03', 'Sofia Rodriguez',       '+34-91-123-4567',   'Gran Via 22, 4to piso, 28013 Madrid, Spain',        'S99887766', 'Spanish',     TO_DATE('1988-07-19','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00006', 'CTM04', 'Chen Wei',               '+86-10-8888-8888', 'No. 5 Dongchangan Avenue, Dongcheng, Beijing 100741','G44332211', 'Chinese',    TO_DATE('1995-12-05','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00007', 'CTM05', 'Priya Sharma',           '+91-98-1234-5678', '12 Vasant Vihar, New Delhi 110057, India',          'P77665544', 'Indian',      TO_DATE('1975-04-20','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00008', 'CTM02', 'James & Linda Wilson',  '+61-2-9876-5432',   '9 Wallaby Way, Sydney NSW 2000, Australia',         'AU1122334', 'Australian',  TO_DATE('1982-09-08','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00009', 'CTM01', 'Michael Johnson',        '+1-312-555-0192',  '456 Oak Street, Chicago, IL 60601, USA',            'A87654321', 'American',    TO_DATE('1990-03-22','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00010', 'CTM01', 'Yuki Nakamura',          '+81-90-3456-7890', '2-5 Shinjuku, Shinjuku-ku, Tokyo, Japan',           'JP9988776', 'Japanese',    TO_DATE('1987-11-05','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00011', 'CTM01', 'Marie Dupont',           '+33-1-4567-8901',  '15 Rue de Rivoli, 75001 Paris, France',             'FR3344556', 'French',      TO_DATE('1983-06-18','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00012', 'CTM01', 'Ahmad Al-Rashid',        '+971-50-123-4567', 'Al Wasl Road, Dubai, UAE',                          'AE7766554', 'Emirati',     TO_DATE('1979-09-30','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00013', 'CTM01', 'Ngo Thi Lan',            '+84-90-234-5678',  '45 Hang Bai, Hoan Kiem, Hanoi, Vietnam',            'VN5544332', 'Vietnamese',  TO_DATE('1995-02-14','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00014', 'CTM01', 'Carlos Mendez',          '+52-55-1234-5678', 'Av. Insurgentes 1234, CDMX 06600, Mexico',          'MX2233445', 'Mexican',     TO_DATE('1988-07-25','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00015', 'CTM01', 'Siti Rahayu',            '+62-21-555-6789',  'Jl. Sudirman 88, Jakarta 10220, Indonesia',         'ID6677889', 'Indonesian',  TO_DATE('1992-12-03','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00016', 'CTM02', 'David & Sarah Park',    '+82-10-9876-5432',  '123 Gangnam-daero, Seoul 06253, Korea',             'KR1122334', 'Korean',      TO_DATE('1981-04-17','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00017', 'CTM02', 'Roberto Bianchi',        '+39-02-1234-5678', 'Via Roma 55, 20121 Milano, Italy',                  'IT4455667', 'Italian',     TO_DATE('1975-08-09','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00018', 'CTM02', 'Tan Ah Kow',             '+65-9234-5678',    '10 Orchard Road, Singapore 238826',                 'SG8899001', 'Singaporean', TO_DATE('1970-01-28','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00019', 'CTM02', 'Hans Mueller',           '+49-89-1234-5678', 'Marienplatz 1, 80331 Munich, Germany',              'DE2345678', 'German',      TO_DATE('1968-05-14','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00020', 'CTM03', 'Sunita Patel',           '+91-22-6789-0123', 'Nariman Point, Mumbai 400021, India',               'IN3456789', 'Indian',      TO_DATE('1980-10-22','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00021', 'CTM03', 'Kevin O''Brien',         '+353-1-987-6543',  '10 Nassau Street, Dublin 2, Ireland',               'IE4567890', 'Irish',       TO_DATE('1977-03-31','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00022', 'CTM03', 'Fatima Al-Zahra',        '+966-50-987-6543', 'King Fahd Road, Riyadh 12345, Saudi Arabia',        'SA5678901', 'Saudi',       TO_DATE('1985-11-19','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00023', 'CTM03', 'Wang Fang',              '+86-21-8888-9999', '168 Nanjing Road, Shanghai 200001, China',          'G12345678', 'Chinese',     TO_DATE('1991-07-07','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00024', 'CTM04', 'Rachel Green',           '+61-3-9876-5432',  '200 Collins Street, Melbourne VIC 3000, AUS',       'AU9988776', 'Australian',  TO_DATE('1986-09-15','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00025', 'CTM04', 'Lars Eriksson',          '+46-8-1234-5678',  'Kungsgatan 10, 111 43 Stockholm, Sweden',           'SE7766554', 'Swedish',     TO_DATE('1973-12-08','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00026', 'CTM04', 'Amira Khalil',           '+20-2-2345-6789',  '26 July Street, Cairo 11511, Egypt',                'EG6655443', 'Egyptian',    TO_DATE('1989-04-02','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00027', 'CTM05', 'William Tang',           '+852-9876-5432',   '1 Harbour Road, Wan Chai, Hong Kong',               'HK5544332', 'Hong Konger', TO_DATE('1965-06-20','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00028', 'CTM05', 'Isabella Ferrari',       '+39-06-9876-5432', 'Via Veneto 100, 00187 Roma, Italy',                 'IT9988001', 'Italian',     TO_DATE('1978-02-11','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00029', 'CTM05', 'Hiroshi Yamamoto',       '+81-3-5678-9012',  '1-1 Marunouchi, Chiyoda, Tokyo, Japan',             'JP1234560', 'Japanese',    TO_DATE('1962-08-30','YYYY-MM-DD'));
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00030', 'CTM05', 'Patricia Vance',         '+1-212-555-0198',  '88 Park Avenue, New York, NY 10016, USA',           'A11223344', 'American',    TO_DATE('1970-11-25','YYYY-MM-DD'));

-- -------------------------------------------------------
-- Promotion
-- -------------------------------------------------------
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0001', 'Early Bird 60 Days',  2,  0, TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'), 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0002', 'Group 10+ Discount', 10,  0, TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'), 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0003', 'New Year Flash Sale', 1, 15, TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'), 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0004', 'Repeat Cust Voucher', 1,  5, TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'), 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0005', 'Low Season Special',  2, 10, TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0006', 'Credit Card Bank X',  1,  5, TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'), 'ACTIVE');

-- -------------------------------------------------------
-- Tour
-- -------------------------------------------------------
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0001', 'JP-INT-SAK-2603', 'TTINT01', 'Japan Tokyo-Osaka Sakura 6D5N',    30,
          TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 'OPEN',   'CTY002');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0002', 'JP-INT-AUT-2604', 'TTINT01', 'Japan Tokyo-Osaka Autumn 6D5N',    30,
          TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 'OPEN',   'CTY002');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0003', 'TH-DOM-CNX-2602', 'TTDOM01', 'Chiang Mai Highlight 3D2N',        25,
          TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 'CLOSED', 'CTY001');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0004', 'SG-FNE-FE-2605',  'TTFNE01', 'Singapore Free & Easy 4D3N',      20,
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 'OPEN',   'CTY004');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0005', 'KR-INT-SJ-2606',  'TTINT01', 'Korea Seoul-Jeju 6D5N',            32,
          TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-15','YYYY-MM-DD'), 'OPEN',   'CTY003');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0006', 'TH-INC-BKK-2607', 'TTINC01', 'Bangkok Incentive Program 3D2N',  40,
          TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 'DRAFT',  'CTY001');

-- -------------------------------------------------------
-- Booking  (TotalPax / TotalAmount = placeholder 1;
--            sp_booking_add_detail will recalculate)
-- -------------------------------------------------------
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0001', 'CUS00001', 'PRM0001', 'E0001', TO_DATE('2026-01-10','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0002', 'CUS00002', 'PRM0004', 'E0002', TO_DATE('2026-01-25','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0003', 'CUS00003', 'PRM0003', 'E0001', TO_DATE('2026-02-15','YYYY-MM-DD'), 'PENDING',   'UNPAID',  'E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0004', 'CUS00004', 'PRM0002', 'E0003', TO_DATE('2026-01-20','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0005', 'CUS00005', 'PRM0004', 'E0002', TO_DATE('2026-02-01','YYYY-MM-DD'), 'CANCELLED', 'REFUNDED','CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0006', 'CUS00001', 'PRM0001', 'E0001', TO_DATE('2026-02-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0007', 'CUS00007', 'PRM0006', 'E0002', TO_DATE('2026-03-10','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0008', 'CUS00006', NULL,       'E0003', TO_DATE('2026-03-20','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0009', 'CUS00009', 'PRM0001', 'E0002', TO_DATE('2026-01-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0010', 'CUS00010', NULL,       'E0001', TO_DATE('2026-02-10','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0011', 'CUS00016', 'PRM0002', 'E0002', TO_DATE('2026-01-15','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0012', 'CUS00027', 'PRM0006', 'E0001', TO_DATE('2026-03-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0013', 'CUS00020', NULL,       'E0003', TO_DATE('2026-02-20','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0014', 'CUS00011', 'PRM0004', 'E0002', TO_DATE('2026-02-01','YYYY-MM-DD'), 'CANCELLED', 'REFUNDED','E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0015', 'CUS00029', 'PRM0001', 'E0001', TO_DATE('2026-01-08','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CASH',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0016', 'CUS00011', 'PRM0001', 'E0002', TO_DATE('2026-01-20','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0017', 'CUS00017', NULL,       'E0003', TO_DATE('2026-02-15','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0018', 'CUS00028', 'PRM0006', 'E0001', TO_DATE('2026-03-01','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0019', 'CUS00022', 'PRM0002', 'E0003', TO_DATE('2026-02-10','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0020', 'CUS00025', 'PRM0004', 'E0002', TO_DATE('2026-01-28','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0021', 'CUS00014', 'PRM0003', 'E0001', TO_DATE('2026-02-25','YYYY-MM-DD'), 'CANCELLED', 'REFUNDED','E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0022', 'CUS00030', 'PRM0001', 'E0002', TO_DATE('2026-01-12','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0023', 'CUS00013', NULL,       'E0002', TO_DATE('2026-01-10','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0024', 'CUS00015', 'PRM0003', 'E0003', TO_DATE('2026-01-15','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0025', 'CUS00019', 'PRM0002', 'E0001', TO_DATE('2026-01-20','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0026', 'CUS00026', 'PRM0004', 'E0002', TO_DATE('2026-01-25','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0027', 'CUS00012', NULL,       'E0003', TO_DATE('2026-02-01','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0028', 'CUS00018', NULL,       'E0002', TO_DATE('2026-02-20','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0029', 'CUS00013', NULL,       'E0001', TO_DATE('2026-03-01','YYYY-MM-DD'), 'CONFIRMED', 'UNPAID',  'E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0030', 'CUS00024', 'PRM0004', 'E0003', TO_DATE('2026-03-10','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0031', 'CUS00021', NULL,       'E0002', TO_DATE('2026-02-28','YYYY-MM-DD'), 'CANCELLED', 'REFUNDED','CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0032', 'CUS00016', 'PRM0001', 'E0002', TO_DATE('2026-03-15','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0033', 'CUS00023', 'PRM0002', 'E0001', TO_DATE('2026-03-20','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0034', 'CUS00010', 'PRM0003', 'E0003', TO_DATE('2026-03-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0035', 'CUS00025', 'PRM0006', 'E0002', TO_DATE('2026-03-18','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0036', 'CUS00029', NULL,       'E0001', TO_DATE('2026-04-01','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CASH',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0037', 'CUS00009', NULL,       'E0003', TO_DATE('2026-03-25','YYYY-MM-DD'), 'CANCELLED', 'REFUNDED','E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0038', 'CUS00020', 'PRM0002', 'E0002', TO_DATE('2026-03-12','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0039', 'CUS00022', 'PRM0002', 'E0003', TO_DATE('2026-04-10','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0040', 'CUS00023', 'PRM0002', 'E0001', TO_DATE('2026-04-15','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0041', 'CUS00027', 'PRM0006', 'E0002', TO_DATE('2026-04-20','YYYY-MM-DD'), 'PENDING',   'UNPAID',  'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0042', 'CUS00030', NULL,       'E0001', TO_DATE('2026-04-25','YYYY-MM-DD'), 'PENDING',   'UNPAID',  'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0043', 'CUS00014', 'PRM0004', 'E0002', TO_DATE('2026-02-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0044', 'CUS00017', 'PRM0001', 'E0001', TO_DATE('2026-01-18','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0045', 'CUS00024', NULL,       'E0003', TO_DATE('2026-02-12','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0046', 'CUS00026', 'PRM0006', 'E0002', TO_DATE('2026-03-08','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0047', 'CUS00015', 'PRM0004', 'E0001', TO_DATE('2026-02-20','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0048', 'CUS00026', NULL,       'E0003', TO_DATE('2026-03-15','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0049', 'CUS00020', 'PRM0003', 'E0002', TO_DATE('2026-01-30','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0050', 'CUS00021', NULL,       'E0001', TO_DATE('2026-02-05','YYYY-MM-DD'), 'COMPLETED', 'PAID',    'CASH',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0051', 'CUS00019', NULL,       'E0003', TO_DATE('2026-03-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0052', 'CUS00014', 'PRM0003', 'E0002', TO_DATE('2026-03-18','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0053', 'CUS00020', 'PRM0002', 'E0001', TO_DATE('2026-04-28','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0054', 'CUS00021', 'PRM0002', 'E0003', TO_DATE('2026-05-02','YYYY-MM-DD'), 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0055', 'CUS00028', NULL,       'E0002', TO_DATE('2026-05-05','YYYY-MM-DD'), 'CONFIRMED', 'PAID',    'CARD',     1, 1);

COMMIT;

-- -------------------------------------------------------
-- TourDetail  (DayNo auto-incremented by TRG_TourDetail_DayNo)
-- -------------------------------------------------------
-- T0001 : Japan Tokyo-Osaka Sakura 6D5N
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0001', NULL, 'TPJP6D01', 'Day 1 : กรุงเทพฯ → โตเกียว (นาริตะ)',
          'เหินฟ้าสู่กรุงโตเกียว สนามบินนาริตะ รับกระเป๋า → เดินทางเข้าที่พัก รับประทานอาหารเย็นเมนูชาบูชาบู',
          'D', 'Narita Excel Hotel Tokyu', 'TG 660 BKK-NRT 23:55 / Airport Limousine Bus');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0001', NULL, 'TPJP6D01', 'Day 2 : โตเกียว City Tour + ซากุระอุเอโนะ',
          'วัดอาซากุสะ → สะพาน Nakamise → สวนอุเอโนะชมซากุระ → โตเกียวสกายทรี (ชั้น 350) → ชิบูยะ Crossing',
          'B,L,D', 'Sunshine City Prince Hotel', 'รถโค้ช 40 ที่นั่ง');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0001', NULL, 'TPJP6D01', 'Day 3 : ฟูจิ-ฮาโกเน่',
          'ทะเลสาบคาวากุจิโกะ (วิวฟูจิ+ซากุระ) → กระเช้า Owakudani → ล่องเรืออาชิโนะโกะ → Gotemba Outlet',
          'B,L', 'Hakone Kowaki-en Hotel', 'รถโค้ช 40 ที่นั่ง / กระเช้าลอยฟ้า');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0001', NULL, 'TPJP6D01', 'Day 4 : โตเกียว อิสระช้อปปิ้ง',
          'อิสระทั้งวัน แนะนำ: ชินจูกุ / ฮาราจูกุ / อากิฮาบาระ / อาเมโยโกะ ตามอัธยาศัย',
          'B', 'Sunshine City Prince Hotel', 'อิสระ (แนะนำ JR Pass / Tokyo Metro)');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0001', NULL, 'TPJP6D01', 'Day 5 : โตเกียว → โอซาก้า (ชินกันเซ็น)',
          'นั่งชินกันเซ็น Nozomi สู่โอซาก้า → ปราสาทโอซาก้า → โดทงโบริ → ชินไซบาชิ ช้อปปิ้ง',
          'B,D', 'Cross Hotel Osaka', 'Shinkansen Nozomi TYO-OSA ~2h30m');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0001', NULL, 'TPJP6D01', 'Day 6 : โอซาก้า → กรุงเทพฯ',
          'อิสระช้อปปิ้งย่านชินไซบาชิ → เดินทางสู่สนามบิน Kansai → เหินฟ้ากลับกรุงเทพฯ',
          'B', '(เครื่องบิน)', 'TG 665 KIX-BKK 13:00 ถึง 17:00');

-- T0002 : Japan Tokyo-Osaka Autumn 6D5N
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0002', NULL, 'TPJP6D02', 'Day 1 : กรุงเทพฯ → โตเกียว (นาริตะ)',
          'เหินฟ้าสู่โตเกียว → เข้าที่พักนาริตะ → อาหารเย็นเมนูยากินิกุ',
          'D', 'Narita Excel Hotel Tokyu', 'TG 660 BKK-NRT / Airport Limousine Bus');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0002', NULL, 'TPJP6D02', 'Day 2 : โตเกียว Autumn City Tour',
          'ศาลเจ้าเมจิ → ฮาราจูกุ (Takeshita Street) → โอโมเตะซันโด → ชมใบไม้แดง Shinjuku Gyoen',
          'B,L,D', 'Shinjuku Washington Hotel', 'รถโค้ช 40 ที่นั่ง');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0002', NULL, 'TPJP6D02', 'Day 3 : คาวากุจิโกะ + Kachi-Kachi Ropeway',
          'ทะเลสาบคาวากุจิโกะ → นั่งกระเช้า Kachi-Kachi ชมวิวฟูจิ → ช้อปปิ้งของที่ระลึกริมทะเลสาบ',
          'B,L', 'Fuji View Hotel', 'รถโค้ช 40 ที่นั่ง / กระเช้า');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0002', NULL, 'TPJP6D02', 'Day 4 : นิกโก้ มรดกโลก',
          'ศาลเจ้า Toshogu (มรดกโลก UNESCO) → น้ำตก Kegon → ทะเลสาบ Chuzenji → กลับโตเกียว',
          'B,L', 'Shinjuku Washington Hotel', 'รถโค้ช 40 ที่นั่ง (ทางด่วน Nikko)');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0002', NULL, 'TPJP6D02', 'Day 5 : โตเกียว → โอซาก้า + ปราสาท',
          'นั่งชินกันเซ็น Nozomi → ปราสาทโอซาก้า → โดทงโบริล่องเรือ → ชินไซบาชิ',
          'B,D', 'Cross Hotel Osaka', 'Shinkansen Nozomi ~2h30m');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0002', NULL, 'TPJP6D02', 'Day 6 : โอซาก้า → กรุงเทพฯ',
          'ช้อปปิ้ง Rinku Premium Outlet → สนามบิน Kansai → บินกลับกรุงเทพฯ',
          'B', '(เครื่องบิน)', 'TG 665 KIX-BKK');

-- T0003 : Chiang Mai Highlight 3D2N
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0003', NULL, 'TPCNX3D1', 'Day 1 : กรุงเทพฯ → เชียงใหม่',
          'รับสนามบินเชียงใหม่ → วัดพระธาตุดอยสุเทพ (วิวเมือง) → ถนนคนเดินท่าแพ ช้อปปิ้ง',
          'L,D', 'Le Meridien Chiang Mai', 'FD 3026 BKK-CNX 07:30 / รถตู้ 9 ที่นั่ง');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0003', NULL, 'TPCNX3D1', 'Day 2 : ดอยอินทนนท์ ยอดดอยสูงสุดในไทย',
          'ยอดดอยอินทนนท์ (2,565 ม.) → พระมหาธาตุนภเมทนีดล → น้ำตกแม่กลาง → กลับเชียงใหม่',
          'B,L', 'Le Meridien Chiang Mai', 'รถตู้ 9 ที่นั่ง (ออก 07:00)');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0003', NULL, 'TPCNX3D1', 'Day 3 : ตลาดวโรรส → กรุงเทพฯ',
          'ช้อปปิ้งของฝากตลาดวโรรส (กาดหลวง) → ของดีเชียงใหม่ → สนามบินเชียงใหม่ → บินกลับ',
          'B', '(เครื่องบิน)', 'FD 3025 CNX-BKK 18:45');

-- T0004 : Singapore Free & Easy 4D3N
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0004', NULL, 'TPSG4D01', 'Day 1 : กรุงเทพฯ → สิงคโปร์',
          'บินสู่สิงคโปร์ → รับกระเป๋า Changi T3 → Marina Bay Sands (ถ่ายรูป) → Merlion Park → อาหารเย็น Chilli Crab ริมอ่าว',
          'D', 'Park Royal Collection Marina Bay', 'SQ 971 BKK-SIN 08:45 / Coach');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0004', NULL, 'TPSG4D01', 'Day 2 : Sentosa Island เต็มวัน',
          'Universal Studios Singapore (1 วันเต็ม) → S.E.A. Aquarium → ชายหาด Palawan → กลับโรงแรม',
          'B', 'Park Royal Collection Marina Bay', 'Coach → Sentosa Express Monorail');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0004', NULL, 'TPSG4D01', 'Day 3 : อิสระเต็มวัน (Free & Easy)',
          'อิสระทั้งวัน แนะนำ: Orchard Road / Gardens by the Bay (ค่ำ) / Chinatown / Little India / Clarke Quay',
          'B', 'Park Royal Collection Marina Bay', 'MRT ด้วยตัวเอง (EZ-Link Card)');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0004', NULL, 'TPSG4D01', 'Day 4 : ช้อปปิ้ง Mustafa → กรุงเทพฯ',
          'ช้อปปิ้ง Mustafa Centre (ห้างเปิด 24 ชม.) → ส่งสนามบิน Changi → เหินฟ้ากลับกรุงเทพฯ',
          'B', '(เครื่องบิน)', 'SQ 974 SIN-BKK 20:30');

-- T0005 : Korea Seoul-Jeju 5D4N
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0005', NULL, 'TPKR5D01', 'Day 1 : กรุงเทพฯ → โซล (อินชอน)',
          'เหินฟ้าสู่เกาหลี → สนามบินอินชอน → เดินทางเข้าโซล → Namsan Tower (ชมวิวยามค่ำคืน) → Myeongdong',
          'D', 'Lotte City Hotel Myeongdong', 'OZ 741 BKK-ICN 09:30 / AREX + Coach');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0005', NULL, 'TPKR5D01', 'Day 2 : โซล City Tour + ช้อปปิ้ง',
          'พระราชวัง Gyeongbokgung + เปลี่ยนเครื่องแต่งกาย Hanbok → Bukchon Hanok Village → Insadong → Myeongdong ช้อปปิ้ง',
          'B,L', 'Lotte City Hotel Myeongdong', 'รถโค้ช 45 ที่นั่ง');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0005', NULL, 'TPKR5D01', 'Day 3 : โซล → เกาะเชจู (บินภายใน)',
          'บินภายในสู่เกาะเชจู → Yongduam Dragon Rock → Hallasan National Park ศูนย์บริการ → ตลาดเช้าเชจู',
          'B,D', 'Ramada by Wyndham Jeju City', '7C 901 GMP-CJU 10:00 / Coach');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0005', NULL, 'TPKR5D01', 'Day 4 : ไฮไลต์เกาะเชจู',
          'Seongsan Ilchulbong (ปล่องภูเขาไฟมรดกโลก) → Jeju Folk Village → Duty Free Shopping → Korean BBQ อาหารเย็น',
          'B,L,D', 'Ramada by Wyndham Jeju City', 'รถโค้ช');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0005', NULL, 'TPKR5D01', 'Day 5 : เชจู → โซล → กรุงเทพฯ',
          'บินกลับโซล (อินชอน) → พักรอเชื่อมต่อ → เหินฟ้ากลับกรุงเทพฯ ถึงปลอดภัย',
          'B', '(เครื่องบิน)', '7C 902 CJU-ICN 13:00 → OZ 742 ICN-BKK 17:30');

-- T0006 : Bangkok Incentive Program 3D2N
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0006', NULL, 'TPCNX3D1', 'Day 1 : รับคณะ + Opening & Welcome Dinner',
          'รับคณะสนามบินสุวรรณภูมิ → ลงทะเบียน Check-in → Opening Ceremony & Company Briefing → Welcome Gala Dinner ริมสระ',
          'L,D', 'Centara Grand Bangkok Convention Centre', 'รถโค้ช VIP 45 ที่นั่ง');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0006', NULL, 'TPCNX3D1', 'Day 2 : Team Building + Chao Phraya Cruise + Gala Dinner',
          'กิจกรรม Outdoor Team Building (ครึ่งวันเช้า) → พักกลางวัน → ล่องเรือเจ้าพระยา (Sunset Cruise) → Gala Dinner พิธีมอบรางวัล Award Ceremony',
          'B,L,D', 'Centara Grand Bangkok Convention Centre', 'รถโค้ช VIP / เรือ Chao Phraya');
INSERT INTO TourDetail (TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote)
  VALUES ('T0006', NULL, 'TPCNX3D1', 'Day 3 : วัดพระแก้ว + Emporium + ส่งสนามบิน',
          'วัดพระแก้ว-วัดโพธิ์ (half day) → ช้อปปิ้ง Emporium / Terminal 21 → ส่งสนามบินสุวรรณภูมิตามเที่ยวบิน',
          'B,L', '(เครื่องบิน)', 'รถโค้ช VIP 45 ที่นั่ง');

COMMIT;

-- -------------------------------------------------------
-- CostDetail  (SeqNo auto-incremented by TRG_CostDetail_SeqNo)
-- -------------------------------------------------------
-- T0001 : JP Tokyo-Osaka Sakura 6D5N
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0001', NULL, NULL,    'IC0001', 6500,  45,  'Hotel 5คืน 9ห้อง (26pax/3คน) Narita+Tokyo+Osaka',
          TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0001', NULL, NULL,    'IC0002', 28000, 6,   'รถโค้ช 40ที่นั่ง เหมา 6วัน',
          TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0001', NULL, 'G0001', 'IC0005', 15000, 6,   'ค่าไกด์ Tanaka Hiroshi 6วัน',
          TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0001', NULL, NULL,    'IC0006', 18000, 1,   'Japan Ground Operator fee (per group)',
          TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0001', NULL, 'G0001', 'IC0003', 950,   234, 'อาหาร 9มื้อ × 26pax (D,B,L,D,B,L,B,B,D,B)',
          TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0001', NULL, NULL,    'IC0004', 3200,  26,  'Fuji-Hakone 1-Day Pass × 26pax (Day3)',
          TO_DATE('2026-03-27','YYYY-MM-DD'), TO_DATE('2026-03-27','YYYY-MM-DD'));

-- T0002 : JP Tokyo-Osaka Autumn 6D5N
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, NULL,    'IC0001', 6500,  45,  'Hotel 5คืน 9ห้อง (25pax/3คน) Narita+Shinjuku+Osaka',
          TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, NULL,    'IC0002', 28000, 6,   'รถโค้ช 40ที่นั่ง เหมา 6วัน',
          TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, 'G0002', 'IC0005', 15000, 6,   'ค่าไกด์ Sato Yumi 6วัน',
          TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, NULL,    'IC0006', 18000, 1,   'Japan Ground Operator fee',
          TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, 'G0002', 'IC0003', 950,   250, 'อาหาร 10มื้อ × 25pax (D,B,L,D,B,L,B,L,B,D,B)',
          TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, NULL,    'IC0004', 1100,  25,  'Kachi-Kachi Ropeway × 25pax (Day3)',
          TO_DATE('2026-04-12','YYYY-MM-DD'), TO_DATE('2026-04-12','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0002', NULL, NULL,    'IC0004', 1300,  25,  'Nikko Toshogu entrance × 25pax (Day4)',
          TO_DATE('2026-04-13','YYYY-MM-DD'), TO_DATE('2026-04-13','YYYY-MM-DD'));

-- T0003 : CNX Highlight 3D2N
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0003', NULL, 'G0003', 'IC0008', 3500,  4,   'รถตู้ 9ที่นั่ง 2คัน × 2วัน (19pax)',
          TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-21','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0003', NULL, NULL,    'IC0007', 2800,  20,  'Hotel CNX 2คืน 10ห้อง (19pax/2คน)',
          TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0003', NULL, 'G0003', 'IC0011', 3500,  3,   'ค่าไกด์ Somchai Phumjai 3วัน',
          TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0003', NULL, 'G0003', 'IC0009', 400,   95,  'อาหาร 5มื้อ × 19pax (Day1=L,D Day2=B,L Day3=B)',
          TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0003', NULL, NULL,    'IC0010', 300,   19,  'ค่าเข้าอุทยานดอยอินทนนท์ × 19pax (Day2)',
          TO_DATE('2026-02-21','YYYY-MM-DD'), TO_DATE('2026-02-21','YYYY-MM-DD'));

-- T0004 : SG Free & Easy 4D3N
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0004', NULL, NULL,    'IC0016', 7200,  27,  'Hotel SG 3คืน 9ห้อง (17pax/2คน)',
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0004', NULL, NULL,    'IC0017', 22000, 3,   'รถโค้ช SG 3วัน (Day1 airport-in, Day2 Sentosa, Day4 airport-out)',
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0004', NULL, 'G0005', 'IC0020', 4000,  2,   'ค่าไกด์ Lim Wei 2วัน (Day1 orientation + Day2 Sentosa)',
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0004', NULL, NULL,    'IC0021', 18000, 1,   'Singapore Ground Operator handling fee',
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0004', NULL, 'G0005', 'IC0018', 750,   68,  'อาหาร 4มื้อ × 17pax (Day1=D, Day2-4=B)',
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0004', NULL, 'G0005', 'IC0019', 3200,  17,  'Universal Studios Singapore 1-Day Pass × 17pax (Day2)',
          TO_DATE('2026-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'));

-- T0005 : KR Seoul-Jeju 5D4N
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0005', NULL, NULL,    'IC0022', 5500,  40,  'Hotel KR 4คืน 10ห้อง (20pax/2คน) Lotte Seoul×2 + Ramada Jeju×2',
          TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0005', NULL, NULL,    'IC0023', 26000, 4,   'รถโค้ช KR เหมา 4วัน (Day1-4, Day5 นั่งเครื่อง)',
          TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-13','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0005', NULL, 'G0004', 'IC0026', 5000,  5,   'ค่าไกด์ Kim Minseo 5วัน (Seoul+Jeju)',
          TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0005', NULL, 'G0004', 'IC0024', 900,   180, 'อาหาร 9มื้อ × 20pax (Day1=D, Day2=B,L, Day3=B,D, Day4=B,L,D, Day5=B)',
          TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0005', NULL, NULL,    'IC0025', 800,   20,  'Seongsan Ilchulbong entrance × 20pax (Day4)',
          TO_DATE('2026-06-13','YYYY-MM-DD'), TO_DATE('2026-06-13','YYYY-MM-DD'));

-- T0006 : Bangkok Incentive 3D2N
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0006', NULL, NULL,    'IC0012', 9500,  40,  'Centara Grand 5* 2คืน 20ห้อง (40pax/2คน)',
          TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0006', NULL, NULL,    'IC0013', 35000, 3,   'รถโค้ช VIP 45ที่นั่ง เหมา 3วัน',
          TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0006', NULL, 'G0003', 'IC0011', 4500,  3,   'ค่าไกด์ Incentive Program 3วัน',
          TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0006', NULL, 'G0003', 'IC0014', 1800,  280, 'Gala Dinner+Meal 7มื้อ × 40pax (Day1=L,D Day2=B,L,D Day3=B,L)',
          TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'));
INSERT INTO CostDetail (TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate)
  VALUES ('T0006', NULL, NULL,    'IC0015', 500,   40,  'ค่าเข้าวัดพระแก้ว × 40pax (Day3)',
          TO_DATE('2026-07-07','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'));

COMMIT;

-- -------------------------------------------------------
-- PromotionDetail  (SeqNo auto-incremented by TRG_PromotionDetail_SeqNo)
-- -------------------------------------------------------
-- PRM0001 : Early Bird 60 Days
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0001', NULL, 'T0001', 10,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-03-24','YYYY-MM-DD'),
          'จองก่อนวันออกเดินทาง >= 60 วัน | ชำระมัดจำ 50% ภายใน 3 วัน | สำหรับผู้ใหญ่เท่านั้น', 59800);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0001', NULL, 'T0002', 10,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-04-09','YYYY-MM-DD'),
          'จองก่อนวันออกเดินทาง >= 60 วัน | ชำระมัดจำ 50% ภายใน 3 วัน', 63000);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0001', NULL, 'T0004', 8,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-04-30','YYYY-MM-DD'),
          'จองก่อนวันออกเดินทาง >= 60 วัน (SG Free & Easy)', 39800);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0001', NULL, 'T0005', 8,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-06-09','YYYY-MM-DD'),
          'จองก่อนวันออกเดินทาง >= 60 วัน (KR Seoul-Jeju)', 55800);

-- PRM0002 : Group 10+ Discount
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0002', NULL, 'T0001', 5,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'กลุ่ม >= 10 คน เดินทางพร้อมกัน | ผู้นำกลุ่มได้ Free 1 ที่', 299000);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0002', NULL, 'T0002', 5,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'กลุ่ม >= 10 คน (JP Autumn) | Free 1 ที่สำหรับผู้นำกลุ่ม', 315000);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0002', NULL, 'T0003', 3,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'กลุ่ม >= 10 คน (CNX) | ลด 3% ทุกที่นั่ง', 59000);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0002', NULL, 'T0004', 4,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'กลุ่ม >= 10 คน (SG) | ลด 4%', 199000);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0002', NULL, 'T0005', 5,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'กลุ่ม >= 10 คน (KR) | ลด 5%', 279000);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0002', NULL, 'T0006', 5,
          TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'กลุ่ม >= 10 คน (Incentive BKK) | ลด 5% ต่อหัว', 150000);

-- PRM0003 : New Year Flash Sale
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0003', NULL, 'T0001', 15,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'Flash Sale — จำนวนจำกัด 5 ที่นั่ง | ไม่สามารถใช้ร่วมกับโปรอื่น', 29900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0003', NULL, 'T0002', 15,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'Flash Sale — จำนวนจำกัด 5 ที่ (JP Autumn)', 31500);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0003', NULL, 'T0003', 10,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'Flash Sale CNX — จำนวนจำกัด 5 ที่', 5900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0003', NULL, 'T0004', 12,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'Flash Sale SG — จำนวนจำกัด 5 ที่', 19900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0003', NULL, 'T0005', 15,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'Flash Sale KR — จำนวนจำกัด 5 ที่', 27900);

-- PRM0004 : Repeat Customer Voucher
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0004', NULL, 'T0001', 5,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'ลูกค้าเก่าที่เคยเดินทางกับบริษัทมาแล้ว >= 1 ครั้ง | ไม่รวมกับโปรอื่น', 29900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0004', NULL, 'T0002', 5,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'ลูกค้าเก่า (JP Autumn) | ไม่รวมกับโปรอื่น', 31500);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0004', NULL, 'T0003', 3,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'ลูกค้าเก่า (CNX) ลด 3%', 5900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0004', NULL, 'T0004', 4,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'ลูกค้าเก่า (SG) ลด 4%', 19900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0004', NULL, 'T0005', 5,
          TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'),
          'ลูกค้าเก่า (KR) ลด 5%', 27900);

-- PRM0005 : Low Season Special
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0005', NULL, 'T0004', 10,
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'),
          'Low Season SG (พ.ค.-ก.ย.) ลด 10% | วันออกเดินทางต้องอยู่ในช่วงโปรโมชัน', 39800);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0005', NULL, 'T0005', 12,
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'),
          'Low Season KR (พ.ค.-ก.ย.) ลด 12% | วันออกเดินทางต้องอยู่ในช่วงโปรโมชัน', 55800);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0005', NULL, 'T0003', 8,
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'),
          'Low Season CNX (ฤดูฝน) ลด 8%', 11800);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0005', NULL, 'T0006', 8,
          TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'),
          'Low Season Incentive BKK ลด 8% | เฉพาะการจองใหม่เท่านั้น', 30000);

-- PRM0006 : Credit Card Bank X
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0006', NULL, 'T0001', 5,
          TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'),
          'ชำระเต็มจำนวนด้วยบัตรเครดิต Bank X เท่านั้น | รับ Cashback 5% ใน Statement ถัดไป', 29900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0006', NULL, 'T0002', 5,
          TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'),
          'ชำระด้วยบัตร Bank X (JP Autumn) | Cashback 5%', 31500);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0006', NULL, 'T0003', 3,
          TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'),
          'ชำระด้วยบัตร Bank X (CNX) | Cashback 3%', 5900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0006', NULL, 'T0004', 5,
          TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'),
          'ชำระด้วยบัตร Bank X (SG) | Cashback 5%', 19900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0006', NULL, 'T0005', 5,
          TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'),
          'ชำระด้วยบัตร Bank X (KR) | Cashback 5%', 27900);
INSERT INTO PromotionDetail (PromotionID, SeqNo, TourID, DiscountPercent, StartDate, EndDate, ExtraCondition, MinBookAmount)
  VALUES ('PRM0006', NULL, 'T0006', 4,
          TO_DATE('2026-03-01','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'),
          'ชำระด้วยบัตร Bank X (Incentive BKK) | Cashback 4% | เฉพาะการจอง B2C', 15000);

COMMIT;

-- -------------------------------------------------------
-- BookingDetail  (SeqNo auto-incremented by TRG_BookingDetail_SeqNo)
-- SubTotalAmount = (PaxAdult + PaxChild) x UnitPrice
-- -------------------------------------------------------
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0001', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 1, 29900, 89700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0002', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 2, 0, 5900,  11800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0003', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 1, 0, 19900, 19900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0004', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 4, 2, 29900, 179400);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0005', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 1, 0, 27900, 27900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0006', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 0, 31500, 63000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0007', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 2, 0, 27900, 55800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0008', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 4, 1, 19900, 99500);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0009', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 0, 29900, 59800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0010', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 1, 0, 29900, 29900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0011', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 2, 29900, 119600);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0012', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 0, 29900, 59800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0013', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 3, 0, 29900, 89700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0014', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 1, 0, 29900, 29900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0015', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 0, 29900, 59800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0016', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 0, 31500, 63000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0017', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 1, 31500, 94500);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0018', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 0, 31500, 63000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0019', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 4, 0, 31500, 126000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0020', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 3, 0, 31500, 94500);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0021', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 0, 31500, 63000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0022', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 0, 31500, 63000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0023', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 2, 0, 5900,  11800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0024', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 1, 0, 5900,  5900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0025', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 2, 2, 5900,  23600);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0026', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 3, 0, 5900,  17700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0027', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 2, 0, 5900,  11800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0028', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 2, 1, 19900, 59700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0029', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 1, 0, 19900, 19900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0030', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 2, 0, 19900, 39800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0031', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 2, 0, 19900, 39800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0032', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 2, 1, 27900, 83700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0033', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 3, 0, 27900, 83700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0034', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 2, 0, 27900, 55800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0035', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 4, 0, 27900, 111600);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0036', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 2, 0, 27900, 55800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0037', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 1, 0, 27900, 27900);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0038', NULL, 'T0005', TO_DATE('2026-06-10','YYYY-MM-DD'), TO_DATE('2026-06-14','YYYY-MM-DD'), 4, 0, 27900, 111600);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0039', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 5, 0, 15000, 75000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0040', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 10, 0, 15000, 150000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0041', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 3, 0, 15000, 45000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0042', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 2, 0, 15000, 30000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0043', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 1, 29900, 89700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0044', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 0, 29900, 59800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0045', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 3, 1, 29900, 119600);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0046', NULL, 'T0001', TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2026-03-30','YYYY-MM-DD'), 2, 1, 29900, 89700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0047', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 0, 31500, 63000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0048', NULL, 'T0002', TO_DATE('2026-04-10','YYYY-MM-DD'), TO_DATE('2026-04-15','YYYY-MM-DD'), 2, 1, 31500, 94500);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0049', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 3, 0, 5900,  17700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0050', NULL, 'T0003', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2026-02-22','YYYY-MM-DD'), 2, 0, 5900,  11800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0051', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 3, 0, 19900, 59700);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0052', NULL, 'T0004', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 2, 0, 19900, 39800);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0053', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 8, 0, 15000, 120000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0054', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 7, 0, 15000, 105000);
INSERT INTO BookingDetail (BookingID, SeqNo, TourID, ServDateFrom, ServDateTo, PaxAdult, PaxChild, UnitPrice, SubTotalAmount)
  VALUES ('BK0055', NULL, 'T0006', TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-07-07','YYYY-MM-DD'), 5, 0, 15000, 75000);

-- Update Booking TotalPax and TotalAmount from BookingDetail
UPDATE Booking b SET (TotalPax, TotalAmount) = (
  SELECT SUM(bd.PaxAdult + bd.PaxChild), SUM(bd.SubTotalAmount)
  FROM BookingDetail bd WHERE bd.BookingID = b.BookingID
) WHERE EXISTS (SELECT 1 FROM BookingDetail bd WHERE bd.BookingID = b.BookingID);

COMMIT;
