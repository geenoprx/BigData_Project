CREATE TABLE DIM_DATE (
    DateKey         NUMBER(8)       CONSTRAINT PK_DimDate PRIMARY KEY,
    FullDate        DATE            NOT NULL,
    DayOfWeek       VARCHAR2(10),
    DayOfMonth      NUMBER(2),
    Month           NUMBER(2),
    MonthName       VARCHAR2(10),
    Quarter         NUMBER(1),
    Year            NUMBER(4),
    Season          VARCHAR2(20)
);

-- SCD2: ExperienceYears and ExperienceBand change over time; history is kept to reflect farmer's skill level at the time of each harvest.
CREATE TABLE DIM_FARMER (
    FarmerKey           NUMBER          CONSTRAINT PK_DimFarmer PRIMARY KEY,
    FarmerID            VARCHAR2(8)     NOT NULL,
    FarmerName          VARCHAR2(100)   NOT NULL,
    Phone               VARCHAR2(20),
    ExperienceYears     NUMBER(3),
    ExperienceBand      VARCHAR2(20),
    EffectiveFrom       DATE            NOT NULL,
    EffectiveTo         DATE,
    IsCurrent           CHAR(1)         NOT NULL,
    CONSTRAINT CHK_Farmer_IsCurrent     CHECK (IsCurrent IN ('Y', 'N')),
    CONSTRAINT CHK_Farmer_EffectiveDates CHECK (EffectiveTo IS NULL OR EffectiveTo > EffectiveFrom)
);

CREATE UNIQUE INDEX UQ_DimFarmer_CurrentRow
    ON DIM_FARMER (CASE WHEN IsCurrent = 'Y' THEN FarmerID END);

CREATE TABLE DIM_VARIETY (
    VarietyKey          NUMBER          CONSTRAINT PK_DimVariety PRIMARY KEY,
    VarietyID           VARCHAR2(8)     NOT NULL,
    VarietyCode         VARCHAR2(20)    NOT NULL,
    VarietyName         VARCHAR2(100)   NOT NULL,
    SkinType            VARCHAR2(50),
    StdHarvestDays      NUMBER(3)
);

-- SCD2: PricePerUnit changes with market price; history is kept to calculate accurate cost at the time each care activity occurred.
CREATE TABLE DIM_INPUT (
    InputKey            NUMBER          CONSTRAINT PK_DimInput PRIMARY KEY,
    InputID             VARCHAR2(8)     NOT NULL,
    InputName           VARCHAR2(100)   NOT NULL,
    InputType           VARCHAR2(50),
    Unit                VARCHAR2(20),
    PricePerUnit        NUMBER(10, 2),
    EffectiveFrom       DATE            NOT NULL,
    EffectiveTo         DATE,
    IsCurrent           CHAR(1)         NOT NULL,
    CONSTRAINT CHK_Input_IsCurrent      CHECK (IsCurrent IN ('Y', 'N')),
    CONSTRAINT CHK_Input_EffectiveDates CHECK (EffectiveTo IS NULL OR EffectiveTo > EffectiveFrom)
);

CREATE UNIQUE INDEX UQ_DimInput_CurrentRow
    ON DIM_INPUT (CASE WHEN IsCurrent = 'Y' THEN InputID END);

-- SCD2: PhLevel and SoilType change after soil treatment; history is kept to correlate soil condition with harvest quality at that time.
CREATE TABLE DIM_PLOT (
    PlotKey             NUMBER          CONSTRAINT PK_DimPlot PRIMARY KEY,
    PlotID              VARCHAR2(8)     NOT NULL,
    PlotCode            VARCHAR2(20)    NOT NULL,
    PlotName            VARCHAR2(100),
    AreaRai             NUMBER(10, 2),
    PhLevel             NUMBER(4, 2),
    SoilType            VARCHAR2(50),
    PlotTypeID          VARCHAR2(8),
    PlotTypeCode        VARCHAR2(20),
    PlotTypeName        VARCHAR2(100),
    EffectiveFrom       DATE            NOT NULL,
    EffectiveTo         DATE,
    IsCurrent           CHAR(1)         NOT NULL,
    CONSTRAINT CHK_Plot_IsCurrent       CHECK (IsCurrent IN ('Y', 'N')),
    CONSTRAINT CHK_Plot_EffectiveDates  CHECK (EffectiveTo IS NULL OR EffectiveTo > EffectiveFrom)
);

CREATE UNIQUE INDEX UQ_DimPlot_CurrentRow
    ON DIM_PLOT (CASE WHEN IsCurrent = 'Y' THEN PlotID END);
