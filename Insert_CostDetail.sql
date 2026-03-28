/* ============================================================
   Insert_CostDetail.sql  (Final Clean Version)
   
   pax จริงต่อ tour (ไม่นับ CANCELLED):
     T0001 JP Sakura   26 pax  (capacity 30)
     T0002 JP Autumn   25 pax  (capacity 30)
     T0003 CNX         19 pax  (capacity 25, CLOSED)
     T0004 SG          17 pax  (capacity 20)
     T0005 KR          20 pax  (capacity 32)
     T0006 Incentive   40 pax  (capacity 40)

   ประเภท Cost:
     Fixed    → Hotel, Coach, Guide, Ground Op  (Quantity ไม่ขึ้นกับ pax)
     Variable → Meal, Attraction Ticket         (Quantity = จำนวนมื้อ/ครั้ง × pax จริง)

   ItemCost:
     IC0001 Hotel JP (6,500/ห้อง-คืน)    IC0002 Coach JP (28,000/วัน)
     IC0003 Meal JP (950/ที่)              IC0004 Attraction JP (ราคาต่างกัน)
     IC0005 Guide JP (15,000/วัน)          IC0006 Ground Op JP (18,000/กรุ๊ป)
     IC0007 Hotel CNX (2,800/ห้อง-คืน)   IC0008 Van CNX (3,500/คัน-วัน)
     IC0009 Meal CNX (400/ที่)             IC0010 Doi Entrance (300/คน)
     IC0011 Guide CNX (3,500/วัน)          IC0012 Hotel BKK 5* (9,500/ห้อง-คืน)
     IC0013 VIP Coach BKK (35,000/วัน)    IC0014 Gala Dinner BKK (1,800/ที่)
     IC0015 Wat Entrance BKK (500/คน)     IC0016 Hotel SG (7,200/ห้อง-คืน)
     IC0017 Coach SG (22,000/วัน)          IC0018 Meal SG (750/ที่)
     IC0019 USS Ticket (3,200/คน)          IC0020 Guide SG (4,000/วัน)
     IC0021 Ground Op SG (18,000/กรุ๊ป)   IC0022 Hotel KR (5,500/ห้อง-คืน)
     IC0023 Coach KR (26,000/วัน)          IC0024 Meal KR (900/ที่)
     IC0025 Seongsan Entrance (800/คน)    IC0026 Guide KR (5,000/วัน)
   ============================================================ */

BEGIN
  /* ================================================================
     T0001 : JP Tokyo-Osaka Sakura 6D5N  |  26 pax จริง
     ----------------------------------------------------------------
     FIXED COST:
       Hotel  : 9ห้อง × 5คืน = 45  (26pax / 3คน/ห้อง ≈ 9ห้อง)
       Coach  : 6วัน
       Guide  : 6วัน
       Ground : 1กรุ๊ป
     VARIABLE COST:
       Meal   : 9มื้อ × 26pax = 234ที่
       Fuji Pass: 26ใบ
     ----------------------------------------------------------------
     Cost รวม:
       Hotel   45×6,500   = 292,500
       Coach   6×28,000   = 168,000
       Meal    234×950    = 222,300
       Fuji    26×3,200   =  83,200
       Guide   6×15,000   =  90,000
       Ground  1×18,000   =  18,000
       รวม               = 874,000
     Revenue: 26×29,900  = 777,400
     Profit : -96,600  (Break Even ที่ 30pax → Rev 897,000 → +23,000)
  ================================================================ */
  -- FIXED
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0001', p_guideid=>NULL, p_itemcostid=>'IC0001',
    p_feeamount=>6500, p_quantity=>45,
    p_note=>'Hotel 5คืน 9ห้อง (26pax/3คน) Narita+Tokyo+Osaka',
    p_startdate=>DATE '2026-03-25', p_enddate=>DATE '2026-03-30'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0001', p_guideid=>NULL, p_itemcostid=>'IC0002',
    p_feeamount=>28000, p_quantity=>6,
    p_note=>'รถโค้ช 40ที่นั่ง เหมา 6วัน',
    p_startdate=>DATE '2026-03-25', p_enddate=>DATE '2026-03-30'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0001', p_guideid=>'G0001', p_itemcostid=>'IC0005',
    p_feeamount=>15000, p_quantity=>6,
    p_note=>'ค่าไกด์ Tanaka Hiroshi 6วัน',
    p_startdate=>DATE '2026-03-25', p_enddate=>DATE '2026-03-30'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0001', p_guideid=>NULL, p_itemcostid=>'IC0006',
    p_feeamount=>18000, p_quantity=>1,
    p_note=>'Japan Ground Operator fee (per group)',
    p_startdate=>DATE '2026-03-25', p_enddate=>DATE '2026-03-30'
  );
  -- VARIABLE
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0001', p_guideid=>'G0001', p_itemcostid=>'IC0003',
    p_feeamount=>950, p_quantity=>234,
    p_note=>'อาหาร 9มื้อ × 26pax (D,B,L,D,B,L,B,B,D,B)',
    p_startdate=>DATE '2026-03-25', p_enddate=>DATE '2026-03-30'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0001', p_guideid=>NULL, p_itemcostid=>'IC0004',
    p_feeamount=>3200, p_quantity=>26,
    p_note=>'Fuji-Hakone 1-Day Pass × 26pax (Day3)',
    p_startdate=>DATE '2026-03-27', p_enddate=>DATE '2026-03-27'
  );

  /* ================================================================
     T0002 : JP Tokyo-Osaka Autumn 6D5N  |  25 pax จริง
     ----------------------------------------------------------------
     FIXED:  Hotel 9ห้อง×5คืน, Coach 6วัน, Guide 6วัน, Ground 1กรุ๊ป
     VARIABLE: Meal 10มื้อ×25pax=250ที่, Ropeway 25ใบ, Toshogu 25ใบ
     ----------------------------------------------------------------
     Cost รวม:
       Hotel   45×6,500   = 292,500
       Coach   6×28,000   = 168,000
       Meal    250×950    = 237,500
       Ropeway 25×1,100   =  27,500
       Toshogu 25×1,300   =  32,500
       Guide   6×15,000   =  90,000
       Ground  1×18,000   =  18,000
       รวม               = 866,000
     Revenue: 25×31,500  = 787,500
     Profit : -78,500  (Break Even ที่ 28pax → Rev 882,000 → +16,000)
  ================================================================ */
  -- FIXED
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>NULL, p_itemcostid=>'IC0001',
    p_feeamount=>6500, p_quantity=>45,
    p_note=>'Hotel 5คืน 9ห้อง (25pax/3คน) Narita+Shinjuku+Osaka',
    p_startdate=>DATE '2026-04-10', p_enddate=>DATE '2026-04-15'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>NULL, p_itemcostid=>'IC0002',
    p_feeamount=>28000, p_quantity=>6,
    p_note=>'รถโค้ช 40ที่นั่ง เหมา 6วัน',
    p_startdate=>DATE '2026-04-10', p_enddate=>DATE '2026-04-15'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>'G0002', p_itemcostid=>'IC0005',
    p_feeamount=>15000, p_quantity=>6,
    p_note=>'ค่าไกด์ Sato Yumi 6วัน',
    p_startdate=>DATE '2026-04-10', p_enddate=>DATE '2026-04-15'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>NULL, p_itemcostid=>'IC0006',
    p_feeamount=>18000, p_quantity=>1,
    p_note=>'Japan Ground Operator fee',
    p_startdate=>DATE '2026-04-10', p_enddate=>DATE '2026-04-15'
  );
  -- VARIABLE
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>'G0002', p_itemcostid=>'IC0003',
    p_feeamount=>950, p_quantity=>250,
    p_note=>'อาหาร 10มื้อ × 25pax (D,B,L,D,B,L,B,L,B,D,B)',
    p_startdate=>DATE '2026-04-10', p_enddate=>DATE '2026-04-15'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>NULL, p_itemcostid=>'IC0004',
    p_feeamount=>1100, p_quantity=>25,
    p_note=>'Kachi-Kachi Ropeway × 25pax (Day3)',
    p_startdate=>DATE '2026-04-12', p_enddate=>DATE '2026-04-12'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0002', p_guideid=>NULL, p_itemcostid=>'IC0004',
    p_feeamount=>1300, p_quantity=>25,
    p_note=>'Nikko Toshogu entrance × 25pax (Day4)',
    p_startdate=>DATE '2026-04-13', p_enddate=>DATE '2026-04-13'
  );

  /* ================================================================
     T0003 : CNX Highlight 3D2N  |  19 pax จริง  (CLOSED)
     ----------------------------------------------------------------
     FIXED:  Van 2คัน×2วัน, Hotel 10ห้อง×2คืน, Guide 3วัน
     VARIABLE: Meal 5มื้อ×19pax=95ที่, Doi 19ใบ
     ----------------------------------------------------------------
     Cost รวม:
       Van     4×3,500    =  14,000
       Hotel   20×2,800   =  56,000
       Meal    95×400     =  38,000
       Doi     19×300     =   5,700
       Guide   3×3,500    =  10,500
       รวม               = 124,200
     Revenue: 19×5,900   = 112,100
     Profit : -12,100
  ================================================================ */
  -- FIXED
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0003', p_guideid=>'G0003', p_itemcostid=>'IC0008',
    p_feeamount=>3500, p_quantity=>4,
    p_note=>'รถตู้ 9ที่นั่ง 2คัน × 2วัน (19pax)',
    p_startdate=>DATE '2026-02-20', p_enddate=>DATE '2026-02-21'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0003', p_guideid=>NULL, p_itemcostid=>'IC0007',
    p_feeamount=>2800, p_quantity=>20,
    p_note=>'Hotel CNX 2คืน 10ห้อง (19pax/2คน)',
    p_startdate=>DATE '2026-02-20', p_enddate=>DATE '2026-02-22'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0003', p_guideid=>'G0003', p_itemcostid=>'IC0011',
    p_feeamount=>3500, p_quantity=>3,
    p_note=>'ค่าไกด์ Somchai Phumjai 3วัน',
    p_startdate=>DATE '2026-02-20', p_enddate=>DATE '2026-02-22'
  );
  -- VARIABLE
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0003', p_guideid=>'G0003', p_itemcostid=>'IC0009',
    p_feeamount=>400, p_quantity=>95,
    p_note=>'อาหาร 5มื้อ × 19pax (Day1=L,D Day2=B,L Day3=B)',
    p_startdate=>DATE '2026-02-20', p_enddate=>DATE '2026-02-22'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0003', p_guideid=>NULL, p_itemcostid=>'IC0010',
    p_feeamount=>300, p_quantity=>19,
    p_note=>'ค่าเข้าอุทยานดอยอินทนนท์ × 19pax (Day2)',
    p_startdate=>DATE '2026-02-21', p_enddate=>DATE '2026-02-21'
  );

  /* ================================================================
     T0004 : SG Free & Easy 4D3N  |  17 pax จริง
     ----------------------------------------------------------------
     FIXED:  Hotel 9ห้อง×3คืน, Coach 3วัน, Guide 2วัน, Ground 1กรุ๊ป
     VARIABLE: Meal 4มื้อ×17pax=68ที่, USS 17ใบ
     ----------------------------------------------------------------
     Cost รวม:
       Hotel   27×7,200   = 194,400
       Coach   3×22,000   =  66,000
       Meal    68×750     =  51,000
       USS     17×3,200   =  54,400
       Guide   2×4,000    =   8,000
       Ground  1×18,000   =  18,000
       รวม               = 391,800
     Revenue: 17×19,900  = 338,300
     Profit : -53,500
  ================================================================ */
  -- FIXED
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0004', p_guideid=>NULL, p_itemcostid=>'IC0016',
    p_feeamount=>7200, p_quantity=>27,
    p_note=>'Hotel SG 3คืน 9ห้อง (17pax/2คน)',
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-05-04'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0004', p_guideid=>NULL, p_itemcostid=>'IC0017',
    p_feeamount=>22000, p_quantity=>3,
    p_note=>'รถโค้ช SG 3วัน (Day1 airport-in, Day2 Sentosa, Day4 airport-out)',
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-05-04'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0004', p_guideid=>'G0005', p_itemcostid=>'IC0020',
    p_feeamount=>4000, p_quantity=>2,
    p_note=>'ค่าไกด์ Lim Wei 2วัน (Day1 orientation + Day2 Sentosa)',
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-05-02'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0004', p_guideid=>NULL, p_itemcostid=>'IC0021',
    p_feeamount=>18000, p_quantity=>1,
    p_note=>'Singapore Ground Operator handling fee',
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-05-04'
  );
  -- VARIABLE
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0004', p_guideid=>'G0005', p_itemcostid=>'IC0018',
    p_feeamount=>750, p_quantity=>68,
    p_note=>'อาหาร 4มื้อ × 17pax (Day1=D, Day2-4=B)',
    p_startdate=>DATE '2026-05-01', p_enddate=>DATE '2026-05-04'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0004', p_guideid=>'G0005', p_itemcostid=>'IC0019',
    p_feeamount=>3200, p_quantity=>17,
    p_note=>'Universal Studios Singapore 1-Day Pass × 17pax (Day2)',
    p_startdate=>DATE '2026-05-02', p_enddate=>DATE '2026-05-02'
  );

  /* ================================================================
     T0005 : KR Seoul-Jeju 5D4N  |  20 pax จริง
     ----------------------------------------------------------------
     FIXED:  Hotel 10ห้อง×4คืน, Coach 4วัน, Guide 5วัน
     VARIABLE: Meal 9มื้อ×20pax=180ที่, Seongsan 20ใบ
     ----------------------------------------------------------------
     Cost รวม:
       Hotel   40×5,500   = 220,000
       Coach   4×26,000   = 104,000
       Meal    180×900    = 162,000
       Seongsan 20×800    =  16,000
       Guide   5×5,000    =  25,000
       รวม               = 527,000
     Revenue: 20×27,900  = 558,000
     Profit : +31,000 ✓
  ================================================================ */
  -- FIXED
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0005', p_guideid=>NULL, p_itemcostid=>'IC0022',
    p_feeamount=>5500, p_quantity=>40,
    p_note=>'Hotel KR 4คืน 10ห้อง (20pax/2คน) Lotte Seoul×2 + Ramada Jeju×2',
    p_startdate=>DATE '2026-06-10', p_enddate=>DATE '2026-06-14'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0005', p_guideid=>NULL, p_itemcostid=>'IC0023',
    p_feeamount=>26000, p_quantity=>4,
    p_note=>'รถโค้ช KR เหมา 4วัน (Day1-4, Day5 นั่งเครื่อง)',
    p_startdate=>DATE '2026-06-10', p_enddate=>DATE '2026-06-13'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0005', p_guideid=>'G0004', p_itemcostid=>'IC0026',
    p_feeamount=>5000, p_quantity=>5,
    p_note=>'ค่าไกด์ Kim Minseo 5วัน (Seoul+Jeju)',
    p_startdate=>DATE '2026-06-10', p_enddate=>DATE '2026-06-14'
  );
  -- VARIABLE
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0005', p_guideid=>'G0004', p_itemcostid=>'IC0024',
    p_feeamount=>900, p_quantity=>180,
    p_note=>'อาหาร 9มื้อ × 20pax (Day1=D, Day2=B,L, Day3=B,D, Day4=B,L,D, Day5=B)',
    p_startdate=>DATE '2026-06-10', p_enddate=>DATE '2026-06-14'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0005', p_guideid=>NULL, p_itemcostid=>'IC0025',
    p_feeamount=>800, p_quantity=>20,
    p_note=>'Seongsan Ilchulbong entrance × 20pax (Day4)',
    p_startdate=>DATE '2026-06-13', p_enddate=>DATE '2026-06-13'
  );

  /* ================================================================
     T0006 : Bangkok Incentive 3D2N  |  40 pax จริง  (DRAFT)
     ----------------------------------------------------------------
     FIXED:  Hotel 20ห้อง×2คืน, VIP Coach 3วัน, Guide 3วัน
     VARIABLE: Gala Meal 7มื้อ×40pax=280ที่, Wat Entrance 40ใบ
     ----------------------------------------------------------------
     Cost รวม:
       Hotel   40×9,500   = 380,000
       Coach   3×35,000   = 105,000
       Meal    280×1,800  = 504,000
       Wat     40×500     =  20,000
       Guide   3×4,500    =  13,500
       รวม               = 1,022,500
     Revenue: 40×15,000  = 600,000
     Profit : -422,500
     หมายเหตุ: แสดงให้เห็นว่า Incentive ราคา 15,000/คน ต่ำเกินไป
               ต้องปรับเป็น 26,000+/คน ถึงจะ Break Even
  ================================================================ */
  -- FIXED
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0006', p_guideid=>NULL, p_itemcostid=>'IC0012',
    p_feeamount=>9500, p_quantity=>40,
    p_note=>'Centara Grand 5* 2คืน 20ห้อง (40pax/2คน)',
    p_startdate=>DATE '2026-07-05', p_enddate=>DATE '2026-07-07'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0006', p_guideid=>NULL, p_itemcostid=>'IC0013',
    p_feeamount=>35000, p_quantity=>3,
    p_note=>'รถโค้ช VIP 45ที่นั่ง เหมา 3วัน',
    p_startdate=>DATE '2026-07-05', p_enddate=>DATE '2026-07-07'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0006', p_guideid=>'G0003', p_itemcostid=>'IC0011',
    p_feeamount=>4500, p_quantity=>3,
    p_note=>'ค่าไกด์ Incentive Program 3วัน',
    p_startdate=>DATE '2026-07-05', p_enddate=>DATE '2026-07-07'
  );
  -- VARIABLE
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0006', p_guideid=>'G0003', p_itemcostid=>'IC0014',
    p_feeamount=>1800, p_quantity=>280,
    p_note=>'Gala Dinner+Meal 7มื้อ × 40pax (Day1=L,D Day2=B,L,D Day3=B,L)',
    p_startdate=>DATE '2026-07-05', p_enddate=>DATE '2026-07-07'
  );
  pkg_costdetail.sp_cost_add_detail(
    p_tourid=>'T0006', p_guideid=>NULL, p_itemcostid=>'IC0015',
    p_feeamount=>500, p_quantity=>40,
    p_note=>'ค่าเข้าวัดพระแก้ว × 40pax (Day3)',
    p_startdate=>DATE '2026-07-07', p_enddate=>DATE '2026-07-07'
  );
END;

COMMIT;

/*
  ============================================================
  สรุป TripProfit ที่คาดหวัง:
  ┌──────────────────┬──────┬─────────┬───────────┬──────────┐
  │ Tour             │ Pax  │ Revenue │ Cost      │ Profit   │
  ├──────────────────┼──────┼─────────┼───────────┼──────────┤
  │ T0001 JP Sakura  │  26  │ 777,400 │  874,000  │  -96,600 │
  │ T0002 JP Autumn  │  25  │ 787,500 │  866,000  │  -78,500 │
  │ T0003 CNX        │  19  │ 112,100 │  124,200  │  -12,100 │
  │ T0004 SG         │  17  │ 338,300 │  391,800  │  -53,500 │
  │ T0005 KR         │  20  │ 558,000 │  527,000  │  +31,000 │
  │ T0006 Incentive  │  40  │ 600,000 │1,022,500  │ -422,500 │
  └──────────────────┴──────┴─────────┴───────────┴──────────┘
  ============================================================
*/
