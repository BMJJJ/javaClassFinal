show tables;

create table kakaoAddress (
	address varchar(50) not null,	/* 지점명*/
	latitude double null,					/*위도*/
	longitude double not null,			/*경도*/
	content text not null
);

desc kakaoAddress;
drop table kakaoAddress;

select * from kakaoAddress order by address;

delete from kakaoAddress where address = '제주도';
select * from kakaoAddress where address = '제주도';

create table bicycle(
	rackTotCnt varchar(50) null, /* 거치대개수 */
	stationName varchar(100) not null, /* 대여소이름 */
	parkingBikeTotCnt varchar(50) null, /* 자전거주차총건수 */
	shared varchar(50) null, /* 거치율 */
	stationLatitude double null, /* 위도 */
	stationLongitude double not null, /* 경도 */
	stationId varchar(50) not null, /* 대여소ID */
);

create table bicycleStore(
	bcyclLendNm varchar(100) null, /* 자전거대여소명 */
	bcyclLendSe varchar(50) null, /* 자전거대여소구분 */
	rdnmadr varchar(200) null, /* 소재지도로명주소 */
	lnmadr varchar(200) null, /* 소재지지번주소 */
	latitude double null, /* 위도 */
	longitude double not null, /* 경도 */
	operOpenHm varchar(50) null, /* 운영시작시각 */
	operCloseHm varchar(50) null, /* 운영종료시각 */
	rstde varchar(50) null, /* 휴무일 */
	chrgeSe varchar(50) null, /* 요금구분 */
	bcyclUseCharge varchar(50) null, /* 자전거이용요금 */
	bcyclHoldCharge varchar(50) null, /* 자전거보유대수 */
	holderCo varchar(50) null, /* 거치대수 */
	airInjectorYn varchar(5) null, /* 공기주입기비치여부 */
	airInjectorType varchar(50) null, /* 공기주입기유형 */
	repairStandYn varchar(5) null, /* 수리대설치여부 */
	phoneNumber varchar(50) null, /* 관리기관전화번호 */
	institutionNm varchar(100) null, /* 관리기관명 */
	referenceDate DATE null, /* 데이터기준일자 */
	insttCode varchar(50) null /* 제공기관코드 */
);
