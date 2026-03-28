-- DML: seed BookingDetail records via pkg_bookingdetail.sp_booking_add_detail
BEGIN
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
