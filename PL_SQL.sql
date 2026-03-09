--PL/SQL for Master table
--Booking
alter table booking modify (
   promotionid varchar2(8) null
);

create or replace package pkg_booking as
   procedure sp_booking_ins (
      p_bookingid     in booking.bookingid%type,
      p_customerid    in booking.customerid%type,
      p_promotionid   in booking.promotionid%type,
      p_empno         in booking.empno%type,
      p_bookingdate   in booking.bookingdate%type,
      p_bookingstatus in booking.bookingstatus%type,
      p_paymentstatus in booking.paymentstatus%type,
      p_paymentmethod in booking.paymentmethod%type,
      p_totalpax      in booking.totalpax%type,
      p_totalamount   in booking.totalamount%type
   );

   procedure sp_booking_upd (
      p_bookingid     in booking.bookingid%type,
      p_customerid    in booking.customerid%type,
      p_promotionid   in booking.promotionid%type,
      p_empno         in booking.empno%type,
      p_bookingdate   in booking.bookingdate%type,
      p_bookingstatus in booking.bookingstatus%type,
      p_paymentstatus in booking.paymentstatus%type,
      p_paymentmethod in booking.paymentmethod%type,
      p_totalpax      in booking.totalpax%type,
      p_totalamount   in booking.totalamount%type
   );

end pkg_booking;

create or replace package body pkg_booking as
   procedure sp_booking_ins (
      p_bookingid     in booking.bookingid%type,
      p_customerid    in booking.customerid%type,
      p_promotionid   in booking.promotionid%type,
      p_empno         in booking.empno%type,
      p_bookingdate   in booking.bookingdate%type,
      p_bookingstatus in booking.bookingstatus%type,
      p_paymentstatus in booking.paymentstatus%type,
      p_paymentmethod in booking.paymentmethod%type,
      p_totalpax      in booking.totalpax%type,
      p_totalamount   in booking.totalamount%type
   ) is
      v_dummy         number;
      v_bookingstatus booking.bookingstatus%type;
      v_paymentstatus booking.paymentstatus%type;
      v_paymentmethod booking.paymentmethod%type;
   begin
      if p_bookingid is null then
         raise_application_error(
            -22001,
            'BookingID is required.'
         );
      end if;
      if p_customerid is null then
         raise_application_error(
            -22002,
            'CustomerID is required.'
         );
      end if;
      if p_empno is null then
         raise_application_error(
            -22004,
            'EmpNo is required.'
         );
      end if;
      if p_bookingdate is null then
         raise_application_error(
            -22005,
            'BookingDate is required.'
         );
      end if;
      if p_bookingstatus is null then
         raise_application_error(
            -22006,
            'BookingStatus is required.'
         );
      end if;
      if p_paymentstatus is null then
         raise_application_error(
            -22007,
            'PaymentStatus is required.'
         );
      end if;
      if p_paymentmethod is null then
         raise_application_error(
            -22008,
            'PaymentMethod is required.'
         );
      end if;
      if p_totalpax is null then
         raise_application_error(
            -22009,
            'TotalPax is required.'
         );
      end if;
      if p_totalamount is null then
         raise_application_error(
            -22010,
            'TotalAmount is required.'
         );
      end if;
      if p_totalpax <= 0 then
         raise_application_error(
            -22011,
            'TotalPax must be > 0.'
         );
      end if;
      if p_totalamount < 0 then
         raise_application_error(
            -22012,
            'TotalAmount must be >= 0.'
         );
      end if;
      v_bookingstatus := nvl(
         p_bookingstatus,
         'PENDING'
      );
      v_paymentstatus := nvl(
         p_paymentstatus,
         'UNPAID'
      );
      v_paymentmethod := nvl(
         p_paymentmethod,
         'CASH'
      );
      if p_bookingstatus not in ( 'PENDING',
                                  'CONFIRMED',
                                  'CANCELLED',
                                  'COMPLETED' ) then
         raise_application_error(
            -22013,
            'Invalid BookingStatus.'
         );
      end if;

      if p_paymentstatus not in ( 'UNPAID',
                                  'PAID',
                                  'REFUNDED',
                                  'PARTIAL' ) then
         raise_application_error(
            -22014,
            'Invalid PaymentStatus.'
         );
      end if;

      if p_paymentmethod not in ( 'CASH',
                                  'CARD',
                                  'TRANSFER',
                                  'E-WALLET' ) then
         raise_application_error(
            -22015,
            'Invalid PaymentMethod.'
         );
      end if;

      select 1
        into v_dummy
        from customer
       where customerid = p_customerid;

      select 1
        into v_dummy
        from employee
       where empno = p_empno;

      select 1
        into v_dummy
        from promotion
       where promotionid = p_promotionid;

      insert into booking (
         bookingid,
         customerid,
         promotionid,
         empno,
         bookingdate,
         bookingstatus,
         paymentstatus,
         paymentmethod,
         totalpax,
         totalamount
      ) values ( p_bookingid,
                 p_customerid,
                 p_promotionid,
                 p_empno,
                 p_bookingdate,
                 p_bookingstatus,
                 p_paymentstatus,
                 p_paymentmethod,
                 p_totalpax,
                 p_totalamount );

   exception
      when dup_val_on_index then
         raise_application_error(
            -22020,
            'BookingID already exists.'
         );
      when no_data_found then
         raise_application_error(
            -22021,
            'Invalid foreign key: CustomerID / EmpNo / PromotionID not found.'
         );
   end sp_booking_ins;

   procedure sp_booking_upd (
      p_bookingid     in booking.bookingid%type,
      p_customerid    in booking.customerid%type,
      p_promotionid   in booking.promotionid%type,
      p_empno         in booking.empno%type,
      p_bookingdate   in booking.bookingdate%type,
      p_bookingstatus in booking.bookingstatus%type,
      p_paymentstatus in booking.paymentstatus%type,
      p_paymentmethod in booking.paymentmethod%type,
      p_totalpax      in booking.totalpax%type,
      p_totalamount   in booking.totalamount%type
   ) is
      v_dummy number;
   begin
      if p_bookingid is null then
         raise_application_error(
            -22031,
            'BookingID is required for update.'
         );
      end if;
      if p_customerid is null
      or p_promotionid is null
      or p_empno is null
      or p_bookingdate is null
      or p_bookingstatus is null
      or p_paymentstatus is null
      or p_paymentmethod is null
      or p_totalpax is null
      or p_totalamount is null then
         raise_application_error(
            -22032,
            'All booking fields are required for update.'
         );
      end if;

      if p_totalpax <= 0 then
         raise_application_error(
            -22033,
            'TotalPax must be > 0.'
         );
      end if;
      if p_totalamount < 0 then
         raise_application_error(
            -22034,
            'TotalAmount must be >= 0.'
         );
      end if;
      if p_bookingstatus not in ( 'PENDING',
                                  'CONFIRMED',
                                  'CANCELLED',
                                  'COMPLETED' ) then
         raise_application_error(
            -22035,
            'Invalid BookingStatus.'
         );
      end if;

      if p_paymentstatus not in ( 'UNPAID',
                                  'PAID',
                                  'REFUNDED',
                                  'PARTIAL' ) then
         raise_application_error(
            -22036,
            'Invalid PaymentStatus.'
         );
      end if;

      if p_paymentmethod not in ( 'CASH',
                                  'CARD',
                                  'TRANSFER',
                                  'E-WALLET' ) then
         raise_application_error(
            -22037,
            'Invalid PaymentMethod.'
         );
      end if;

      select 1
        into v_dummy
        from customer
       where customerid = p_customerid;
      select 1
        into v_dummy
        from employee
       where empno = p_empno;
      select 1
        into v_dummy
        from promotion
       where promotionid = p_promotionid;

      update booking
         set customerid = p_customerid,
             promotionid = p_promotionid,
             empno = p_empno,
             bookingdate = p_bookingdate,
             bookingstatus = p_bookingstatus,
             paymentstatus = p_paymentstatus,
             paymentmethod = p_paymentmethod,
             totalpax = p_totalpax,
             totalamount = p_totalamount
       where bookingid = p_bookingid;

      if sql%rowcount = 0 then
         raise_application_error(
            -22038,
            'BookingID not found.'
         );
      end if;
   exception
      when no_data_found then
         raise_application_error(
            -22039,
            'Invalid foreign key: CustomerID / EmpNo / PromotionID not found.'
         );
   end sp_booking_upd;

end pkg_booking;


--Insert and Update PL/SQL of Employee
create or replace package pkg_employee as
   procedure sp_employee_ins (
      p_empno      in employee.empno%type,
      p_fname      in employee.fname%type,
      p_lname      in employee.lname%type,
      p_position   in employee.position%type,
      p_startdate  in employee.startdate%type,
      p_resigndate in employee.resigndate%type,
      p_deptcode   in employee.deptcode%type,
      p_status     in employee.status%type
   );

   procedure sp_employee_upd (
      p_empno      in employee.empno%type,
      p_fname      in employee.fname%type,
      p_lname      in employee.lname%type,
      p_position   in employee.position%type,
      p_startdate  in employee.startdate%type,
      p_resigndate in employee.resigndate%type,
      p_deptcode   in employee.deptcode%type,
      p_status     in employee.status%type
   );

end pkg_employee;

create or replace package body pkg_employee as
   procedure sp_employee_ins (
      p_empno      in employee.empno%type,
      p_fname      in employee.fname%type,
      p_lname      in employee.lname%type,
      p_position   in employee.position%type,
      p_startdate  in employee.startdate%type,
      p_resigndate in employee.resigndate%type,
      p_deptcode   in employee.deptcode%type,
      p_status     in employee.status%type
   ) is
      v_dummy number;
   begin
      if p_empno is null then
         raise_application_error(
            -20101,
            'EmpNo is required.'
         );
      end if;
      if p_fname is null then
         raise_application_error(
            -20102,
            'FName is required.'
         );
      end if;
      if p_lname is null then
         raise_application_error(
            -20103,
            'LName is required.'
         );
      end if;
      if p_status is null then
         raise_application_error(
            -20104,
            'Status is required (A/R).'
         );
      end if;
      if p_status not in ( 'A',
                           'R' ) then
         raise_application_error(
            -20105,
            'Status must be A (Active) or R (Resigned).'
         );
      end if;

      if p_resigndate is not null then
         if p_startdate is null then
            raise_application_error(
               -20106,
               'StartDate is required when ResignDate is provided.'
            );
         end if;
         if p_resigndate < p_startdate then
            raise_application_error(
               -20107,
               'ResignDate must be >= StartDate.'
            );
         end if;
      end if;

      if p_deptcode is not null then
         select 1
           into v_dummy
           from department
          where deptcode = p_deptcode;
      end if;

      insert into employee (
         empno,
         fname,
         lname,
         position,
         startdate,
         resigndate,
         deptcode,
         status
      ) values ( p_empno,
                 p_fname,
                 p_lname,
                 p_position,
                 p_startdate,
                 p_resigndate,
                 p_deptcode,
                 p_status );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20110,
            'EmpNo already exists.'
         );
      when no_data_found then
         raise_application_error(
            -20111,
            'DeptCode not found in Department.'
         );
   end sp_employee_ins;

   procedure sp_employee_upd (
      p_empno      in employee.empno%type,
      p_fname      in employee.fname%type,
      p_lname      in employee.lname%type,
      p_position   in employee.position%type,
      p_startdate  in employee.startdate%type,
      p_resigndate in employee.resigndate%type,
      p_deptcode   in employee.deptcode%type,
      p_status     in employee.status%type
   ) is
      v_dummy number;
   begin
      if p_empno is null then
         raise_application_error(
            -20121,
            'EmpNo is required for update.'
         );
      end if;
      if
         p_status is not null
         and p_status not in ( 'A',
                               'R' )
      then
         raise_application_error(
            -20122,
            'Status must be A (Active) or R (Resigned).'
         );
      end if;

      if p_resigndate is not null then
         if p_startdate is null then
            raise_application_error(
               -20123,
               'StartDate is required when ResignDate is provided.'
            );
         end if;
         if p_resigndate < p_startdate then
            raise_application_error(
               -20124,
               'ResignDate must be >= StartDate.'
            );
         end if;
      end if;

      if p_deptcode is not null then
         select 1
           into v_dummy
           from department
          where deptcode = p_deptcode;
      end if;

      update employee
         set fname = p_fname,
             lname = p_lname,
             position = p_position,
             startdate = p_startdate,
             resigndate = p_resigndate,
             deptcode = p_deptcode,
             status = p_status
       where empno = p_empno;

      if sql%rowcount = 0 then
         raise_application_error(
            -20125,
            'EmpNo not found.'
         );
      end if;
   exception
      when no_data_found then
         raise_application_error(
            -20126,
            'DeptCode not found in Department.'
         );
   end sp_employee_upd;

end pkg_employee;

--CostType Insert & Update PL/SQL

create or replace package pkg_costtype as
   procedure sp_costtype_ins (
      p_costtypeid  in costtype.costtypeid%type,
      p_name        in costtype.name%type,
      p_description in costtype.description%type
   );

   procedure sp_costtype_upd (
      p_costtypeid  in costtype.costtypeid%type,
      p_name        in costtype.name%type,
      p_description in costtype.description%type
   );

end pkg_costtype;

create or replace package body pkg_costtype as
   procedure sp_costtype_ins (
      p_costtypeid  in costtype.costtypeid%type,
      p_name        in costtype.name%type,
      p_description in costtype.description%type
   ) is
   begin
      if p_costtypeid is null then
         raise_application_error(
            -20201,
            'CostTypeID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20202,
            'Name is required.'
         );
      end if;
      insert into costtype (
         costtypeid,
         name,
         description
      ) values ( p_costtypeid,
                 p_name,
                 p_description );
   exception
      when dup_val_on_index then
         raise_application_error(
            -20203,
            'CostTypeID already exists.'
         );
   end sp_costtype_ins;

   procedure sp_costtype_upd (
      p_costtypeid  in costtype.costtypeid%type,
      p_name        in costtype.name%type,
      p_description in costtype.description%type
   ) is
   begin
      if p_costtypeid is null then
         raise_application_error(
            -20211,
            'CostTypeID is required for update.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20212,
            'Name is required.'
         );
      end if;
      update costtype
         set name = p_name,
             description = p_description
       where costtypeid = p_costtypeid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20213,
            'CostTypeID not found.'
         );
      end if;
   end sp_costtype_upd;
end pkg_costtype;

--ItemCost Insert & Update PL/SQL
create or replace package pkg_itemcost as
   procedure sp_itemcost_ins (
      p_itemcostid  in itemcost.itemcostid%type,
      p_name        in itemcost.name%type,
      p_email       in itemcost.email%type,
      p_rateperunit in itemcost.rateperunit%type,
      p_status      in itemcost.status%type,
      p_countryid   in itemcost.countryid%type,
      p_costtypeid  in itemcost.costtypeid%type
   );

   procedure sp_itemcost_upd (
      p_itemcostid  in itemcost.itemcostid%type,
      p_name        in itemcost.name%type,
      p_email       in itemcost.email%type,
      p_rateperunit in itemcost.rateperunit%type,
      p_status      in itemcost.status%type,
      p_countryid   in itemcost.countryid%type,
      p_costtypeid  in itemcost.costtypeid%type
   );

end pkg_itemcost;

create or replace package body pkg_itemcost as
   procedure sp_itemcost_ins (
      p_itemcostid  in itemcost.itemcostid%type,
      p_name        in itemcost.name%type,
      p_email       in itemcost.email%type,
      p_rateperunit in itemcost.rateperunit%type,
      p_status      in itemcost.status%type,
      p_countryid   in itemcost.countryid%type,
      p_costtypeid  in itemcost.costtypeid%type
   ) is
      v_dummy number;
   begin
      if p_itemcostid is null then
         raise_application_error(
            -20301,
            'ItemCostID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20302,
            'Name is required.'
         );
      end if;
      if
         p_rateperunit is not null
         and p_rateperunit < 0
      then
         raise_application_error(
            -20303,
            'RatePerUnit must be >= 0.'
         );
      end if;

      if
         p_status is not null
         and p_status not in ( 'A',
                               'R' )
      then
         raise_application_error(
            -20304,
            'Status must be A (Active) or R (Resigned).'
         );
      end if;

      if p_countryid is not null then
         select 1
           into v_dummy
           from country
          where countryid = p_countryid;
      end if;

      if p_costtypeid is not null then
         select 1
           into v_dummy
           from costtype
          where costtypeid = p_costtypeid;
      end if;

      insert into itemcost (
         itemcostid,
         name,
         email,
         rateperunit,
         status,
         countryid,
         costtypeid
      ) values ( p_itemcostid,
                 p_name,
                 p_email,
                 p_rateperunit,
                 p_status,
                 p_countryid,
                 p_costtypeid );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20310,
            'ItemCostID already exists.'
         );
      when no_data_found then
         raise_application_error(
            -20311,
            'Invalid foreign key: CountryID or CostTypeID not found.'
         );
   end sp_itemcost_ins;

   procedure sp_itemcost_upd (
      p_itemcostid  in itemcost.itemcostid%type,
      p_name        in itemcost.name%type,
      p_email       in itemcost.email%type,
      p_rateperunit in itemcost.rateperunit%type,
      p_status      in itemcost.status%type,
      p_countryid   in itemcost.countryid%type,
      p_costtypeid  in itemcost.costtypeid%type
   ) is
      v_dummy number;
   begin
      if p_itemcostid is null then
         raise_application_error(
            -20321,
            'ItemCostID is required for update.'
         );
      end if;
      if
         p_rateperunit is not null
         and p_rateperunit < 0
      then
         raise_application_error(
            -20322,
            'RatePerUnit must be >= 0.'
         );
      end if;

      if
         p_status is not null
         and p_status not in ( 'A',
                               'I' )
      then
         raise_application_error(
            -20323,
            'Status must be A (Active) or I (Inactive).'
         );
      end if;

      if p_countryid is not null then
         select 1
           into v_dummy
           from country
          where countryid = p_countryid;
      end if;

      if p_costtypeid is not null then
         select 1
           into v_dummy
           from costtype
          where costtypeid = p_costtypeid;
      end if;

      update itemcost
         set name = p_name,
             email = p_email,
             rateperunit = p_rateperunit,
             status = p_status,
             countryid = p_countryid,
             costtypeid = p_costtypeid
       where itemcostid = p_itemcostid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20324,
            'ItemCostID not found.'
         );
      end if;
   exception
      when no_data_found then
         raise_application_error(
            -20325,
            'Invalid foreign key: CountryID or CostTypeID not found.'
         );
   end sp_itemcost_upd;
end pkg_itemcost;

--TourPlan PL/SQL
create or replace package pkg_tourplan as
   procedure sp_tourplan_ins (
      p_tourplanid  in tourplan.tourplanid%type,
      p_name        in tourplan.name%type,
      p_description in tourplan.description%type
   );

   procedure sp_tourplan_upd (
      p_tourplanid  in tourplan.tourplanid%type,
      p_name        in tourplan.name%type,
      p_description in tourplan.description%type
   );

end pkg_tourplan;

create or replace package body pkg_tourplan as
   procedure sp_tourplan_ins (
      p_tourplanid  in tourplan.tourplanid%type,
      p_name        in tourplan.name%type,
      p_description in tourplan.description%type
   ) is
   begin
      if p_tourplanid is null then
         raise_application_error(
            -20401,
            'TourPlanID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20402,
            'Name is required.'
         );
      end if;
      insert into tourplan (
         tourplanid,
         name,
         description
      ) values ( p_tourplanid,
                 p_name,
                 p_description );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20403,
            'TourPlanID already exists.'
         );
   end sp_tourplan_ins;

   procedure sp_tourplan_upd (
      p_tourplanid  in tourplan.tourplanid%type,
      p_name        in tourplan.name%type,
      p_description in tourplan.description%type
   ) is
   begin
      if p_tourplanid is null then
         raise_application_error(
            -20411,
            'TourPlanID is required for update.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20412,
            'Name is required.'
         );
      end if;
      update tourplan
         set name = p_name,
             description = p_description
       where tourplanid = p_tourplanid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20413,
            'TourPlanID not found.'
         );
      end if;
   end sp_tourplan_upd;

end pkg_tourplan;

--TourType PL/SQL (Insert & Update)
create or replace package pkg_tourtype as
   procedure sp_tourtype_ins (
      p_tourtypeid   in tourtype.tourtypeid%type,
      p_name         in tourtype.name%type,
      p_description  in tourtype.description%type,
      p_baseprice    in tourtype.baseprice%type,
      p_durationdays in tourtype.durationdays%type,
      p_activeflag   in tourtype.activeflag%type
   );

   procedure sp_tourtype_upd (
      p_tourtypeid   in tourtype.tourtypeid%type,
      p_name         in tourtype.name%type,
      p_description  in tourtype.description%type,
      p_baseprice    in tourtype.baseprice%type,
      p_durationdays in tourtype.durationdays%type,
      p_activeflag   in tourtype.activeflag%type
   );

end pkg_tourtype;

create or replace package body pkg_tourtype as
   procedure sp_tourtype_ins (
      p_tourtypeid   in tourtype.tourtypeid%type,
      p_name         in tourtype.name%type,
      p_description  in tourtype.description%type,
      p_baseprice    in tourtype.baseprice%type,
      p_durationdays in tourtype.durationdays%type,
      p_activeflag   in tourtype.activeflag%type
   ) is
   begin
      if p_tourtypeid is null then
         raise_application_error(
            -20501,
            'TourTypeID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20502,
            'Name is required.'
         );
      end if;
      if
         p_baseprice is not null
         and p_baseprice < 0
      then
         raise_application_error(
            -20503,
            'BasePrice must be >= 0.'
         );
      end if;

      if
         p_durationdays is not null
         and p_durationdays <= 0
      then
         raise_application_error(
            -20504,
            'DurationDays must be > 0.'
         );
      end if;

      if
         p_activeflag is not null
         and p_activeflag not in ( 'Y',
                                   'N' )
      then
         raise_application_error(
            -20505,
            'ActiveFlag must be Y or N.'
         );
      end if;

      insert into tourtype (
         tourtypeid,
         name,
         description,
         baseprice,
         durationdays,
         activeflag
      ) values ( p_tourtypeid,
                 p_name,
                 p_description,
                 p_baseprice,
                 p_durationdays,
                 p_activeflag );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20506,
            'TourTypeID already exists.'
         );
   end sp_tourtype_ins;

   procedure sp_tourtype_upd (
      p_tourtypeid   in tourtype.tourtypeid%type,
      p_name         in tourtype.name%type,
      p_description  in tourtype.description%type,
      p_baseprice    in tourtype.baseprice%type,
      p_durationdays in tourtype.durationdays%type,
      p_activeflag   in tourtype.activeflag%type
   ) is
   begin
      if p_tourtypeid is null then
         raise_application_error(
            -20511,
            'TourTypeID is required for update.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20512,
            'Name is required.'
         );
      end if;
      if
         p_baseprice is not null
         and p_baseprice < 0
      then
         raise_application_error(
            -20513,
            'BasePrice must be >= 0.'
         );
      end if;

      if
         p_durationdays is not null
         and p_durationdays <= 0
      then
         raise_application_error(
            -20514,
            'DurationDays must be > 0.'
         );
      end if;

      if
         p_activeflag is not null
         and p_activeflag not in ( 'Y',
                                   'N' )
      then
         raise_application_error(
            -20515,
            'ActiveFlag must be Y or N.'
         );
      end if;

      update tourtype
         set name = p_name,
             description = p_description,
             baseprice = p_baseprice,
             durationdays = p_durationdays,
             activeflag = p_activeflag
       where tourtypeid = p_tourtypeid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20516,
            'TourTypeID not found.'
         );
      end if;
   end sp_tourtype_upd;

end pkg_tourtype;

--Country PL/SQL
create or replace package pkg_country as
   procedure sp_country_ins (
      p_countryid   in country.countryid%type,
      p_name        in country.name%type,
      p_description in country.description%type,
      p_regionid    in country.regionid%type       
   );

   procedure sp_country_upd (
      p_countryid   in country.countryid%type,
      p_name        in country.name%type,
      p_description in country.description%type,
      p_regionid    in country.regionid%type      
   );
end pkg_country;

create or replace package body pkg_country as
   procedure sp_country_ins (
      p_countryid   in country.countryid%type,
      p_name        in country.name%type,
      p_description in country.description%type,
      p_regionid    in country.regionid%type       
   ) is
      v_dummy number;
   begin
      if p_countryid is null then
         raise_application_error(-20601, 'CountryID is required.');
      end if;
      if p_name is null then
         raise_application_error(-20602, 'Name is required.');
      end if;

      -- เช็ค FK RegionID เฉพาะตอนที่ใส่ค่ามา
      if p_regionid is not null then
         select 1 into v_dummy from region where regionid = p_regionid;
      end if;

      insert into country (
         countryid, name, description, regionid
      ) values (
         p_countryid, p_name, p_description, p_regionid
      );
   exception
      when dup_val_on_index then
         raise_application_error(-20603, 'CountryID already exists.');
      when no_data_found then
         raise_application_error(-20604, 'RegionID not found in Region.');
   end sp_country_ins;

   procedure sp_country_upd (
      p_countryid   in country.countryid%type,
      p_name        in country.name%type,
      p_description in country.description%type,
      p_regionid    in country.regionid%type      
   ) is
      v_dummy number;
   begin
      if p_countryid is null then
         raise_application_error(-20611, 'CountryID is required for update.');
      end if;
      if p_name is null then
         raise_application_error(-20612, 'Name is required.');
      end if;

      -- เช็ค FK RegionID เฉพาะตอนที่ใส่ค่ามา
      if p_regionid is not null then
         select 1 into v_dummy from region where regionid = p_regionid;
      end if;

      update country
         set name        = p_name,
             description = p_description,
             regionid    = p_regionid            
       where countryid = p_countryid;

      if sql%rowcount = 0 then
         raise_application_error(-20613, 'CountryID not found.');
      end if;
   exception
      when no_data_found then
         raise_application_error(-20614, 'RegionID not found in Region.');
   end sp_country_upd;
end pkg_country;

--Guide
create or replace package pkg_guide as
   procedure sp_guide_ins (
      p_guideid        in guide.guideid%type,
      p_name           in guide.name%type,
      p_email          in guide.email%type,
      p_languageskills in guide.languageskills%type,
      p_phone          in guide.phone%type,
      p_salary         in guide.salary%type,
      p_specialty      in guide.specialty%type,
      p_status         in guide.status%type
   );

   procedure sp_guide_upd (
       p_guideid        in guide.guideid%type,
      p_name           in guide.name%type,
      p_email          in guide.email%type,
      p_languageskills in guide.languageskills%type,
      p_phone          in guide.phone%type,
      p_salary         in guide.salary%type,       
      p_specialty      in guide.specialty%type,
      p_status         in guide.status%type

   );

end pkg_guide;

create or replace package body pkg_guide as
   procedure sp_guide_ins (
      p_guideid        in guide.guideid%type,
      p_name           in guide.name%type,
      p_email          in guide.email%type,
      p_languageskills in guide.languageskills%type,
      p_phone          in guide.phone%type,
      p_salary         in guide.salary%type,
      p_specialty      in guide.specialty%type,
      p_status         in guide.status%type

   ) is
   begin
      if p_guideid is null then
         raise_application_error(
            -20701,
            'GuideID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20702,
            'Name is required.'
         );
      end if;
      if
         p_phone is not null
         and p_phone < 0
      then
         raise_application_error(
            -20703,
            'Phone must be >= 0.'
         );
      end if;

      insert into guide (
         guideid,
         name,
         email,
         languageskills,
         phone,
         salary,
         specialty,
         status

      ) values ( p_guideid,
                 p_name,
                 p_email,
                 p_languageskills,
                 p_phone,
                 p_salary,
                 p_specialty,
                 p_status );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20704,
            'GuideID already exists.'
         );
   end sp_guide_ins;

   procedure sp_guide_upd (
      p_guideid        in guide.guideid%type,
      p_name           in guide.name%type,
      p_email          in guide.email%type,
      p_languageskills in guide.languageskills%type,
      p_phone          in guide.phone%type,
      p_salary         in guide.salary%type,      
      p_specialty      in guide.specialty%type,
      p_status         in guide.status%type
   ) is
   begin
      if p_guideid is null then
         raise_application_error(
            -20711,
            'GuideID is required for update.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20712,
            'Name is required.'
         );
      end if;
      if
         p_phone is not null
         and p_phone < 0
      then
         raise_application_error(
            -20713,
            'Phone must be >= 0.'
         );
      end if;

      update guide
         set name = p_name,
             email = p_email,
             languageskills = p_languageskills,
             phone = p_phone,
             salary = p_salary,
             specialty = p_specialty,
             status = p_status
       where guideid = p_guideid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20714,
            'GuideID not found.'
         );
      end if;
   end sp_guide_upd;
end pkg_guide;
 
--Tour PL/SQL
create or replace package pkg_tour as
   procedure sp_tour_ins (
      p_tourid      in tour.tourid%type,
      p_tourcode    in tour.tourcode%type,
      p_tourtypeid  in tour.tourtypeid%type,
      p_name        in tour.name%type,
      p_capacitypax in tour.capacitypax%type,
      p_startdate   in tour.startdate%type,
      p_enddate     in tour.enddate%type,
      p_status      in tour.status%type,
      p_countryid   IN tour.countryid%TYPE          

   );

   procedure sp_tour_upd (
      p_tourid      in tour.tourid%type,
      p_tourcode    in tour.tourcode%type,
      p_tourtypeid  in tour.tourtypeid%type,
      p_name        in tour.name%type,
      p_capacitypax in tour.capacitypax%type,
      p_startdate   in tour.startdate%type,
      p_enddate     in tour.enddate%type,
      p_status      in tour.status%type,
      p_countryid   IN tour.countryid%TYPE          
   );

end pkg_tour;

create or replace package body pkg_tour as
   procedure sp_tour_ins (
      p_tourid      in tour.tourid%type,
      p_tourcode    in tour.tourcode%type,
      p_tourtypeid  in tour.tourtypeid%type,
      p_name        in tour.name%type,
      p_capacitypax in tour.capacitypax%type,
      p_startdate   in tour.startdate%type,
      p_enddate     in tour.enddate%type,
      p_status      in tour.status%type,
      p_countryid   IN tour.countryid%TYPE         
   ) is
      v_dummy number;
   begin
      if p_tourid is null then
         raise_application_error(
            -20801,
            'TourID is required.'
         );
      end if;
      if p_tourcode is null then
         raise_application_error(
            -20802,
            'TourCode is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20803,
            'Name is required.'
         );
      end if;
      if
         p_capacitypax is not null
         and p_capacitypax < 0
      then
         raise_application_error(
            -20804,
            'CapacityPax must be >= 0.'
         );
      end if;

      if
         p_startdate is not null
         and p_enddate is not null
         and p_enddate < p_startdate
      then
         raise_application_error(
            -20805,
            'EndDate must be >= StartDate.'
         );
      end if;

      if p_tourtypeid is not null then
         select 1
           into v_dummy
           from tourtype
          where tourtypeid = p_tourtypeid;
      end if;

       -- เช็ค FK CountryID เฉพาะตอนที่ใส่ค่ามา
      IF p_countryid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM country WHERE countryid = p_countryid;
      END IF;

      insert into tour (
         tourid,
         tourcode,
         tourtypeid,
         name,
         capacitypax,
         startdate,
         enddate,
         status,
         countryid                                  
      ) values ( p_tourid,
                 p_tourcode,
                 p_tourtypeid,
                 p_name,
                 p_capacitypax,
                 p_startdate,
                 p_enddate,
                 p_status,
                 p_countryid );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20810,
            'Duplicate TourID or TourCode.'
         );
      when no_data_found then
         raise_application_error(
            -20811,
            'TourTypeID not found in TourType.'
         );
   end sp_tour_ins;

   procedure sp_tour_upd (
      p_tourid      in tour.tourid%type,
      p_tourcode    in tour.tourcode%type,
      p_tourtypeid  in tour.tourtypeid%type,
      p_name        in tour.name%type,
      p_capacitypax in tour.capacitypax%type,
      p_startdate   in tour.startdate%type,
      p_enddate     in tour.enddate%type,
      p_status      in tour.status%type,
      p_countryid   IN tour.countryid%TYPE   
   ) is
      v_dummy number;
   begin
      if p_tourid is null then
         raise_application_error(
            -20821,
            'TourID is required for update.'
         );
      end if;
      if p_tourcode is null then
         raise_application_error(
            -20822,
            'TourCode is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20823,
            'Name is required.'
         );
      end if;
      if
         p_capacitypax is not null
         and p_capacitypax < 0
      then
         raise_application_error(
            -20824,
            'CapacityPax must be >= 0.'
         );
      end if;

      if
         p_startdate is not null
         and p_enddate is not null
         and p_enddate < p_startdate
      then
         raise_application_error(
            -20825,
            'EndDate must be >= StartDate.'
         );
      end if;

      if p_tourtypeid is not null then
         select 1
           into v_dummy
           from tourtype
          where tourtypeid = p_tourtypeid;
      end if;

      -- เช็ค FK CountryID เฉพาะตอนที่ใส่ค่ามา
      IF p_countryid IS NOT NULL THEN
         SELECT 1 INTO v_dummy FROM country WHERE countryid = p_countryid;
      END IF;

      update tour
         set tourcode = p_tourcode,
             tourtypeid = p_tourtypeid,
             name = p_name,
             capacitypax = p_capacitypax,
             startdate = p_startdate,
             enddate = p_enddate,
             status = p_status,
             countryid   = p_countryid  
       where tourid = p_tourid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20826,
            'TourID not found.'
         );
      end if;
   exception
      when dup_val_on_index then
         raise_application_error(
            -20827,
            'Duplicate TourCode (must be unique).'
         );
      when no_data_found then
         raise_application_error(
            -20828,
            'TourTypeID not found in TourType.'
         );
   end sp_tour_upd;
end pkg_tour;

--Promotion PL/SQL
create or replace package pkg_promotion as
   procedure sp_promotion_ins (
      p_promotionid   in promotion.promotionid%type,
      p_name          in promotion.name%type,
      p_minpax        in promotion.minpax%type,
      p_discountvalue in promotion.discountvalue%type,
      p_startdate     in promotion.startdate%type,
      p_enddate       in promotion.enddate%type,
      p_status        in promotion.status%type
   );

   procedure sp_promotion_upd (
      p_promotionid   in promotion.promotionid%type,
      p_name          in promotion.name%type,
      p_minpax        in promotion.minpax%type,
      p_discountvalue in promotion.discountvalue%type,
      p_startdate     in promotion.startdate%type,
      p_enddate       in promotion.enddate%type,
      p_status        in promotion.status%type
   );

end pkg_promotion;

create or replace package body pkg_promotion as
   procedure sp_promotion_ins (
      p_promotionid   in promotion.promotionid%type,
      p_name          in promotion.name%type,
      p_minpax        in promotion.minpax%type,
      p_discountvalue in promotion.discountvalue%type,
      p_startdate     in promotion.startdate%type,
      p_enddate       in promotion.enddate%type,
      p_status        in promotion.status%type
   ) is
   begin
      if p_promotionid is null then
         raise_application_error(
            -20901,
            'PromotionID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20902,
            'Name is required.'
         );
      end if;
      if
         p_minpax is not null
         and p_minpax < 0
      then
         raise_application_error(
            -20903,
            'MinPax must be >= 0.'
         );
      end if;

      if
         p_discountvalue is not null
         and p_discountvalue < 0
      then
         raise_application_error(
            -20904,
            'DiscountValue must be >= 0.'
         );
      end if;

      if
         p_startdate is not null
         and p_enddate is not null
         and p_enddate < p_startdate
      then
         raise_application_error(
            -20905,
            'EndDate must be >= StartDate.'
         );
      end if;

      insert into promotion (
         promotionid,
         name,
         minpax,
         discountvalue,
         startdate,
         enddate,
         status
      ) values ( p_promotionid,
                 p_name,
                 p_minpax,
                 p_discountvalue,
                 p_startdate,
                 p_enddate,
                 p_status );

   exception
      when dup_val_on_index then
         raise_application_error(
            -20906,
            'PromotionID already exists.'
         );
   end sp_promotion_ins;

   procedure sp_promotion_upd (
      p_promotionid   in promotion.promotionid%type,
      p_name          in promotion.name%type,
      p_minpax        in promotion.minpax%type,
      p_discountvalue in promotion.discountvalue%type,
      p_startdate     in promotion.startdate%type,
      p_enddate       in promotion.enddate%type,
      p_status        in promotion.status%type
   ) is
   begin
      if p_promotionid is null then
         raise_application_error(
            -20911,
            'PromotionID is required for update.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -20912,
            'Name is required.'
         );
      end if;
      if
         p_minpax is not null
         and p_minpax < 0
      then
         raise_application_error(
            -20913,
            'MinPax must be >= 0.'
         );
      end if;

      if
         p_discountvalue is not null
         and p_discountvalue < 0
      then
         raise_application_error(
            -20914,
            'DiscountValue must be >= 0.'
         );
      end if;

      if
         p_startdate is not null
         and p_enddate is not null
         and p_enddate < p_startdate
      then
         raise_application_error(
            -20915,
            'EndDate must be >= StartDate.'
         );
      end if;

      update promotion
         set name = p_name,
             minpax = p_minpax,
             discountvalue = p_discountvalue,
             startdate = p_startdate,
             enddate = p_enddate,
             status = p_status
       where promotionid = p_promotionid;

      if sql%rowcount = 0 then
         raise_application_error(
            -20916,
            'PromotionID not found.'
         );
      end if;
   end sp_promotion_upd;

end pkg_promotion;

--CustomerType
create or replace package pkg_customertype as
   procedure sp_customertype_ins (
      p_custtypeid   in customertype.custtypeid%type,
      p_name         in customertype.name%type,
      p_discountrate in customertype.discountrate%type
   );

   procedure sp_customertype_upd (
      p_custtypeid   in customertype.custtypeid%type,
      p_name         in customertype.name%type,
      p_discountrate in customertype.discountrate%type
   );

end pkg_customertype;

create or replace package body pkg_customertype as
   procedure sp_customertype_ins (
      p_custtypeid   in customertype.custtypeid%type,
      p_name         in customertype.name%type,
      p_discountrate in customertype.discountrate%type
   ) is
   begin
      if p_custtypeid is null then
         raise_application_error(
            -21001,
            'CustTypeID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -21002,
            'Name is required.'
         );
      end if;
      if p_discountrate is null then
         raise_application_error(
            -21003,
            'DiscountRate is required.'
         );
      end if;
      if p_discountrate < 0
      or p_discountrate > 100 then
         raise_application_error(
            -21004,
            'DiscountRate must be between 0 and 100.'
         );
      end if;

      insert into customertype (
         custtypeid,
         name,
         discountrate
      ) values ( p_custtypeid,
                 p_name,
                 p_discountrate );

   exception
      when dup_val_on_index then
         raise_application_error(
            -21005,
            'Duplicate CustTypeID or Name.'
         );
   end sp_customertype_ins;

   procedure sp_customertype_upd (
      p_custtypeid   in customertype.custtypeid%type,
      p_name         in customertype.name%type,
      p_discountrate in customertype.discountrate%type
   ) is
   begin
      if p_custtypeid is null then
         raise_application_error(
            -21011,
            'CustTypeID is required for update.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -21012,
            'Name is required.'
         );
      end if;
      if p_discountrate is null then
         raise_application_error(
            -21013,
            'DiscountRate is required.'
         );
      end if;
      if p_discountrate < 0
      or p_discountrate > 100 then
         raise_application_error(
            -21014,
            'DiscountRate must be between 0 and 100.'
         );
      end if;

      update customertype
         set name = p_name,
             discountrate = p_discountrate
       where custtypeid = p_custtypeid;

      if sql%rowcount = 0 then
         raise_application_error(
            -21015,
            'CustTypeID not found.'
         );
      end if;
   exception
      when dup_val_on_index then
         raise_application_error(
            -21016,
            'Name already exists (must be unique).'
         );
   end sp_customertype_upd;

end pkg_customertype;

--Customer
create or replace package pkg_customer as
   procedure sp_customer_ins (
      p_customerid  in customer.customerid%type,
      p_custtypeid  in customer.custtypeid%type,
      p_name        in customer.name%type,
      p_phone       in customer.phone%type,
      p_address     in customer.address%type,
      p_passportno  in customer.passportno%type,
      p_nationality in customer.nationality%type,
      p_dob         in customer.dob%type
   );

   procedure sp_customer_upd (
      p_customerid  in customer.customerid%type,
      p_custtypeid  in customer.custtypeid%type,
      p_name        in customer.name%type,
      p_phone       in customer.phone%type,
      p_address     in customer.address%type,
      p_passportno  in customer.passportno%type,
      p_nationality in customer.nationality%type,
      p_dob         in customer.dob%type
   );

end pkg_customer;

create or replace package body pkg_customer as
   procedure sp_customer_ins (
      p_customerid  in customer.customerid%type,
      p_custtypeid  in customer.custtypeid%type,
      p_name        in customer.name%type,
      p_phone       in customer.phone%type,
      p_address     in customer.address%type,
      p_passportno  in customer.passportno%type,
      p_nationality in customer.nationality%type,
      p_dob         in customer.dob%type
   ) is
      v_dummy number;
   begin
      if p_customerid is null then
         raise_application_error(
            -21101,
            'CustomerID is required.'
         );
      end if;
      if p_custtypeid is null then
         raise_application_error(
            -21102,
            'CustTypeID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -21103,
            'Name is required.'
         );
      end if;
      if p_phone is null then
         raise_application_error(
            -21104,
            'Phone is required.'
         );
      end if;
      if p_address is null then
         raise_application_error(
            -21105,
            'Address is required.'
         );
      end if;
      if p_passportno is null then
         raise_application_error(
            -21106,
            'PassportNo is required.'
         );
      end if;
      if p_nationality is null then
         raise_application_error(
            -21107,
            'Nationality is required.'
         );
      end if;
      if p_dob is null then
         raise_application_error(
            -21108,
            'DOB is required.'
         );
      end if;
      select 1
        into v_dummy
        from customertype
       where custtypeid = p_custtypeid;

      insert into customer (
         customerid,
         custtypeid,
         name,
         phone,
         address,
         passportno,
         nationality,
         dob
      ) values ( p_customerid,
                 p_custtypeid,
                 p_name,
                 p_phone,
                 p_address,
                 p_passportno,
                 p_nationality,
                 p_dob );

   exception
      when dup_val_on_index then
         raise_application_error(
            -21110,
            'Duplicate CustomerID or PassportNo.'
         );
      when no_data_found then
         raise_application_error(
            -21111,
            'CustTypeID not found in CustomerType.'
         );
   end sp_customer_ins;

   procedure sp_customer_upd (
      p_customerid  in customer.customerid%type,
      p_custtypeid  in customer.custtypeid%type,
      p_name        in customer.name%type,
      p_phone       in customer.phone%type,
      p_address     in customer.address%type,
      p_passportno  in customer.passportno%type,
      p_nationality in customer.nationality%type,
      p_dob         in customer.dob%type
   ) is
      v_dummy number;
   begin
      if p_customerid is null then
         raise_application_error(
            -21121,
            'CustomerID is required for update.'
         );
      end if;
      if p_custtypeid is null then
         raise_application_error(
            -21122,
            'CustTypeID is required.'
         );
      end if;
      if p_name is null then
         raise_application_error(
            -21123,
            'Name is required.'
         );
      end if;
      if p_phone is null then
         raise_application_error(
            -21124,
            'Phone is required.'
         );
      end if;
      if p_address is null then
         raise_application_error(
            -21125,
            'Address is required.'
         );
      end if;
      if p_passportno is null then
         raise_application_error(
            -21126,
            'PassportNo is required.'
         );
      end if;
      if p_nationality is null then
         raise_application_error(
            -21127,
            'Nationality is required.'
         );
      end if;
      if p_dob is null then
         raise_application_error(
            -21128,
            'DOB is required.'
         );
      end if;
      select 1
        into v_dummy
        from customertype
       where custtypeid = p_custtypeid;

      update customer
         set custtypeid = p_custtypeid,
             name = p_name,
             phone = p_phone,
             address = p_address,
             passportno = p_passportno,
             nationality = p_nationality,
             dob = p_dob
       where customerid = p_customerid;

      if sql%rowcount = 0 then
         raise_application_error(
            -21129,
            'CustomerID not found.'
         );
      end if;
   exception
      when dup_val_on_index then
         raise_application_error(
            -21130,
            'PassportNo already exists (must be unique).'
         );
      when no_data_found then
         raise_application_error(
            -21131,
            'CustTypeID not found in CustomerType.'
         );
   end sp_customer_upd;

end pkg_customer;

--CostDetail
CREATE OR REPLACE PACKAGE pkg_costdetail AS
   PROCEDURE sp_cost_add_detail (
      p_tourid     IN costdetail.tourid%TYPE,
      p_guideid    IN costdetail.guideid%TYPE, 
      p_itemcostid IN costdetail.itemcostid%TYPE,
      p_feeamount  IN costdetail.feeamount%TYPE,
      p_quantity   IN costdetail.quantity%TYPE,
      p_note       IN costdetail.note%TYPE,
      p_startdate  IN costdetail.startdate%TYPE,
      p_enddate    IN costdetail.enddate%TYPE
   );
END pkg_costdetail;


CREATE OR REPLACE PACKAGE BODY pkg_costdetail AS
   PROCEDURE sp_cost_add_detail (
      p_tourid     IN costdetail.tourid%TYPE,
      p_guideid    IN costdetail.guideid%TYPE,
      p_itemcostid IN costdetail.itemcostid%TYPE,
      p_feeamount  IN costdetail.feeamount%TYPE,
      p_quantity   IN costdetail.quantity%TYPE,
      p_note       IN costdetail.note%TYPE,
      p_startdate  IN costdetail.startdate%TYPE,
      p_enddate    IN costdetail.enddate%TYPE
   ) IS
      v_dummy NUMBER;
      v_next_seq NUMBER;
   BEGIN
      IF p_tourid IS NULL OR p_itemcostid IS NULL THEN 
         raise_application_error(-26001, 'TourID and ItemCostID are required.'); 
      END IF;

      -- Check FK (เช็ค GuideID เฉพาะตอนที่ใส่ค่ามาเท่านั้น)
      BEGIN
         SELECT 1 INTO v_dummy FROM tour WHERE tourid = p_tourid;
         SELECT 1 INTO v_dummy FROM itemcost WHERE itemcostid = p_itemcostid;
         
         IF p_guideid IS NOT NULL THEN
            SELECT 1 INTO v_dummy FROM guide WHERE guideid = p_guideid;
         END IF;
      EXCEPTION
         WHEN no_data_found THEN
            raise_application_error(-26010, 'Invalid Foreign Key Not Found.');
      END;

      -- Auto-Generate SeqNo
      SELECT NVL(MAX(seqno), 0) + 1 INTO v_next_seq FROM costdetail WHERE tourid = p_tourid;

      INSERT INTO costdetail (
         tourid, seqno, guideid, itemcostid, feeamount, quantity, note, startdate, enddate
      ) VALUES (
         p_tourid, v_next_seq, p_guideid, p_itemcostid, p_feeamount, p_quantity, p_note, p_startdate, p_enddate
      );
      COMMIT;
   END sp_cost_add_detail;
END pkg_costdetail;


--PromotionDetail
CREATE OR REPLACE PACKAGE pkg_promodetail AS
   PROCEDURE sp_promo_add_detail (
      p_promotionid     IN promotiondetail.promotionid%TYPE,
      p_tourid          IN promotiondetail.tourid%TYPE,
      p_discountpercent IN promotiondetail.discountpercent%TYPE,
      p_startdate       IN promotiondetail.startdate%TYPE,
      p_enddate         IN promotiondetail.enddate%TYPE,
      p_extracondition  IN promotiondetail.extracondition%TYPE,
      p_minbookamount   IN promotiondetail.minbookamount%TYPE DEFAULT 0
   );

   PROCEDURE sp_promo_del_detail (
      p_promotionid IN promotiondetail.promotionid%TYPE,
      p_seqno       IN promotiondetail.seqno%TYPE
   );
END pkg_promodetail;

CREATE OR REPLACE PACKAGE BODY pkg_promodetail AS
   PROCEDURE sp_promo_add_detail (
      p_promotionid     IN promotiondetail.promotionid%TYPE,
      p_tourid          IN promotiondetail.tourid%TYPE,
      p_discountpercent IN promotiondetail.discountpercent%TYPE,
      p_startdate       IN promotiondetail.startdate%TYPE,
      p_enddate         IN promotiondetail.enddate%TYPE,
      p_extracondition  IN promotiondetail.extracondition%TYPE,
      p_minbookamount   IN promotiondetail.minbookamount%TYPE DEFAULT 0
   ) IS
      v_dummy NUMBER;
      v_next_seq NUMBER;
   BEGIN
      -- Validation
      IF p_promotionid IS NULL THEN raise_application_error(-27001, 'PromotionID is required.'); END IF;
      IF p_tourid IS NULL THEN raise_application_error(-27002, 'TourID is required.'); END IF;
      IF p_discountpercent < 0 OR p_discountpercent > 100 THEN 
         raise_application_error(-27003, 'DiscountPercent must be between 0 and 100.'); 
      END IF;
      IF p_enddate < p_startdate THEN raise_application_error(-27004, 'EndDate must be >= StartDate.'); END IF;

      -- Check FK existence
      BEGIN
         SELECT 1 INTO v_dummy FROM promotion WHERE promotionid = p_promotionid;
         SELECT 1 INTO v_dummy FROM tour WHERE tourid = p_tourid;
      EXCEPTION
         WHEN no_data_found THEN
            raise_application_error(-27010, 'Invalid Foreign Key: Promotion or Tour not found.');
      END;

      -- Auto-Generate SeqNo
      SELECT NVL(MAX(seqno), 0) + 1 INTO v_next_seq 
      FROM promotiondetail 
      WHERE promotionid = p_promotionid;

      INSERT INTO promotiondetail (
         promotionid, seqno, tourid, discountpercent,
         startdate, enddate, extracondition, minbookamount
      ) VALUES (
         p_promotionid, v_next_seq, p_tourid, p_discountpercent,
         p_startdate, p_enddate, p_extracondition, p_minbookamount
      );
      COMMIT;
   END sp_promo_add_detail;

   PROCEDURE sp_promo_del_detail (
      p_promotionid IN promotiondetail.promotionid%TYPE,
      p_seqno       IN promotiondetail.seqno%TYPE
   ) IS
   BEGIN
      DELETE FROM promotiondetail
      WHERE promotionid = p_promotionid AND seqno = p_seqno;

      IF SQL%ROWCOUNT = 0 THEN
         raise_application_error(-27020, 'PromotionDetail not found.');
      END IF;
      COMMIT;
   END sp_promo_del_detail;
END pkg_promodetail;

--Add tourDetail into Tour (Main activity)
create or replace package pkg_tourdetail as
   procedure sp_tour_add_detail (
      p_tourid        in tourdetail.tourid%type,
      p_tourplanid    in tourdetail.tourplanid%type,
      p_title         in tourdetail.title%type,
      p_description   in tourdetail.description%type,
      p_meal          in tourdetail.meal%type,
      p_hotelname     in tourdetail.hotelname%type,
      p_transportnote in tourdetail.transportnote%type,
      p_dayno         in tourdetail.dayno%type default null
   );

   procedure sp_tour_del_detail (
      p_tourid in tourdetail.tourid%type,
      p_dayno  in tourdetail.dayno%type
   );
end pkg_tourdetail;

create or replace package body pkg_tourdetail as
   procedure sp_tour_add_detail (
      p_tourid        in tourdetail.tourid%type,
      p_tourplanid    in tourdetail.tourplanid%type,
      p_title         in tourdetail.title%type,
      p_description   in tourdetail.description%type,
      p_meal          in tourdetail.meal%type,
      p_hotelname     in tourdetail.hotelname%type,
      p_transportnote in tourdetail.transportnote%type,
      p_dayno         in tourdetail.dayno%type default null
   ) is
      v_dummy number;
      v_next  tourdetail.dayno%type;
   begin
      if p_tourid is null then
         raise_application_error(
            -23101,
            'TourID is required.'
         );
      end if;
      if p_tourplanid is null then
         raise_application_error(
            -23102,
            'TourPlanID is required.'
         );
      end if;
      insert into tourdetail (
         tourid,
         dayno,
         tourplanid,
         title,
         description,
         meal,
         hotelname,
         transportnote
      ) values ( p_tourid,
                 p_dayno,
                 p_tourplanid,
                 p_title,
                 p_description,
                 p_meal,
                 p_hotelname,
                 p_transportnote );
   exception
      when no_data_found then
         raise_application_error(
            -23110,
            'Invalid foreign key: TourID or TourPlanID not found.'
         );
      when dup_val_on_index then
         raise_application_error(
            -23111,
            'Duplicate (TourID, DayNo).'
         );
   end sp_tour_add_detail;

   procedure sp_tour_del_detail (
      p_tourid in tourdetail.tourid%type,
      p_dayno  in tourdetail.dayno%type
   ) is
      v_dummy number;
   begin
      if p_tourid is null then
         raise_application_error(
            -23201,
            'TourID is required for delete.'
         );
      end if;
      if p_dayno is null then
         raise_application_error(
            -23202,
            'DayNo is required for delete.'
         );
      end if;
      select 1
        into v_dummy
        from tour
       where tourid = p_tourid
      for update;

      delete from tourdetail
       where tourid = p_tourid
         and dayno = p_dayno;

      if sql%rowcount = 0 then
         raise_application_error(
            -23203,
            'TourDetail not found (TourID + DayNo).'
         );
      end if;
   exception
      when no_data_found then
         raise_application_error(
            -23204,
            'TourID not found in Tour.'
         );
   end sp_tour_del_detail;
end pkg_tourdetail;

--Add bookingDetail and Update Booking (Main activity)
create or replace package pkg_bookingdetail as
   procedure sp_booking_add_detail (
      p_bookingid    in bookingdetail.bookingid%type,
      p_tourid       in bookingdetail.tourid%type,
      p_servdatefrom in bookingdetail.servdatefrom%type,
      p_servdateto   in bookingdetail.servdateto%type,
      p_paxadult     in bookingdetail.paxadult%type,
      p_paxchild     in bookingdetail.paxchild%type,
      p_unitprice    in bookingdetail.unitprice%type,
      p_seqno        in bookingdetail.seqno%type default null
   );
end pkg_bookingdetail;

create or replace package body pkg_bookingdetail as
   procedure sp_booking_add_detail (
      p_bookingid    in bookingdetail.bookingid%type,
      p_tourid       in bookingdetail.tourid%type,
      p_servdatefrom in bookingdetail.servdatefrom%type,
      p_servdateto   in bookingdetail.servdateto%type,
      p_paxadult     in bookingdetail.paxadult%type,
      p_paxchild     in bookingdetail.paxchild%type,
      p_unitprice    in bookingdetail.unitprice%type,
      p_seqno        in bookingdetail.seqno%type default null
   ) is
      v_dummy    number;
      v_totalpax number;
      v_subtotal bookingdetail.subtotalamount%type;
   begin
      if p_bookingid is null then
         raise_application_error(
            -25001,
            'BookingID is required.'
         );
      end if;
      if p_tourid is null then
         raise_application_error(
            -25002,
            'TourID is required.'
         );
      end if;
      if p_servdatefrom is null
      or p_servdateto is null then
         raise_application_error(
            -25003,
            'ServDateFrom and ServDateTo are required.'
         );
      end if;

      if p_paxadult is null
      or p_paxchild is null then
         raise_application_error(
            -25004,
            'PaxAdult and PaxChild are required.'
         );
      end if;

      if p_unitprice is null then
         raise_application_error(
            -25005,
            'UnitPrice is required.'
         );
      end if;
      if p_servdateto < p_servdatefrom then
         raise_application_error(
            -25006,
            'ServDateTo must be >= ServDateFrom.'
         );
      end if;
      if p_paxadult < 0 then
         raise_application_error(
            -25007,
            'PaxAdult must be >= 0.'
         );
      end if;
      if p_paxchild < 0 then
         raise_application_error(
            -25008,
            'PaxChild must be >= 0.'
         );
      end if;
      if p_unitprice < 0 then
         raise_application_error(
            -25009,
            'UnitPrice must be >= 0.'
         );
      end if;
      select 1
        into v_dummy
        from booking
       where bookingid = p_bookingid
      for update;

      select 1
        into v_dummy
        from tour
       where tourid = p_tourid;

      v_totalpax := p_paxadult + p_paxchild;
      v_subtotal := v_totalpax * p_unitprice;
      insert into bookingdetail (
         bookingid,
         seqno,
         tourid,
         servdatefrom,
         servdateto,
         paxadult,
         paxchild,
         unitprice,
         subtotalamount
      ) values ( p_bookingid,
                 p_seqno,
                 p_tourid,
                 p_servdatefrom,
                 p_servdateto,
                 p_paxadult,
                 p_paxchild,
                 p_unitprice,
                 v_subtotal );

      update booking
         set totalpax = (
         select nvl(
            sum(paxadult + paxchild),
            0
         )
           from bookingdetail
          where bookingid = p_bookingid
      ),
             totalamount = (
                select nvl(
                   sum(subtotalamount),
                   0
                )
                  from bookingdetail
                 where bookingid = p_bookingid
             )
       where bookingid = p_bookingid;

   exception
      when no_data_found then
         raise_application_error(
            -25020,
            'Invalid foreign key: BookingID or TourID not found.'
         );
      when dup_val_on_index then
         raise_application_error(
            -25021,
            'Duplicate (BookingID, SeqNo).'
         );
   end sp_booking_add_detail;
end pkg_bookingdetail;


--Booking Calculate TotalAmount Procedure
create or replace procedure sp_booking_recalc_total (
   p_bookingid in booking.bookingid%type
) is
   v_dummy       number;
   v_totalpax    number;
   v_totalamount booking.totalamount%type;
begin
   if p_bookingid is null then
      raise_application_error(
         -26001,
         'BookingID is required.'
      );
   end if;
   select 1
     into v_dummy
     from booking
    where bookingid = p_bookingid
   for update;

   select nvl(
      sum(paxadult + paxchild),
      0
   ),
          nvl(
             sum(subtotalamount),
             0
          )
     into
      v_totalpax,
      v_totalamount
     from bookingdetail
    where bookingid = p_bookingid;

   update booking
      set totalpax = v_totalpax,
          totalamount = v_totalamount
    where bookingid = p_bookingid;

exception
   when no_data_found then
      raise_application_error(
         -26002,
         'BookingID not found.'
      );
end sp_booking_recalc_total;

--Function to return Promotion discount Percentage.
create or replace function fn_promo_discount (
   p_bookingid in booking.bookingid%type
) return number is
   v_promoid        booking.promotionid%type;
   v_bookingdate    booking.bookingdate%type;
   v_totalpax       booking.totalpax%type;
   v_totalamount    booking.totalamount%type;
   v_minpax         promotion.minpax%type;
   v_discountvalue  promotion.discountvalue%type;
   v_startdate      promotion.startdate%type;
   v_enddate        promotion.enddate%type;
   v_status         promotion.status%type;
   v_discountamount number(
      12,
      2
   );
begin
   if p_bookingid is null then
      raise_application_error(
         -28001,
         'BookingID is required.'
      );
   end if;
   select promotionid,
          bookingdate,
          totalpax,
          totalamount
     into
      v_promoid,
      v_bookingdate,
      v_totalpax,
      v_totalamount
     from booking
    where bookingid = p_bookingid;

   if v_promoid is null then
      return 0;
   end if;
   select minpax,
          discountvalue,
          startdate,
          enddate,
          status
     into
      v_minpax,
      v_discountvalue,
      v_startdate,
      v_enddate,
      v_status
     from promotion
    where promotionid = v_promoid;

   if
      v_status is not null
      and upper(v_status) not in ( 'ACTIVE',
                                   'A' )
   then
      return 0;
   end if;

   if
      v_minpax is not null
      and v_totalpax < v_minpax
   then
      return 0;
   end if;
   if
      v_startdate is not null
      and v_bookingdate < v_startdate
   then
      return 0;
   end if;
   if
      v_enddate is not null
      and v_bookingdate > v_enddate
   then
      return 0;
   end if;
   if v_discountvalue is null
   or v_discountvalue <= 0 then
      return 0;
   end if;
   v_discountamount := round(
      v_totalamount *(v_discountvalue / 100),
      2
   );
   if v_discountamount < 0 then
      v_discountamount := 0;
   end if;
   return v_discountamount;
exception
   when no_data_found then
      raise_application_error(
         -28002,
         'Booking or Promotion not found for discount calculation.'
      );
end fn_promo_discount;

--Apply promotion to Booking
create or replace procedure sp_apply_booking_promo (
   p_bookingid   in booking.bookingid%type,
   p_promotionid in promotion.promotionid%type
) is
   v_bookingdate   booking.bookingdate%type;
   v_totalpax      booking.totalpax%type;
   v_totalamount   booking.totalamount%type;
   v_paymentstatus booking.paymentstatus%type;
   v_bookingstatus booking.bookingstatus%type;
   v_minpax        promotion.minpax%type;
   v_discountvalue promotion.discountvalue%type;
   v_startdate     promotion.startdate%type;
   v_enddate       promotion.enddate%type;
   v_status        promotion.status%type;
   v_discountamt   number(
      12,
      2
   );
   v_netamt        number(
      12,
      2
   );
begin
   if p_bookingid is null then
      raise_application_error(
         -29001,
         'BookingID is required.'
      );
   end if;
   if p_promotionid is null then
      raise_application_error(
         -29002,
         'PromotionID is required.'
      );
   end if;
   select bookingdate,
          totalpax,
          totalamount,
          paymentstatus,
          bookingstatus
     into
      v_bookingdate,
      v_totalpax,
      v_totalamount,
      v_paymentstatus,
      v_bookingstatus
     from booking
    where bookingid = p_bookingid
   for update;

   if v_bookingstatus in ( 'CANCELLED',
                           'COMPLETED' ) then
      raise_application_error(
         -29003,
         'Cannot apply promotion: booking is CANCELLED or COMPLETED.'
      );
   end if;

   if v_paymentstatus in ( 'PAID',
                           'REFUNDED' ) then
      raise_application_error(
         -29004,
         'Cannot apply promotion: payment already processed.'
      );
   end if;

   select minpax,
          discountvalue,
          startdate,
          enddate,
          status
     into
      v_minpax,
      v_discountvalue,
      v_startdate,
      v_enddate,
      v_status
     from promotion
    where promotionid = p_promotionid;

   if
      v_status is not null
      and upper(v_status) not in ( 'ACTIVE',
                                   'A' )
   then
      raise_application_error(
         -29005,
         'Promotion is not active.'
      );
   end if;

   if
      v_minpax is not null
      and v_totalpax < v_minpax
   then
      raise_application_error(
         -29006,
         'Promotion not eligible: TotalPax is less than MinPax.'
      );
   end if;

   if
      v_startdate is not null
      and v_bookingdate < v_startdate
   then
      raise_application_error(
         -29007,
         'Promotion not eligible: BookingDate before promotion StartDate.'
      );
   end if;

   if
      v_enddate is not null
      and v_bookingdate > v_enddate
   then
      raise_application_error(
         -29008,
         'Promotion not eligible: BookingDate after promotion EndDate.'
      );
   end if;

   v_discountamt := round(
      (v_totalamount *(v_discountvalue / 100)),
      2
   );
   v_netamt := round(
      (v_totalamount - v_discountamt),
      2
   );
   if v_netamt < 0 then
      v_netamt := 0;
   end if;
   update booking
      set promotionid = p_promotionid,
          totalamount = v_netamt
    where bookingid = p_bookingid;
    COMMIT;

exception
   when no_data_found then
      raise_application_error(
         -29020,
         'BookingID or PromotionID not found.'
      );
end sp_apply_booking_promo;