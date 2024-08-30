create table parks(
	idx int not null auto_increment,
	parkName varchar(50) not null,
	location varchar(100) not null,
	expl text not null,
	primary key(idx)
);
drop table parks;

create table national(
	idx int not null auto_increment,
	title varchar(20) not null,	/* 지역명 */
	nPeople int not null,/*탐방 인원수*/
	content text not null,/*특이사항*/
	photo text not null,/*홍보사진,참고사진,ckeditor*/
	course varchar(50) not null,/*코스명(행사명)*/
	part  varchar(10) not null,/*산책로,탐방로(산),탐방로(해안),*/
	/* noneDate varchar(100),*/ /*비개방날짜,정비,우천,눈*/
	primary key(idx)
);

drop table national;

select * from national where part = '탐방로(산)' order by idx desc;
select * from national where part = '탐방로(해안)' order by idx desc;
select * from national order by idx desc;

insert into national values (default,'경기도',100,'음식물반입금지','','우이동 경관 둘레길','산책로');
insert into national values (default,'강원도',70,'애완견 동반 가능','','정동진 부채길','탐방로(해안)');
insert into national values (default,'강원도',70,'취사가능','','평창 운탄고도 하늘길','탐방로(산)');
insert into national values (default,'경기도',120,'취식금지','','광명시 천연동굴','산책로');
insert into national values (default,'충청도',80,'다양한 포토존 제공','','단양 느림보 강물길','산책로');
insert into national values (default,'경기도',120,'쉬운마루길','','안양천 국화길','산책로');

select * from national;
select date_format(now(), '%Y-%m-%d');
select date_format(noneDate, '%Y-%m-%d') from national;
select * from national where noneDate like concat('%',date_format(now(), '%Y-%m-%d'),'%');
select * from national where part like '%탐%';
select * from national where noneDate like '%2024%';
select *,count(part) as partCnt from national group by part order by part;
select part,count(part) as partCnt from national group by part order by part;
select part,count(part) as partCnt from national where noneDate not like concat('%',date_format(now(), '%Y-%m-%d'),'%') group by part order by part;




	searchNearby text not null,/*ckeditor*/
insert into national values (default, '경복궁', '50', '서울 도심에서 맛볼 수 있는 역사와 문화가 고르게 어우러진 코스이다.
경복궁 내부의 여러 전각을 둘러보고 고풍스런 담장길을 따라 걷다 푸른 기와가 상징처럼 알려진 청와대의 앞길을 걸어 삼청동 카페길에 다다른다.
이후 서울성곽까지도 갈 수 있는 삼청공원을 산책한 후 서울에서 가장 한옥이 잘 보존되어 있다는 북촌한옥마을의 고즈넉한 길을 밟는다.
서울 도심에 이런 역사와 문화가 깃든 길이 있다는 것이 내내 감사할 따름이다.','','둘레길','산책로','눈');

insert into national values (default, '오크벨리 숨길', '50', '오크밸리 산책로는 탁 트인 오크밸리 CC 골프장과 참나무 숲으로 둘러싸인 파노라마 뷰를 바라보며 산책을 즐길 수 있다. 경사도가 높지 않아 편안하게 걸으며 재충전의 시간을 가질 수 있다.','','월요일길','산책로','눈');


drop table national;

/*예약 테이블*/
create table schedule (
  idx   int not null auto_increment,	/* 스케줄관리 고유번호 */
	nationalIdx int not null,						/* 방문지 고유번호 */
	course varchar(50) not null,				/*코스명(행사명)*/
  mid   varchar(20) not null,					/* 회원 아이디(일정검색시 필요) */
	visitDate datetime not null,
  visitCnt int not null,							/*방문인원수*/
  content text not null,							/* 특이사항 */
  visitCheck char(2) not null default 'NO',
  primary key(idx),
  foreign key(mid) references member(mid),
	foreign key(nationalIdx) references national(idx)
);
drop table schedule;

insert into schedule values (default,1,'우이동 경관 둘레길','admin','2024-08-31',3,'잘부탁드려요','NO');
insert into schedule values (default,2,'정동진 부채길','admin','2024-08-30',5,'잘부탁드려요2','NO');
insert into schedule values (default,2,'정동진 부채길','admin','2024-08-30',2,'부부가 갑니다.','NO');
insert into schedule values (default,4,'광명시 천연동굴','admin','2024-08-30',5,'친구모임으로 갑니다.','NO');
insert into schedule values (default,1,'우이동 경관 둘레길','hkd1234','2024-08-30',5,'가 볼까요?','NO');
insert into schedule values (default,1,'우이동 경관 둘레길','kms1234','2024-08-30',2,'우리도 갑니다.','NO');

select * from schedule;
select course,sum(visitCnt) as allVisitCnt from schedule where visitDate = '2024-8-30';
select course,sum(visitCnt) as allVisitCnt from schedule where visitDate = '2024-8-30' group by course;


drop table schedule;


/* 비개방일자 등록테이블 */
create table noneVisit(
  idx int not null auto_increment primary key,
  nationalIdx int not null,							/* 탐방지 고유번호 */
  noneDate datetime default now(), 			/*비개방날짜,정비,우천,눈*/
  foreign key(nationalIdx) references national(idx)
);
drop table noneVisit;

insert into noneVisit values (default, 2, '2024-08-01');
insert into noneVisit values (default, 2, '2024-08-05');
insert into noneVisit values (default, 4, '2024-07-31');
insert into noneVisit values (default, 4, '2024-08-01');
insert into noneVisit values (default, 4, '2024-08-09');
insert into noneVisit values (default, 6, '2024-08-03');
insert into noneVisit values (default, 6, '2024-08-10');
insert into noneVisit values (default, 6, '2024-08-15');
insert into noneVisit values (default, 6, '2024-07-31');

select * from noneVisit;

select * from noneVisit v order by noneDate;
select *,(select part from national where idx = v.nationalIdx) as part from noneVisit v order by noneDate;
select *,(select part from national where idx = v.nationalIdx) as part from noneVisit v group by noneDate,part  order by noneDate;
select *,(select part from national where idx = v.nationalIdx) as part,count(*) as partCnt from noneVisit v group by noneDate,part  order by noneDate;
select *,(select part from national where idx = v.nationalIdx) as part,count(*) as partCnt from noneVisit v where date_format(noneDate,"%Y-%m") = '2024-08' group by noneDate,part  order by noneDate,part;

select * from national order by part;
select *,count(*) as partCnt from national group by part order by part;

select ifnull(visitCnt, 0) from schedule where nationalIdx = 4 and visitDate = '2024-8-1';