show tables;

/* 대분류(main) */
create table categoryMain(
  categoryMainCode  char(1)  not null,		/* 대분류코드(A,B,C,...) => 영문 대문자 1자(중복불허) */
  categoryMainName  varchar(20) not null, /* 대분류명(회사명 => 삼성/현대/LG...(중복불허) */
  primary key(categoryMainCode),
  unique key(categoryMainName)
);

/* 중분류(middle) */
create table categoryMiddle(
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드(01,02,03,...) => 문자형 숫자 2자(중복불허) */
  categoryMiddleName  varchar(20) not null, /* 중분류명(제품분류명 => 전자제품/생활가전/차종/의류/신발류...(중복불허) */
  primary key(categoryMiddleCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode)
);

/* 소분류(sub) */
create table categorySub(
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드를 외래키로 지정 */
  categorySubCode  char(3)  not null,				/* 소분류코드(001,002,003,...) => 문자형 숫자 2자(중복불허) */
  categorySubName  varchar(20) not null, 		/* 소분류명(상품구분 => 중분류가 전자제품이라면? 냉장고/에어컨/오디오/TV */
  primary key(categorySubCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);
