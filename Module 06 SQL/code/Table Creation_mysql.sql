DROP DATABASE IF EXISTS Module06;

CREATE DATABASE Module06;

USE Module06;

CREATE TABLE Passenger (
	PassengerNo		int,
    PassengerName 	nvarchar(10),
    Grade 			int,
    Age 			int,
    
    CONSTRAINT pk_Passenger PRIMARY KEY(PassengerNo)
);

CREATE TABLE Aircraft (
	AircraftNo		int,
    KindOfAircraft 	nvarchar(30),
    Airline 		nvarchar(20),
    
    CONSTRAINT pk_Aircraft PRIMARY KEY(AircraftNo)
);

CREATE TABLE Flight (
	FlightNo 	int,
    AircraftNo 	int,
    Depareture 	nvarchar(20),
    Arrival 	nvarchar(20),
    Price		int,
    FlightDate 	datetime,
    
    CONSTRAINT pk_Flight PRIMARY KEY(FlightNo),
    CONSTRAINT fk_Flight_Aircraft FOREIGN KEY(AircraftNo) REFERENCES Aircraft(AircraftNo)
);

CREATE TABLE Reservation (
	PassengerNo 	int,
    FlightNo 		int,
    ReservedDate 	date,
    
    CONSTRAINT pk_Reservation PRIMARY KEY(PassengerNo, FlightNo),
    CONSTRAINT fk_Reservation_Passenger FOREIGN KEY(PassengerNo) REFERENCES Passenger(PassengerNo),
    CONSTRAINT fk_Reservation_Flight FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo)
);

INSERT INTO Passenger VALUES (1, '홍길동', 1, 44);
INSERT INTO Passenger VALUES (2, '이순신', 10, 44);
INSERT INTO Passenger VALUES (3, '안중근', 7, NULL);
INSERT INTO Passenger VALUES (4, '김영랑', 9, 54);
INSERT INTO Passenger VALUES (5, '김소월', 9, 45);
INSERT INTO Passenger VALUES (6, '윤동주', 10, 26);
INSERT INTO Passenger VALUES (7, '천상병', 8, 55);

INSERT INTO Aircraft VALUES(101, '보잉 747', '대한항공');
INSERT INTO Aircraft VALUES(102, '보잉 727', '대한항공');
INSERT INTO Aircraft VALUES(103, '에어버스 A380', '아시아나 항공');
INSERT INTO Aircraft VALUES(104, '에어버스 A300', '대한항공');
INSERT INTO Aircraft VALUES(105, '보잉 737-800', '제주항공');

INSERT INTO Flight VALUES(1, 101, '인천', '샌프란시스코', 1230000, '2022-10-23 10:20:00');
INSERT INTO Flight VALUES(2, 101, '샌프란시스코', '인천', 1320000, '2022-10-26 13:00:00');
INSERT INTO Flight VALUES(3, 105, '김포', '제주', 72000,  '2022-11-23 09:00:00');
INSERT INTO Flight VALUES(4, 104, '김포', '김해', 68000, '2022-11-12 17:30:00');
INSERT INTO Flight VALUES(5, 103, '인천', '프랑크푸르트', 1480000, '2022-12-01 18:00:00');
INSERT INTO Flight VALUES(6, 103, '프랑크푸르트', '인천', 1560000, '2022-12-10 10:00:00');
INSERT INTO Flight VALUES(7, 104, '김해', '김포', 70000, '2022-11-13 11:00:00');
INSERT INTO Flight VALUES(8, 101, '인천', '샌프란시스코', 12300000,  '2022-11-15 10:00:00');

INSERT INTO Reservation VALUES (1, 4, '2022-10-22');
INSERT INTO Reservation VALUES (3, 1, '2022-10-20');
INSERT INTO Reservation VALUES (4, 7, '2022-10-11');
INSERT INTO Reservation VALUES (6, 6, '2022-10-21');
INSERT INTO Reservation VALUES (2, 1, '2022-10-11');
INSERT INTO Reservation VALUES (2, 2, '2022-10-11');
INSERT INTO Reservation VALUES (7, 3, '2022-09-11');
INSERT INTO Reservation VALUES (1, 3, '2022-11-09');