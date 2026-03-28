/* ============================================================
   SQL_DML.sql  —  Master Data 
   ============================================================ */

-- -------------------------------------------------------
-- Department
-- ทัวร์บริษัทจริงๆ มีแผนก Sales, Operation, Accounting ฯลฯ
-- -------------------------------------------------------
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D001', 'Sales & Marketing', 8);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D002', 'Tour Operation',    6);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D003', 'Accounting',        4);
INSERT INTO Department (DeptCode, DeptName, TotalEmp) VALUES ('D004', 'Human Resource',    3);

-- -------------------------------------------------------
-- Employee
-- ตำแหน่งให้ตรงกับบริษัทนำเที่ยว และ dept ที่เพิ่มมา
-- ResignDate / Status ให้มี variety (A=Active, R=Resigned)
-- -------------------------------------------------------
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0001', 'Somchai',   'Jaidee',    'Sales Manager',      TO_DATE('2019-03-01','YYYY-MM-DD'), 'D001', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0002', 'Nattaya',   'Srisuk',    'Sales Executive',    TO_DATE('2021-06-15','YYYY-MM-DD'), 'D001', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0003', 'Piyaporn',  'Meena',     'Tour Coordinator',   TO_DATE('2020-08-01','YYYY-MM-DD'), 'D002', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0004', 'Wanchai',   'Rattana',   'Operation Supervisor',TO_DATE('2018-05-10','YYYY-MM-DD'),'D002', 'A');
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, ResignDate, DeptCode, Status)
  VALUES ('E0005', 'Malee',     'Jaihan',    'Accountant',         TO_DATE('2020-01-15','YYYY-MM-DD'),
          TO_DATE('2024-12-31','YYYY-MM-DD'), 'D003', 'R');  -- ลาออกสิ้นปี 2024
INSERT INTO Employee (EmpNo, FName, LName, Position, StartDate, DeptCode, Status)
  VALUES ('E0006', 'Thanaporn', 'Sukjai',    'Accountant',         TO_DATE('2025-01-10','YYYY-MM-DD'), 'D003', 'A');

-- -------------------------------------------------------
-- TourPlan  (แผนโปรแกรม — ไม่เปลี่ยนมาก แต่ปรับ Description ให้ละเอียด)
-- -------------------------------------------------------
INSERT INTO TourPlan (TourPlanID, Name, Description)
  VALUES ('TPJP6D01', 'JP 6D Tokyo-Osaka Sakura',
          'apan 6D5N Tokyo-Hakone-Osaka, Sakura Season Mar-Apr');
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
-- TTINC01 Incentive — แก้ ActiveFlag เป็น 'Y' (มี Tour T0006 ใช้อยู่)
-- เพิ่ม CostType CT005 Guide ให้ชัดเจนก่อนที่จะมี ItemCost เชื่อม
-- -------------------------------------------------------
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTDOM01', 'Domestic Package',  'กรุ๊ปทัวร์ในประเทศพร้อมไกด์', 5900,  3, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTINT01', 'Intl Short Haul',   'ทัวร์ต่างประเทศระยะใกล้ 4-6 วัน', 29900, 6, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTFNE01', 'Free & Easy',       'แพ็กเกจตั๋ว+โรงแรม อิสระท่องเที่ยว', 19900, 4, 'Y');
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTINC01', 'Incentive Tour',    'ทัวร์ Incentive สำหรับองค์กร', 15000, 3, 'Y');  -- แก้เป็น Y
INSERT INTO TourType (TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag)
  VALUES ('TTINT02', 'Intl Medium Haul',  'ทัวร์ต่างประเทศระยะกลาง 7-8 วัน', 39900, 7, 'Y');

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
  VALUES ('CTY001', 'Thailand',   'เส้นทางในไทย (BKK, CNX, HKT, KBI)', 'REG002');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY002', 'Japan',      'เส้นทางญี่ปุ่น (TYO, OSA, NGO, FUK)', 'REG001');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY003', 'Korea',      'เส้นทางเกาหลี (SEL, CJU, PUS)',  'REG001');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY004', 'Singapore',  'เส้นทางสิงคโปร์ (SIN)',           'REG002');
INSERT INTO Country (CountryID, Name, Description, RegionID)
  VALUES ('CTY005', 'Vietnam',    'เส้นทางเวียดนาม (HAN, SGN, DAD)', 'REG002');

-- -------------------------------------------------------
-- CostType
-- CT005 Guide เพิ่มเพื่อใช้กับ ItemCost ค่าไกด์โดยตรง
-- -------------------------------------------------------
INSERT INTO CostType (CostTypeID, Name, Description)
  VALUES ('CT001', 'Hotel',          'ค่าที่พักต่อห้องต่อคืน');
INSERT INTO CostType (CostTypeID, Name, Description)
  VALUES ('CT002', 'Transport',      'ค่ารถโค้ช/รถตู้/รถไฟ');
INSERT INTO CostType (CostTypeID, Name, Description)
  VALUES ('CT003', 'Meal',           'ค่าอาหารต่อที่/มื้อ');
INSERT INTO CostType (CostTypeID, Name, Description)
  VALUES ('CT004', 'Attraction',     'ค่าบัตรเข้าสถานที่/กิจกรรม');
INSERT INTO CostType (CostTypeID, Name, Description)
  VALUES ('CT005', 'Guide Fee',      'ค่าไกด์ท้องถิ่นต่อวัน');
INSERT INTO CostType (CostTypeID, Name, Description)
  VALUES ('CT006', 'Ground Operator','ค่า Ground Operator ต่อกรุ๊ป');

-- -------------------------------------------------------
-- ItemCost  — เพิ่ม ItemCost ให้ครบทุกประเทศที่มี Tour
-- เดิมมีแค่ JP (CTY002) และ TH-CNX (CTY001)
-- เพิ่ม KR (CTY003) และ SG (CTY004) ให้ CostDetail ไม่ต้อง reuse ข้ามประเทศ
-- -------------------------------------------------------
-- Japan (CTY002)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0001', 'CT001', 'CTY002', 'Tokyo Business Hotel (Twin)', 'sales@tokyohotel3.jp', 6500, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0002', 'CT002', 'CTY002', 'Coach 40 seats Japan (per day)', 'reserve@tokyobus.jp', 28000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0003', 'CT003', 'CTY002', 'Japanese Set Meal (per person)', 'ops@localrest.jp', 950, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0004', 'CT004', 'CTY002', 'Fuji-Hakone 1-Day Pass', 'ticket@mtfujipass.jp', 3200, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0005', 'CT005', 'CTY002', 'Japan Local Guide (per day)', 'guide@jpstaff.jp', 15000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0006', 'CT006', 'CTY002', 'Japan Ground Operator (per group)', 'contract@jpground.jp', 18000, 'A');

-- Thailand / Chiang Mai (CTY001)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0007', 'CT001', 'CTY001', 'Chiang Mai 4* Hotel (Twin)', 'rsvn@cmhotel.th', 2800, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0008', 'CT002', 'CTY001', 'Van 9 seats Chiang Mai (per day)', 'booking@cmvan.th', 3500, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0009', 'CT003', 'CTY001', 'Thai Set Meal CNX (per person)', 'ops@cmlocalfood.th', 400, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0010', 'CT004', 'CTY001', 'Doi Inthanon Park Entrance', 'doi@dnp.th', 300, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0011', 'CT005', 'CTY001', 'Thai Local Guide CNX (per day)', 'guide@cntourism.th', 3500, 'A');

-- Thailand / Bangkok Incentive (CTY001)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0012', 'CT001', 'CTY001', 'Bangkok 5* Hotel Incentive (Twin)', 'incentive@tarag.th', 9500, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0013', 'CT002', 'CTY001', 'VIP Coach 45 seats Bangkok (per day)', 'ops@vipcoach.th', 35000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0014', 'CT003', 'CTY001', 'Gala Dinner BKK (per person)', 'banquet@cegrand.th', 1800, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0015', 'CT004', 'CTY001', 'Wat Phra Kaew Entrance (per person)', 'ticket@finearts.th', 500, 'A');

-- Singapore (CTY004)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0016', 'CT001', 'CTY004', 'Singapore 4* Hotel (Twin)', 'rsvn@sghotel.com.sg', 7200, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0017', 'CT002', 'CTY004', 'Coach SG (per day)', 'ops@sgbus.com.sg', 22000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0018', 'CT003', 'CTY004', 'Meal SG (per person per meal)', 'ops@restaurant.sg', 750, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0019', 'CT004', 'CTY004', 'Universal Studios Singapore (per person)', 'ticket@uss.com.sg', 3200, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0020', 'CT005', 'CTY004', 'Singapore Local Guide (per day)', 'guide@stb.com.sg', 4000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0021', 'CT006', 'CTY004', 'Singapore Ground Operator (per group)', 'contract@ground.sg', 18000, 'A');

-- Korea (CTY003)
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0022', 'CT001', 'CTY003', 'Seoul Business Hotel (Twin)', 'rsvn@seoulhotel.kr', 5500, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0023', 'CT002', 'CTY003', 'Coach KR (per day)', 'ops@krbus.kr', 26000, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0024', 'CT003', 'CTY003', 'Korean Set Meal (per person)', 'ops@krfood.kr', 900, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0025', 'CT004', 'CTY003', 'Songsan Ichulbong Entrance (per person', 'ticket@seongsan.kr', 800, 'A');
INSERT INTO ItemCost (ItemCostID, CostTypeID, CountryID, Name, Email, RatePerUnit, Status)
  VALUES ('IC0026', 'CT005', 'CTY003', 'Korea Local Guide (per day)', 'guide@visitkorea.kr', 5000, 'A');

-- -------------------------------------------------------
-- Guide
-- เบอร์โทรแก้ให้ถูกต้องตาม country code และ format จริง
-- Salary ต้องสอดคล้อง rate ที่คิดใน CostDetail
-- -------------------------------------------------------
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary)
  VALUES ('G0001', 'Tanaka Hiroshi', 'tanaka.guide@jp.com', '+81-90-1111-2222',
          'JP,EN', 'Tokyo city tour, Temples, Culture', 'AVAILABLE', 15000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary)
  VALUES ('G0002', 'Sato Yumi', 'yumi.sato@jp.com', '+81-90-2222-3333',
          'JP,EN,TH', 'Shopping, Family group, Osaka area', 'AVAILABLE', 15000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary)
  VALUES ('G0003', 'Somchai Phumjai', 'somchai.guide@th.com', '+66-81-234-5678',
          'TH,EN', 'Northern Thailand, Nature, Temples', 'AVAILABLE', 3500);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary)
  VALUES ('G0004', 'Kim Minseo', 'minseo.kim@kr.com', '+82-10-7777-8888',
          'KR,EN', 'Seoul city, K-pop, Jeju Island', 'BUSY', 5000);
INSERT INTO Guide (GuideID, Name, Email, Phone, LanguageSkills, Specialty, Status, Salary)
  VALUES ('G0005', 'Lim Wei', 'wei.lim@sg.com', '+65-9123-4567',
          'EN,ZH,MS', 'Singapore highlights, Food tour, Sentosa', 'AVAILABLE', 4000);

-- -------------------------------------------------------
-- CustomerType
-- -------------------------------------------------------
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM01', 'Individual',   0.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM02', 'Family',        3.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM03', 'Corporate',     5.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM04', 'Travel Agent',  8.00);
INSERT INTO CustomerType (CustTypeID, Name, DiscountRate) VALUES ('CTM05', 'VIP Member',   10.00);

-- -------------------------------------------------------
-- Customer  — เพิ่มลูกค้าให้ครบ CustType และ Nationality หลากหลาย
-- -------------------------------------------------------
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00001', 'CTM01', 'John Anderson','+1-555-0101', '123 Maple Avenue, Springfield, IL 62701, USA','A12345678', 'American', DATE '1980-05-15');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00002', 'CTM02', 'Emma Charlotte Davies','+44-20-7946-0958', '45 Baker Street, Marylebone, London W1U 8EW, UK','B98765432', 'British', DATE '1985-08-22');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00003', 'CTM01', 'Liam O''Connor','+353-1-234-5678', '88 Grafton Street, Dublin 2, D02 ET79, Ireland','C11223344', 'Irish', DATE '1992-11-30');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00004', 'CTM03', 'Akira Tanaka','+81-3-1234-5678', '1-1 Chiyoda, Chiyoda-ku, Tokyo 100-0001, Japan','JP5566778', 'Japanese', DATE '1978-03-10');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00005', 'CTM03', 'Sofia Rodriguez','+34-91-123-4567', 'Gran Via 22, 4to piso, 28013 Madrid, Spain','S99887766', 'Spanish', DATE '1988-07-19');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00006', 'CTM04', 'Chen Wei','+86-10-8888-8888', 'No. 5 Dongchangan Avenue, Dongcheng District, Beijing 100741, China','G44332211', 'Chinese', DATE '1995-12-05');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00007', 'CTM05', 'Priya Sharma','+91-98-1234-5678', '12 Vasant Vihar, New Delhi 110057, India','P77665544', 'Indian', DATE '1975-04-20');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00008', 'CTM02', 'James & Linda Wilson','+61-2-9876-5432', '9 Wallaby Way, Sydney NSW 2000, Australia','AU1122334', 'Australian', DATE '1982-09-08');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00009','CTM01','Michael Johnson','+1-312-555-0192','456 Oak Street, Chicago, IL 60601, USA','A87654321','American',DATE '1990-03-22');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00010','CTM01','Yuki Nakamura','+81-90-3456-7890','2-5 Shinjuku, Shinjuku-ku, Tokyo, Japan','JP9988776','Japanese',DATE '1987-11-05');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00011','CTM01','Marie Dupont','+33-1-4567-8901','15 Rue de Rivoli, 75001 Paris, France','FR3344556','French',DATE '1983-06-18');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00012','CTM01','Ahmad Al-Rashid','+971-50-123-4567','Al Wasl Road, Dubai, UAE','AE7766554','Emirati',DATE '1979-09-30');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00013','CTM01','Ngo Thi Lan','+84-90-234-5678','45 Hang Bai, Hoan Kiem, Hanoi, Vietnam','VN5544332','Vietnamese',DATE '1995-02-14');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00014','CTM01','Carlos Mendez','+52-55-1234-5678','Av. Insurgentes 1234, CDMX 06600, Mexico','MX2233445','Mexican',DATE '1988-07-25');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00015','CTM01','Siti Rahayu','+62-21-555-6789','Jl. Sudirman 88, Jakarta 10220, Indonesia','ID6677889','Indonesian',DATE '1992-12-03');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00016','CTM02','David & Sarah Park','+82-10-9876-5432','123 Gangnam-daero, Seoul 06253, Korea','KR1122334','Korean',DATE '1981-04-17');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00017','CTM02','Roberto Bianchi','+39-02-1234-5678','Via Roma 55, 20121 Milano, Italy','IT4455667','Italian',DATE '1975-08-09');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00018','CTM02','Tan Ah Kow','+65-9234-5678','10 Orchard Road, Singapore 238826','SG8899001','Singaporean',DATE '1970-01-28');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00019','CTM02','Hans Mueller','+49-89-1234-5678','Marienplatz 1, 80331 Munich, Germany','DE2345678','German',DATE '1968-05-14');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00020','CTM03','Sunita Patel','+91-22-6789-0123','Nariman Point, Mumbai 400021, India','IN3456789','Indian',DATE '1980-10-22');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00021','CTM03','Kevin O''Brien','+353-1-987-6543','10 Nassau Street, Dublin 2, Ireland','IE4567890','Irish',DATE '1977-03-31');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00022','CTM03','Fatima Al-Zahra','+966-50-987-6543','King Fahd Road, Riyadh 12345, Saudi Arabia','SA5678901','Saudi',DATE '1985-11-19');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00023','CTM03','Wang Fang','+86-21-8888-9999','168 Nanjing Road, Shanghai 200001, China','G12345678','Chinese',DATE '1991-07-07');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00024','CTM04','Rachel Green','+61-3-9876-5432','200 Collins Street, Melbourne VIC 3000, AUS','AU9988776','Australian',DATE '1986-09-15');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00025','CTM04','Lars Eriksson','+46-8-1234-5678','Kungsgatan 10, 111 43 Stockholm, Sweden','SE7766554','Swedish',DATE '1973-12-08');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00026','CTM04','Amira Khalil','+20-2-2345-6789','26 July Street, Cairo 11511, Egypt','EG6655443','Egyptian',DATE '1989-04-02');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00027','CTM05','William Tang','+852-9876-5432','1 Harbour Road, Wan Chai, Hong Kong','HK5544332','Hong Konger',DATE '1965-06-20');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00028','CTM05','Isabella Ferrari','+39-06-9876-5432','Via Veneto 100, 00187 Roma, Italy','IT9988001','Italian',DATE '1978-02-11');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00029','CTM05','Hiroshi Yamamoto','+81-3-5678-9012','1-1 Marunouchi, Chiyoda, Tokyo, Japan','JP1234560','Japanese',DATE '1962-08-30');
INSERT INTO Customer (CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB)
  VALUES ('CUS00030','CTM05','Patricia Vance','+1-212-555-0198','88 Park Avenue, New York, NY 10016, USA','A11223344','American',DATE '1970-11-25');
-- -------------------------------------------------------
-- Promotion
-- แก้ DiscountValue และ MinPax ให้สมเหตุสมผล:
--   PRM0001 Early Bird  — DiscountValue 0 (ส่วนลดจริงอยู่ใน PromotionDetail ต่อทัวร์)
--   PRM0002 Group 10+   — MinPax 10, DiscountValue 0 (อยู่ใน PromotionDetail)
--   PRM0003 Flash Sale  — DiscountValue 15 (ลด 15% header), EndDate ขยายให้ booking จาก 2024 ยัง valid
--   PRM0004 Repeat Cust — DiscountValue 5  (5%)
--   PRM0005 Low Season  — DiscountValue 10 (10%)
--   PRM0006 Credit Card — DiscountValue 5  (5%)
-- -------------------------------------------------------
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0001', 'Early Bird 60 Days',   2,  0, DATE '2026-01-01', DATE '2026-12-31', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0002', 'Group 10+ Discount',  10,  0, DATE '2026-01-01', DATE '2026-12-31', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0003', 'New Year Flash Sale',  1, 15, DATE '2024-01-01', DATE '2026-12-31', 'ACTIVE');  -- ขยาย ให้ครอบ booking 2024
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0004', 'Repeat Cust Voucher',  1,  5, DATE '2024-01-01', DATE '2026-12-31', 'ACTIVE');  -- ขยาย
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0005', 'Low Season Special',   2, 10, DATE '2026-05-01', DATE '2026-09-30', 'ACTIVE');
INSERT INTO Promotion (PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status)
  VALUES ('PRM0006', 'Credit Card Bank X',   1,  5, DATE '2026-03-01', DATE '2026-08-31', 'ACTIVE');

-- -------------------------------------------------------
-- Tour
-- TourCode ปรับให้มี convention ชัดเจน: [CTY]-[TYPE]-[SEASON]-[SEQ]
-- CapacityPax สอดคล้องกับ TourType (Incentive ใหญ่กว่า Normal group)
-- -------------------------------------------------------
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0001', 'JP-INT-SAK-2603', 'TTINT01',
          'Japan Tokyo-Osaka Sakura 6D5N', 30,
          DATE '2026-03-25', DATE '2026-03-30', 'OPEN', 'CTY002');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0002', 'JP-INT-AUT-2604', 'TTINT01',
          'Japan Tokyo-Osaka Autumn 6D5N', 30,
          DATE '2026-04-10', DATE '2026-04-15', 'OPEN', 'CTY002');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0003', 'TH-DOM-CNX-2602', 'TTDOM01',
          'Chiang Mai Highlight 3D2N', 25,
          DATE '2026-02-20', DATE '2026-02-22', 'CLOSED', 'CTY001');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0004', 'SG-FNE-FE-2605', 'TTFNE01',
          'Singapore Free & Easy 4D3N', 20,
          DATE '2026-05-01', DATE '2026-05-04', 'OPEN', 'CTY004');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0005', 'KR-INT-SJ-2606', 'TTINT01',
          'Korea Seoul-Jeju 5D4N', 32,
          DATE '2026-06-10', DATE '2026-06-14', 'OPEN', 'CTY003');
INSERT INTO Tour (TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID)
  VALUES ('T0006', 'TH-INC-BKK-2607', 'TTINC01',
          'Bangkok Incentive Program 3D2N', 40,
          DATE '2026-07-05', DATE '2026-07-07', 'DRAFT', 'CTY001');

-- -------------------------------------------------------
-- Booking
-- แก้ BookingDate จาก 2024 ให้สอดคล้องกับ Tour StartDate (ปี 2026)
-- และให้ BookingDate อยู่ใน range ของ Promotion ที่ใช้
-- TotalPax / TotalAmount จะถูก recalculate โดย sp_booking_add_detail
-- แต่ต้องใส่ค่า placeholder ไว้ก่อน (constraint NOT NULL / > 0)
-- -------------------------------------------------------
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate,BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0001', 'CUS00001', 'PRM0001', 'E0001', DATE '2026-01-10', 'CONFIRMED', 'PAID', 'CARD', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0002', 'CUS00002', 'PRM0004', 'E0002', DATE '2026-01-25', 'COMPLETED', 'PAID', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0003', 'CUS00003', 'PRM0003', 'E0001', DATE '2026-02-15','PENDING', 'UNPAID', 'E-WALLET', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0004', 'CUS00004', 'PRM0002', 'E0003', DATE '2026-01-20','CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0005', 'CUS00005', 'PRM0004', 'E0002', DATE '2026-02-01', 'CANCELLED', 'REFUNDED', 'CARD', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0006', 'CUS00001', 'PRM0001', 'E0001', DATE '2026-02-05', 'CONFIRMED', 'PAID', 'CARD', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0007', 'CUS00007', 'PRM0006', 'E0002', DATE '2026-03-10','CONFIRMED', 'PAID', 'CARD', 1, 1);
INSERT INTO Booking (BookingID, CustomerID, PromotionID, EmpNo, BookingDate, BookingStatus, PaymentStatus, PaymentMethod, TotalPax, TotalAmount)
  VALUES ('BK0008', 'CUS00006', 'PRM0005', 'E0003', DATE '2026-03-20', 'CONFIRMED', 'PARTIAL', 'TRANSFER', 1, 1);
INSERT INTO Booking VALUES ('BK0009','CUS00009','PRM0001','E0002',DATE '2026-01-05','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0010','CUS00010',NULL,'E0001',DATE '2026-02-10','CONFIRMED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0011','CUS00016','PRM0002','E0002',DATE '2026-01-15','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0012','CUS00027','PRM0006','E0001',DATE '2026-03-05','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0013','CUS00020',NULL,'E0003',DATE '2026-02-20','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0014','CUS00011','PRM0004','E0002',DATE '2026-02-01','CANCELLED','REFUNDED','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0015','CUS00029','PRM0001','E0001',DATE '2026-01-08','CONFIRMED','PAID','CASH',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0016','CUS00011','PRM0001','E0002',DATE '2026-01-20','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0017','CUS00017',NULL,'E0003',DATE '2026-02-15','CONFIRMED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0018','CUS00028','PRM0006','E0001',DATE '2026-03-01','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0019','CUS00022','PRM0002','E0003',DATE '2026-02-10','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0020','CUS00025','PRM0004','E0002',DATE '2026-01-28','CONFIRMED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0021','CUS00014','PRM0003','E0001',DATE '2026-02-25','CANCELLED','REFUNDED','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0022','CUS00030','PRM0001','E0002',DATE '2026-01-12','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0023','CUS00013',NULL,'E0002',DATE '2026-01-10','COMPLETED','PAID','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0024','CUS00015','PRM0003','E0003',DATE '2026-01-15','COMPLETED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0025','CUS00019','PRM0002','E0001',DATE '2026-01-20','COMPLETED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0026','CUS00026','PRM0004','E0002',DATE '2026-01-25','COMPLETED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0027','CUS00012','PRM0006','E0003',DATE '2026-02-01','COMPLETED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0028','CUS00018',NULL,'E0002',DATE '2026-02-20','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0029','CUS00013','PRM0005','E0001',DATE '2026-03-01','CONFIRMED','UNPAID','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0030','CUS00024','PRM0004','E0003',DATE '2026-03-10','CONFIRMED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0031','CUS00021','PRM0006','E0002',DATE '2026-02-28','CANCELLED','REFUNDED','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0032','CUS00016','PRM0001','E0002',DATE '2026-03-15','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0033','CUS00023','PRM0002','E0001',DATE '2026-03-20','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0034','CUS00010','PRM0003','E0003',DATE '2026-03-05','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0035','CUS00025','PRM0006','E0002',DATE '2026-03-18','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0036','CUS00029',NULL,'E0001',DATE '2026-04-01','CONFIRMED','PAID','CASH',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0037','CUS00009','PRM0005','E0003',DATE '2026-03-25','CANCELLED','REFUNDED','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0038','CUS00020','PRM0002','E0002',DATE '2026-03-12','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0039','CUS00022','PRM0002','E0003',DATE '2026-04-10','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0040','CUS00023','PRM0002','E0001',DATE '2026-04-15','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0041','CUS00027','PRM0006','E0002',DATE '2026-04-20','PENDING','UNPAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0042','CUS00030',NULL,'E0001',DATE '2026-04-25','PENDING','UNPAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0043','CUS00014','PRM0004','E0002',DATE '2026-02-05','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0044','CUS00017','PRM0001','E0001',DATE '2026-01-18','CONFIRMED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0045','CUS00024',NULL,'E0003',DATE '2026-02-12','CONFIRMED','PAID','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0046','CUS00026','PRM0006','E0002',DATE '2026-03-08','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0047','CUS00015','PRM0004','E0001',DATE '2026-02-20','CONFIRMED','PAID','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0048','CUS00026',NULL,'E0003',DATE '2026-03-15','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0049','CUS00020','PRM0003','E0002',DATE '2026-01-30','COMPLETED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0050','CUS00021',NULL,'E0001',DATE '2026-02-05','COMPLETED','PAID','CASH',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0051','CUS00019','PRM0005','E0003',DATE '2026-03-05','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0052','CUS00014','PRM0003','E0002',DATE '2026-03-18','CONFIRMED','PAID','E-WALLET',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0053','CUS00020','PRM0002','E0001',DATE '2026-04-28','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0054','CUS00021','PRM0002','E0003',DATE '2026-05-02','CONFIRMED','PARTIAL','TRANSFER',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);
INSERT INTO Booking VALUES ('BK0055','CUS00028',NULL,'E0002',DATE '2026-05-05','CONFIRMED','PAID','CARD',1,1,CURRENT_TIMESTAMP,USER,NULL,NULL);

COMMIT;

/*
  หมายเหตุ: TotalPax และ TotalAmount ใส่เป็น placeholder (1) ไว้ก่อน
  เพราะ procedure sp_booking_add_detail จะ recalculate ให้อัตโนมัติ
  เมื่อ run Insert_Realistic_All.sql (BookingDetail) ต่อ
*/
