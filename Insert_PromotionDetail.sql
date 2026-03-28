-- DML: seed PromotionDetail records via pkg_promodetail.sp_promo_add_detail
BEGIN
  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0001',
    p_discountpercent => 10,
    p_startdate       => DATE '2026-01-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Early bird >=60 days',
    p_minbookamount   => 50000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0002',
    p_discountpercent => 10,
    p_startdate       => DATE '2026-01-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Early bird JP2',
    p_minbookamount   => 60000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0003',
    p_discountpercent => 8,
    p_startdate       => DATE '2026-01-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Early bird CNX',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0004',
    p_discountpercent => 10,
    p_startdate       => DATE '2026-01-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Early bird SG',
    p_minbookamount   => 40000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0005',
    p_discountpercent => 12,
    p_startdate       => DATE '2026-01-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Early bird KR',
    p_minbookamount   => 70000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0001',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Group >=10 pax',
    p_minbookamount   => 100000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0002',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Group10 JP2',
    p_minbookamount   => 120000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0003',
    p_discountpercent => 3,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Group10 CNX',
    p_minbookamount   => 40000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0004',
    p_discountpercent => 4,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Group10 SG',
    p_minbookamount   => 60000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0005',
    p_discountpercent => 6,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Group10 KR',
    p_minbookamount   => 90000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0003',
    p_tourid          => 'T0001',
    p_discountpercent => 25,
    p_startdate       => DATE '2026-12-20',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Flash sale JP1',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0003',
    p_tourid          => 'T0002',
    p_discountpercent => 25,
    p_startdate       => DATE '2026-12-20',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Flash sale JP2',
    p_minbookamount   => 35000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0003',
    p_tourid          => 'T0003',
    p_discountpercent => 20,
    p_startdate       => DATE '2026-12-20',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Flash sale CNX',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0003',
    p_tourid          => 'T0004',
    p_discountpercent => 22,
    p_startdate       => DATE '2026-12-20',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Flash sale SG',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0003',
    p_tourid          => 'T0005',
    p_discountpercent => 28,
    p_startdate       => DATE '2026-12-20',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Flash sale KR',
    p_minbookamount   => 40000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0001',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Repeat cust JP',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0002',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Repeat cust JP2',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0003',
    p_discountpercent => 4,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Repeat cust CNX',
    p_minbookamount   => 15000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0004',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Repeat cust SG',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0005',
    p_discountpercent => 6,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Repeat cust KR',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0001',
    p_discountpercent => 15,
    p_startdate       => DATE '2026-05-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Low season JP1',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0002',
    p_discountpercent => 15,
    p_startdate       => DATE '2026-05-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Low season JP2',
    p_minbookamount   => 35000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0003',
    p_discountpercent => 10,
    p_startdate       => DATE '2026-05-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Low season CNX',
    p_minbookamount   => 15000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0004',
    p_discountpercent => 12,
    p_startdate       => DATE '2026-05-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Low season SG',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0005',
    p_discountpercent => 18,
    p_startdate       => DATE '2026-05-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Low season KR',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0001',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X card',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0002',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X JP2',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0003',
    p_discountpercent => 4,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X CNX',
    p_minbookamount   => 15000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0004',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X SG',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0005',
    p_discountpercent => 6,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X KR',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0006',
    p_discountpercent => 8,
    p_startdate       => DATE '2026-01-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Early bird incentive',
    p_minbookamount   => 50000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0006',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Group10 incentive',
    p_minbookamount   => 70000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0003',
    p_tourid          => 'T0006',
    p_discountpercent => 20,
    p_startdate       => DATE '2026-12-20',
    p_enddate         => DATE '2026-12-31',
    p_extracondition  => 'Flash sale incentive',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0006',
    p_discountpercent => 4,
    p_startdate       => DATE '2026-02-01',
    p_enddate         => DATE '2026-06-30',
    p_extracondition  => 'Repeat cust incentive',
    p_minbookamount   => 20000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0006',
    p_discountpercent => 12,
    p_startdate       => DATE '2026-05-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Low season incentive',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0006',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X incentive',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0001',
    p_discountpercent => 9,
    p_startdate       => DATE '2026-09-01',
    p_enddate         => DATE '2026-11-30',
    p_extracondition  => 'Autumn early bird',
    p_minbookamount   => 45000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0002',
    p_discountpercent => 7,
    p_startdate       => DATE '2026-09-01',
    p_enddate         => DATE '2026-11-30',
    p_extracondition  => 'Group10 autumn',
    p_minbookamount   => 80000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0003',
    p_discountpercent => 11,
    p_startdate       => DATE '2026-06-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'CNX green season',
    p_minbookamount   => 18000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0004',
    p_discountpercent => 13,
    p_startdate       => DATE '2026-06-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'SG low season card',
    p_minbookamount   => 22000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0005',
    p_tourid          => 'T0005',
    p_discountpercent => 16,
    p_startdate       => DATE '2026-06-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'KR low season',
    p_minbookamount   => 26000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0002',
    p_discountpercent => 11,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-04-30',
    p_extracondition  => 'Sakura early bird',
    p_minbookamount   => 55000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0001',
    p_tourid          => 'T0001',
    p_discountpercent => 12,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-04-30',
    p_extracondition  => 'Sakura EB 2',
    p_minbookamount   => 60000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0002',
    p_tourid          => 'T0004',
    p_discountpercent => 6,
    p_startdate       => DATE '2026-04-01',
    p_enddate         => DATE '2026-09-30',
    p_extracondition  => 'Group10 SG FE',
    p_minbookamount   => 50000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0001',
    p_discountpercent => 7,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-05-31',
    p_extracondition  => 'Repeat premium JP',
    p_minbookamount   => 30000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0004',
    p_tourid          => 'T0005',
    p_discountpercent => 8,
    p_startdate       => DATE '2026-03-01',
    p_enddate         => DATE '2026-05-31',
    p_extracondition  => 'Repeat premium KR',
    p_minbookamount   => 35000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0001',
    p_discountpercent => 6,
    p_startdate       => DATE '2026-04-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X double points',
    p_minbookamount   => 25000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0002',
    p_discountpercent => 7,
    p_startdate       => DATE '2026-04-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X JP2 double',
    p_minbookamount   => 28000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0004',
    p_discountpercent => 5,
    p_startdate       => DATE '2026-04-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X SG cashback',
    p_minbookamount   => 22000
  );

  pkg_promodetail.sp_promo_add_detail(
    p_promotionid     => 'PRM0006',
    p_tourid          => 'T0005',
    p_discountpercent => 6,
    p_startdate       => DATE '2026-04-01',
    p_enddate         => DATE '2026-08-31',
    p_extracondition  => 'Bank X KR cashback',
    p_minbookamount   => 26000
  );
END;

COMMIT;
