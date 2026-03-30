-- Surrogate key sequences for all dimension and fact tables
CREATE SEQUENCE SEQ_DIM_DATE      START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_DIM_FARMER    START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_DIM_VARIETY   START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_DIM_INPUT     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_DIM_PLOT      START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_FACT_HARVEST  START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_FACT_CARE     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_FACT_SEEDLING START WITH 1 INCREMENT BY 1 NOCACHE;

-- Generates one row per day between p_start and p_end. Safe to re-run.
CREATE OR REPLACE PROCEDURE ETL_LOAD_DIM_DATE (
    p_start DATE DEFAULT TO_DATE('2020-01-01', 'YYYY-MM-DD'),
    p_end   DATE DEFAULT TO_DATE('2030-12-31', 'YYYY-MM-DD')
) AS
    v_date DATE := p_start;
    v_key  NUMBER;
BEGIN
    WHILE v_date <= p_end LOOP
        v_key := TO_NUMBER(TO_CHAR(v_date, 'YYYYMMDD'));

        BEGIN
            INSERT INTO DIM_DATE (
                DateKey, FullDate, DayOfWeek, DayOfMonth,
                Month, MonthName, Quarter, Year, Season
            ) VALUES (
                v_key,
                v_date,
                TO_CHAR(v_date, 'Day'),
                EXTRACT(DAY   FROM v_date),
                EXTRACT(MONTH FROM v_date),
                TO_CHAR(v_date, 'Month'),
                CEIL(EXTRACT(MONTH FROM v_date) / 3),
                EXTRACT(YEAR  FROM v_date),
                CASE
                    WHEN EXTRACT(MONTH FROM v_date) IN (3,4,5)      THEN 'Hot'
                    WHEN EXTRACT(MONTH FROM v_date) IN (6,7,8,9,10) THEN 'Rainy'
                    ELSE 'Cool'
                END
            );
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN NULL;
        END;

        v_date := v_date + 1;
    END LOOP;
    COMMIT;
END ETL_LOAD_DIM_DATE;
/

-- SCD2: inserts new farmer or closes old row and adds new version when ExperienceYears changes.
CREATE OR REPLACE PROCEDURE ETL_LOAD_DIM_FARMER AS
    v_exp_band  VARCHAR2(20);
    v_curr_key  NUMBER;
    v_curr_exp  NUMBER;

    CURSOR c_src IS SELECT FarmerID, FarmerName, Phone, ExperienceYears FROM FARMER;
BEGIN
    FOR src IN c_src LOOP

        v_exp_band := CASE
            WHEN src.ExperienceYears < 3  THEN 'Novice'
            WHEN src.ExperienceYears < 10 THEN 'Intermediate'
            ELSE 'Expert'
        END;

        BEGIN
            SELECT FarmerKey, ExperienceYears
              INTO v_curr_key, v_curr_exp
              FROM DIM_FARMER
             WHERE FarmerID = src.FarmerID AND IsCurrent = 'Y';

            IF v_curr_exp != src.ExperienceYears THEN
                UPDATE DIM_FARMER
                   SET IsCurrent   = 'N',
                       EffectiveTo = SYSDATE
                 WHERE FarmerKey = v_curr_key;

                INSERT INTO DIM_FARMER (
                    FarmerKey, FarmerID, FarmerName, Phone,
                    ExperienceYears, ExperienceBand,
                    EffectiveFrom, EffectiveTo, IsCurrent
                ) VALUES (
                    SEQ_DIM_FARMER.NEXTVAL, src.FarmerID, src.FarmerName, src.Phone,
                    src.ExperienceYears, v_exp_band,
                    SYSDATE, NULL, 'Y'
                );
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO DIM_FARMER (
                    FarmerKey, FarmerID, FarmerName, Phone,
                    ExperienceYears, ExperienceBand,
                    EffectiveFrom, EffectiveTo, IsCurrent
                ) VALUES (
                    SEQ_DIM_FARMER.NEXTVAL, src.FarmerID, src.FarmerName, src.Phone,
                    src.ExperienceYears, v_exp_band,
                    SYSDATE, NULL, 'Y'
                );
        END;
    END LOOP;
    COMMIT;
END ETL_LOAD_DIM_FARMER;
/

-- Inserts new varieties only. No SCD2 — variety data is stable.
CREATE OR REPLACE PROCEDURE ETL_LOAD_DIM_VARIETY AS
BEGIN
    MERGE INTO DIM_VARIETY tgt
    USING (SELECT VarietyID, VarietyCode, VarietyName, SkinType, StdHarvestDays FROM VARIETY) src
    ON (tgt.VarietyID = src.VarietyID)
    WHEN NOT MATCHED THEN
        INSERT (VarietyKey, VarietyID, VarietyCode, VarietyName, SkinType, StdHarvestDays)
        VALUES (SEQ_DIM_VARIETY.NEXTVAL, src.VarietyID, src.VarietyCode, src.VarietyName, src.SkinType, src.StdHarvestDays);
    COMMIT;
END ETL_LOAD_DIM_VARIETY;
/

-- SCD2: inserts new input or closes old row and adds new version when PricePerUnit changes.
CREATE OR REPLACE PROCEDURE ETL_LOAD_DIM_INPUT AS
    v_curr_key   NUMBER;
    v_curr_price NUMBER;

    CURSOR c_src IS SELECT InputID, InputName, InputType, Unit, PricePerUnit FROM INPUT;
BEGIN
    FOR src IN c_src LOOP

        BEGIN
            SELECT InputKey, PricePerUnit
              INTO v_curr_key, v_curr_price
              FROM DIM_INPUT
             WHERE InputID = src.InputID AND IsCurrent = 'Y';

            IF v_curr_price != src.PricePerUnit THEN
                UPDATE DIM_INPUT
                   SET IsCurrent   = 'N',
                       EffectiveTo = SYSDATE
                 WHERE InputKey = v_curr_key;

                INSERT INTO DIM_INPUT (
                    InputKey, InputID, InputName, InputType, Unit, PricePerUnit,
                    EffectiveFrom, EffectiveTo, IsCurrent
                ) VALUES (
                    SEQ_DIM_INPUT.NEXTVAL, src.InputID, src.InputName, src.InputType, src.Unit, src.PricePerUnit,
                    SYSDATE, NULL, 'Y'
                );
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO DIM_INPUT (
                    InputKey, InputID, InputName, InputType, Unit, PricePerUnit,
                    EffectiveFrom, EffectiveTo, IsCurrent
                ) VALUES (
                    SEQ_DIM_INPUT.NEXTVAL, src.InputID, src.InputName, src.InputType, src.Unit, src.PricePerUnit,
                    SYSDATE, NULL, 'Y'
                );
        END;
    END LOOP;
    COMMIT;
END ETL_LOAD_DIM_INPUT;
/

-- SCD2: inserts new plot or closes old row and adds new version when PhLevel or SoilType changes.
-- Flattens PLOT_TYPE attributes to avoid joins at query time.
CREATE OR REPLACE PROCEDURE ETL_LOAD_DIM_PLOT AS
    v_curr_key  NUMBER;
    v_curr_ph   NUMBER;
    v_curr_soil VARCHAR2(50);

    CURSOR c_src IS
        SELECT p.PlotID, p.PlotCode, p.PlotName, p.AreaRai,
               p.PhLevel, p.SoilType,
               p.PlotTypeID, pt.PlotTypeCode, pt.PlotTypeName
          FROM PLOT p
          LEFT JOIN PLOT_TYPE pt ON pt.PlotTypeID = p.PlotTypeID;
BEGIN
    FOR src IN c_src LOOP

        BEGIN
            SELECT PlotKey, PhLevel, SoilType
              INTO v_curr_key, v_curr_ph, v_curr_soil
              FROM DIM_PLOT
             WHERE PlotID = src.PlotID AND IsCurrent = 'Y';

            IF NVL(v_curr_ph, -1) != NVL(src.PhLevel, -1) OR NVL(v_curr_soil,'~') != NVL(src.SoilType,'~') THEN
                UPDATE DIM_PLOT
                   SET IsCurrent   = 'N',
                       EffectiveTo = SYSDATE
                 WHERE PlotKey = v_curr_key;

                INSERT INTO DIM_PLOT (
                    PlotKey, PlotID, PlotCode, PlotName, AreaRai,
                    PhLevel, SoilType, PlotTypeID, PlotTypeCode, PlotTypeName,
                    EffectiveFrom, EffectiveTo, IsCurrent
                ) VALUES (
                    SEQ_DIM_PLOT.NEXTVAL, src.PlotID, src.PlotCode, src.PlotName, src.AreaRai,
                    src.PhLevel, src.SoilType, src.PlotTypeID, src.PlotTypeCode, src.PlotTypeName,
                    SYSDATE, NULL, 'Y'
                );
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO DIM_PLOT (
                    PlotKey, PlotID, PlotCode, PlotName, AreaRai,
                    PhLevel, SoilType, PlotTypeID, PlotTypeCode, PlotTypeName,
                    EffectiveFrom, EffectiveTo, IsCurrent
                ) VALUES (
                    SEQ_DIM_PLOT.NEXTVAL, src.PlotID, src.PlotCode, src.PlotName, src.AreaRai,
                    src.PhLevel, src.SoilType, src.PlotTypeID, src.PlotTypeCode, src.PlotTypeName,
                    SYSDATE, NULL, 'Y'
                );
        END;
    END LOOP;
    COMMIT;
END ETL_LOAD_DIM_PLOT;
/

-- Loads new harvest events. VarietyKey resolved from most recent PLANTING before HarvestDate.
CREATE OR REPLACE PROCEDURE ETL_LOAD_FACT_HARVEST AS
    v_date_key    NUMBER(8);
    v_plot_key    NUMBER;
    v_farmer_key  NUMBER;
    v_variety_key NUMBER;

    CURSOR c_src IS
        SELECT h.HarvestID, h.PlotID, h.FarmerID, h.HarvestDate,
               h.TotalWeightKg, h.TotalCount, h.GradeACount,
               h.RejectCount, h.BrixScore, h.RevenueTHB
          FROM HARVEST h
         WHERE NOT EXISTS (
               SELECT 1 FROM FACT_HARVEST f
                WHERE f.DateKey   = TO_NUMBER(TO_CHAR(h.HarvestDate, 'YYYYMMDD'))
                  AND f.PlotKey   = (SELECT PlotKey   FROM DIM_PLOT   WHERE PlotID   = h.PlotID   AND IsCurrent = 'Y')
                  AND f.FarmerKey = (SELECT FarmerKey FROM DIM_FARMER WHERE FarmerID = h.FarmerID AND IsCurrent = 'Y')
         );
BEGIN
    FOR src IN c_src LOOP
        v_date_key := TO_NUMBER(TO_CHAR(src.HarvestDate, 'YYYYMMDD'));

        SELECT PlotKey   INTO v_plot_key   FROM DIM_PLOT   WHERE PlotID   = src.PlotID   AND IsCurrent = 'Y';
        SELECT FarmerKey INTO v_farmer_key FROM DIM_FARMER WHERE FarmerID = src.FarmerID AND IsCurrent = 'Y';

        SELECT VarietyKey INTO v_variety_key
          FROM DIM_VARIETY
         WHERE VarietyID = (
               SELECT VarietyID FROM PLANTING
                WHERE PlotID    = src.PlotID
                  AND PlantDate = (SELECT MAX(PlantDate) FROM PLANTING
                                    WHERE PlotID    = src.PlotID
                                      AND PlantDate <= src.HarvestDate)
                  AND ROWNUM = 1
         );

        INSERT INTO FACT_HARVEST (
            HarvestKey, DateKey, PlotKey, FarmerKey, VarietyKey,
            TotalWeightKg, TotalCount, GradeACount, RejectCount, BrixScore, RevenueTHB
        ) VALUES (
            SEQ_FACT_HARVEST.NEXTVAL, v_date_key, v_plot_key, v_farmer_key, v_variety_key,
            src.TotalWeightKg, src.TotalCount, src.GradeACount, src.RejectCount, src.BrixScore, src.RevenueTHB
        );
    END LOOP;
    COMMIT;
END ETL_LOAD_FACT_HARVEST;
/

-- Loads new care activities. Skips already loaded records by CareID.
CREATE OR REPLACE PROCEDURE ETL_LOAD_FACT_CARE AS
    v_date_key  NUMBER(8);
    v_plot_key  NUMBER;
    v_input_key NUMBER;

    CURSOR c_src IS
        SELECT c.CareID, c.PlotID, c.InputID, c.CareDate, c.QtyUsed, c.CostTHB
          FROM CARE c
         WHERE NOT EXISTS (
               SELECT 1 FROM FACT_CARE f
                WHERE f.DateKey  = TO_NUMBER(TO_CHAR(c.CareDate, 'YYYYMMDD'))
                  AND f.PlotKey  = (SELECT PlotKey  FROM DIM_PLOT  WHERE PlotID  = c.PlotID  AND IsCurrent = 'Y')
                  AND f.InputKey = (SELECT InputKey FROM DIM_INPUT WHERE InputID = c.InputID AND IsCurrent = 'Y')
         );
BEGIN
    FOR src IN c_src LOOP
        v_date_key := TO_NUMBER(TO_CHAR(src.CareDate, 'YYYYMMDD'));

        SELECT PlotKey  INTO v_plot_key  FROM DIM_PLOT  WHERE PlotID  = src.PlotID  AND IsCurrent = 'Y';
        SELECT InputKey INTO v_input_key FROM DIM_INPUT WHERE InputID = src.InputID AND IsCurrent = 'Y';

        INSERT INTO FACT_CARE (
            CareKey, DateKey, PlotKey, InputKey, QtyUsed, CostTHB
        ) VALUES (
            SEQ_FACT_CARE.NEXTVAL, v_date_key, v_plot_key, v_input_key,
            src.QtyUsed, src.CostTHB
        );
    END LOOP;
    COMMIT;
END ETL_LOAD_FACT_CARE;
/

-- Loads new seedling batches. Skips already loaded records by SeedlingID.
CREATE OR REPLACE PROCEDURE ETL_LOAD_FACT_SEEDLING AS
    v_date_key    NUMBER(8);
    v_plot_key    NUMBER;
    v_farmer_key  NUMBER;
    v_variety_key NUMBER;

    CURSOR c_src IS
        SELECT s.SeedlingID, s.PlotID, s.FarmerID, s.VarietyID,
               s.SeedDate, s.SeedQtyGram, s.SproutCount
          FROM SEEDLING s
         WHERE NOT EXISTS (
               SELECT 1 FROM FACT_SEEDLING f
                WHERE f.DateKey    = TO_NUMBER(TO_CHAR(s.SeedDate, 'YYYYMMDD'))
                  AND f.PlotKey    = (SELECT PlotKey    FROM DIM_PLOT    WHERE PlotID    = s.PlotID    AND IsCurrent = 'Y')
                  AND f.FarmerKey  = (SELECT FarmerKey  FROM DIM_FARMER  WHERE FarmerID  = s.FarmerID  AND IsCurrent = 'Y')
                  AND f.VarietyKey = (SELECT VarietyKey FROM DIM_VARIETY WHERE VarietyID = s.VarietyID)
         );
BEGIN
    FOR src IN c_src LOOP
        v_date_key := TO_NUMBER(TO_CHAR(src.SeedDate, 'YYYYMMDD'));

        SELECT PlotKey    INTO v_plot_key    FROM DIM_PLOT    WHERE PlotID    = src.PlotID    AND IsCurrent = 'Y';
        SELECT FarmerKey  INTO v_farmer_key  FROM DIM_FARMER  WHERE FarmerID  = src.FarmerID  AND IsCurrent = 'Y';
        SELECT VarietyKey INTO v_variety_key FROM DIM_VARIETY WHERE VarietyID = src.VarietyID;

        INSERT INTO FACT_SEEDLING (
            SeedlingKey, DateKey, PlotKey, FarmerKey, VarietyKey,
            SeedQtyGram, SproutCount
        ) VALUES (
            SEQ_FACT_SEEDLING.NEXTVAL, v_date_key, v_plot_key, v_farmer_key, v_variety_key,
            src.SeedQtyGram, src.SproutCount
        );
    END LOOP;
    COMMIT;
END ETL_LOAD_FACT_SEEDLING;
/

-- Master procedure: loads all dimensions first, then facts.
CREATE OR REPLACE PROCEDURE ETL_RUN_ALL AS
BEGIN
    ETL_LOAD_DIM_DATE;
    ETL_LOAD_DIM_FARMER;
    ETL_LOAD_DIM_VARIETY;
    ETL_LOAD_DIM_INPUT;
    ETL_LOAD_DIM_PLOT;
    ETL_LOAD_FACT_SEEDLING;
    ETL_LOAD_FACT_CARE;
    ETL_LOAD_FACT_HARVEST;
END ETL_RUN_ALL;
/
