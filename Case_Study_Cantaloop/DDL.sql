-- Farmer profile and experience
CREATE TABLE FARMER (
    FarmerID        VARCHAR2(8)     CONSTRAINT PK_Farmer PRIMARY KEY,
    FarmerName      VARCHAR2(100)   NOT NULL,
    Phone           VARCHAR2(20),
    ExperienceYears NUMBER(3)
);

-- Cantaloop seed variety catalogue
CREATE TABLE VARIETY (
    VarietyID       VARCHAR2(8)     CONSTRAINT PK_Variety PRIMARY KEY,
    VarietyCode     VARCHAR2(20)    NOT NULL CONSTRAINT UQ_Variety_Code UNIQUE,
    VarietyName     VARCHAR2(100)   NOT NULL,
    SkinType        VARCHAR2(50),
    StdHarvestDays  NUMBER(3)
);

-- Lookup for plot type classification
CREATE TABLE PLOT_TYPE (
    PlotTypeID      VARCHAR2(8)     CONSTRAINT PK_PlotType PRIMARY KEY,
    PlotTypeCode    VARCHAR2(20)    NOT NULL CONSTRAINT UQ_PlotType_Code UNIQUE,
    PlotTypeName    VARCHAR2(100)   NOT NULL
);

-- Physical farm plot (central entity referenced by all event tables)
CREATE TABLE PLOT (
    PlotID          VARCHAR2(8)     CONSTRAINT PK_Plot PRIMARY KEY,
    PlotCode        VARCHAR2(20)    NOT NULL CONSTRAINT UQ_Plot_Code UNIQUE,
    PlotName        VARCHAR2(100),
    AreaRai         NUMBER(10, 2),
    PlotTypeID      VARCHAR2(8),
    PhLevel         NUMBER(4, 2),
    SoilType        VARCHAR2(50),
    CONSTRAINT FK_Plot_PlotType FOREIGN KEY (PlotTypeID) REFERENCES PLOT_TYPE (PlotTypeID)
);

-- Production input catalogue (fertilizer, pesticide, etc.)
CREATE TABLE INPUT (
    InputID         VARCHAR2(8)     CONSTRAINT PK_Input PRIMARY KEY,
    InputName       VARCHAR2(100)   NOT NULL,
    InputType       VARCHAR2(50),
    Unit            VARCHAR2(20),
    PricePerUnit    NUMBER(10, 2)
);

-- Event: seedling germination batch on a plot
CREATE TABLE SEEDLING (
    SeedlingID      VARCHAR2(8)     CONSTRAINT PK_Seedling PRIMARY KEY,
    PlotID          VARCHAR2(8)     NOT NULL,
    VarietyID       VARCHAR2(8)     NOT NULL,
    FarmerID        VARCHAR2(8)     NOT NULL,
    SeedDate        DATE            NOT NULL,
    SeedQtyGram     NUMBER(10, 2),
    SproutCount     NUMBER(5),
    CONSTRAINT FK_Seedling_Plot     FOREIGN KEY (PlotID)    REFERENCES PLOT (PlotID),
    CONSTRAINT FK_Seedling_Variety  FOREIGN KEY (VarietyID) REFERENCES VARIETY (VarietyID),
    CONSTRAINT FK_Seedling_Farmer   FOREIGN KEY (FarmerID)  REFERENCES FARMER (FarmerID)
);

-- Event: transplanting seedlings into a plot
CREATE TABLE PLANTING (
    PlantingID      VARCHAR2(8)     CONSTRAINT PK_Planting PRIMARY KEY,
    PlotID          VARCHAR2(8)     NOT NULL,
    VarietyID       VARCHAR2(8)     NOT NULL,
    PlantDate       DATE            NOT NULL,
    PlantCount      NUMBER(5),
    LimeKg          NUMBER(10, 2),
    CONSTRAINT FK_Planting_Plot     FOREIGN KEY (PlotID)    REFERENCES PLOT (PlotID),
    CONSTRAINT FK_Planting_Variety  FOREIGN KEY (VarietyID) REFERENCES VARIETY (VarietyID)
);

-- Event: maintenance activity on a plot using a specific input
CREATE TABLE CARE (
    CareID          VARCHAR2(8)     CONSTRAINT PK_Care PRIMARY KEY,
    PlotID          VARCHAR2(8)     NOT NULL,
    InputID         VARCHAR2(8)     NOT NULL,
    CareDate        DATE            NOT NULL,
    CareType        VARCHAR2(50),
    QtyUsed         NUMBER(10, 2),
    CostTHB         NUMBER(12, 2),
    CONSTRAINT FK_Care_Plot     FOREIGN KEY (PlotID)    REFERENCES PLOT (PlotID),
    CONSTRAINT FK_Care_Input    FOREIGN KEY (InputID)   REFERENCES INPUT (InputID)
);

-- Event: harvest yield record on a plot
CREATE TABLE HARVEST (
    HarvestID       VARCHAR2(8)     CONSTRAINT PK_Harvest PRIMARY KEY,
    PlotID          VARCHAR2(8)     NOT NULL,
    FarmerID        VARCHAR2(8)     NOT NULL,
    HarvestDate     DATE            NOT NULL,
    TotalWeightKg   NUMBER(10, 2),
    TotalCount      NUMBER(5),
    GradeACount     NUMBER(5),
    RejectCount     NUMBER(5),
    BrixScore       NUMBER(5, 2),
    PricePerKg      NUMBER(10, 2),
    RevenueTHB      NUMBER(15, 2),
    CONSTRAINT FK_Harvest_Plot      FOREIGN KEY (PlotID)    REFERENCES PLOT (PlotID),
    CONSTRAINT FK_Harvest_Farmer    FOREIGN KEY (FarmerID)  REFERENCES FARMER (FarmerID)
);
