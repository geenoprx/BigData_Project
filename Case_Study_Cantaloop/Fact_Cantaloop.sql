CREATE TABLE FACT_HARVEST (
    HarvestKey      NUMBER          CONSTRAINT PK_FactHarvest PRIMARY KEY,
    DateKey         NUMBER(8)       NOT NULL,
    PlotKey         NUMBER          NOT NULL,
    FarmerKey       NUMBER          NOT NULL,
    VarietyKey      NUMBER          NOT NULL,
    TotalWeightKg   NUMBER(10, 2),
    TotalCount      NUMBER(5),
    GradeACount     NUMBER(5),
    RejectCount     NUMBER(5),
    BrixScore       NUMBER(5, 2),
    RevenueTHB      NUMBER(15, 2),
    CONSTRAINT FK_FH_Date    FOREIGN KEY (DateKey)    REFERENCES DIM_DATE (DateKey),
    CONSTRAINT FK_FH_Plot    FOREIGN KEY (PlotKey)    REFERENCES DIM_PLOT (PlotKey),
    CONSTRAINT FK_FH_Farmer  FOREIGN KEY (FarmerKey)  REFERENCES DIM_FARMER (FarmerKey),
    CONSTRAINT FK_FH_Variety FOREIGN KEY (VarietyKey) REFERENCES DIM_VARIETY (VarietyKey)
);

CREATE TABLE FACT_CARE (
    CareKey         NUMBER          CONSTRAINT PK_FactCare PRIMARY KEY,
    DateKey         NUMBER(8)       NOT NULL,
    PlotKey         NUMBER          NOT NULL,
    InputKey        NUMBER          NOT NULL,
    QtyUsed         NUMBER(10, 2),
    CostTHB         NUMBER(12, 2),
    CONSTRAINT FK_FC_Date   FOREIGN KEY (DateKey)   REFERENCES DIM_DATE (DateKey),
    CONSTRAINT FK_FC_Plot   FOREIGN KEY (PlotKey)   REFERENCES DIM_PLOT (PlotKey),
    CONSTRAINT FK_FC_Input  FOREIGN KEY (InputKey)  REFERENCES DIM_INPUT (InputKey)
);

CREATE TABLE FACT_SEEDLING (
    SeedlingKey     NUMBER          CONSTRAINT PK_FactSeedling PRIMARY KEY,
    DateKey         NUMBER(8)       NOT NULL,
    PlotKey         NUMBER          NOT NULL,
    FarmerKey       NUMBER          NOT NULL,
    VarietyKey      NUMBER          NOT NULL,
    SeedQtyGram     NUMBER(10, 2),
    SproutCount     NUMBER(5),
    CONSTRAINT FK_FS_Date    FOREIGN KEY (DateKey)    REFERENCES DIM_DATE (DateKey),
    CONSTRAINT FK_FS_Plot    FOREIGN KEY (PlotKey)    REFERENCES DIM_PLOT (PlotKey),
    CONSTRAINT FK_FS_Farmer  FOREIGN KEY (FarmerKey)  REFERENCES DIM_FARMER (FarmerKey),
    CONSTRAINT FK_FS_Variety FOREIGN KEY (VarietyKey) REFERENCES DIM_VARIETY (VarietyKey)
);
