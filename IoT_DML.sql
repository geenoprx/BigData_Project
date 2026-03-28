-- Seed data: IoTDeviceType
INSERT INTO IoTDeviceType (DevTypeID, DevTypeName, Description)
VALUES ('DVT001', 'GPS Vehicle',   'GPS tracker installed on tour buses and vans');
INSERT INTO IoTDeviceType (DevTypeID, DevTypeName, Description)
VALUES ('DVT002', 'Wristband',     'NFC/BLE wristband issued to tourists for check-in scanning');
INSERT INTO IoTDeviceType (DevTypeID, DevTypeName, Description)
VALUES ('DVT003', 'Env Sensor',    'Environmental sensor measuring temperature and humidity');
INSERT INTO IoTDeviceType (DevTypeID, DevTypeName, Description)
VALUES ('DVT004', 'Gate Scanner',  'Entry/exit gate scanner for headcount at attractions');

-- Seed data: IoTLocation
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC001', 'Suvarnabhumi Airport',    'CTY001', 'AIRPORT',    13.6900,  100.7501, 'Bangkok international departure hub');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC002', 'Narita Airport',          'CTY002', 'AIRPORT',    35.7720,  140.3929, 'Tokyo main international airport');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC003', 'Senso-ji Temple',         'CTY002', 'ATTRACTION', 35.7148,  139.7967, 'Famous Buddhist temple in Asakusa, Tokyo');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC004', 'Osaka Castle',            'CTY002', 'ATTRACTION', 34.6873,  135.5262, 'Historic castle and park in Osaka');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC005', 'Hotel Sunroute Tokyo',    'CTY002', 'HOTEL',      35.6895,  139.6917, 'Group hotel in Shinjuku, Tokyo');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC006', 'Doi Inthanon Peak',       'CTY001', 'ATTRACTION', 18.5877,  98.4864,  'Highest mountain in Thailand');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC007', 'Gardens by the Bay',      'CTY004', 'ATTRACTION', 1.2816,   103.8636, 'Iconic nature park in Singapore');
INSERT INTO IoTLocation (LocationID, LocationName, CountryID, ZoneType, Latitude, Longitude, Description)
VALUES ('LOC008', 'Incheon Airport',         'CTY003', 'AIRPORT',    37.4602,  126.4407, 'Seoul main international airport');

-- Seed data: IoTDevice
INSERT INTO IoTDevice (DeviceID, DevTypeID, DeviceName, Status, InstalledAt)
VALUES ('DEV-JP01-G',  'DVT001', 'GPS Bus JP Tokyo Run-1',   'A', DATE '2026-03-20');
INSERT INTO IoTDevice (DeviceID, DevTypeID, DeviceName, Status, InstalledAt)
VALUES ('DEV-JP02-G',  'DVT001', 'GPS Bus JP Tokyo Run-2',   'A', DATE '2026-04-05');
INSERT INTO IoTDevice (DeviceID, DevTypeID, DeviceName, Status, InstalledAt)
VALUES ('DEV-JP01-W',  'DVT002', 'Wristband Gate JP Run-1',  'A', DATE '2026-03-20');
INSERT INTO IoTDevice (DeviceID, DevTypeID, DeviceName, Status, InstalledAt)
VALUES ('DEV-CNX01-E', 'DVT003', 'Env Sensor Doi Inthanon',  'A', DATE '2026-02-18');
INSERT INTO IoTDevice (DeviceID, DevTypeID, DeviceName, Status, InstalledAt)
VALUES ('DEV-CNX01-S', 'DVT004', 'Gate Scanner CNX Run-1',   'A', DATE '2026-02-18');
INSERT INTO IoTDevice (DeviceID, DevTypeID, DeviceName, Status, InstalledAt)
VALUES ('DEV-SG01-G',  'DVT001', 'GPS Van SG FreeEzy',       'A', DATE '2026-04-28');

-- Seed data: ReadingType
INSERT INTO ReadingType (ReadingTypeID, ReadingTypeName, Unit, Description)
VALUES ('RT001', 'Temperature', '°C',    'Ambient air temperature');
INSERT INTO ReadingType (ReadingTypeID, ReadingTypeName, Unit, Description)
VALUES ('RT002', 'Humidity',    '%',     'Relative humidity');
INSERT INTO ReadingType (ReadingTypeID, ReadingTypeName, Unit, Description)
VALUES ('RT003', 'Pax Count',   'people','Number of tourists counted at a location');
COMMIT;