-- PL/SQL for Master table (Oracle 10g compatible)
-- Error code remapping: all codes are within -20000 to -20999 (Oracle 10g valid range)
--
-- Range allocation:
--   -20001 to -20039 : pkg_booking
--   -20041 to -20056 : pkg_customertype
--   -20061 to -20091 : pkg_customer
--   -20101 to -20126 : pkg_employee
--   -20201 to -20213 : pkg_costtype
--   -20301 to -20325 : pkg_itemcost
--   -20401 to -20413 : pkg_tourplan
--   -20501 to -20516 : pkg_tourtype
--   -20601 to -20614 : pkg_country
--   -20701 to -20714 : pkg_guide
--   -20801 to -20828 : pkg_tour
--   -20901 to -20916 : pkg_promotion
--   -20921 to -20944 : pkg_tourdetail
--   -20951 to -20961 : pkg_bookingdetail
--   -20971 to -20972 : sp_booking_recalc_total
--   -20973 to -20974 : pkg_costdetail
--   -20975 to -20980 : pkg_promodetail
--   -20981 to -20982 : fn_promo_discount
--   -20983 to -20991 : sp_apply_booking_promo

ALTER TABLE Booking MODIFY (
   PromotionID VARCHAR2(8) NULL
);

-- ============================================================
-- Booking
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_booking AS
   PROCEDURE sp_booking_ins (
      p_bookingid     IN Booking.BookingID%TYPE,
      p_customerid    IN Booking.CustomerID%TYPE,
      p_promotionid   IN Booking.PromotionID%TYPE,
      p_empno         IN Booking.EmpNo%TYPE,
      p_bookingdate   IN Booking.BookingDate%TYPE,
      p_bookingstatus IN Booking.BookingStatus%TYPE,
      p_paymentstatus IN Booking.PaymentStatus%TYPE,
      p_paymentmethod IN Booking.PaymentMethod%TYPE,
      p_totalpax      IN Booking.TotalPax%TYPE,
      p_totalamount   IN Booking.TotalAmount%TYPE
   );

   PROCEDURE sp_booking_upd (
      p_bookingid     IN Booking.BookingID%TYPE,
      p_customerid    IN Booking.CustomerID%TYPE,
      p_promotionid   IN Booking.PromotionID%TYPE,
      p_empno         IN Booking.EmpNo%TYPE,
      p_bookingdate   IN Booking.BookingDate%TYPE,
      p_bookingstatus IN Booking.BookingStatus%TYPE,
      p_paymentstatus IN Booking.PaymentStatus%TYPE,
      p_paymentmethod IN Booking.PaymentMethod%TYPE,
      p_totalpax      IN Booking.TotalPax%TYPE,
      p_totalamount   IN Booking.TotalAmount%TYPE
   );
END pkg_booking;
/

CREATE OR REPLACE PACKAGE BODY pkg_booking AS
   PROCEDURE sp_booking_ins (
      p_bookingid     IN Booking.BookingID%TYPE,
      p_customerid    IN Booking.CustomerID%TYPE,
      p_promotionid   IN Booking.PromotionID%TYPE,
      p_empno         IN Booking.EmpNo%TYPE,
      p_bookingdate   IN Booking.BookingDate%TYPE,
      p_bookingstatus IN Booking.BookingStatus%TYPE,
      p_paymentstatus IN Booking.PaymentStatus%TYPE,
      p_paymentmethod IN Booking.PaymentMethod%TYPE,
      p_totalpax      IN Booking.TotalPax%TYPE,
      p_totalamount   IN Booking.TotalAmount%TYPE
   ) IS
      v_dummy         NUMBER;
      v_bookingstatus Booking.BookingStatus%TYPE;
      v_paymentstatus Booking.PaymentStatus%TYPE;
      v_paymentmethod Booking.PaymentMethod%TYPE;
   BEGIN
      IF p_bookingid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20001, 'BookingID is required.');
      END IF;
      IF p_customerid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20002, 'CustomerID is required.');
      END IF;
      IF p_empno IS NULL THEN
         RAISE_APPLICATION_ERROR(-20004, 'EmpNo is required.');
      END IF;
      IF p_bookingdate IS NULL THEN
         RAISE_APPLICATION_ERROR(-20005, 'BookingDate is required.');
      END IF;
      IF p_bookingstatus IS NULL THEN
         RAISE_APPLICATION_ERROR(-20006, 'BookingStatus is required.');
      END IF;
      IF p_paymentstatus IS NULL THEN
         RAISE_APPLICATION_ERROR(-20007, 'PaymentStatus is required.');
      END IF;
      IF p_paymentmethod IS NULL THEN
         RAISE_APPLICATION_ERROR(-20008, 'PaymentMethod is required.');
      END IF;
      IF p_totalpax IS NULL THEN
         RAISE_APPLICATION_ERROR(-20009, 'TotalPax is required.');
      END IF;
      IF p_totalamount IS NULL THEN
         RAISE_APPLICATION_ERROR(-20010, 'TotalAmount is required.');
      END IF;
      IF p_totalpax <= 0 THEN
         RAISE_APPLICATION_ERROR(-20011, 'TotalPax must be > 0.');
      END IF;
      IF p_totalamount < 0 THEN
         RAISE_APPLICATION_ERROR(-20012, 'TotalAmount must be >= 0.');
      END IF;

      v_bookingstatus := NVL(p_bookingstatus, 'PENDING');
      v_paymentstatus := NVL(p_paymentstatus, 'UNPAID');
      v_paymentmethod := NVL(p_paymentmethod, 'CASH');

      IF p_bookingstatus NOT IN ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') THEN
         RAISE_APPLICATION_ERROR(-20013, 'Invalid BookingStatus.');
      END IF;
      IF p_paymentstatus NOT IN ('UNPAID', 'PAID', 'REFUNDED', 'PARTIAL') THEN
         RAISE_APPLICATION_ERROR(-20014, 'Invalid PaymentStatus.');
      END IF;
      IF p_paymentmethod NOT IN ('CASH', 'CARD', 'TRANSFER', 'E-WALLET') THEN
         RAISE_APPLICATION_ERROR(-20015, 'Invalid PaymentMethod.');
      END IF;

      SELECT 1 INTO v_dummy FROM Customer WHERE CustomerID = p_customerid;
      SELECT 1 INTO v_dummy FROM Employee WHERE EmpNo = p_empno;

      IF p_promotionid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Promotion WHERE PromotionID = p_promotionid;
      END IF;

      INSERT INTO Booking (
         BookingID, CustomerID, PromotionID, EmpNo,
         BookingDate, BookingStatus, PaymentStatus, PaymentMethod,
         TotalPax, TotalAmount
      ) VALUES (
         p_bookingid, p_customerid, p_promotionid, p_empno,
         p_bookingdate, p_bookingstatus, p_paymentstatus, p_paymentmethod,
         p_totalpax, p_totalamount
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20020, 'BookingID already exists.');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20021, 'Invalid foreign key: CustomerID / EmpNo / PromotionID not found.');
   END sp_booking_ins;

   PROCEDURE sp_booking_upd (
      p_bookingid     IN Booking.BookingID%TYPE,
      p_customerid    IN Booking.CustomerID%TYPE,
      p_promotionid   IN Booking.PromotionID%TYPE,
      p_empno         IN Booking.EmpNo%TYPE,
      p_bookingdate   IN Booking.BookingDate%TYPE,
      p_bookingstatus IN Booking.BookingStatus%TYPE,
      p_paymentstatus IN Booking.PaymentStatus%TYPE,
      p_paymentmethod IN Booking.PaymentMethod%TYPE,
      p_totalpax      IN Booking.TotalPax%TYPE,
      p_totalamount   IN Booking.TotalAmount%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_bookingid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20031, 'BookingID is required for update.');
      END IF;
      IF p_customerid IS NULL
      OR p_empno IS NULL
      OR p_bookingdate IS NULL
      OR p_bookingstatus IS NULL
      OR p_paymentstatus IS NULL
      OR p_paymentmethod IS NULL
      OR p_totalpax IS NULL
      OR p_totalamount IS NULL THEN
         RAISE_APPLICATION_ERROR(-20032, 'All booking fields are required for update.');
      END IF;
      IF p_totalpax <= 0 THEN
         RAISE_APPLICATION_ERROR(-20033, 'TotalPax must be > 0.');
      END IF;
      IF p_totalamount < 0 THEN
         RAISE_APPLICATION_ERROR(-20034, 'TotalAmount must be >= 0.');
      END IF;
      IF p_bookingstatus NOT IN ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') THEN
         RAISE_APPLICATION_ERROR(-20035, 'Invalid BookingStatus.');
      END IF;
      IF p_paymentstatus NOT IN ('UNPAID', 'PAID', 'REFUNDED', 'PARTIAL') THEN
         RAISE_APPLICATION_ERROR(-20036, 'Invalid PaymentStatus.');
      END IF;
      IF p_paymentmethod NOT IN ('CASH', 'CARD', 'TRANSFER', 'E-WALLET') THEN
         RAISE_APPLICATION_ERROR(-20037, 'Invalid PaymentMethod.');
      END IF;

      SELECT 1 INTO v_dummy FROM Customer WHERE CustomerID = p_customerid;
      SELECT 1 INTO v_dummy FROM Employee  WHERE EmpNo = p_empno;

      IF p_promotionid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Promotion WHERE PromotionID = p_promotionid;
      END IF;

      UPDATE Booking
         SET CustomerID    = p_customerid,
             PromotionID   = p_promotionid,
             EmpNo         = p_empno,
             BookingDate   = p_bookingdate,
             BookingStatus = p_bookingstatus,
             PaymentStatus = p_paymentstatus,
             PaymentMethod = p_paymentmethod,
             TotalPax      = p_totalpax,
             TotalAmount   = p_totalamount
       WHERE BookingID = p_bookingid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20038, 'BookingID not found.');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20039, 'Invalid foreign key: CustomerID / EmpNo / PromotionID not found.');
   END sp_booking_upd;

END pkg_booking;
/

-- ============================================================
-- Employee
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_employee AS
   PROCEDURE sp_employee_ins (
      p_empno      IN Employee.EmpNo%TYPE,
      p_fname      IN Employee.FName%TYPE,
      p_lname      IN Employee.LName%TYPE,
      p_position   IN Employee.Position%TYPE,
      p_startdate  IN Employee.StartDate%TYPE,
      p_resigndate IN Employee.ResignDate%TYPE,
      p_deptcode   IN Employee.DeptCode%TYPE,
      p_status     IN Employee.Status%TYPE
   );

   PROCEDURE sp_employee_upd (
      p_empno      IN Employee.EmpNo%TYPE,
      p_fname      IN Employee.FName%TYPE,
      p_lname      IN Employee.LName%TYPE,
      p_position   IN Employee.Position%TYPE,
      p_startdate  IN Employee.StartDate%TYPE,
      p_resigndate IN Employee.ResignDate%TYPE,
      p_deptcode   IN Employee.DeptCode%TYPE,
      p_status     IN Employee.Status%TYPE
   );
END pkg_employee;
/

CREATE OR REPLACE PACKAGE BODY pkg_employee AS
   PROCEDURE sp_employee_ins (
      p_empno      IN Employee.EmpNo%TYPE,
      p_fname      IN Employee.FName%TYPE,
      p_lname      IN Employee.LName%TYPE,
      p_position   IN Employee.Position%TYPE,
      p_startdate  IN Employee.StartDate%TYPE,
      p_resigndate IN Employee.ResignDate%TYPE,
      p_deptcode   IN Employee.DeptCode%TYPE,
      p_status     IN Employee.Status%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_empno IS NULL THEN
         RAISE_APPLICATION_ERROR(-20101, 'EmpNo is required.');
      END IF;
      IF p_fname IS NULL THEN
         RAISE_APPLICATION_ERROR(-20102, 'FName is required.');
      END IF;
      IF p_lname IS NULL THEN
         RAISE_APPLICATION_ERROR(-20103, 'LName is required.');
      END IF;
      IF p_status IS NULL THEN
         RAISE_APPLICATION_ERROR(-20104, 'Status is required (A/R).');
      END IF;
      IF p_status NOT IN ('A', 'R') THEN
         RAISE_APPLICATION_ERROR(-20105, 'Status must be A (Active) or R (Resigned).');
      END IF;
      IF p_resigndate IS NOT NULL THEN
         IF p_startdate IS NULL THEN
            RAISE_APPLICATION_ERROR(-20106, 'StartDate is required when ResignDate is provided.');
         END IF;
         IF p_resigndate < p_startdate THEN
            RAISE_APPLICATION_ERROR(-20107, 'ResignDate must be >= StartDate.');
         END IF;
      END IF;
      IF p_deptcode IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Department WHERE DeptCode = p_deptcode;
      END IF;

      INSERT INTO Employee (
         EmpNo, FName, LName, Position, StartDate, ResignDate, DeptCode, Status
      ) VALUES (
         p_empno, p_fname, p_lname, p_position, p_startdate, p_resigndate, p_deptcode, p_status
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20110, 'EmpNo already exists.');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20111, 'DeptCode not found in Department.');
   END sp_employee_ins;

   PROCEDURE sp_employee_upd (
      p_empno      IN Employee.EmpNo%TYPE,
      p_fname      IN Employee.FName%TYPE,
      p_lname      IN Employee.LName%TYPE,
      p_position   IN Employee.Position%TYPE,
      p_startdate  IN Employee.StartDate%TYPE,
      p_resigndate IN Employee.ResignDate%TYPE,
      p_deptcode   IN Employee.DeptCode%TYPE,
      p_status     IN Employee.Status%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_empno IS NULL THEN
         RAISE_APPLICATION_ERROR(-20121, 'EmpNo is required for update.');
      END IF;
      IF p_status IS NOT NULL AND p_status NOT IN ('A', 'R') THEN
         RAISE_APPLICATION_ERROR(-20122, 'Status must be A (Active) or R (Resigned).');
      END IF;
      IF p_resigndate IS NOT NULL THEN
         IF p_startdate IS NULL THEN
            RAISE_APPLICATION_ERROR(-20123, 'StartDate is required when ResignDate is provided.');
         END IF;
         IF p_resigndate < p_startdate THEN
            RAISE_APPLICATION_ERROR(-20124, 'ResignDate must be >= StartDate.');
         END IF;
      END IF;
      IF p_deptcode IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Department WHERE DeptCode = p_deptcode;
      END IF;

      UPDATE Employee
         SET FName      = p_fname,
             LName      = p_lname,
             Position   = p_position,
             StartDate  = p_startdate,
             ResignDate = p_resigndate,
             DeptCode   = p_deptcode,
             Status     = p_status
       WHERE EmpNo = p_empno;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20125, 'EmpNo not found.');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20126, 'DeptCode not found in Department.');
   END sp_employee_upd;

END pkg_employee;
/

-- ============================================================
-- CostType
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_costtype AS
   PROCEDURE sp_costtype_ins (
      p_costtypeid  IN CostType.CostTypeID%TYPE,
      p_name        IN CostType.Name%TYPE,
      p_description IN CostType.Description%TYPE
   );

   PROCEDURE sp_costtype_upd (
      p_costtypeid  IN CostType.CostTypeID%TYPE,
      p_name        IN CostType.Name%TYPE,
      p_description IN CostType.Description%TYPE
   );
END pkg_costtype;
/

CREATE OR REPLACE PACKAGE BODY pkg_costtype AS
   PROCEDURE sp_costtype_ins (
      p_costtypeid  IN CostType.CostTypeID%TYPE,
      p_name        IN CostType.Name%TYPE,
      p_description IN CostType.Description%TYPE
   ) IS
   BEGIN
      IF p_costtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20201, 'CostTypeID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20202, 'Name is required.');
      END IF;
      INSERT INTO CostType (CostTypeID, Name, Description)
      VALUES (p_costtypeid, p_name, p_description);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20203, 'CostTypeID already exists.');
   END sp_costtype_ins;

   PROCEDURE sp_costtype_upd (
      p_costtypeid  IN CostType.CostTypeID%TYPE,
      p_name        IN CostType.Name%TYPE,
      p_description IN CostType.Description%TYPE
   ) IS
   BEGIN
      IF p_costtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20211, 'CostTypeID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20212, 'Name is required.');
      END IF;
      UPDATE CostType
         SET Name        = p_name,
             Description = p_description
       WHERE CostTypeID = p_costtypeid;
      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20213, 'CostTypeID not found.');
      END IF;
   END sp_costtype_upd;
END pkg_costtype;
/

-- ============================================================
-- ItemCost
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_itemcost AS
   PROCEDURE sp_itemcost_ins (
      p_itemcostid  IN ItemCost.ItemCostID%TYPE,
      p_name        IN ItemCost.Name%TYPE,
      p_email       IN ItemCost.Email%TYPE,
      p_rateperunit IN ItemCost.RatePerUnit%TYPE,
      p_status      IN ItemCost.Status%TYPE,
      p_countryid   IN ItemCost.CountryID%TYPE,
      p_costtypeid  IN ItemCost.CostTypeID%TYPE
   );

   PROCEDURE sp_itemcost_upd (
      p_itemcostid  IN ItemCost.ItemCostID%TYPE,
      p_name        IN ItemCost.Name%TYPE,
      p_email       IN ItemCost.Email%TYPE,
      p_rateperunit IN ItemCost.RatePerUnit%TYPE,
      p_status      IN ItemCost.Status%TYPE,
      p_countryid   IN ItemCost.CountryID%TYPE,
      p_costtypeid  IN ItemCost.CostTypeID%TYPE
   );
END pkg_itemcost;
/

CREATE OR REPLACE PACKAGE BODY pkg_itemcost AS
   PROCEDURE sp_itemcost_ins (
      p_itemcostid  IN ItemCost.ItemCostID%TYPE,
      p_name        IN ItemCost.Name%TYPE,
      p_email       IN ItemCost.Email%TYPE,
      p_rateperunit IN ItemCost.RatePerUnit%TYPE,
      p_status      IN ItemCost.Status%TYPE,
      p_countryid   IN ItemCost.CountryID%TYPE,
      p_costtypeid  IN ItemCost.CostTypeID%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_itemcostid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20301, 'ItemCostID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20302, 'Name is required.');
      END IF;
      IF p_rateperunit IS NOT NULL AND p_rateperunit < 0 THEN
         RAISE_APPLICATION_ERROR(-20303, 'RatePerUnit must be >= 0.');
      END IF;
      IF p_status IS NOT NULL AND p_status NOT IN ('A', 'R') THEN
         RAISE_APPLICATION_ERROR(-20304, 'Status must be A (Active) or R (Resigned).');
      END IF;
      IF p_countryid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Country WHERE CountryID = p_countryid;
      END IF;
      IF p_costtypeid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM CostType WHERE CostTypeID = p_costtypeid;
      END IF;

      INSERT INTO ItemCost (
         ItemCostID, Name, Email, RatePerUnit, Status, CountryID, CostTypeID
      ) VALUES (
         p_itemcostid, p_name, p_email, p_rateperunit, p_status, p_countryid, p_costtypeid
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20310, 'ItemCostID already exists.');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20311, 'Invalid foreign key: CountryID or CostTypeID not found.');
   END sp_itemcost_ins;

   PROCEDURE sp_itemcost_upd (
      p_itemcostid  IN ItemCost.ItemCostID%TYPE,
      p_name        IN ItemCost.Name%TYPE,
      p_email       IN ItemCost.Email%TYPE,
      p_rateperunit IN ItemCost.RatePerUnit%TYPE,
      p_status      IN ItemCost.Status%TYPE,
      p_countryid   IN ItemCost.CountryID%TYPE,
      p_costtypeid  IN ItemCost.CostTypeID%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_itemcostid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20321, 'ItemCostID is required for update.');
      END IF;
      IF p_rateperunit IS NOT NULL AND p_rateperunit < 0 THEN
         RAISE_APPLICATION_ERROR(-20322, 'RatePerUnit must be >= 0.');
      END IF;
      IF p_status IS NOT NULL AND p_status NOT IN ('A', 'I') THEN
         RAISE_APPLICATION_ERROR(-20323, 'Status must be A (Active) or I (Inactive).');
      END IF;
      IF p_countryid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Country WHERE CountryID = p_countryid;
      END IF;
      IF p_costtypeid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM CostType WHERE CostTypeID = p_costtypeid;
      END IF;

      UPDATE ItemCost
         SET Name        = p_name,
             Email       = p_email,
             RatePerUnit = p_rateperunit,
             Status      = p_status,
             CountryID   = p_countryid,
             CostTypeID  = p_costtypeid
       WHERE ItemCostID = p_itemcostid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20324, 'ItemCostID not found.');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20325, 'Invalid foreign key: CountryID or CostTypeID not found.');
   END sp_itemcost_upd;
END pkg_itemcost;
/

-- ============================================================
-- TourPlan
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_tourplan AS
   PROCEDURE sp_tourplan_ins (
      p_tourplanid  IN TourPlan.TourPlanID%TYPE,
      p_name        IN TourPlan.Name%TYPE,
      p_description IN TourPlan.Description%TYPE
   );

   PROCEDURE sp_tourplan_upd (
      p_tourplanid  IN TourPlan.TourPlanID%TYPE,
      p_name        IN TourPlan.Name%TYPE,
      p_description IN TourPlan.Description%TYPE
   );
END pkg_tourplan;
/

CREATE OR REPLACE PACKAGE BODY pkg_tourplan AS
   PROCEDURE sp_tourplan_ins (
      p_tourplanid  IN TourPlan.TourPlanID%TYPE,
      p_name        IN TourPlan.Name%TYPE,
      p_description IN TourPlan.Description%TYPE
   ) IS
   BEGIN
      IF p_tourplanid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20401, 'TourPlanID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20402, 'Name is required.');
      END IF;
      INSERT INTO TourPlan (TourPlanID, Name, Description)
      VALUES (p_tourplanid, p_name, p_description);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20403, 'TourPlanID already exists.');
   END sp_tourplan_ins;

   PROCEDURE sp_tourplan_upd (
      p_tourplanid  IN TourPlan.TourPlanID%TYPE,
      p_name        IN TourPlan.Name%TYPE,
      p_description IN TourPlan.Description%TYPE
   ) IS
   BEGIN
      IF p_tourplanid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20411, 'TourPlanID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20412, 'Name is required.');
      END IF;
      UPDATE TourPlan
         SET Name        = p_name,
             Description = p_description
       WHERE TourPlanID = p_tourplanid;
      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20413, 'TourPlanID not found.');
      END IF;
   END sp_tourplan_upd;
END pkg_tourplan;
/

-- ============================================================
-- TourType
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_tourtype AS
   PROCEDURE sp_tourtype_ins (
      p_tourtypeid   IN TourType.TourTypeID%TYPE,
      p_name         IN TourType.Name%TYPE,
      p_description  IN TourType.Description%TYPE,
      p_baseprice    IN TourType.BasePrice%TYPE,
      p_durationdays IN TourType.DurationDays%TYPE,
      p_activeflag   IN TourType.ActiveFlag%TYPE
   );

   PROCEDURE sp_tourtype_upd (
      p_tourtypeid   IN TourType.TourTypeID%TYPE,
      p_name         IN TourType.Name%TYPE,
      p_description  IN TourType.Description%TYPE,
      p_baseprice    IN TourType.BasePrice%TYPE,
      p_durationdays IN TourType.DurationDays%TYPE,
      p_activeflag   IN TourType.ActiveFlag%TYPE
   );
END pkg_tourtype;
/

CREATE OR REPLACE PACKAGE BODY pkg_tourtype AS
   PROCEDURE sp_tourtype_ins (
      p_tourtypeid   IN TourType.TourTypeID%TYPE,
      p_name         IN TourType.Name%TYPE,
      p_description  IN TourType.Description%TYPE,
      p_baseprice    IN TourType.BasePrice%TYPE,
      p_durationdays IN TourType.DurationDays%TYPE,
      p_activeflag   IN TourType.ActiveFlag%TYPE
   ) IS
   BEGIN
      IF p_tourtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20501, 'TourTypeID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20502, 'Name is required.');
      END IF;
      IF p_baseprice IS NOT NULL AND p_baseprice < 0 THEN
         RAISE_APPLICATION_ERROR(-20503, 'BasePrice must be >= 0.');
      END IF;
      IF p_durationdays IS NOT NULL AND p_durationdays <= 0 THEN
         RAISE_APPLICATION_ERROR(-20504, 'DurationDays must be > 0.');
      END IF;
      IF p_activeflag IS NOT NULL AND p_activeflag NOT IN ('Y', 'N') THEN
         RAISE_APPLICATION_ERROR(-20505, 'ActiveFlag must be Y or N.');
      END IF;

      INSERT INTO TourType (
         TourTypeID, Name, Description, BasePrice, DurationDays, ActiveFlag
      ) VALUES (
         p_tourtypeid, p_name, p_description, p_baseprice, p_durationdays, p_activeflag
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20506, 'TourTypeID already exists.');
   END sp_tourtype_ins;

   PROCEDURE sp_tourtype_upd (
      p_tourtypeid   IN TourType.TourTypeID%TYPE,
      p_name         IN TourType.Name%TYPE,
      p_description  IN TourType.Description%TYPE,
      p_baseprice    IN TourType.BasePrice%TYPE,
      p_durationdays IN TourType.DurationDays%TYPE,
      p_activeflag   IN TourType.ActiveFlag%TYPE
   ) IS
   BEGIN
      IF p_tourtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20511, 'TourTypeID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20512, 'Name is required.');
      END IF;
      IF p_baseprice IS NOT NULL AND p_baseprice < 0 THEN
         RAISE_APPLICATION_ERROR(-20513, 'BasePrice must be >= 0.');
      END IF;
      IF p_durationdays IS NOT NULL AND p_durationdays <= 0 THEN
         RAISE_APPLICATION_ERROR(-20514, 'DurationDays must be > 0.');
      END IF;
      IF p_activeflag IS NOT NULL AND p_activeflag NOT IN ('Y', 'N') THEN
         RAISE_APPLICATION_ERROR(-20515, 'ActiveFlag must be Y or N.');
      END IF;

      UPDATE TourType
         SET Name         = p_name,
             Description  = p_description,
             BasePrice    = p_baseprice,
             DurationDays = p_durationdays,
             ActiveFlag   = p_activeflag
       WHERE TourTypeID = p_tourtypeid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20516, 'TourTypeID not found.');
      END IF;
   END sp_tourtype_upd;
END pkg_tourtype;
/

-- ============================================================
-- Country
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_country AS
   PROCEDURE sp_country_ins (
      p_countryid   IN Country.CountryID%TYPE,
      p_name        IN Country.Name%TYPE,
      p_description IN Country.Description%TYPE,
      p_regionid    IN Country.RegionID%TYPE
   );

   PROCEDURE sp_country_upd (
      p_countryid   IN Country.CountryID%TYPE,
      p_name        IN Country.Name%TYPE,
      p_description IN Country.Description%TYPE,
      p_regionid    IN Country.RegionID%TYPE
   );
END pkg_country;
/

CREATE OR REPLACE PACKAGE BODY pkg_country AS
   PROCEDURE sp_country_ins (
      p_countryid   IN Country.CountryID%TYPE,
      p_name        IN Country.Name%TYPE,
      p_description IN Country.Description%TYPE,
      p_regionid    IN Country.RegionID%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_countryid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20601, 'CountryID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20602, 'Name is required.');
      END IF;
      IF p_regionid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Region WHERE RegionID = p_regionid;
      END IF;

      INSERT INTO Country (CountryID, Name, Description, RegionID)
      VALUES (p_countryid, p_name, p_description, p_regionid);

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20603, 'CountryID already exists.');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20604, 'RegionID not found in Region.');
   END sp_country_ins;

   PROCEDURE sp_country_upd (
      p_countryid   IN Country.CountryID%TYPE,
      p_name        IN Country.Name%TYPE,
      p_description IN Country.Description%TYPE,
      p_regionid    IN Country.RegionID%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_countryid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20611, 'CountryID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20612, 'Name is required.');
      END IF;
      IF p_regionid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Region WHERE RegionID = p_regionid;
      END IF;

      UPDATE Country
         SET Name        = p_name,
             Description = p_description,
             RegionID    = p_regionid
       WHERE CountryID = p_countryid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20613, 'CountryID not found.');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20614, 'RegionID not found in Region.');
   END sp_country_upd;
END pkg_country;
/

-- ============================================================
-- Guide
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_guide AS
   PROCEDURE sp_guide_ins (
      p_guideid        IN Guide.GuideID%TYPE,
      p_name           IN Guide.Name%TYPE,
      p_email          IN Guide.Email%TYPE,
      p_languageskills IN Guide.LanguageSkills%TYPE,
      p_phone          IN Guide.Phone%TYPE,
      p_salary         IN Guide.Salary%TYPE,
      p_specialty      IN Guide.Specialty%TYPE,
      p_status         IN Guide.Status%TYPE
   );

   PROCEDURE sp_guide_upd (
      p_guideid        IN Guide.GuideID%TYPE,
      p_name           IN Guide.Name%TYPE,
      p_email          IN Guide.Email%TYPE,
      p_languageskills IN Guide.LanguageSkills%TYPE,
      p_phone          IN Guide.Phone%TYPE,
      p_salary         IN Guide.Salary%TYPE,
      p_specialty      IN Guide.Specialty%TYPE,
      p_status         IN Guide.Status%TYPE
   );
END pkg_guide;
/

CREATE OR REPLACE PACKAGE BODY pkg_guide AS
   PROCEDURE sp_guide_ins (
      p_guideid        IN Guide.GuideID%TYPE,
      p_name           IN Guide.Name%TYPE,
      p_email          IN Guide.Email%TYPE,
      p_languageskills IN Guide.LanguageSkills%TYPE,
      p_phone          IN Guide.Phone%TYPE,
      p_salary         IN Guide.Salary%TYPE,
      p_specialty      IN Guide.Specialty%TYPE,
      p_status         IN Guide.Status%TYPE
   ) IS
   BEGIN
      IF p_guideid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20701, 'GuideID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20702, 'Name is required.');
      END IF;

      INSERT INTO Guide (
         GuideID, Name, Email, LanguageSkills, Phone, Salary, Specialty, Status
      ) VALUES (
         p_guideid, p_name, p_email, p_languageskills, p_phone, p_salary, p_specialty, p_status
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20704, 'GuideID already exists.');
   END sp_guide_ins;

   PROCEDURE sp_guide_upd (
      p_guideid        IN Guide.GuideID%TYPE,
      p_name           IN Guide.Name%TYPE,
      p_email          IN Guide.Email%TYPE,
      p_languageskills IN Guide.LanguageSkills%TYPE,
      p_phone          IN Guide.Phone%TYPE,
      p_salary         IN Guide.Salary%TYPE,
      p_specialty      IN Guide.Specialty%TYPE,
      p_status         IN Guide.Status%TYPE
   ) IS
   BEGIN
      IF p_guideid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20711, 'GuideID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20712, 'Name is required.');
      END IF;
      -- Note: p_phone is VARCHAR2(30); numeric comparison removed to avoid ORA-01722

      UPDATE Guide
         SET Name           = p_name,
             Email          = p_email,
             LanguageSkills = p_languageskills,
             Phone          = p_phone,
             Salary         = p_salary,
             Specialty      = p_specialty,
             Status         = p_status
       WHERE GuideID = p_guideid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20714, 'GuideID not found.');
      END IF;
   END sp_guide_upd;
END pkg_guide;
/

-- ============================================================
-- Tour
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_tour AS
   PROCEDURE sp_tour_ins (
      p_tourid      IN Tour.TourID%TYPE,
      p_tourcode    IN Tour.TourCode%TYPE,
      p_tourtypeid  IN Tour.TourTypeID%TYPE,
      p_name        IN Tour.Name%TYPE,
      p_capacitypax IN Tour.CapacityPax%TYPE,
      p_startdate   IN Tour.StartDate%TYPE,
      p_enddate     IN Tour.EndDate%TYPE,
      p_status      IN Tour.Status%TYPE,
      p_countryid   IN Tour.CountryID%TYPE
   );

   PROCEDURE sp_tour_upd (
      p_tourid      IN Tour.TourID%TYPE,
      p_tourcode    IN Tour.TourCode%TYPE,
      p_tourtypeid  IN Tour.TourTypeID%TYPE,
      p_name        IN Tour.Name%TYPE,
      p_capacitypax IN Tour.CapacityPax%TYPE,
      p_startdate   IN Tour.StartDate%TYPE,
      p_enddate     IN Tour.EndDate%TYPE,
      p_status      IN Tour.Status%TYPE,
      p_countryid   IN Tour.CountryID%TYPE
   );
END pkg_tour;
/

CREATE OR REPLACE PACKAGE BODY pkg_tour AS
   PROCEDURE sp_tour_ins (
      p_tourid      IN Tour.TourID%TYPE,
      p_tourcode    IN Tour.TourCode%TYPE,
      p_tourtypeid  IN Tour.TourTypeID%TYPE,
      p_name        IN Tour.Name%TYPE,
      p_capacitypax IN Tour.CapacityPax%TYPE,
      p_startdate   IN Tour.StartDate%TYPE,
      p_enddate     IN Tour.EndDate%TYPE,
      p_status      IN Tour.Status%TYPE,
      p_countryid   IN Tour.CountryID%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_tourid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20801, 'TourID is required.');
      END IF;
      IF p_tourcode IS NULL THEN
         RAISE_APPLICATION_ERROR(-20802, 'TourCode is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20803, 'Name is required.');
      END IF;
      IF p_capacitypax IS NOT NULL AND p_capacitypax < 0 THEN
         RAISE_APPLICATION_ERROR(-20804, 'CapacityPax must be >= 0.');
      END IF;
      IF p_startdate IS NOT NULL AND p_enddate IS NOT NULL AND p_enddate < p_startdate THEN
         RAISE_APPLICATION_ERROR(-20805, 'EndDate must be >= StartDate.');
      END IF;
      IF p_tourtypeid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM TourType WHERE TourTypeID = p_tourtypeid;
      END IF;
      IF p_countryid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Country WHERE CountryID = p_countryid;
      END IF;

      INSERT INTO Tour (
         TourID, TourCode, TourTypeID, Name, CapacityPax, StartDate, EndDate, Status, CountryID
      ) VALUES (
         p_tourid, p_tourcode, p_tourtypeid, p_name, p_capacitypax, p_startdate, p_enddate, p_status, p_countryid
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20810, 'Duplicate TourID or TourCode.');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20811, 'TourTypeID not found in TourType.');
   END sp_tour_ins;

   PROCEDURE sp_tour_upd (
      p_tourid      IN Tour.TourID%TYPE,
      p_tourcode    IN Tour.TourCode%TYPE,
      p_tourtypeid  IN Tour.TourTypeID%TYPE,
      p_name        IN Tour.Name%TYPE,
      p_capacitypax IN Tour.CapacityPax%TYPE,
      p_startdate   IN Tour.StartDate%TYPE,
      p_enddate     IN Tour.EndDate%TYPE,
      p_status      IN Tour.Status%TYPE,
      p_countryid   IN Tour.CountryID%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_tourid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20821, 'TourID is required for update.');
      END IF;
      IF p_tourcode IS NULL THEN
         RAISE_APPLICATION_ERROR(-20822, 'TourCode is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20823, 'Name is required.');
      END IF;
      IF p_capacitypax IS NOT NULL AND p_capacitypax < 0 THEN
         RAISE_APPLICATION_ERROR(-20824, 'CapacityPax must be >= 0.');
      END IF;
      IF p_startdate IS NOT NULL AND p_enddate IS NOT NULL AND p_enddate < p_startdate THEN
         RAISE_APPLICATION_ERROR(-20825, 'EndDate must be >= StartDate.');
      END IF;
      IF p_tourtypeid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM TourType WHERE TourTypeID = p_tourtypeid;
      END IF;
      IF p_countryid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM Country WHERE CountryID = p_countryid;
      END IF;

      UPDATE Tour
         SET TourCode    = p_tourcode,
             TourTypeID  = p_tourtypeid,
             Name        = p_name,
             CapacityPax = p_capacitypax,
             StartDate   = p_startdate,
             EndDate     = p_enddate,
             Status      = p_status,
             CountryID   = p_countryid
       WHERE TourID = p_tourid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20826, 'TourID not found.');
      END IF;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20827, 'Duplicate TourCode (must be unique).');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20828, 'TourTypeID not found in TourType.');
   END sp_tour_upd;
END pkg_tour;
/

-- ============================================================
-- Promotion
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_promotion AS
   PROCEDURE sp_promotion_ins (
      p_promotionid   IN Promotion.PromotionID%TYPE,
      p_name          IN Promotion.Name%TYPE,
      p_minpax        IN Promotion.MinPax%TYPE,
      p_discountvalue IN Promotion.DiscountValue%TYPE,
      p_startdate     IN Promotion.StartDate%TYPE,
      p_enddate       IN Promotion.EndDate%TYPE,
      p_status        IN Promotion.Status%TYPE
   );

   PROCEDURE sp_promotion_upd (
      p_promotionid   IN Promotion.PromotionID%TYPE,
      p_name          IN Promotion.Name%TYPE,
      p_minpax        IN Promotion.MinPax%TYPE,
      p_discountvalue IN Promotion.DiscountValue%TYPE,
      p_startdate     IN Promotion.StartDate%TYPE,
      p_enddate       IN Promotion.EndDate%TYPE,
      p_status        IN Promotion.Status%TYPE
   );
END pkg_promotion;
/

CREATE OR REPLACE PACKAGE BODY pkg_promotion AS
   PROCEDURE sp_promotion_ins (
      p_promotionid   IN Promotion.PromotionID%TYPE,
      p_name          IN Promotion.Name%TYPE,
      p_minpax        IN Promotion.MinPax%TYPE,
      p_discountvalue IN Promotion.DiscountValue%TYPE,
      p_startdate     IN Promotion.StartDate%TYPE,
      p_enddate       IN Promotion.EndDate%TYPE,
      p_status        IN Promotion.Status%TYPE
   ) IS
   BEGIN
      IF p_promotionid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20901, 'PromotionID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20902, 'Name is required.');
      END IF;
      IF p_minpax IS NOT NULL AND p_minpax < 0 THEN
         RAISE_APPLICATION_ERROR(-20903, 'MinPax must be >= 0.');
      END IF;
      IF p_discountvalue IS NOT NULL AND p_discountvalue < 0 THEN
         RAISE_APPLICATION_ERROR(-20904, 'DiscountValue must be >= 0.');
      END IF;
      IF p_startdate IS NOT NULL AND p_enddate IS NOT NULL AND p_enddate < p_startdate THEN
         RAISE_APPLICATION_ERROR(-20905, 'EndDate must be >= StartDate.');
      END IF;

      INSERT INTO Promotion (
         PromotionID, Name, MinPax, DiscountValue, StartDate, EndDate, Status
      ) VALUES (
         p_promotionid, p_name, p_minpax, p_discountvalue, p_startdate, p_enddate, p_status
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20906, 'PromotionID already exists.');
   END sp_promotion_ins;

   PROCEDURE sp_promotion_upd (
      p_promotionid   IN Promotion.PromotionID%TYPE,
      p_name          IN Promotion.Name%TYPE,
      p_minpax        IN Promotion.MinPax%TYPE,
      p_discountvalue IN Promotion.DiscountValue%TYPE,
      p_startdate     IN Promotion.StartDate%TYPE,
      p_enddate       IN Promotion.EndDate%TYPE,
      p_status        IN Promotion.Status%TYPE
   ) IS
   BEGIN
      IF p_promotionid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20911, 'PromotionID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20912, 'Name is required.');
      END IF;
      IF p_minpax IS NOT NULL AND p_minpax < 0 THEN
         RAISE_APPLICATION_ERROR(-20913, 'MinPax must be >= 0.');
      END IF;
      IF p_discountvalue IS NOT NULL AND p_discountvalue < 0 THEN
         RAISE_APPLICATION_ERROR(-20914, 'DiscountValue must be >= 0.');
      END IF;
      IF p_startdate IS NOT NULL AND p_enddate IS NOT NULL AND p_enddate < p_startdate THEN
         RAISE_APPLICATION_ERROR(-20915, 'EndDate must be >= StartDate.');
      END IF;

      UPDATE Promotion
         SET Name          = p_name,
             MinPax        = p_minpax,
             DiscountValue = p_discountvalue,
             StartDate     = p_startdate,
             EndDate       = p_enddate,
             Status        = p_status
       WHERE PromotionID = p_promotionid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20916, 'PromotionID not found.');
      END IF;
   END sp_promotion_upd;
END pkg_promotion;
/

-- ============================================================
-- CustomerType
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_customertype AS
   PROCEDURE sp_customertype_ins (
      p_custtypeid   IN CustomerType.CustTypeID%TYPE,
      p_name         IN CustomerType.Name%TYPE,
      p_discountrate IN CustomerType.DiscountRate%TYPE
   );

   PROCEDURE sp_customertype_upd (
      p_custtypeid   IN CustomerType.CustTypeID%TYPE,
      p_name         IN CustomerType.Name%TYPE,
      p_discountrate IN CustomerType.DiscountRate%TYPE
   );
END pkg_customertype;
/

CREATE OR REPLACE PACKAGE BODY pkg_customertype AS
   PROCEDURE sp_customertype_ins (
      p_custtypeid   IN CustomerType.CustTypeID%TYPE,
      p_name         IN CustomerType.Name%TYPE,
      p_discountrate IN CustomerType.DiscountRate%TYPE
   ) IS
   BEGIN
      IF p_custtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20041, 'CustTypeID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20042, 'Name is required.');
      END IF;
      IF p_discountrate IS NULL THEN
         RAISE_APPLICATION_ERROR(-20043, 'DiscountRate is required.');
      END IF;
      IF p_discountrate < 0 OR p_discountrate > 100 THEN
         RAISE_APPLICATION_ERROR(-20044, 'DiscountRate must be between 0 and 100.');
      END IF;

      INSERT INTO CustomerType (CustTypeID, Name, DiscountRate)
      VALUES (p_custtypeid, p_name, p_discountrate);

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20045, 'Duplicate CustTypeID or Name.');
   END sp_customertype_ins;

   PROCEDURE sp_customertype_upd (
      p_custtypeid   IN CustomerType.CustTypeID%TYPE,
      p_name         IN CustomerType.Name%TYPE,
      p_discountrate IN CustomerType.DiscountRate%TYPE
   ) IS
   BEGIN
      IF p_custtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20051, 'CustTypeID is required for update.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20052, 'Name is required.');
      END IF;
      IF p_discountrate IS NULL THEN
         RAISE_APPLICATION_ERROR(-20053, 'DiscountRate is required.');
      END IF;
      IF p_discountrate < 0 OR p_discountrate > 100 THEN
         RAISE_APPLICATION_ERROR(-20054, 'DiscountRate must be between 0 and 100.');
      END IF;

      UPDATE CustomerType
         SET Name         = p_name,
             DiscountRate = p_discountrate
       WHERE CustTypeID = p_custtypeid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20055, 'CustTypeID not found.');
      END IF;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20056, 'Name already exists (must be unique).');
   END sp_customertype_upd;
END pkg_customertype;
/

-- ============================================================
-- Customer
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_customer AS
   PROCEDURE sp_customer_ins (
      p_customerid  IN Customer.CustomerID%TYPE,
      p_custtypeid  IN Customer.CustTypeID%TYPE,
      p_name        IN Customer.Name%TYPE,
      p_phone       IN Customer.Phone%TYPE,
      p_address     IN Customer.Address%TYPE,
      p_passportno  IN Customer.PassportNo%TYPE,
      p_nationality IN Customer.Nationality%TYPE,
      p_dob         IN Customer.DOB%TYPE
   );

   PROCEDURE sp_customer_upd (
      p_customerid  IN Customer.CustomerID%TYPE,
      p_custtypeid  IN Customer.CustTypeID%TYPE,
      p_name        IN Customer.Name%TYPE,
      p_phone       IN Customer.Phone%TYPE,
      p_address     IN Customer.Address%TYPE,
      p_passportno  IN Customer.PassportNo%TYPE,
      p_nationality IN Customer.Nationality%TYPE,
      p_dob         IN Customer.DOB%TYPE
   );
END pkg_customer;
/

CREATE OR REPLACE PACKAGE BODY pkg_customer AS
   PROCEDURE sp_customer_ins (
      p_customerid  IN Customer.CustomerID%TYPE,
      p_custtypeid  IN Customer.CustTypeID%TYPE,
      p_name        IN Customer.Name%TYPE,
      p_phone       IN Customer.Phone%TYPE,
      p_address     IN Customer.Address%TYPE,
      p_passportno  IN Customer.PassportNo%TYPE,
      p_nationality IN Customer.Nationality%TYPE,
      p_dob         IN Customer.DOB%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_customerid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20061, 'CustomerID is required.');
      END IF;
      IF p_custtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20062, 'CustTypeID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20063, 'Name is required.');
      END IF;
      IF p_phone IS NULL THEN
         RAISE_APPLICATION_ERROR(-20064, 'Phone is required.');
      END IF;
      IF p_address IS NULL THEN
         RAISE_APPLICATION_ERROR(-20065, 'Address is required.');
      END IF;
      IF p_passportno IS NULL THEN
         RAISE_APPLICATION_ERROR(-20066, 'PassportNo is required.');
      END IF;
      IF p_nationality IS NULL THEN
         RAISE_APPLICATION_ERROR(-20067, 'Nationality is required.');
      END IF;
      IF p_dob IS NULL THEN
         RAISE_APPLICATION_ERROR(-20068, 'DOB is required.');
      END IF;

      SELECT 1 INTO v_dummy FROM CustomerType WHERE CustTypeID = p_custtypeid;

      INSERT INTO Customer (
         CustomerID, CustTypeID, Name, Phone, Address, PassportNo, Nationality, DOB
      ) VALUES (
         p_customerid, p_custtypeid, p_name, p_phone, p_address, p_passportno, p_nationality, p_dob
      );

   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20070, 'Duplicate CustomerID or PassportNo.');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20071, 'CustTypeID not found in CustomerType.');
   END sp_customer_ins;

   PROCEDURE sp_customer_upd (
      p_customerid  IN Customer.CustomerID%TYPE,
      p_custtypeid  IN Customer.CustTypeID%TYPE,
      p_name        IN Customer.Name%TYPE,
      p_phone       IN Customer.Phone%TYPE,
      p_address     IN Customer.Address%TYPE,
      p_passportno  IN Customer.PassportNo%TYPE,
      p_nationality IN Customer.Nationality%TYPE,
      p_dob         IN Customer.DOB%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_customerid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20081, 'CustomerID is required for update.');
      END IF;
      IF p_custtypeid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20082, 'CustTypeID is required.');
      END IF;
      IF p_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20083, 'Name is required.');
      END IF;
      IF p_phone IS NULL THEN
         RAISE_APPLICATION_ERROR(-20084, 'Phone is required.');
      END IF;
      IF p_address IS NULL THEN
         RAISE_APPLICATION_ERROR(-20085, 'Address is required.');
      END IF;
      IF p_passportno IS NULL THEN
         RAISE_APPLICATION_ERROR(-20086, 'PassportNo is required.');
      END IF;
      IF p_nationality IS NULL THEN
         RAISE_APPLICATION_ERROR(-20087, 'Nationality is required.');
      END IF;
      IF p_dob IS NULL THEN
         RAISE_APPLICATION_ERROR(-20088, 'DOB is required.');
      END IF;

      SELECT 1 INTO v_dummy FROM CustomerType WHERE CustTypeID = p_custtypeid;

      UPDATE Customer
         SET CustTypeID  = p_custtypeid,
             Name        = p_name,
             Phone       = p_phone,
             Address     = p_address,
             PassportNo  = p_passportno,
             Nationality = p_nationality,
             DOB         = p_dob
       WHERE CustomerID = p_customerid;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20089, 'CustomerID not found.');
      END IF;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20090, 'PassportNo already exists (must be unique).');
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20091, 'CustTypeID not found in CustomerType.');
   END sp_customer_upd;
END pkg_customer;
/

-- ============================================================
-- CostDetail
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_costdetail AS
   PROCEDURE sp_cost_add_detail (
      p_tourid     IN CostDetail.TourID%TYPE,
      p_guideid    IN CostDetail.GuideID%TYPE,
      p_itemcostid IN CostDetail.ItemCostID%TYPE,
      p_feeamount  IN CostDetail.FeeAmount%TYPE,
      p_quantity   IN CostDetail.Quantity%TYPE,
      p_note       IN CostDetail.Note%TYPE,
      p_startdate  IN CostDetail.StartDate%TYPE,
      p_enddate    IN CostDetail.EndDate%TYPE
   );
END pkg_costdetail;
/

CREATE OR REPLACE PACKAGE BODY pkg_costdetail AS
   PROCEDURE sp_cost_add_detail (
      p_tourid     IN CostDetail.TourID%TYPE,
      p_guideid    IN CostDetail.GuideID%TYPE,
      p_itemcostid IN CostDetail.ItemCostID%TYPE,
      p_feeamount  IN CostDetail.FeeAmount%TYPE,
      p_quantity   IN CostDetail.Quantity%TYPE,
      p_note       IN CostDetail.Note%TYPE,
      p_startdate  IN CostDetail.StartDate%TYPE,
      p_enddate    IN CostDetail.EndDate%TYPE
   ) IS
      v_dummy    NUMBER;
      v_next_seq NUMBER;
   BEGIN
      IF p_tourid IS NULL OR p_itemcostid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20973, 'TourID and ItemCostID are required.');
      END IF;

      BEGIN
         SELECT 1 INTO v_dummy FROM Tour     WHERE TourID     = p_tourid;
         SELECT 1 INTO v_dummy FROM ItemCost WHERE ItemCostID = p_itemcostid;
         IF p_guideid IS NOT NULL THEN
            SELECT 1 INTO v_dummy FROM Guide WHERE GuideID = p_guideid;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20974, 'Invalid Foreign Key Not Found.');
      END;

      SELECT NVL(MAX(SeqNo), 0) + 1 INTO v_next_seq
        FROM CostDetail
       WHERE TourID = p_tourid;

      INSERT INTO CostDetail (
         TourID, SeqNo, GuideID, ItemCostID, FeeAmount, Quantity, Note, StartDate, EndDate
      ) VALUES (
         p_tourid, v_next_seq, p_guideid, p_itemcostid, p_feeamount, p_quantity, p_note, p_startdate, p_enddate
      );
      COMMIT;
   END sp_cost_add_detail;
END pkg_costdetail;
/

-- ============================================================
-- PromotionDetail
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_promodetail AS
   PROCEDURE sp_promo_add_detail (
      p_promotionid     IN PromotionDetail.PromotionID%TYPE,
      p_tourid          IN PromotionDetail.TourID%TYPE,
      p_discountpercent IN PromotionDetail.DiscountPercent%TYPE,
      p_startdate       IN PromotionDetail.StartDate%TYPE,
      p_enddate         IN PromotionDetail.EndDate%TYPE,
      p_extracondition  IN PromotionDetail.ExtraCondition%TYPE,
      p_minbookamount   IN PromotionDetail.MinBookAmount%TYPE DEFAULT 0
   );

   PROCEDURE sp_promo_del_detail (
      p_promotionid IN PromotionDetail.PromotionID%TYPE,
      p_seqno       IN PromotionDetail.SeqNo%TYPE
   );
END pkg_promodetail;
/

CREATE OR REPLACE PACKAGE BODY pkg_promodetail AS
   PROCEDURE sp_promo_add_detail (
      p_promotionid     IN PromotionDetail.PromotionID%TYPE,
      p_tourid          IN PromotionDetail.TourID%TYPE,
      p_discountpercent IN PromotionDetail.DiscountPercent%TYPE,
      p_startdate       IN PromotionDetail.StartDate%TYPE,
      p_enddate         IN PromotionDetail.EndDate%TYPE,
      p_extracondition  IN PromotionDetail.ExtraCondition%TYPE,
      p_minbookamount   IN PromotionDetail.MinBookAmount%TYPE DEFAULT 0
   ) IS
      v_dummy    NUMBER;
      v_next_seq NUMBER;
   BEGIN
      IF p_promotionid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20975, 'PromotionID is required.');
      END IF;
      IF p_tourid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20976, 'TourID is required.');
      END IF;
      IF p_discountpercent < 0 OR p_discountpercent > 100 THEN
         RAISE_APPLICATION_ERROR(-20977, 'DiscountPercent must be between 0 and 100.');
      END IF;
      IF p_enddate < p_startdate THEN
         RAISE_APPLICATION_ERROR(-20978, 'EndDate must be >= StartDate.');
      END IF;

      BEGIN
         SELECT 1 INTO v_dummy FROM Promotion WHERE PromotionID = p_promotionid;
         SELECT 1 INTO v_dummy FROM Tour      WHERE TourID      = p_tourid;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20979, 'Invalid Foreign Key: Promotion or Tour not found.');
      END;

      SELECT NVL(MAX(SeqNo), 0) + 1 INTO v_next_seq
        FROM PromotionDetail
       WHERE PromotionID = p_promotionid;

      INSERT INTO PromotionDetail (
         PromotionID, SeqNo, TourID, DiscountPercent,
         StartDate, EndDate, ExtraCondition, MinBookAmount
      ) VALUES (
         p_promotionid, v_next_seq, p_tourid, p_discountpercent,
         p_startdate, p_enddate, p_extracondition, p_minbookamount
      );
      COMMIT;
   END sp_promo_add_detail;

   PROCEDURE sp_promo_del_detail (
      p_promotionid IN PromotionDetail.PromotionID%TYPE,
      p_seqno       IN PromotionDetail.SeqNo%TYPE
   ) IS
   BEGIN
      DELETE FROM PromotionDetail
       WHERE PromotionID = p_promotionid
         AND SeqNo       = p_seqno;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20980, 'PromotionDetail not found.');
      END IF;
      COMMIT;
   END sp_promo_del_detail;
END pkg_promodetail;
/

-- ============================================================
-- TourDetail
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_tourdetail AS
   PROCEDURE sp_tour_add_detail (
      p_tourid        IN TourDetail.TourID%TYPE,
      p_tourplanid    IN TourDetail.TourPlanID%TYPE,
      p_title         IN TourDetail.Title%TYPE,
      p_description   IN TourDetail.Description%TYPE,
      p_meal          IN TourDetail.Meal%TYPE,
      p_hotelname     IN TourDetail.HotelName%TYPE,
      p_transportnote IN TourDetail.TransportNote%TYPE,
      p_dayno         IN TourDetail.DayNo%TYPE DEFAULT NULL
   );

   PROCEDURE sp_tour_del_detail (
      p_tourid IN TourDetail.TourID%TYPE,
      p_dayno  IN TourDetail.DayNo%TYPE
   );
END pkg_tourdetail;
/

CREATE OR REPLACE PACKAGE BODY pkg_tourdetail AS
   PROCEDURE sp_tour_add_detail (
      p_tourid        IN TourDetail.TourID%TYPE,
      p_tourplanid    IN TourDetail.TourPlanID%TYPE,
      p_title         IN TourDetail.Title%TYPE,
      p_description   IN TourDetail.Description%TYPE,
      p_meal          IN TourDetail.Meal%TYPE,
      p_hotelname     IN TourDetail.HotelName%TYPE,
      p_transportnote IN TourDetail.TransportNote%TYPE,
      p_dayno         IN TourDetail.DayNo%TYPE DEFAULT NULL
   ) IS
      v_dummy NUMBER;
      v_next  TourDetail.DayNo%TYPE;
   BEGIN
      IF p_tourid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20921, 'TourID is required.');
      END IF;
      IF p_tourplanid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20922, 'TourPlanID is required.');
      END IF;

      INSERT INTO TourDetail (
         TourID, DayNo, TourPlanID, Title, Description, Meal, HotelName, TransportNote
      ) VALUES (
         p_tourid, p_dayno, p_tourplanid, p_title, p_description, p_meal, p_hotelname, p_transportnote
      );

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20930, 'Invalid foreign key: TourID or TourPlanID not found.');
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20931, 'Duplicate (TourID, DayNo).');
   END sp_tour_add_detail;

   PROCEDURE sp_tour_del_detail (
      p_tourid IN TourDetail.TourID%TYPE,
      p_dayno  IN TourDetail.DayNo%TYPE
   ) IS
      v_dummy NUMBER;
   BEGIN
      IF p_tourid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20941, 'TourID is required for delete.');
      END IF;
      IF p_dayno IS NULL THEN
         RAISE_APPLICATION_ERROR(-20942, 'DayNo is required for delete.');
      END IF;

      SELECT 1 INTO v_dummy FROM Tour WHERE TourID = p_tourid FOR UPDATE;

      DELETE FROM TourDetail
       WHERE TourID = p_tourid
         AND DayNo  = p_dayno;

      IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20943, 'TourDetail not found (TourID + DayNo).');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20944, 'TourID not found in Tour.');
   END sp_tour_del_detail;
END pkg_tourdetail;
/

-- ============================================================
-- BookingDetail
-- ============================================================
CREATE OR REPLACE PACKAGE pkg_bookingdetail AS
   PROCEDURE sp_booking_add_detail (
      p_bookingid    IN BookingDetail.BookingID%TYPE,
      p_tourid       IN BookingDetail.TourID%TYPE,
      p_servdatefrom IN BookingDetail.ServDateFrom%TYPE,
      p_servdateto   IN BookingDetail.ServDateTo%TYPE,
      p_paxadult     IN BookingDetail.PaxAdult%TYPE,
      p_paxchild     IN BookingDetail.PaxChild%TYPE,
      p_unitprice    IN BookingDetail.UnitPrice%TYPE,
      p_seqno        IN BookingDetail.SeqNo%TYPE DEFAULT NULL
   );
END pkg_bookingdetail;
/

CREATE OR REPLACE PACKAGE BODY pkg_bookingdetail AS
   PROCEDURE sp_booking_add_detail (
      p_bookingid    IN BookingDetail.BookingID%TYPE,
      p_tourid       IN BookingDetail.TourID%TYPE,
      p_servdatefrom IN BookingDetail.ServDateFrom%TYPE,
      p_servdateto   IN BookingDetail.ServDateTo%TYPE,
      p_paxadult     IN BookingDetail.PaxAdult%TYPE,
      p_paxchild     IN BookingDetail.PaxChild%TYPE,
      p_unitprice    IN BookingDetail.UnitPrice%TYPE,
      p_seqno        IN BookingDetail.SeqNo%TYPE DEFAULT NULL
   ) IS
      v_dummy    NUMBER;
      v_totalpax NUMBER;
      v_subtotal BookingDetail.SubTotalAmount%TYPE;
   BEGIN
      IF p_bookingid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20951, 'BookingID is required.');
      END IF;
      IF p_tourid IS NULL THEN
         RAISE_APPLICATION_ERROR(-20952, 'TourID is required.');
      END IF;
      IF p_servdatefrom IS NULL OR p_servdateto IS NULL THEN
         RAISE_APPLICATION_ERROR(-20953, 'ServDateFrom and ServDateTo are required.');
      END IF;
      IF p_paxadult IS NULL OR p_paxchild IS NULL THEN
         RAISE_APPLICATION_ERROR(-20954, 'PaxAdult and PaxChild are required.');
      END IF;
      IF p_unitprice IS NULL THEN
         RAISE_APPLICATION_ERROR(-20955, 'UnitPrice is required.');
      END IF;
      IF p_servdateto < p_servdatefrom THEN
         RAISE_APPLICATION_ERROR(-20956, 'ServDateTo must be >= ServDateFrom.');
      END IF;
      IF p_paxadult < 0 THEN
         RAISE_APPLICATION_ERROR(-20957, 'PaxAdult must be >= 0.');
      END IF;
      IF p_paxchild < 0 THEN
         RAISE_APPLICATION_ERROR(-20958, 'PaxChild must be >= 0.');
      END IF;
      IF p_unitprice < 0 THEN
         RAISE_APPLICATION_ERROR(-20959, 'UnitPrice must be >= 0.');
      END IF;

      SELECT 1 INTO v_dummy FROM Booking WHERE BookingID = p_bookingid FOR UPDATE;
      SELECT 1 INTO v_dummy FROM Tour    WHERE TourID    = p_tourid;

      v_totalpax := p_paxadult + p_paxchild;
      v_subtotal := v_totalpax * p_unitprice;

      INSERT INTO BookingDetail (
         BookingID, SeqNo, TourID, ServDateFrom, ServDateTo,
         PaxAdult, PaxChild, UnitPrice, SubTotalAmount
      ) VALUES (
         p_bookingid, p_seqno, p_tourid, p_servdatefrom, p_servdateto,
         p_paxadult, p_paxchild, p_unitprice, v_subtotal
      );

      UPDATE Booking
         SET TotalPax    = (SELECT NVL(SUM(PaxAdult + PaxChild), 0)
                              FROM BookingDetail
                             WHERE BookingID = p_bookingid),
             TotalAmount = (SELECT NVL(SUM(SubTotalAmount), 0)
                              FROM BookingDetail
                             WHERE BookingID = p_bookingid)
       WHERE BookingID = p_bookingid;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20960, 'Invalid foreign key: BookingID or TourID not found.');
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20961, 'Duplicate (BookingID, SeqNo).');
   END sp_booking_add_detail;
END pkg_bookingdetail;
/

-- ============================================================
-- Booking Recalculate Total
-- ============================================================
CREATE OR REPLACE PROCEDURE sp_booking_recalc_total (
   p_bookingid IN Booking.BookingID%TYPE
) IS
   v_dummy       NUMBER;
   v_totalpax    NUMBER;
   v_totalamount Booking.TotalAmount%TYPE;
BEGIN
   IF p_bookingid IS NULL THEN
      RAISE_APPLICATION_ERROR(-20971, 'BookingID is required.');
   END IF;

   SELECT 1 INTO v_dummy FROM Booking WHERE BookingID = p_bookingid FOR UPDATE;

   SELECT NVL(SUM(PaxAdult + PaxChild), 0),
          NVL(SUM(SubTotalAmount), 0)
     INTO v_totalpax,
          v_totalamount
     FROM BookingDetail
    WHERE BookingID = p_bookingid;

   UPDATE Booking
      SET TotalPax    = v_totalpax,
          TotalAmount = v_totalamount
    WHERE BookingID = p_bookingid;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20972, 'BookingID not found.');
END sp_booking_recalc_total;
/

-- ============================================================
-- Function: Promotion Discount Amount
-- ============================================================
CREATE OR REPLACE FUNCTION fn_promo_discount (
   p_bookingid IN Booking.BookingID%TYPE
) RETURN NUMBER IS
   v_promoid       Booking.PromotionID%TYPE;
   v_bookingdate   Booking.BookingDate%TYPE;
   v_totalpax      Booking.TotalPax%TYPE;
   v_totalamount   Booking.TotalAmount%TYPE;
   v_minpax        Promotion.MinPax%TYPE;
   v_discountvalue Promotion.DiscountValue%TYPE;
   v_startdate     Promotion.StartDate%TYPE;
   v_enddate       Promotion.EndDate%TYPE;
   v_status        Promotion.Status%TYPE;
   v_discountamount NUMBER(12, 2);
BEGIN
   IF p_bookingid IS NULL THEN
      RAISE_APPLICATION_ERROR(-20981, 'BookingID is required.');
   END IF;

   SELECT PromotionID, BookingDate, TotalPax, TotalAmount
     INTO v_promoid, v_bookingdate, v_totalpax, v_totalamount
     FROM Booking
    WHERE BookingID = p_bookingid;

   IF v_promoid IS NULL THEN
      RETURN 0;
   END IF;

   SELECT MinPax, DiscountValue, StartDate, EndDate, Status
     INTO v_minpax, v_discountvalue, v_startdate, v_enddate, v_status
     FROM Promotion
    WHERE PromotionID = v_promoid;

   IF v_status IS NOT NULL AND UPPER(v_status) NOT IN ('ACTIVE', 'A') THEN
      RETURN 0;
   END IF;
   IF v_minpax IS NOT NULL AND v_totalpax < v_minpax THEN
      RETURN 0;
   END IF;
   IF v_startdate IS NOT NULL AND v_bookingdate < v_startdate THEN
      RETURN 0;
   END IF;
   IF v_enddate IS NOT NULL AND v_bookingdate > v_enddate THEN
      RETURN 0;
   END IF;
   IF v_discountvalue IS NULL OR v_discountvalue <= 0 THEN
      RETURN 0;
   END IF;

   v_discountamount := ROUND(v_totalamount * (v_discountvalue / 100), 2);
   IF v_discountamount < 0 THEN
      v_discountamount := 0;
   END IF;
   RETURN v_discountamount;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20982, 'Booking or Promotion not found for discount calculation.');
END fn_promo_discount;
/

-- ============================================================
-- Apply Promotion to Booking
-- ============================================================
CREATE OR REPLACE PROCEDURE sp_apply_booking_promo (
   p_bookingid   IN Booking.BookingID%TYPE,
   p_promotionid IN Promotion.PromotionID%TYPE
) IS
   v_bookingdate   Booking.BookingDate%TYPE;
   v_totalpax      Booking.TotalPax%TYPE;
   v_totalamount   Booking.TotalAmount%TYPE;
   v_paymentstatus Booking.PaymentStatus%TYPE;
   v_bookingstatus Booking.BookingStatus%TYPE;
   v_minpax        Promotion.MinPax%TYPE;
   v_discountvalue Promotion.DiscountValue%TYPE;
   v_startdate     Promotion.StartDate%TYPE;
   v_enddate       Promotion.EndDate%TYPE;
   v_status        Promotion.Status%TYPE;
   v_discountamt   NUMBER(12, 2);
   v_netamt        NUMBER(12, 2);
BEGIN
   IF p_bookingid IS NULL THEN
      RAISE_APPLICATION_ERROR(-20983, 'BookingID is required.');
   END IF;
   IF p_promotionid IS NULL THEN
      RAISE_APPLICATION_ERROR(-20984, 'PromotionID is required.');
   END IF;

   SELECT BookingDate, TotalPax, TotalAmount, PaymentStatus, BookingStatus
     INTO v_bookingdate, v_totalpax, v_totalamount, v_paymentstatus, v_bookingstatus
     FROM Booking
    WHERE BookingID = p_bookingid
    FOR UPDATE;

   IF v_bookingstatus IN ('CANCELLED', 'COMPLETED') THEN
      RAISE_APPLICATION_ERROR(-20985, 'Cannot apply promotion: booking is CANCELLED or COMPLETED.');
   END IF;
   IF v_paymentstatus IN ('PAID', 'REFUNDED') THEN
      RAISE_APPLICATION_ERROR(-20986, 'Cannot apply promotion: payment already processed.');
   END IF;

   SELECT MinPax, DiscountValue, StartDate, EndDate, Status
     INTO v_minpax, v_discountvalue, v_startdate, v_enddate, v_status
     FROM Promotion
    WHERE PromotionID = p_promotionid;

   IF v_status IS NOT NULL AND UPPER(v_status) NOT IN ('ACTIVE', 'A') THEN
      RAISE_APPLICATION_ERROR(-20987, 'Promotion is not active.');
   END IF;
   IF v_minpax IS NOT NULL AND v_totalpax < v_minpax THEN
      RAISE_APPLICATION_ERROR(-20988, 'Promotion not eligible: TotalPax is less than MinPax.');
   END IF;
   IF v_startdate IS NOT NULL AND v_bookingdate < v_startdate THEN
      RAISE_APPLICATION_ERROR(-20989, 'Promotion not eligible: BookingDate before promotion StartDate.');
   END IF;
   IF v_enddate IS NOT NULL AND v_bookingdate > v_enddate THEN
      RAISE_APPLICATION_ERROR(-20990, 'Promotion not eligible: BookingDate after promotion EndDate.');
   END IF;

   v_discountamt := ROUND((v_totalamount * (v_discountvalue / 100)), 2);
   v_netamt      := ROUND((v_totalamount - v_discountamt), 2);
   IF v_netamt < 0 THEN
      v_netamt := 0;
   END IF;

   UPDATE Booking
      SET PromotionID = p_promotionid,
          TotalAmount = v_netamt
    WHERE BookingID = p_bookingid;

   COMMIT;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20991, 'BookingID or PromotionID not found.');
END sp_apply_booking_promo;
/
