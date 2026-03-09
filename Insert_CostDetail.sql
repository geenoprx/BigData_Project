BEGIN
  -- 1: Tour T0001 / Guide G0001 / IC0001
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0001',
    p_guideid   => 'G0001',
    p_itemcostid=> 'IC0001',
    p_feeamount => 10000,
    p_quantity  => 1,
    p_note      => 'Hotel cost JP1',
    p_startdate => DATE '2026-03-25',
    p_enddate   => DATE '2026-03-30'
  );

  -- 2: Tour T0001 / ไม่มี guide (NULL)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0001',
    p_guideid   => NULL,
    p_itemcostid=> 'IC0002',
    p_feeamount => 28000,
    p_quantity  => 1,
    p_note      => 'Bus rental JP1',
    p_startdate => DATE '2026-03-25',
    p_enddate   => DATE '2026-03-25'
  );

  -- 3: Tour T0001 / Guide G0002 / อาหาร
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0001',
    p_guideid   => 'G0002',
    p_itemcostid=> 'IC0003',
    p_feeamount => 950,
    p_quantity  => 5,
    p_note      => 'Dinner day 2',
    p_startdate => DATE '2026-03-26',
    p_enddate   => DATE '2026-03-26'
  );

  -- 4: Tour T0002 / Guide G0001
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0002',
    p_guideid   => 'G0001',
    p_itemcostid=> 'IC0001',
    p_feeamount => 12000,
    p_quantity  => 1,
    p_note      => 'Hotel cost JP2',
    p_startdate => DATE '2026-04-10',
    p_enddate   => DATE '2026-04-15'
  );

  -- 5: Tour T0002 / Bus
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0002',
    p_guideid   => NULL,
    p_itemcostid=> 'IC0002',
    p_feeamount => 30000,
    p_quantity  => 1,
    p_note      => 'Bus rental JP2',
    p_startdate => DATE '2026-04-10',
    p_enddate   => DATE '2026-04-10'
  );

  -- 6: Tour T0003 / Guide G0003 / Van TH
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0003',
    p_guideid   => 'G0003',
    p_itemcostid=> 'IC0005',
    p_feeamount => 3500,
    p_quantity  => 2,
    p_note      => 'CNX van full day',
    p_startdate => DATE '2026-02-20',
    p_enddate   => DATE '2026-02-22'
  );

  -- 7: Tour T0003 / อาหาร TH
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0003',
    p_guideid   => 'G0003',
    p_itemcostid=> 'IC0003',
    p_feeamount => 700,
    p_quantity  => 3,
    p_note      => 'Local meals',
    p_startdate => DATE '2026-02-21',
    p_enddate   => DATE '2026-02-21'
  );

  -- 8: Tour T0004 / Guide G0005 / Ground operator SG
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0004',
    p_guideid   => 'G0005',
    p_itemcostid=> 'IC0006',
    p_feeamount => 18000,
    p_quantity  => 1,
    p_note      => 'SG handling fee',
    p_startdate => DATE '2026-05-01',
    p_enddate   => DATE '2026-05-04'
  );

  -- 9: Tour T0005 / Guide G0004 / KR tour
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0005',
    p_guideid   => 'G0004',
    p_itemcostid=> 'IC0003',
    p_feeamount => 900,
    p_quantity  => 5,
    p_note      => 'KR meals',
    p_startdate => DATE '2026-06-10',
    p_enddate   => DATE '2026-06-14'
  );

  -- 10: Tour T0005 / ไม่มี guide (ค่าตั๋ว attraction)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid    => 'T0005',
    p_guideid   => NULL,
    p_itemcostid=> 'IC0004',
    p_feeamount => 3200,
    p_quantity  => 3,
    p_note      => 'Attraction tickets',
    p_startdate => DATE '2026-06-11',
    p_enddate   => DATE '2026-06-11'
  );

  -- 11: T0001 เพิ่มค่า attraction
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => NULL,
    p_itemcostid => 'IC0004',
    p_feeamount  => 3200,
    p_quantity   => 4,
    p_note       => 'Attraction tickets JP1',
    p_startdate  => DATE '2026-03-27',
    p_enddate    => DATE '2026-03-27'
  );

  -- 12: T0001 guide G0001 เพิ่ม day trip
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => 'G0001',
    p_itemcostid => 'IC0003',
    p_feeamount  => 900,
    p_quantity   => 3,
    p_note       => 'Extra guiding day',
    p_startdate  => DATE '2026-03-28',
    p_enddate    => DATE '2026-03-28'
  );

  -- 13: T0002 attraction
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => NULL,
    p_itemcostid => 'IC0004',
    p_feeamount  => 3200,
    p_quantity   => 3,
    p_note       => 'Fuji-Hakone pass',
    p_startdate  => DATE '2026-04-12',
    p_enddate    => DATE '2026-04-12'
  );

  -- 14: T0002 guide G0002
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => 'G0002',
    p_itemcostid => 'IC0003',
    p_feeamount  => 950,
    p_quantity   => 4,
    p_note       => 'Shopping escort',
    p_startdate  => DATE '2026-04-13',
    p_enddate    => DATE '2026-04-13'
  );

  -- 15: T0003 extra van day
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0003',
    p_guideid    => 'G0003',
    p_itemcostid => 'IC0005',
    p_feeamount  => 3500,
    p_quantity   => 1,
    p_note       => 'Extra CNX van',
    p_startdate  => DATE '2026-02-21',
    p_enddate    => DATE '2026-02-21'
  );

  -- 16: T0003 hotel (ใช้ IC0001 สมมติ rate ต่างประเทศ)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0003',
    p_guideid    => NULL,
    p_itemcostid => 'IC0001',
    p_feeamount  => 5000,
    p_quantity   => 2,
    p_note       => 'Hotel CNX',
    p_startdate  => DATE '2026-02-20',
    p_enddate    => DATE '2026-02-22'
  );

  -- 17: T0004 meals SG
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0004',
    p_guideid    => 'G0005',
    p_itemcostid => 'IC0003',
    p_feeamount  => 850,
    p_quantity   => 4,
    p_note       => 'SG meals',
    p_startdate  => DATE '2026-05-02',
    p_enddate    => DATE '2026-05-02'
  );

  -- 18: T0004 bus SG
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0004',
    p_guideid    => NULL,
    p_itemcostid => 'IC0002',
    p_feeamount  => 26000,
    p_quantity   => 1,
    p_note       => 'SG coach',
    p_startdate  => DATE '2026-05-02',
    p_enddate    => DATE '2026-05-02'
  );

  -- 19: T0005 hotel KR (reuse IC0001 เป็น generic hotel)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0005',
    p_guideid    => 'G0004',
    p_itemcostid => 'IC0001',
    p_feeamount  => 11000,
    p_quantity   => 1,
    p_note       => 'KR hotel',
    p_startdate  => DATE '2026-06-10',
    p_enddate    => DATE '2026-06-14'
  );

  -- 20: T0005 bus KR
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0005',
    p_guideid    => NULL,
    p_itemcostid => 'IC0002',
    p_feeamount  => 30000,
    p_quantity   => 1,
    p_note       => 'KR coach',
    p_startdate  => DATE '2026-06-11',
    p_enddate    => DATE '2026-06-11'
  );

  -- 21: T0005 extra meals
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0005',
    p_guideid    => 'G0004',
    p_itemcostid => 'IC0003',
    p_feeamount  => 950,
    p_quantity   => 4,
    p_note       => 'KR dinners',
    p_startdate  => DATE '2026-06-12',
    p_enddate    => DATE '2026-06-12'
  );

  -- 22: T0001 ground operator (IC0006)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => NULL,
    p_itemcostid => 'IC0006',
    p_feeamount  => 18000,
    p_quantity   => 1,
    p_note       => 'JP ground handling',
    p_startdate  => DATE '2026-03-25',
    p_enddate    => DATE '2026-03-30'
  );

  -- 23: T0002 ground operator
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => NULL,
    p_itemcostid => 'IC0006',
    p_feeamount  => 18500,
    p_quantity   => 1,
    p_note       => 'JP ground handling 2',
    p_startdate  => DATE '2026-04-10',
    p_enddate    => DATE '2026-04-15'
  );

  -- 24: T0003 ground operator TH (reuse IC0006)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0003',
    p_guideid    => NULL,
    p_itemcostid => 'IC0006',
    p_feeamount  => 9000,
    p_quantity   => 1,
    p_note       => 'TH ground',
    p_startdate  => DATE '2026-02-20',
    p_enddate    => DATE '2026-02-22'
  );

  -- 25: T0004 extra handling SG
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0004',
    p_guideid    => 'G0005',
    p_itemcostid => 'IC0006',
    p_feeamount  => 15000,
    p_quantity   => 1,
    p_note       => 'SG ground extra',
    p_startdate  => DATE '2026-05-01',
    p_enddate    => DATE '2026-05-04'
  );

  -- 26: T0006 incentive TH, guide G0003
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0006',
    p_guideid    => 'G0003',
    p_itemcostid => 'IC0005',
    p_feeamount  => 3500,
    p_quantity   => 2,
    p_note       => 'Incentive van',
    p_startdate  => DATE '2026-07-05',
    p_enddate    => DATE '2026-07-07'
  );

  -- 27: T0006 hotel
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0006',
    p_guideid    => NULL,
    p_itemcostid => 'IC0001',
    p_feeamount  => 4500,
    p_quantity   => 2,
    p_note       => 'Incentive hotel',
    p_startdate  => DATE '2026-07-05',
    p_enddate    => DATE '2026-07-07'
  );

  -- 28: T0006 meals
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0006',
    p_guideid    => 'G0003',
    p_itemcostid => 'IC0003',
    p_feeamount  => 600,
    p_quantity   => 3,
    p_note       => 'Incentive meals',
    p_startdate  => DATE '2026-07-06',
    p_enddate    => DATE '2026-07-06'
  );

  -- 29: T0002 extra bus half day
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => NULL,
    p_itemcostid => 'IC0002',
    p_feeamount  => 15000,
    p_quantity   => 1,
    p_note       => 'Half-day coach',
    p_startdate  => DATE '2026-04-14',
    p_enddate    => DATE '2026-04-14'
  );

  -- 30: T0001 extra CNX-style van reuse IC0005
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => 'G0002',
    p_itemcostid => 'IC0005',
    p_feeamount  => 3500,
    p_quantity   => 1,
    p_note       => 'Small group van',
    p_startdate  => DATE '2026-03-29',
    p_enddate    => DATE '2026-03-29'
  );

  -- 31: T0001 small extra meal
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => 'G0001',
    p_itemcostid => 'IC0003',
    p_feeamount  => 600,
    p_quantity   => 3,
    p_note       => 'Snack pack JP1',
    p_startdate  => DATE '2026-03-26',
    p_enddate    => DATE '2026-03-26'
  );

  -- 32: T0001 extra attraction
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => NULL,
    p_itemcostid => 'IC0004',
    p_feeamount  => 3200,
    p_quantity   => 2,
    p_note       => 'Optional attraction JP1',
    p_startdate  => DATE '2026-03-29',
    p_enddate    => DATE '2026-03-29'
  );

  -- 33: T0002 guide overtime
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => 'G0002',
    p_itemcostid => 'IC0005',
    p_feeamount  => 4000,
    p_quantity   => 1,
    p_note       => 'Guide overtime JP2',
    p_startdate  => DATE '2026-04-14',
    p_enddate    => DATE '2026-04-14'
  );

  -- 34: T0002 extra meals
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => 'G0001',
    p_itemcostid => 'IC0003',
    p_feeamount  => 900,
    p_quantity   => 2,
    p_note       => 'Lunch JP2',
    p_startdate  => DATE '2026-04-11',
    p_enddate    => DATE '2026-04-11'
  );

  -- 35: T0003 snack
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0003',
    p_guideid    => 'G0003',
    p_itemcostid => 'IC0003',
    p_feeamount  => 500,
    p_quantity   => 2,
    p_note       => 'Snack CNX',
    p_startdate  => DATE '2026-02-21',
    p_enddate    => DATE '2026-02-21'
  );

  -- 36: T0003 extra hotel night
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0003',
    p_guideid    => NULL,
    p_itemcostid => 'IC0001',
    p_feeamount  => 4500,
    p_quantity   => 1,
    p_note       => 'Pre-night CNX',
    p_startdate  => DATE '2026-02-19',
    p_enddate    => DATE '2026-02-19'
  );

  -- 37: T0004 river cruise
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0004',
    p_guideid    => 'G0005',
    p_itemcostid => 'IC0004',
    p_feeamount  => 3500,
    p_quantity   => 1,
    p_note       => 'River cruise ticket',
    p_startdate  => DATE '2026-05-03',
    p_enddate    => DATE '2026-05-03'
  );

  -- 38: T0004 airport transfer
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0004',
    p_guideid    => NULL,
    p_itemcostid => 'IC0002',
    p_feeamount  => 12000,
    p_quantity   => 1,
    p_note       => 'Airport transfer SG',
    p_startdate  => DATE '2026-05-01',
    p_enddate    => DATE '2026-05-01'
  );

  -- 39: T0005 Nami Island ticket (reuse IC0004)
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0005',
    p_guideid    => NULL,
    p_itemcostid => 'IC0004',
    p_feeamount  => 2800,
    p_quantity   => 4,
    p_note       => 'KR attraction tickets',
    p_startdate  => DATE '2026-06-12',
    p_enddate    => DATE '2026-06-12'
  );

  -- 40: T0005 extra van
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0005',
    p_guideid    => 'G0004',
    p_itemcostid => 'IC0005',
    p_feeamount  => 3600,
    p_quantity   => 1,
    p_note       => 'Extra KR van',
    p_startdate  => DATE '2026-06-13',
    p_enddate    => DATE '2026-06-13'
  );

  -- 41: T0006 team dinner
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0006',
    p_guideid    => 'G0003',
    p_itemcostid => 'IC0003',
    p_feeamount  => 700,
    p_quantity   => 4,
    p_note       => 'Team dinner incentive',
    p_startdate  => DATE '2026-07-06',
    p_enddate    => DATE '2026-07-06'
  );

  -- 42: T0006 city tour bus
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0006',
    p_guideid    => NULL,
    p_itemcostid => 'IC0002',
    p_feeamount  => 18000,
    p_quantity   => 1,
    p_note       => 'Incentive coach',
    p_startdate  => DATE '2026-07-05',
    p_enddate    => DATE '2026-07-05'
  );

  -- 43: T0001 late check-out
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => NULL,
    p_itemcostid => 'IC0001',
    p_feeamount  => 3000,
    p_quantity   => 1,
    p_note       => 'Late check-out hotel',
    p_startdate  => DATE '2026-03-30',
    p_enddate    => DATE '2026-03-30'
  );

  -- 44: T0002 luggage handling
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => 'G0002',
    p_itemcostid => 'IC0005',
    p_feeamount  => 2500,
    p_quantity   => 1,
    p_note       => 'Luggage handling',
    p_startdate  => DATE '2026-04-15',
    p_enddate    => DATE '2026-04-15'
  );

  -- 45: T0003 local show ticket
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0003',
    p_guideid    => 'G0003',
    p_itemcostid => 'IC0004',
    p_feeamount  => 1200,
    p_quantity   => 3,
    p_note       => 'CNX show',
    p_startdate  => DATE '2026-02-21',
    p_enddate    => DATE '2026-02-21'
  );

  -- 46: T0004 extra hotel night
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0004',
    p_guideid    => NULL,
    p_itemcostid => 'IC0001',
    p_feeamount  => 7000,
    p_quantity   => 1,
    p_note       => 'Pre-night SG',
    p_startdate  => DATE '2026-04-30',
    p_enddate    => DATE '2026-04-30'
  );

  -- 47: T0005 night snack
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0005',
    p_guideid    => 'G0004',
    p_itemcostid => 'IC0003',
    p_feeamount  => 400,
    p_quantity   => 3,
    p_note       => 'Night snack KR',
    p_startdate  => DATE '2026-06-11',
    p_enddate    => DATE '2026-06-11'
  );

  -- 48: T0006 optional activity
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0006',
    p_guideid    => NULL,
    p_itemcostid => 'IC0004',
    p_feeamount  => 2000,
    p_quantity   => 2,
    p_note       => 'Optional activity',
    p_startdate  => DATE '2026-07-06',
    p_enddate    => DATE '2026-07-06'
  );

  -- 49: T0001 extra bus hour
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0001',
    p_guideid    => NULL,
    p_itemcostid => 'IC0002',
    p_feeamount  => 8000,
    p_quantity   => 1,
    p_note       => 'Extra bus hour',
    p_startdate  => DATE '2026-03-28',
    p_enddate    => DATE '2026-03-28'
  );

  -- 50: T0002 final dinner upgrade
  pkg_costdetail.sp_cost_add_detail(
    p_tourid     => 'T0002',
    p_guideid    => 'G0001',
    p_itemcostid => 'IC0003',
    p_feeamount  => 1300,
    p_quantity   => 4,
    p_note       => 'Farewell dinner upgrade',
    p_startdate  => DATE '2026-04-15',
    p_enddate    => DATE '2026-04-15'
  );
END;

COMMIT;
