/* ============================================================
   Insert_BookingDetail.sql
   กฎหลัก:
     1. 1 Booking = 1 Tour ที่สมเหตุสมผล (ไม่ mix หลาย tour ใน booking เดียว)
     2. UnitPrice ตรงกับ BasePrice ของ TourType:
          T0001 JP Sakura   TTINT01 → 29,900 THB/คน
          T0002 JP Autumn   TTINT01 → 31,500 THB/คน (peak +5%)
          T0003 CNX 3D      TTDOM01 →  5,900 THB/คน
          T0004 SG 4D       TTFNE01 → 19,900 THB/คน
          T0005 KR 5D       TTINT01 → 27,900 THB/คน
          T0006 Incentive   TTINC01 → 15,000 THB/คน
     3. ServDateFrom/To ต้องตรงกับ Tour.StartDate/EndDate
     4. TotalPax และ TotalAmount ใน Booking จะถูก recalc อัตโนมัติ
        โดย procedure sp_booking_add_detail
   Booking reference (จาก SQL_DML.sql ใหม่):
     BK0001 CUS00001 John Anderson      CONFIRMED PAID    CARD     PRM0001 → T0001
     BK0002 CUS00002 Emma Charlotte     COMPLETED PAID    TRANSFER PRM0004 → T0003
     BK0003 CUS00003 Liam O'Connor      PENDING   UNPAID  E-WALLET PRM0003 → T0004
     BK0004 CUS00004 Akira Tanaka       CONFIRMED PARTIAL TRANSFER PRM0002 → T0001
     BK0005 CUS00005 Sofia Rodriguez    CANCELLED REFUNDED CARD    PRM0004 → T0005
     BK0006 CUS00001 John Anderson      CONFIRMED PAID    CARD     PRM0001 → T0002
     BK0007 CUS00007 Priya Sharma (VIP) CONFIRMED PAID    CARD     PRM0006 → T0005
     BK0008 CUS00006 Chen Wei (Agent)   CONFIRMED PARTIAL TRANSFER PRM0005 → T0004
   ============================================================ */
BEGIN
  /* ------------------------------------------------------------------
     BK0001 : John Anderson (Individual) — CONFIRMED / PAID / CARD
     ทัวร์ JP Sakura T0001 | 25-30 Mar 2026
     ใช้ PRM0001 Early Bird (จอง 10 ม.ค. 2026 → ออก 25 มี.ค. = 74 วัน ✓ >= 60)
     กลุ่มครอบครัว: 2 ผู้ใหญ่ + 1 เด็ก
     SubTotal = 3 × 29,900 = 89,700
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 2,
    p_paxchild     => 1,
    p_unitprice    => 29900,
    p_seqno        => NULL
  );
  /* TotalPax=3, TotalAmount=89,700 (recalc by procedure) */

  /* ------------------------------------------------------------------
     BK0002 : Emma Charlotte (Family) — COMPLETED / PAID / TRANSFER
     ทัวร์ CNX T0003 | 20-22 Feb 2026 (tour CLOSED แล้ว = ไปจบแล้ว)
     ใช้ PRM0004 Repeat Cust
     กลุ่มครอบครัว: 2 ผู้ใหญ่
     SubTotal = 2 × 5,900 = 11,800
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );
  /* TotalPax=2, TotalAmount=11,800 */

  /* ------------------------------------------------------------------
     BK0003 : Liam O'Connor (Individual) — PENDING / UNPAID / E-WALLET
     ทัวร์ SG T0004 | 1-4 May 2026
     ใช้ PRM0003 Flash Sale — รอยืนยันชำระเงิน
     1 ผู้ใหญ่ เดินทางคนเดียว
     SubTotal = 1 × 19,900 = 19,900
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 19900,
    p_seqno        => NULL
  );
  /* TotalPax=1, TotalAmount=19,900 */

  /* ------------------------------------------------------------------
     BK0004 : Akira Tanaka (Corporate) — CONFIRMED / PARTIAL / TRANSFER
     ทัวร์ JP Sakura T0001 | 25-30 Mar 2026
     ใช้ PRM0002 Group 10+ (จองในนามบริษัท 6 คน ต่อรองพิเศษ)
     4 ผู้ใหญ่ + 2 เด็ก
     SubTotal = 6 × 29,900 = 179,400 (ชำระบางส่วนไว้ก่อน)
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 4,
    p_paxchild     => 2,
    p_unitprice    => 29900,
    p_seqno        => NULL
  );
  /* TotalPax=6, TotalAmount=179,400 */

  /* ------------------------------------------------------------------
     BK0005 : Sofia Rodriguez (Corporate) — CANCELLED / REFUNDED / CARD
     ทัวร์ KR T0005 | 10-14 Jun 2026
     ใช้ PRM0004 Repeat Cust — จองแล้วยกเลิก (เหตุฉุกเฉิน)
     1 ผู้ใหญ่
     SubTotal = 1 × 27,900 = 27,900 (คืนเงินแล้ว)
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 27900,
    p_seqno        => NULL
  );
  /* TotalPax=1, TotalAmount=27,900 */

  /* ------------------------------------------------------------------
     BK0006 : John Anderson (Individual, กลับมาจองครั้งที่ 2)
     — CONFIRMED / PAID / CARD
     ทัวร์ JP Autumn T0002 | 10-15 Apr 2026
     ใช้ PRM0001 Early Bird (จอง 5 ก.พ. → ออก 10 เม.ย. = 64 วัน ✓)
     2 ผู้ใหญ่ (ไปกับเพื่อน)
     SubTotal = 2 × 31,500 = 63,000
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 31500,
    p_seqno        => NULL
  );
  /* TotalPax=2, TotalAmount=63,000 */

  /* ------------------------------------------------------------------
     BK0007 : Priya Sharma (VIP) — CONFIRMED / PAID / CARD
     ทัวร์ KR T0005 | 10-14 Jun 2026
     ใช้ PRM0006 Credit Card Bank X
     2 ผู้ใหญ่ (คู่สามีภรรยา)
     SubTotal = 2 × 27,900 = 55,800
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0007',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 27900,
    p_seqno        => NULL
  );
  /* TotalPax=2, TotalAmount=55,800 */

  /* ------------------------------------------------------------------
     BK0008 : Chen Wei (Travel Agent) — CONFIRMED / PARTIAL / TRANSFER
     ทัวร์ SG T0004 | 1-4 May 2026
     ใช้ PRM0005 Low Season Special (SG May อยู่ในช่วง Low Season)
     4 ผู้ใหญ่ + 1 เด็ก (จองแทนลูกค้าของ Travel Agent)
     SubTotal = 5 × 19,900 = 99,500
  ------------------------------------------------------------------ */
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0008',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 4,
    p_paxchild     => 1,
    p_unitprice    => 19900,
    p_seqno        => NULL
  );

   /* ==== T0001 JP Sakura (29,900/คน) ==== */
  pkg_bookingdetail.sp_booking_add_detail('BK0009','T0001',DATE '2026-03-25',DATE '2026-03-30',2,0,29900,NULL);  -- 59,800
  pkg_bookingdetail.sp_booking_add_detail('BK0010','T0001',DATE '2026-03-25',DATE '2026-03-30',1,0,29900,NULL);  -- 29,900
  pkg_bookingdetail.sp_booking_add_detail('BK0011','T0001',DATE '2026-03-25',DATE '2026-03-30',2,2,29900,NULL);  -- 119,600
  pkg_bookingdetail.sp_booking_add_detail('BK0012','T0001',DATE '2026-03-25',DATE '2026-03-30',2,0,29900,NULL);  -- 59,800
  pkg_bookingdetail.sp_booking_add_detail('BK0013','T0001',DATE '2026-03-25',DATE '2026-03-30',3,0,29900,NULL);  -- 89,700
  pkg_bookingdetail.sp_booking_add_detail('BK0014','T0001',DATE '2026-03-25',DATE '2026-03-30',1,0,29900,NULL);  -- 29,900 (CANCELLED)
  pkg_bookingdetail.sp_booking_add_detail('BK0015','T0001',DATE '2026-03-25',DATE '2026-03-30',2,0,29900,NULL);  -- 59,800
  /* T0001 รวม (ไม่นับ cancel): BK0001(3)+BK0004(6)+BK0009(2)+BK0010(1)+BK0011(4)+BK0012(2)+BK0013(3)+BK0015(2) = 23 pax */
 
  /* ==== T0002 JP Autumn (31,500/คน) ==== */
  pkg_bookingdetail.sp_booking_add_detail('BK0016','T0002',DATE '2026-04-10',DATE '2026-04-15',2,0,31500,NULL);  -- 63,000
  pkg_bookingdetail.sp_booking_add_detail('BK0017','T0002',DATE '2026-04-10',DATE '2026-04-15',2,1,31500,NULL);  -- 94,500
  pkg_bookingdetail.sp_booking_add_detail('BK0018','T0002',DATE '2026-04-10',DATE '2026-04-15',2,0,31500,NULL);  -- 63,000
  pkg_bookingdetail.sp_booking_add_detail('BK0019','T0002',DATE '2026-04-10',DATE '2026-04-15',4,0,31500,NULL);  -- 126,000
  pkg_bookingdetail.sp_booking_add_detail('BK0020','T0002',DATE '2026-04-10',DATE '2026-04-15',3,0,31500,NULL);  -- 94,500
  pkg_bookingdetail.sp_booking_add_detail('BK0021','T0002',DATE '2026-04-10',DATE '2026-04-15',2,0,31500,NULL);  -- 63,000 (CANCELLED)
  pkg_bookingdetail.sp_booking_add_detail('BK0022','T0002',DATE '2026-04-10',DATE '2026-04-15',2,0,31500,NULL);  -- 63,000
  /* T0002 รวม (ไม่นับ cancel): BK0006(2)+BK0016(2)+BK0017(3)+BK0018(2)+BK0019(4)+BK0020(3)+BK0022(2) = 18 pax */
 
  /* ==== T0003 CNX (5,900/คน) CLOSED ==== */
  pkg_bookingdetail.sp_booking_add_detail('BK0023','T0003',DATE '2026-02-20',DATE '2026-02-22',2,0,5900,NULL);   -- 11,800
  pkg_bookingdetail.sp_booking_add_detail('BK0024','T0003',DATE '2026-02-20',DATE '2026-02-22',1,0,5900,NULL);   -- 5,900
  pkg_bookingdetail.sp_booking_add_detail('BK0025','T0003',DATE '2026-02-20',DATE '2026-02-22',2,2,5900,NULL);   -- 23,600
  pkg_bookingdetail.sp_booking_add_detail('BK0026','T0003',DATE '2026-02-20',DATE '2026-02-22',3,0,5900,NULL);   -- 17,700
  pkg_bookingdetail.sp_booking_add_detail('BK0027','T0003',DATE '2026-02-20',DATE '2026-02-22',2,0,5900,NULL);   -- 11,800
  /* T0003 รวม: BK0002(2)+BK0023(2)+BK0024(1)+BK0025(4)+BK0026(3)+BK0027(2) = 14 pax */
 
  /* ==== T0004 SG (19,900/คน) ==== */
  pkg_bookingdetail.sp_booking_add_detail('BK0028','T0004',DATE '2026-05-01',DATE '2026-05-04',2,1,19900,NULL);  -- 59,700
  pkg_bookingdetail.sp_booking_add_detail('BK0029','T0004',DATE '2026-05-01',DATE '2026-05-04',1,0,19900,NULL);  -- 19,900
  pkg_bookingdetail.sp_booking_add_detail('BK0030','T0004',DATE '2026-05-01',DATE '2026-05-04',2,0,19900,NULL);  -- 39,800
  pkg_bookingdetail.sp_booking_add_detail('BK0031','T0004',DATE '2026-05-01',DATE '2026-05-04',2,0,19900,NULL);  -- 39,800 (CANCELLED)
  /* T0004 รวม (ไม่นับ cancel): BK0003(1)+BK0008(5)+BK0028(3)+BK0029(1)+BK0030(2) = 12 pax */
 
  /* ==== T0005 KR (27,900/คน) ==== */
  pkg_bookingdetail.sp_booking_add_detail('BK0032','T0005',DATE '2026-06-10',DATE '2026-06-14',2,1,27900,NULL);  -- 83,700
  pkg_bookingdetail.sp_booking_add_detail('BK0033','T0005',DATE '2026-06-10',DATE '2026-06-14',3,0,27900,NULL);  -- 83,700
  pkg_bookingdetail.sp_booking_add_detail('BK0034','T0005',DATE '2026-06-10',DATE '2026-06-14',2,0,27900,NULL);  -- 55,800
  pkg_bookingdetail.sp_booking_add_detail('BK0035','T0005',DATE '2026-06-10',DATE '2026-06-14',4,0,27900,NULL);  -- 111,600
  pkg_bookingdetail.sp_booking_add_detail('BK0036','T0005',DATE '2026-06-10',DATE '2026-06-14',2,0,27900,NULL);  -- 55,800
  pkg_bookingdetail.sp_booking_add_detail('BK0037','T0005',DATE '2026-06-10',DATE '2026-06-14',1,0,27900,NULL);  -- 27,900 (CANCELLED)
  pkg_bookingdetail.sp_booking_add_detail('BK0038','T0005',DATE '2026-06-10',DATE '2026-06-14',4,0,27900,NULL);  -- 111,600
  /* T0005 รวม (ไม่นับ cancel): BK0007(2)+BK0032(3)+BK0033(3)+BK0034(2)+BK0035(4)+BK0036(2)+BK0038(4) = 20 pax */
 
  /* ==== T0006 Incentive BKK (15,000/คน) ==== */
  pkg_bookingdetail.sp_booking_add_detail('BK0039','T0006',DATE '2026-07-05',DATE '2026-07-07',5,0,15000,NULL);  -- 75,000
  pkg_bookingdetail.sp_booking_add_detail('BK0040','T0006',DATE '2026-07-05',DATE '2026-07-07',10,0,15000,NULL); -- 150,000
  pkg_bookingdetail.sp_booking_add_detail('BK0041','T0006',DATE '2026-07-05',DATE '2026-07-07',3,0,15000,NULL);  -- 45,000
  pkg_bookingdetail.sp_booking_add_detail('BK0042','T0006',DATE '2026-07-05',DATE '2026-07-07',2,0,15000,NULL);  -- 30,000
  /* T0006 รวม: 20 pax */

   -- T0001 JP Sakura (+14 pax)
  pkg_bookingdetail.sp_booking_add_detail('BK0043','T0001',DATE '2026-03-25',DATE '2026-03-30',2,1,29900,NULL); -- 3 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0044','T0001',DATE '2026-03-25',DATE '2026-03-30',2,0,29900,NULL); -- 2 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0045','T0001',DATE '2026-03-25',DATE '2026-03-30',3,1,29900,NULL); -- 4 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0046','T0001',DATE '2026-03-25',DATE '2026-03-30',2,1,29900,NULL); -- 3 pax
  -- T0001 รวม: 14(เดิม)+3+2+4+3 = 26 pax ✓ (เกิน BE 27 นิดหน่อย)
 
  -- T0002 JP Autumn (+5 pax)
  pkg_bookingdetail.sp_booking_add_detail('BK0047','T0002',DATE '2026-04-10',DATE '2026-04-15',2,0,31500,NULL); -- 2 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0048','T0002',DATE '2026-04-10',DATE '2026-04-15',2,1,31500,NULL); -- 3 pax
  -- T0002 รวม: 20(เดิม)+2+3 = 25 pax ✓ (เกิน BE 23)
 
  -- T0003 CNX (+5 pax) COMPLETED
  pkg_bookingdetail.sp_booking_add_detail('BK0049','T0003',DATE '2026-02-20',DATE '2026-02-22',3,0,5900,NULL);  -- 3 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0050','T0003',DATE '2026-02-20',DATE '2026-02-22',2,0,5900,NULL);  -- 2 pax
  -- T0003 รวม: 14(เดิม)+3+2 = 19 pax ✓ (เกิน BE 17)
 
  -- T0004 SG (+5 pax)
  pkg_bookingdetail.sp_booking_add_detail('BK0051','T0004',DATE '2026-05-01',DATE '2026-05-04',3,0,19900,NULL); -- 3 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0052','T0004',DATE '2026-05-01',DATE '2026-05-04',2,0,19900,NULL); -- 2 pax
  -- T0004 รวม: 12(เดิม)+3+2 = 17 pax ✓ (เกิน BE 15)
 
  -- T0006 Incentive (+20 pax)
  pkg_bookingdetail.sp_booking_add_detail('BK0053','T0006',DATE '2026-07-05',DATE '2026-07-07',8,0,15000,NULL);  -- 8 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0054','T0006',DATE '2026-07-05',DATE '2026-07-07',7,0,15000,NULL);  -- 7 pax
  pkg_bookingdetail.sp_booking_add_detail('BK0055','T0006',DATE '2026-07-05',DATE '2026-07-07',5,0,15000,NULL);  -- 5 pax
  -- T0006 รวม: 20(เดิม)+8+7+5 = 40 pax ✓ เต็ม capacity (เกิน BE 38)

END;

COMMIT;
