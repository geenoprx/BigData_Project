BEGIN
  ------------------------------------------------------------------
  -- T0001 JP Tokyo-Osaka 6D (TPJP6D01) : 6 วัน
  ------------------------------------------------------------------
  -- 1
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Day 1: BKK - Narita',
    p_description   => 'Flight from BKK to Tokyo, transfer to hotel',
    p_meal          => 'D',
    p_hotelname     => 'Narita View Hotel',
    p_transportnote => 'Plane / Coach'
  );

  -- 2
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Day 2: Tokyo City Tour',
    p_description   => 'Asakusa, Skytree view, Shibuya crossing',
    p_meal          => 'B,L,D',
    p_hotelname     => 'Sunshine City Prince',
    p_transportnote => 'Coach'
  );

  -- 3
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Day 3: Mt.Fuji & Hakone',
    p_description   => 'Lake Ashi cruise, Owakudani, outlet',
    p_meal          => 'B,L',
    p_hotelname     => 'Hakone Hotel',
    p_transportnote => 'Coach'
  );

  -- 4
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Day 4: Tokyo Free Time',
    p_description   => 'Shopping Shinjuku/Shibuya',
    p_meal          => 'B',
    p_hotelname     => 'Sunshine City Prince',
    p_transportnote => 'Coach / own'
  );

  -- 5
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Day 5: Tokyo - Osaka',
    p_description   => 'Bullet train to Osaka, Dotonbori',
    p_meal          => 'B',
    p_hotelname     => 'Osaka City Hotel',
    p_transportnote => 'Shinkansen'
  );

  -- 6
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Day 6: Osaka - BKK',
    p_description   => 'Free time then flight back to BKK',
    p_meal          => 'B',
    p_hotelname     => 'On board',
    p_transportnote => 'Plane'
  );

  ------------------------------------------------------------------
  -- T0002 JP Tokyo-Osaka 6D Autumn (TPJP6D02) : 6 วัน
  ------------------------------------------------------------------
  -- 7
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Day 1: BKK - Tokyo Autumn',
    p_description   => 'Arrive Tokyo, autumn foliage',
    p_meal          => 'D',
    p_hotelname     => 'Narita View Hotel',
    p_transportnote => 'Plane / Coach'
  );

  -- 8
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Day 2: Autumn Tokyo City',
    p_description   => 'Meiji Shrine, Harajuku, Omotesando',
    p_meal          => 'B,L,D',
    p_hotelname     => 'Tokyo Hotel',
    p_transportnote => 'Coach'
  );

  -- 9
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Day 3: Fuji Autumn View',
    p_description   => 'Kawaguchiko, ropeway, momiji',
    p_meal          => 'B,L',
    p_hotelname     => 'Fuji Hotel',
    p_transportnote => 'Coach'
  );

  -- 10
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Day 4: Tokyo Free & Easy',
    p_description   => 'Shopping and chill',
    p_meal          => 'B',
    p_hotelname     => 'Tokyo Hotel',
    p_transportnote => 'Own'
  );

  -- 11
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Day 5: Tokyo - Osaka Autumn',
    p_description   => 'Bullet train to Osaka',
    p_meal          => 'B',
    p_hotelname     => 'Osaka Hotel',
    p_transportnote => 'Shinkansen'
  );

  -- 12
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Day 6: Osaka - BKK',
    p_description   => 'Outlet shopping, fly back',
    p_meal          => 'B',
    p_hotelname     => 'On board',
    p_transportnote => 'Plane'
  );

  ------------------------------------------------------------------
  -- T0003 CNX 3D Highlight (TPCNX3D1) : 3 วัน
  ------------------------------------------------------------------
  -- 13
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0003',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Day 1: BKK - CNX City',
    p_description   => 'Check in, city tour, temples',
    p_meal          => 'L,D',
    p_hotelname     => 'Chiang Mai Hotel',
    p_transportnote => 'Plane / Van'
  );

  -- 14
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0003',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Day 2: Doi Inthanon',
    p_description   => 'Summit, twin pagoda, waterfall',
    p_meal          => 'B,L',
    p_hotelname     => 'Chiang Mai Hotel',
    p_transportnote => 'Van'
  );

  -- 15
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0003',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Day 3: Local Market - BKK',
    p_description   => 'Warorot market, fly back',
    p_meal          => 'B',
    p_hotelname     => 'On board',
    p_transportnote => 'Plane'
  );

  ------------------------------------------------------------------
  -- T0004 SG 4D Free & Easy (TPSG4D01) : 4 วัน
  ------------------------------------------------------------------
  -- 16
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Day 1: BKK - Singapore',
    p_description   => 'City orientation, Merlion',
    p_meal          => 'D',
    p_hotelname     => 'Singapore City Hotel',
    p_transportnote => 'Plane / Coach'
  );

  -- 17
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Day 2: Sentosa & Universal',
    p_description   => 'Full day theme park',
    p_meal          => 'B',
    p_hotelname     => 'Singapore City Hotel',
    p_transportnote => 'Coach'
  );

  -- 18
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Day 3: Free & Easy',
    p_description   => 'Shopping Orchard / Marina',
    p_meal          => 'B',
    p_hotelname     => 'Singapore City Hotel',
    p_transportnote => 'Own'
  );

  -- 19
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Day 4: SG - BKK',
    p_description   => 'Free time then fly back',
    p_meal          => 'B',
    p_hotelname     => 'On board',
    p_transportnote => 'Plane'
  );

  ------------------------------------------------------------------
  -- T0005 KR Seoul-Jeju 5D (TPKR5D01) : 5 วัน
  ------------------------------------------------------------------
  -- 20
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Day 1: BKK - Seoul',
    p_description   => 'Arrive, Namsan Tower night view',
    p_meal          => 'D',
    p_hotelname     => 'Seoul Hotel',
    p_transportnote => 'Plane / Coach'
  );

  -- 21
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Day 2: Seoul City & Palace',
    p_description   => 'Gyeongbokgung, Bukchon, Myeongdong',
    p_meal          => 'B,L',
    p_hotelname     => 'Seoul Hotel',
    p_transportnote => 'Coach'
  );

  -- 22
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Day 3: Seoul - Jeju',
    p_description   => 'Flight to Jeju, Yongduam Rock',
    p_meal          => 'B,D',
    p_hotelname     => 'Jeju Hotel',
    p_transportnote => 'Plane / Coach'
  );

  -- 23
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Day 4: Jeju Highlights',
    p_description   => 'Seongsan, folk village',
    p_meal          => 'B,L',
    p_hotelname     => 'Jeju Hotel',
    p_transportnote => 'Coach'
  );

  -- 24
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Day 5: Jeju - Seoul - BKK',
    p_description   => 'Transfer and fly back',
    p_meal          => 'B',
    p_hotelname     => 'On board',
    p_transportnote => 'Plane'
  );

  ------------------------------------------------------------------
  -- T0006 Incentive TH 3D (ใช้ TPCNX3D1 เป็นแผนพื้นฐาน) : 3 วัน
  ------------------------------------------------------------------
  -- 25
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0006',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Day 1: Incentive arrival',
    p_description   => 'Workshop + welcome dinner',
    p_meal          => 'L,D',
    p_hotelname     => 'Bangkok Hotel',
    p_transportnote => 'Coach'
  );

  -- 26
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0006',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Day 2: Team building',
    p_description   => 'Outdoor activities & gala',
    p_meal          => 'B,L,D',
    p_hotelname     => 'Bangkok Hotel',
    p_transportnote => 'Coach'
  );

  -- 27
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0006',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Day 3: Check-out',
    p_description   => 'Half-day city tour + depart',
    p_meal          => 'B',
    p_hotelname     => 'On board',
    p_transportnote => 'Coach / Plane'
  );

  ------------------------------------------------------------------
  -- เพิ่ม variation ย่อย ๆ ให้แต่ละทัวร์มี detail เพิ่ม (จนครบ ~50)
  ------------------------------------------------------------------
  -- 28: Extra optional tour day in T0001
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Optional: Disney day',
    p_description   => 'Tokyo Disney resort (optional)',
    p_meal          => 'None',
    p_hotelname     => 'Tokyo Hotel',
    p_transportnote => 'Own'
  );

  -- 29
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Optional: Onsen night',
    p_description   => 'Onsen experience',
    p_meal          => 'None',
    p_hotelname     => 'Ryokan',
    p_transportnote => 'Coach'
  );

  -- 30: extra CNX options
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0003',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Optional: Night bazaar',
    p_description   => 'Chiang Mai night market',
    p_meal          => 'None',
    p_hotelname     => 'Chiang Mai Hotel',
    p_transportnote => 'Own'
  );

  -- 31
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0003',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Optional: Elephant camp',
    p_description   => 'Half-day visit',
    p_meal          => 'L',
    p_hotelname     => 'Chiang Mai Hotel',
    p_transportnote => 'Van'
  );

  -- 32: SG optional
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Optional: Night safari',
    p_description   => 'Singapore night safari',
    p_meal          => 'None',
    p_hotelname     => 'Singapore City Hotel',
    p_transportnote => 'Coach'
  );

  -- 33
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Optional: Garden by the Bay',
    p_description   => 'Light show',
    p_meal          => 'None',
    p_hotelname     => 'Singapore City Hotel',
    p_transportnote => 'Own'
  );

  -- 34: KR optional
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Optional: Nami Island',
    p_description   => 'Day trip from Seoul',
    p_meal          => 'L',
    p_hotelname     => 'Seoul Hotel',
    p_transportnote => 'Coach'
  );

  -- 35
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Optional: K-pop experience',
    p_description   => 'Dance class & studio visit',
    p_meal          => 'None',
    p_hotelname     => 'Seoul Hotel',
    p_transportnote => 'Coach'
  );

  -- 36–50: เติม extra free time / shopping slots สลับทัวร์
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Free time Shinjuku',
    p_description   => 'Evening shopping',
    p_meal          => 'None',
    p_hotelname     => 'Sunshine City Prince',
    p_transportnote => 'Own'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0001',
    p_tourplanid    => 'TPJP6D01',
    p_title         => 'Free time Osaka',
    p_description   => 'Dotonbori night',
    p_meal          => 'None',
    p_hotelname     => 'Osaka City Hotel',
    p_transportnote => 'Own'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Autumn leaves photo stop',
    p_description   => 'Photo shooting spot',
    p_meal          => 'None',
    p_hotelname     => 'Tokyo Hotel',
    p_transportnote => 'Coach'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0002',
    p_tourplanid    => 'TPJP6D02',
    p_title         => 'Free night Tokyo',
    p_description   => 'Explore city by yourself',
    p_meal          => 'None',
    p_hotelname     => 'Tokyo Hotel',
    p_transportnote => 'Own'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0003',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Cafe hopping',
    p_description   => 'Local cafes CNX',
    p_meal          => 'None',
    p_hotelname     => 'Chiang Mai Hotel',
    p_transportnote => 'Own'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0004',
    p_tourplanid    => 'TPSG4D01',
    p_title         => 'Chinatown food tour',
    p_description   => 'Street food exploration',
    p_meal          => 'D',
    p_hotelname     => 'Singapore City Hotel',
    p_transportnote => 'Coach'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0005',
    p_tourplanid    => 'TPKR5D01',
    p_title         => 'Korean BBQ night',
    p_description   => 'BBQ dinner with group',
    p_meal          => 'D',
    p_hotelname     => 'Seoul Hotel',
    p_transportnote => 'Own'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0006',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Optional: Spa session',
    p_description   => 'Team relax program',
    p_meal          => 'None',
    p_hotelname     => 'Bangkok Hotel',
    p_transportnote => 'Own'
  );

  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0006',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Optional: Dinner cruise',
    p_description   => 'Chao Phraya river cruise',
    p_meal          => 'D',
    p_hotelname     => 'Bangkok Hotel',
    p_transportnote => 'Coach'
  );
  
  pkg_tourdetail.sp_tour_add_detail(
    p_tourid        => 'T0006',
    p_tourplanid    => 'TPCNX3D1',
    p_title         => 'Extra city sightseeing',
    p_description   => 'Bangkok highlights',
    p_meal          => 'L',
    p_hotelname     => 'Bangkok Hotel',
    p_transportnote => 'Coach'
  );
END;

COMMIT;
