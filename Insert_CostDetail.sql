-- DML: seed CostDetail records via pkg_costdetail.sp_cost_add_detail
BEGIN
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
