/* ============================================================
   Insert_TourDetail.sql
   โปรแกรมทัวร์รายวัน — สอดคล้องกับ Tour + TourPlan ใน DML
   ============================================================ */
BEGIN
  /* ================================================================
     T0001 : Japan Tokyo-Osaka Sakura 6D5N  (TourPlan TPJP6D01)
     StartDate 25 Mar → EndDate 30 Mar 2026
  ================================================================ */
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0001', p_tourplanid=>'TPJP6D01',
    p_title=>'Day 1 : กรุงเทพฯ → โตเกียว (นาริตะ)',
    p_description=>'เหินฟ้าสู่กรุงโตเกียว สนามบินนาริตะ รับกระเป๋า → เดินทางเข้าที่พัก รับประทานอาหารเย็นเมนูชาบูชาบู',
    p_meal=>'D', p_hotelname=>'Narita Excel Hotel Tokyu',
    p_transportnote=>'TG 660 BKK-NRT 23:55 / Airport Limousine Bus'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0001', p_tourplanid=>'TPJP6D01',
    p_title=>'Day 2 : โตเกียว City Tour + ซากุระอุเอโนะ',
    p_description=>'วัดอาซากุสะ → สะพาน Nakamise → สวนอุเอโนะชมซากุระ → โตเกียวสกายทรี (ชั้น 350) → ชิบูยะ Crossing',
    p_meal=>'B,L,D', p_hotelname=>'Sunshine City Prince Hotel',
    p_transportnote=>'รถโค้ช 40 ที่นั่ง'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0001', p_tourplanid=>'TPJP6D01',
    p_title=>'Day 3 : ฟูจิ-ฮาโกเน่',
    p_description=>'ทะเลสาบคาวากุจิโกะ (วิวฟูจิ+ซากุระ) → กระเช้า Owakudani → ล่องเรืออาชิโนะโกะ → Gotemba Outlet',
    p_meal=>'B,L', p_hotelname=>'Hakone Kowaki-en Hotel',
    p_transportnote=>'รถโค้ช 40 ที่นั่ง / กระเช้าลอยฟ้า'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0001', p_tourplanid=>'TPJP6D01',
    p_title=>'Day 4 : โตเกียว อิสระช้อปปิ้ง',
    p_description=>'อิสระทั้งวัน แนะนำ: ชินจูกุ / ฮาราจูกุ / อากิฮาบาระ / อาเมโยโกะ ตามอัธยาศัย',
    p_meal=>'B', p_hotelname=>'Sunshine City Prince Hotel',
    p_transportnote=>'อิสระ (แนะนำ JR Pass / Tokyo Metro)'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0001', p_tourplanid=>'TPJP6D01',
    p_title=>'Day 5 : โตเกียว → โอซาก้า (ชินกันเซ็น)',
    p_description=>'นั่งชินกันเซ็น Nozomi สู่โอซาก้า → ปราสาทโอซาก้า → โดทงโบริ → ชินไซบาชิ ช้อปปิ้ง',
    p_meal=>'B,D', p_hotelname=>'Cross Hotel Osaka',
    p_transportnote=>'Shinkansen Nozomi TYO-OSA ~2h30m'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0001', p_tourplanid=>'TPJP6D01',
    p_title=>'Day 6 : โอซาก้า → กรุงเทพฯ',
    p_description=>'อิสระช้อปปิ้งย่านชินไซบาชิ → เดินทางสู่สนามบิน Kansai → เหินฟ้ากลับกรุงเทพฯ',
    p_meal=>'B', p_hotelname=>'(เครื่องบิน)',
    p_transportnote=>'TG 665 KIX-BKK 13:00 ถึง 17:00'
  );

  /* ================================================================
     T0002 : Japan Tokyo-Osaka Autumn 6D5N  (TourPlan TPJP6D02)
     StartDate 10 Apr → EndDate 15 Apr 2026
  ================================================================ */
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0002', p_tourplanid=>'TPJP6D02',
    p_title=>'Day 1 : กรุงเทพฯ → โตเกียว (นาริตะ)',
    p_description=>'เหินฟ้าสู่โตเกียว → เข้าที่พักนาริตะ → อาหารเย็นเมนูยากินิกุ',
    p_meal=>'D', p_hotelname=>'Narita Excel Hotel Tokyu',
    p_transportnote=>'TG 660 BKK-NRT / Airport Limousine Bus'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0002', p_tourplanid=>'TPJP6D02',
    p_title=>'Day 2 : โตเกียว Autumn City Tour',
    p_description=>'ศาลเจ้าเมจิ → ฮาราจูกุ (Takeshita Street) → โอโมเตะซันโด → ชมใบไม้แดง Shinjuku Gyoen',
    p_meal=>'B,L,D', p_hotelname=>'Shinjuku Washington Hotel',
    p_transportnote=>'รถโค้ช 40 ที่นั่ง'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0002', p_tourplanid=>'TPJP6D02',
    p_title=>'Day 3 : คาวากุจิโกะ + Kachi-Kachi Ropeway',
    p_description=>'ทะเลสาบคาวากุจิโกะ → นั่งกระเช้า Kachi-Kachi ชมวิวฟูจิ → ช้อปปิ้งของที่ระลึกริมทะเลสาบ',
    p_meal=>'B,L', p_hotelname=>'Fuji View Hotel',
    p_transportnote=>'รถโค้ช 40 ที่นั่ง / กระเช้า'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0002', p_tourplanid=>'TPJP6D02',
    p_title=>'Day 4 : นิกโก้ มรดกโลก',
    p_description=>'ศาลเจ้า Toshogu (มรดกโลก UNESCO) → น้ำตก Kegon → ทะเลสาบ Chuzenji → กลับโตเกียว',
    p_meal=>'B,L', p_hotelname=>'Shinjuku Washington Hotel',
    p_transportnote=>'รถโค้ช 40 ที่นั่ง (ทางด่วน Nikko)'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0002', p_tourplanid=>'TPJP6D02',
    p_title=>'Day 5 : โตเกียว → โอซาก้า + ปราสาท',
    p_description=>'นั่งชินกันเซ็น Nozomi → ปราสาทโอซาก้า → โดทงโบริล่องเรือ → ชินไซบาชิ',
    p_meal=>'B,D', p_hotelname=>'Cross Hotel Osaka',
    p_transportnote=>'Shinkansen Nozomi ~2h30m'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0002', p_tourplanid=>'TPJP6D02',
    p_title=>'Day 6 : โอซาก้า → กรุงเทพฯ',
    p_description=>'ช้อปปิ้ง Rinku Premium Outlet → สนามบิน Kansai → บินกลับกรุงเทพฯ',
    p_meal=>'B', p_hotelname=>'(เครื่องบิน)',
    p_transportnote=>'TG 665 KIX-BKK'
  );

  /* ================================================================
     T0003 : Chiang Mai Highlight 3D2N  (TourPlan TPCNX3D1)
     StartDate 20 Feb → EndDate 22 Feb 2026  (CLOSED)
  ================================================================ */
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0003', p_tourplanid=>'TPCNX3D1',
    p_title=>'Day 1 : กรุงเทพฯ → เชียงใหม่',
    p_description=>'รับสนามบินเชียงใหม่ → วัดพระธาตุดอยสุเทพ (วิวเมือง) → ถนนคนเดินท่าแพ ช้อปปิ้ง',
    p_meal=>'L,D', p_hotelname=>'Le Meridien Chiang Mai',
    p_transportnote=>'FD 3026 BKK-CNX 07:30 / รถตู้ 9 ที่นั่ง'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0003', p_tourplanid=>'TPCNX3D1',
    p_title=>'Day 2 : ดอยอินทนนท์ ยอดดอยสูงสุดในไทย',
    p_description=>'ยอดดอยอินทนนท์ (2,565 ม.) → พระมหาธาตุนภเมทนีดล → น้ำตกแม่กลาง → กลับเชียงใหม่',
    p_meal=>'B,L', p_hotelname=>'Le Meridien Chiang Mai',
    p_transportnote=>'รถตู้ 9 ที่นั่ง (ออก 07:00)'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0003', p_tourplanid=>'TPCNX3D1',
    p_title=>'Day 3 : ตลาดวโรรส → กรุงเทพฯ',
    p_description=>'ช้อปปิ้งของฝากตลาดวโรรส (กาดหลวง) → ของดีเชียงใหม่ → สนามบินเชียงใหม่ → บินกลับ',
    p_meal=>'B', p_hotelname=>'(เครื่องบิน)',
    p_transportnote=>'FD 3025 CNX-BKK 18:45'
  );

  /* ================================================================
     T0004 : Singapore Free & Easy 4D3N  (TourPlan TPSG4D01)
     StartDate 1 May → EndDate 4 May 2026
  ================================================================ */
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0004', p_tourplanid=>'TPSG4D01',
    p_title=>'Day 1 : กรุงเทพฯ → สิงคโปร์',
    p_description=>'บินสู่สิงคโปร์ → รับกระเป๋า Changi T3 → Marina Bay Sands (ถ่ายรูป) → Merlion Park → อาหารเย็น Chilli Crab ริมอ่าว',
    p_meal=>'D', p_hotelname=>'Park Royal Collection Marina Bay',
    p_transportnote=>'SQ 971 BKK-SIN 08:45 / Coach'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0004', p_tourplanid=>'TPSG4D01',
    p_title=>'Day 2 : Sentosa Island เต็มวัน',
    p_description=>'Universal Studios Singapore (1 วันเต็ม) → S.E.A. Aquarium → ชายหาด Palawan → กลับโรงแรม',
    p_meal=>'B', p_hotelname=>'Park Royal Collection Marina Bay',
    p_transportnote=>'Coach → Sentosa Express Monorail'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0004', p_tourplanid=>'TPSG4D01',
    p_title=>'Day 3 : อิสระเต็มวัน (Free & Easy)',
    p_description=>'อิสระทั้งวัน แนะนำ: Orchard Road / Gardens by the Bay (ค่ำ) / Chinatown / Little India / Clarke Quay',
    p_meal=>'B', p_hotelname=>'Park Royal Collection Marina Bay',
    p_transportnote=>'MRT ด้วยตัวเอง (EZ-Link Card)'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0004', p_tourplanid=>'TPSG4D01',
    p_title=>'Day 4 : ช้อปปิ้ง Mustafa → กรุงเทพฯ',
    p_description=>'ช้อปปิ้ง Mustafa Centre (ห้างเปิด 24 ชม.) → ส่งสนามบิน Changi → เหินฟ้ากลับกรุงเทพฯ',
    p_meal=>'B', p_hotelname=>'(เครื่องบิน)',
    p_transportnote=>'SQ 974 SIN-BKK 20:30'
  );

  /* ================================================================
     T0005 : Korea Seoul-Jeju 5D4N  (TourPlan TPKR5D01)
     StartDate 10 Jun → EndDate 14 Jun 2026
  ================================================================ */
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0005', p_tourplanid=>'TPKR5D01',
    p_title=>'Day 1 : กรุงเทพฯ → โซล (อินชอน)',
    p_description=>'เหินฟ้าสู่เกาหลี → สนามบินอินชอน → เดินทางเข้าโซล → Namsan Tower (ชมวิวยามค่ำคืน) → Myeongdong',
    p_meal=>'D', p_hotelname=>'Lotte City Hotel Myeongdong',
    p_transportnote=>'OZ 741 BKK-ICN 09:30 / AREX + Coach'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0005', p_tourplanid=>'TPKR5D01',
    p_title=>'Day 2 : โซล City Tour + ช้อปปิ้ง',
    p_description=>'พระราชวัง Gyeongbokgung + เปลี่ยนเครื่องแต่งกาย Hanbok → Bukchon Hanok Village → Insadong → Myeongdong ช้อปปิ้ง',
    p_meal=>'B,L', p_hotelname=>'Lotte City Hotel Myeongdong',
    p_transportnote=>'รถโค้ช 45 ที่นั่ง'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0005', p_tourplanid=>'TPKR5D01',
    p_title=>'Day 3 : โซล → เกาะเชจู (บินภายใน)',
    p_description=>'บินภายในสู่เกาะเชจู → Yongduam Dragon Rock → Hallasan National Park ศูนย์บริการ → ตลาดเช้าเชจู',
    p_meal=>'B,D', p_hotelname=>'Ramada by Wyndham Jeju City',
    p_transportnote=>'7C 901 GMP-CJU 10:00 / Coach'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0005', p_tourplanid=>'TPKR5D01',
    p_title=>'Day 4 : ไฮไลต์เกาะเชจู',
    p_description=>'Seongsan Ilchulbong (ปล่องภูเขาไฟมรดกโลก) → Jeju Folk Village → Duty Free Shopping → Korean BBQ อาหารเย็น',
    p_meal=>'B,L,D', p_hotelname=>'Ramada by Wyndham Jeju City',
    p_transportnote=>'รถโค้ช'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0005', p_tourplanid=>'TPKR5D01',
    p_title=>'Day 5 : เชจู → โซล → กรุงเทพฯ',
    p_description=>'บินกลับโซล (อินชอน) → พักรอเชื่อมต่อ → เหินฟ้ากลับกรุงเทพฯ ถึงปลอดภัย',
    p_meal=>'B', p_hotelname=>'(เครื่องบิน)',
    p_transportnote=>'7C 902 CJU-ICN 13:00 → OZ 742 ICN-BKK 17:30'
  );

  /* ================================================================
     T0006 : Bangkok Incentive Program 3D2N  (TourPlan TPCNX3D1)
     StartDate 5 Jul → EndDate 7 Jul 2026  (DRAFT)
  ================================================================ */
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0006', p_tourplanid=>'TPCNX3D1',
    p_title=>'Day 1 : รับคณะ + Opening & Welcome Dinner',
    p_description=>'รับคณะสนามบินสุวรรณภูมิ → ลงทะเบียน Check-in → Opening Ceremony & Company Briefing → Welcome Gala Dinner ริมสระ',
    p_meal=>'L,D', p_hotelname=>'Centara Grand Bangkok Convention Centre',
    p_transportnote=>'รถโค้ช VIP 45 ที่นั่ง'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0006', p_tourplanid=>'TPCNX3D1',
    p_title=>'Day 2 : Team Building + Chao Phraya Cruise + Gala Dinner',
    p_description=>'กิจกรรม Outdoor Team Building (ครึ่งวันเช้า) → พักกลางวัน → ล่องเรือเจ้าพระยา (Sunset Cruise) → Gala Dinner พิธีมอบรางวัล Award Ceremony',
    p_meal=>'B,L,D', p_hotelname=>'Centara Grand Bangkok Convention Centre',
    p_transportnote=>'รถโค้ช VIP / เรือ Chao Phraya'
  );
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid=>'T0006', p_tourplanid=>'TPCNX3D1',
    p_title=>'Day 3 : วัดพระแก้ว + Emporium + ส่งสนามบิน',
    p_description=>'วัดพระแก้ว-วัดโพธิ์ (half day) → ช้อปปิ้ง Emporium / Terminal 21 → ส่งสนามบินสุวรรณภูมิตามเที่ยวบิน',
    p_meal=>'B,L', p_hotelname=>'(เครื่องบิน)',
    p_transportnote=>'รถโค้ช VIP 45 ที่นั่ง'
  );
END;

COMMIT;
