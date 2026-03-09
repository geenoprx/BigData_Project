BEGIN
  -- 1
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 2,
    p_paxchild     => 1,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 2
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 3
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 4
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 4,
    p_paxchild     => 2,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 5 (booking ที่ถูก cancel ก็ใส่ได้, ดีสำหรับ FactBookingStatus)
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 6
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 7
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 8
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 9
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 10
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 11
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 12
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 13
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 3,
    p_paxchild     => 1,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 14
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 15
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 16
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0006',
    p_servdatefrom => DATE '2026-07-05',
    p_servdateto   => DATE '2026-07-07',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 15000,
    p_seqno        => NULL
  );

  -- 17
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 3,
    p_paxchild     => 2,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 18
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 19
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 20
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 21
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 22
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 23
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 2,
    p_paxchild     => 1,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 24
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 3,
    p_paxchild     => 0,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 25
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 2,
    p_paxchild     => 2,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 26
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 2,
    p_paxchild     => 1,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 27
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 3,
    p_paxchild     => 0,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 28
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 29
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0006',
    p_servdatefrom => DATE '2026-07-05',
    p_servdateto   => DATE '2026-07-07',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 15000,
    p_seqno        => NULL
  );

  -- 30
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0006',
    p_servdatefrom => DATE '2026-07-05',
    p_servdateto   => DATE '2026-07-07',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 15000,
    p_seqno        => NULL
  );

  -- 31
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 32
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0006',
    p_servdatefrom => DATE '2026-07-05',
    p_servdateto   => DATE '2026-07-07',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 15000,
    p_seqno        => NULL
  );

  -- 33
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 2,
    p_paxchild     => 2,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 34
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0006',
    p_servdatefrom => DATE '2026-07-05',
    p_servdateto   => DATE '2026-07-07',
    p_paxadult     => 3,
    p_paxchild     => 0,
    p_unitprice    => 15000,
    p_seqno        => NULL
  );

  -- 35
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 36
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 2,
    p_paxchild     => 1,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 37
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 38
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 39
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 40
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 41
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 1,
    p_paxchild     => 2,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 42
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 3,
    p_paxchild     => 1,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 43
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 44
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0006',
    p_servdatefrom => DATE '2026-07-05',
    p_servdateto   => DATE '2026-07-07',
    p_paxadult     => 2,
    p_paxchild     => 1,
    p_unitprice    => 15000,
    p_seqno        => NULL
  );

  -- 45
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0001',
    p_tourid       => 'T0004',
    p_servdatefrom => DATE '2026-05-01',
    p_servdateto   => DATE '2026-05-04',
    p_paxadult     => 1,
    p_paxchild     => 0,
    p_unitprice    => 22000,
    p_seqno        => NULL
  );

  -- 46
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0002',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 1,
    p_paxchild     => 1,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );

  -- 47
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0003',
    p_tourid       => 'T0005',
    p_servdatefrom => DATE '2026-06-10',
    p_servdateto   => DATE '2026-06-14',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 25000,
    p_seqno        => NULL
  );

  -- 48
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0004',
    p_tourid       => 'T0001',
    p_servdatefrom => DATE '2026-03-25',
    p_servdateto   => DATE '2026-03-30',
    p_paxadult     => 2,
    p_paxchild     => 0,
    p_unitprice    => 150000,
    p_seqno        => NULL
  );

  -- 49
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0005',
    p_tourid       => 'T0002',
    p_servdatefrom => DATE '2026-04-10',
    p_servdateto   => DATE '2026-04-15',
    p_paxadult     => 2,
    p_paxchild     => 2,
    p_unitprice    => 160000,
    p_seqno        => NULL
  );

  -- 50
  pkg_bookingdetail.sp_booking_add_detail(
    p_bookingid    => 'BK0006',
    p_tourid       => 'T0003',
    p_servdatefrom => DATE '2026-02-20',
    p_servdateto   => DATE '2026-02-22',
    p_paxadult     => 1,
    p_paxchild     => 2,
    p_unitprice    => 5900,
    p_seqno        => NULL
  );
END;

COMMIT;
