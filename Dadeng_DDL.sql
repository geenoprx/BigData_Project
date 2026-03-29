-- Department
CREATE TABLE Department (
    DeptCode    VARCHAR2(8)   CONSTRAINT PK_Department PRIMARY KEY,
    DeptName    VARCHAR2(20)  NOT NULL,
    TotalEmp    NUMBER(3),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128)
);

-- Employee
CREATE TABLE Employee (
    EmpNo       VARCHAR2(8)   CONSTRAINT PK_Employee PRIMARY KEY,
    FName       VARCHAR2(20)  NOT NULL,
    LName       VARCHAR2(20)  NOT NULL,
    Position    VARCHAR2(20),
    StartDate   DATE,
    ResignDate  DATE,
    DeptCode    VARCHAR2(8),
    Status      CHAR(1),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128),
    CONSTRAINT FK_EmployeeDept     FOREIGN KEY (DeptCode)   REFERENCES Department(DeptCode),
    CONSTRAINT CK_Employee_Status  CHECK (Status IN ('A', 'R')),
    CONSTRAINT CK_Employee_ResignDate CHECK (
        ResignDate IS NULL
        OR (StartDate IS NOT NULL AND ResignDate >= StartDate)
    )
);

-- TourPlan
CREATE TABLE TourPlan (
    TourPlanID  VARCHAR2(8)   CONSTRAINT PK_TourPlan PRIMARY KEY,
    Name        VARCHAR2(50)  NOT NULL,
    Description VARCHAR2(100),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128)
);

-- TourType
CREATE TABLE TourType (
    TourTypeID   VARCHAR2(8)   CONSTRAINT PK_TourType PRIMARY KEY,
    Name         VARCHAR2(40)  NOT NULL,
    Description  VARCHAR2(100),
    BasePrice    NUMBER(10),
    DurationDays NUMBER(3),
    ActiveFlag   CHAR(1),
    createdAt    TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy    VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt    TIMESTAMP,
    updatedBy    VARCHAR2(128)
);

-- Region
CREATE TABLE Region (
    RegionID    VARCHAR2(8)   CONSTRAINT PK_Region PRIMARY KEY,
    Name        VARCHAR2(50)  NOT NULL,
    Description VARCHAR2(255),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128)
);

-- Country
CREATE TABLE Country (
    CountryID   VARCHAR2(8)   CONSTRAINT PK_Country PRIMARY KEY,
    Name        VARCHAR2(40)  NOT NULL,
    Description VARCHAR2(100),
    RegionID    VARCHAR2(8),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128),
    CONSTRAINT FK_Country_Region FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- CostType
CREATE TABLE CostType (
    CostTypeID  VARCHAR2(8)   CONSTRAINT PK_CostType PRIMARY KEY,
    Name        VARCHAR2(40)  NOT NULL,
    Description VARCHAR2(100),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128)
);

-- ItemCost
CREATE TABLE ItemCost (
    ItemCostID  VARCHAR2(8)   CONSTRAINT PK_ItemCost PRIMARY KEY,
    Name        VARCHAR2(40)  NOT NULL,
    Email       VARCHAR2(20),
    RatePerUnit NUMBER(10),
    Status      CHAR(1),
    CountryID   VARCHAR2(8),
    CostTypeID  VARCHAR2(8),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128),
    CONSTRAINT FK_ItemCost_Country  FOREIGN KEY (CountryID)  REFERENCES Country(CountryID),
    CONSTRAINT FK_ItemCost_CostType FOREIGN KEY (CostTypeID) REFERENCES CostType(CostTypeID)
);

-- Guide
CREATE TABLE Guide (
    GuideID        VARCHAR2(8)   CONSTRAINT PK_Guide PRIMARY KEY,
    Name           VARCHAR2(40)  NOT NULL,
    Email          VARCHAR2(20),
    LanguageSkills VARCHAR2(20),
    Phone          VARCHAR2(30),
    Specialty      VARCHAR2(80),
    Salary         NUMBER(10),
    Status         VARCHAR2(10),
    createdAt      TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy      VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt      TIMESTAMP,
    updatedBy      VARCHAR2(128)
);

-- Tour
CREATE TABLE Tour (
    TourID      VARCHAR2(8)   CONSTRAINT PK_Tour PRIMARY KEY,
    TourCode    VARCHAR2(20)  NOT NULL,
    TourTypeID  VARCHAR2(8),
    Name        VARCHAR2(40)  NOT NULL,
    CapacityPax NUMBER(2),
    StartDate   DATE,
    EndDate     DATE,
    Status      VARCHAR2(10),
    CountryID   VARCHAR2(8),
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128),
    CONSTRAINT UQ_Tour_TourCode UNIQUE (TourCode),
    CONSTRAINT FK_Tour_TourType FOREIGN KEY (TourTypeID) REFERENCES TourType(TourTypeID),
    CONSTRAINT FK_Tour_Country  FOREIGN KEY (CountryID)  REFERENCES Country(CountryID)
);

-- TourDetail
CREATE TABLE TourDetail (
    TourID         VARCHAR2(8)   NOT NULL,
    DayNo          NUMBER(3),
    TourPlanID     VARCHAR2(8)   NOT NULL,
    Title          VARCHAR2(100),
    Description    VARCHAR2(500),
    Meal           VARCHAR2(50),
    HotelName      VARCHAR2(100),
    TransportNote  VARCHAR2(100),
    createdAt      TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy      VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt      TIMESTAMP,
    updatedBy      VARCHAR2(128),
    CONSTRAINT PK_TourDetail       PRIMARY KEY (TourID, DayNo),
    CONSTRAINT FK_TourDetail_Tour  FOREIGN KEY (TourID)     REFERENCES Tour(TourID)     ON DELETE CASCADE,
    CONSTRAINT FK_TourDetail_Plan  FOREIGN KEY (TourPlanID) REFERENCES TourPlan(TourPlanID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER TRG_TourDetail_DayNo
BEFORE INSERT ON TourDetail
FOR EACH ROW
DECLARE
    v_next_dayno NUMBER;
BEGIN
    IF :NEW.DayNo IS NULL THEN
        SELECT NVL(MAX(DayNo), 0) + 1
          INTO v_next_dayno
          FROM TourDetail
         WHERE TourID = :NEW.TourID;
        :NEW.DayNo := v_next_dayno;
    END IF;
END;
/

-- Promotion
CREATE TABLE Promotion (
    PromotionID   VARCHAR2(8)   CONSTRAINT PK_Promotion PRIMARY KEY,
    Name          VARCHAR2(40)  NOT NULL,
    MinPax        NUMBER(2),
    DiscountValue NUMBER(2),
    StartDate     DATE,
    EndDate       DATE,
    Status        VARCHAR2(10),
    createdAt     TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy     VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt     TIMESTAMP,
    updatedBy     VARCHAR2(128),
    CONSTRAINT CK_Promotion_DateRange CHECK (
        EndDate IS NULL OR StartDate IS NULL OR EndDate >= StartDate
    )
);

-- CustomerType
CREATE TABLE CustomerType (
    CustTypeID   VARCHAR2(5)    CONSTRAINT PK_CustomerType PRIMARY KEY,
    Name         VARCHAR2(100)  CONSTRAINT UQ_CustomerType_Name UNIQUE NOT NULL,
    DiscountRate NUMBER(5, 2)   NOT NULL,
    createdAt    TIMESTAMP      DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy    VARCHAR2(128)  DEFAULT USER NOT NULL,
    updatedAt    TIMESTAMP,
    updatedBy    VARCHAR2(128),
    CONSTRAINT CK_CustomerType_DiscountRate CHECK (DiscountRate >= 0 AND DiscountRate <= 100)
);

-- Customer
CREATE TABLE Customer (
    CustomerID  VARCHAR2(8)   CONSTRAINT PK_Customer PRIMARY KEY,
    CustTypeID  VARCHAR2(5)   NOT NULL,
    Name        VARCHAR2(200) NOT NULL,
    Phone       VARCHAR2(30)  NOT NULL,
    Address     VARCHAR2(300) NOT NULL,
    PassportNo  VARCHAR2(30)  NOT NULL,
    Nationality VARCHAR2(80)  NOT NULL,
    DOB         DATE          NOT NULL,
    createdAt   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy   VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt   TIMESTAMP,
    updatedBy   VARCHAR2(128),
    CONSTRAINT FK_Customer_CustomerType FOREIGN KEY (CustTypeID) REFERENCES CustomerType(CustTypeID),
    CONSTRAINT UQ_Customer_PassportNo   UNIQUE (PassportNo)
);

-- Booking
CREATE TABLE Booking (
    BookingID     VARCHAR2(8)    CONSTRAINT PK_Booking PRIMARY KEY,
    CustomerID    VARCHAR2(8)    NOT NULL,
    PromotionID   VARCHAR2(8),
    EmpNo         VARCHAR2(8)    NOT NULL,
    BookingDate   DATE           NOT NULL,
    BookingStatus VARCHAR2(20)   NOT NULL,
    PaymentStatus VARCHAR2(20)   NOT NULL,
    PaymentMethod VARCHAR2(20)   NOT NULL,
    TotalPax      NUMBER(3)      NOT NULL,
    TotalAmount   NUMBER(12, 2)  NOT NULL,
    createdAt     TIMESTAMP      DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy     VARCHAR2(128)  DEFAULT USER NOT NULL,
    updatedAt     TIMESTAMP,
    updatedBy     VARCHAR2(128),
    CONSTRAINT FK_Booking_Customer  FOREIGN KEY (CustomerID)  REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Booking_Employee  FOREIGN KEY (EmpNo)       REFERENCES Employee(EmpNo),
    CONSTRAINT FK_Booking_Promotion FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID),
    CONSTRAINT CK_Booking_TotalPax    CHECK (TotalPax > 0),
    CONSTRAINT CK_Booking_TotalAmount CHECK (TotalAmount >= 0),
    CONSTRAINT CK_Booking_BookingStatus CHECK (
        BookingStatus IN ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED')
    ),
    CONSTRAINT CK_Booking_PaymentStatus CHECK (
        PaymentStatus IN ('UNPAID', 'PAID', 'REFUNDED', 'PARTIAL')
    ),
    CONSTRAINT CK_Booking_PaymentMethod CHECK (
        PaymentMethod IN ('CASH', 'CARD', 'TRANSFER', 'E-WALLET')
    )
);

-- BookingDetail
CREATE TABLE BookingDetail (
    BookingID     VARCHAR2(8)   NOT NULL,
    SeqNo         NUMBER(3)     NOT NULL,
    TourID        VARCHAR2(8)   NOT NULL,
    ServDateFrom  DATE          NOT NULL,
    ServDateTo    DATE          NOT NULL,
    PaxAdult      NUMBER(3)     NOT NULL,
    PaxChild      NUMBER(3)     NOT NULL,
    UnitPrice     NUMBER(12, 2) NOT NULL,
    SubTotalAmount NUMBER(12, 2) NOT NULL,
    createdAt     TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy     VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt     TIMESTAMP,
    updatedBy     VARCHAR2(128),
    CONSTRAINT PK_BookingDetail         PRIMARY KEY (BookingID, SeqNo),
    CONSTRAINT FK_BookingDetail_Booking FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE,
    CONSTRAINT FK_BookingDetail_Tour    FOREIGN KEY (TourID)    REFERENCES Tour(TourID),
    CONSTRAINT CK_BookingDetail_ServDate  CHECK (ServDateTo >= ServDateFrom),
    CONSTRAINT CK_BookingDetail_PaxAdult  CHECK (PaxAdult >= 0),
    CONSTRAINT CK_BookingDetail_PaxChild  CHECK (PaxChild >= 0),
    CONSTRAINT CK_BookingDetail_UnitPrice CHECK (UnitPrice >= 0),
    CONSTRAINT CK_BookingDetail_SubTotal  CHECK (SubTotalAmount >= 0)
);

CREATE OR REPLACE TRIGGER TRG_BookingDetail_SeqNo
BEFORE INSERT ON BookingDetail
FOR EACH ROW
DECLARE
    v_next_seqno NUMBER;
BEGIN
    IF :NEW.SeqNo IS NULL THEN
        SELECT NVL(MAX(SeqNo), 0) + 1
          INTO v_next_seqno
          FROM BookingDetail
         WHERE BookingID = :NEW.BookingID;
        :NEW.SeqNo := v_next_seqno;
    END IF;
END;
/

-- CostDetail
CREATE TABLE CostDetail (
    TourID     VARCHAR2(8)   NOT NULL,
    SeqNo      NUMBER(3)     NOT NULL,
    GuideID    VARCHAR2(8),
    ItemCostID VARCHAR2(8)   NOT NULL,
    FeeAmount  NUMBER(12, 2) NOT NULL,
    Quantity   NUMBER(6)     NOT NULL,
    Note       VARCHAR2(255),
    StartDate  DATE          NOT NULL,
    EndDate    DATE          NOT NULL,
    createdAt  TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy  VARCHAR2(128) DEFAULT USER NOT NULL,
    updatedAt  TIMESTAMP,
    updatedBy  VARCHAR2(128),
    CONSTRAINT PK_CostDetail          PRIMARY KEY (TourID, SeqNo),
    CONSTRAINT FK_CostDetail_Tour     FOREIGN KEY (TourID)     REFERENCES Tour(TourID),
    CONSTRAINT FK_CostDetail_Guide    FOREIGN KEY (GuideID)    REFERENCES Guide(GuideID),
    CONSTRAINT FK_CostDetail_ItemCost FOREIGN KEY (ItemCostID) REFERENCES ItemCost(ItemCostID),
    CONSTRAINT CK_CostDetail_Quantity  CHECK (Quantity > 0),
    CONSTRAINT CK_CostDetail_FeeAmount CHECK (FeeAmount >= 0),
    CONSTRAINT CK_CostDetail_DateRange CHECK (EndDate >= StartDate)
);

CREATE OR REPLACE TRIGGER TRG_CostDetail_SeqNo
BEFORE INSERT ON CostDetail
FOR EACH ROW
DECLARE
    v_next_seqno NUMBER;
BEGIN
    IF :NEW.SeqNo IS NULL THEN
        SELECT NVL(MAX(SeqNo), 0) + 1
          INTO v_next_seqno
          FROM CostDetail
         WHERE TourID = :NEW.TourID;
        :NEW.SeqNo := v_next_seqno;
    END IF;
END;
/

-- PromotionDetail
CREATE TABLE PromotionDetail (
    PromotionID      VARCHAR2(8)    NOT NULL,
    SeqNo            NUMBER(3)      NOT NULL,
    TourID           VARCHAR2(8)    NOT NULL,
    DiscountPercent  NUMBER(5, 2)   NOT NULL,
    StartDate        DATE           NOT NULL,
    EndDate          DATE           NOT NULL,
    ExtraCondition   VARCHAR2(255),
    MinBookAmount    NUMBER(12, 2)  DEFAULT 0 NOT NULL,
    createdAt        TIMESTAMP      DEFAULT SYSTIMESTAMP NOT NULL,
    createdBy        VARCHAR2(128)  DEFAULT USER NOT NULL,
    updatedAt        TIMESTAMP,
    updatedBy        VARCHAR2(128),
    CONSTRAINT PK_PromotionDetail        PRIMARY KEY (PromotionID, SeqNo),
    CONSTRAINT FK_PromoDetail_Promo      FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID) ON DELETE CASCADE,
    CONSTRAINT FK_PromoDetail_Tour       FOREIGN KEY (TourID)      REFERENCES Tour(TourID),
    CONSTRAINT CK_PromoDetail_DiscountPer CHECK (
        DiscountPercent >= 0 AND DiscountPercent <= 100
    ),
    CONSTRAINT CK_PromoDetail_DateRange     CHECK (EndDate >= StartDate),
    CONSTRAINT CK_PromoDetail_MinBookAmount CHECK (MinBookAmount >= 0)
);

CREATE OR REPLACE TRIGGER TRG_PromotionDetail_SeqNo
BEFORE INSERT ON PromotionDetail
FOR EACH ROW
DECLARE
    v_next_seqno NUMBER;
BEGIN
    IF :NEW.SeqNo IS NULL THEN
        SELECT NVL(MAX(SeqNo), 0) + 1
          INTO v_next_seqno
          FROM PromotionDetail
         WHERE PromotionID = :NEW.PromotionID;
        :NEW.SeqNo := v_next_seqno;
    END IF;
END;
/
