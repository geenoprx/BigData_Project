/* ============================================================
   Insert_PromotionDetail.sql
   โปรโมชันรายทัวร์ — % ส่วนลดและเงื่อนไขสอดคล้องกับ Promotion header
   PromotionDetail.DiscountPercent คือส่วนลดจริง (% ต่อทัวร์นั้นๆ)
   MinBookAmount ต้องมากกว่าหรือเท่ากับ UnitPrice × MinPax
   ============================================================ */
BEGIN
  /* ============================================================
     PRM0001 : Early Bird 60 Days  (MinPax=2, Status=ACTIVE)
     ผูกกับ JP Sakura, JP Autumn, SG, KR — ทัวร์ที่ราคาสูงและซื้อล่วงหน้า
     ไม่ผูก CNX (ราคาต่ำ Early Bird ไม่ค่อย make sense) และ Incentive (B2B)
  ============================================================ */
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0001', p_tourid=>'T0001',
    p_discountpercent=>10,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-03-24',
    p_extracondition=>'จองก่อนวันออกเดินทาง >= 60 วัน | ชำระมัดจำ 50% ภายใน 3 วัน | สำหรับผู้ใหญ่เท่านั้น',
    p_minbookamount=>59800   -- 2 pax × 29,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0001', p_tourid=>'T0002',
    p_discountpercent=>10,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-04-09',
    p_extracondition=>'จองก่อนวันออกเดินทาง >= 60 วัน | ชำระมัดจำ 50% ภายใน 3 วัน',
    p_minbookamount=>63000   -- 2 pax × 31,500 (Autumn peak rate)
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0001', p_tourid=>'T0004',
    p_discountpercent=>8,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-04-30',
    p_extracondition=>'จองก่อนวันออกเดินทาง >= 60 วัน (SG Free & Easy)',
    p_minbookamount=>39800   -- 2 pax × 19,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0001', p_tourid=>'T0005',
    p_discountpercent=>8,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-06-09',
    p_extracondition=>'จองก่อนวันออกเดินทาง >= 60 วัน (KR Seoul-Jeju)',
    p_minbookamount=>55800   -- 2 pax × 27,900
  );

  /* ============================================================
     PRM0002 : Group 10+ Discount  (MinPax=10, Status=ACTIVE)
     ผูกทุก Tour เพราะกลุ่มใหญ่ได้ส่วนลดทุก destination
  ============================================================ */
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0002', p_tourid=>'T0001',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'กลุ่ม >= 10 คน เดินทางพร้อมกัน | ผู้นำกลุ่มได้ Free 1 ที่',
    p_minbookamount=>299000  -- 10 pax × 29,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0002', p_tourid=>'T0002',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'กลุ่ม >= 10 คน (JP Autumn) | Free 1 ที่สำหรับผู้นำกลุ่ม',
    p_minbookamount=>315000  -- 10 pax × 31,500
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0002', p_tourid=>'T0003',
    p_discountpercent=>3,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'กลุ่ม >= 10 คน (CNX) | ลด 3% ทุกที่นั่ง',
    p_minbookamount=>59000   -- 10 pax × 5,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0002', p_tourid=>'T0004',
    p_discountpercent=>4,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'กลุ่ม >= 10 คน (SG) | ลด 4%',
    p_minbookamount=>199000  -- 10 pax × 19,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0002', p_tourid=>'T0005',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'กลุ่ม >= 10 คน (KR) | ลด 5%',
    p_minbookamount=>279000  -- 10 pax × 27,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0002', p_tourid=>'T0006',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'กลุ่ม >= 10 คน (Incentive BKK) | ลด 5% ต่อหัว',
    p_minbookamount=>150000  -- 10 pax × 15,000
  );

  /* ============================================================
     PRM0003 : New Year Flash Sale  (MinPax=1, DiscountValue=15, Status=ACTIVE)
     ผูกทุก Tour — จองช่วงปลายปีเพื่อเดินทางปี 2026
  ============================================================ */
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0003', p_tourid=>'T0001',
    p_discountpercent=>15,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'Flash Sale — จำนวนจำกัด 5 ที่นั่ง | ไม่สามารถใช้ร่วมกับโปรอื่น',
    p_minbookamount=>29900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0003', p_tourid=>'T0002',
    p_discountpercent=>15,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'Flash Sale — จำนวนจำกัด 5 ที่ (JP Autumn)',
    p_minbookamount=>31500
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0003', p_tourid=>'T0003',
    p_discountpercent=>10,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'Flash Sale CNX — จำนวนจำกัด 5 ที่',
    p_minbookamount=>5900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0003', p_tourid=>'T0004',
    p_discountpercent=>12,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'Flash Sale SG — จำนวนจำกัด 5 ที่',
    p_minbookamount=>19900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0003', p_tourid=>'T0005',
    p_discountpercent=>15,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'Flash Sale KR — จำนวนจำกัด 5 ที่',
    p_minbookamount=>27900
  );

  /* ============================================================
     PRM0004 : Repeat Customer Voucher  (MinPax=1, DiscountValue=5)
     ผูกทุก Tour — ลูกค้าเก่าที่เคยเดินทางมาแล้ว >= 1 ครั้ง
  ============================================================ */
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0004', p_tourid=>'T0001',
    p_discountpercent=>5,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'ลูกค้าเก่าที่เคยเดินทางกับบริษัทมาแล้ว >= 1 ครั้ง | ไม่รวมกับโปรอื่น',
    p_minbookamount=>29900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0004', p_tourid=>'T0002',
    p_discountpercent=>5,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'ลูกค้าเก่า (JP Autumn) | ไม่รวมกับโปรอื่น',
    p_minbookamount=>31500
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0004', p_tourid=>'T0003',
    p_discountpercent=>3,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'ลูกค้าเก่า (CNX) ลด 3%',
    p_minbookamount=>5900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0004', p_tourid=>'T0004',
    p_discountpercent=>4,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'ลูกค้าเก่า (SG) ลด 4%',
    p_minbookamount=>19900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0004', p_tourid=>'T0005',
    p_discountpercent=>5,
    p_startdate=>DATE '2024-01-01', p_enddate=>DATE '2026-12-31',
    p_extracondition=>'ลูกค้าเก่า (KR) ลด 5%',
    p_minbookamount=>27900
  );

  /* ============================================================
     PRM0005 : Low Season Special  (MinPax=2, DiscountValue=10)
     ผูกกับ Tour ที่มี Low Season จริงๆ (SG, KR, CNX ช่วง May-Sep)
     ไม่ผูก JP Sakura/Autumn (ช่วงนั้นเป็น High Season ญี่ปุ่น)
  ============================================================ */
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0005', p_tourid=>'T0004',
    p_discountpercent=>10,
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-09-30',
    p_extracondition=>'Low Season SG (พ.ค.-ก.ย.) ลด 10% | วันออกเดินทางต้องอยู่ในช่วงโปรโมชัน',
    p_minbookamount=>39800   -- 2 pax × 19,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0005', p_tourid=>'T0005',
    p_discountpercent=>12,
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-09-30',
    p_extracondition=>'Low Season KR (พ.ค.-ก.ย.) ลด 12% | วันออกเดินทางต้องอยู่ในช่วงโปรโมชัน',
    p_minbookamount=>55800   -- 2 pax × 27,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0005', p_tourid=>'T0003',
    p_discountpercent=>8,
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-09-30',
    p_extracondition=>'Low Season CNX (ฤดูฝน) ลด 8%',
    p_minbookamount=>11800   -- 2 pax × 5,900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0005', p_tourid=>'T0006',
    p_discountpercent=>8,
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-09-30',
    p_extracondition=>'Low Season Incentive BKK ลด 8% | เฉพาะการจองใหม่เท่านั้น',
    p_minbookamount=>30000   -- 2 pax × 15,000
  );

  /* ============================================================
     PRM0006 : Credit Card Bank X  (MinPax=1, DiscountValue=5)
     ผูกทุก Tour — ต้องชำระด้วยบัตรเครดิต Bank X เท่านั้น
  ============================================================ */
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0006', p_tourid=>'T0001',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-03-01', p_enddate=>DATE '2026-08-31',
    p_extracondition=>'ชำระเต็มจำนวนด้วยบัตรเครดิต Bank X เท่านั้น | รับ Cashback 5% ใน Statement ถัดไป',
    p_minbookamount=>29900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0006', p_tourid=>'T0002',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-03-01', p_enddate=>DATE '2026-08-31',
    p_extracondition=>'ชำระด้วยบัตร Bank X (JP Autumn) | Cashback 5%',
    p_minbookamount=>31500
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0006', p_tourid=>'T0003',
    p_discountpercent=>3,
    p_startdate=>DATE '2026-03-01', p_enddate=>DATE '2026-08-31',
    p_extracondition=>'ชำระด้วยบัตร Bank X (CNX) | Cashback 3%',
    p_minbookamount=>5900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0006', p_tourid=>'T0004',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-03-01', p_enddate=>DATE '2026-08-31',
    p_extracondition=>'ชำระด้วยบัตร Bank X (SG) | Cashback 5%',
    p_minbookamount=>19900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0006', p_tourid=>'T0005',
    p_discountpercent=>5,
    p_startdate=>DATE '2026-03-01', p_enddate=>DATE '2026-08-31',
    p_extracondition=>'ชำระด้วยบัตร Bank X (KR) | Cashback 5%',
    p_minbookamount=>27900
  );
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid=>'PRM0006', p_tourid=>'T0006',
    p_discountpercent=>4,
    p_startdate=>DATE '2026-03-01', p_enddate=>DATE '2026-08-31',
    p_extracondition=>'ชำระด้วยบัตร Bank X (Incentive BKK) | Cashback 4% | เฉพาะการจอง B2C',
    p_minbookamount=>15000
  );
END;

COMMIT;
