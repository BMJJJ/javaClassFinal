show tables;

create table photoGallery(
	idx int not null auto_increment,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	title varchar(20) not null,
	content text not null,
	expl text not null,
	readNum int default 0,
	pDate datetime default now(),
	thumbnail	varchar(50) not null,			/* 포토갤러리에 올린 사진 이름 */
	good int default 0,
	part varchar(20) not null,
	photoCount 	int not null,
	primary key(idx),
	foreign key(mid) references member(mid)
);

drop table photoGallery;
select pg.*,(select fSName from photoStorage where photoIdx=pg.idx limit 1) as fSName from photoGallery pg order by pg.idx desc;
select pg.*,(select fSName from photoStorage where photoIdx=pg.idx limit 1) as fSName, (select count(*) as replyCnt from photoReply where photoIdx=pg.idx) from photoGallery pg order by pg.idx desc;

 UPDATE photoGallery SET good = good + 1 WHERE idx = 14;

 /*버전1*/
create table photoReply (
  idx  int not null auto_increment,
  mid   varchar(20) not null,				/* 포토갤러리에 댓글 올린이 아이디 */
  photoIdx int not null,						/* 포토갤러리 고유번호 */
  content  text not null,						/* 포토갤러리 댓글 내용 */
  prDate   datetime default now(),	/* 댓글 입력일자 */
  primary key(idx),
  foreign key(photoIdx) references photoGallery(idx),
  foreign key(mid) references member(mid)
);
/*버전2*/
create table photoReply (
  idx  int not null auto_increment,
  photoIdx int not null,						/* 포토갤러리 고유번호 */
  re_step   int not null,						/* 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다. 대댓글의 경우는 '부모re_step+1'로 처리한다. */
  re_order  int not null,						/* 댓글의 순서를 결정한다. 부모댓글을 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글은 re_order+1 처리하고, 자신은 부모댓글의 re_order보다 +1 처리한다.*/  
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  prDate		datetime	default now(),/* 댓글 올린 날짜/시간 */
  content		text not null,					/* 댓글 내용 */
  openSw char(2) default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
  primary key(idx),
  foreign key(photoIdx) references photoGallery(idx),
  foreign key(mid) references member(mid)
);
drop table photoReply;
select * from photoReply;

create table photoSingle (
  photo  varchar(50) not null
);


create table photoGood(
	idx int not null auto_increment,
	midIdx   varchar(20) not null,				
	photoIdx int not null,						
	primary key(idx),
	foreign key(photoIdx) references photoGallery(idx),
	foreign key(midIdx) references member(mid)
);

SELECT * FROM photoGood WHERE photoIdx = 14 AND midIdx = 1;

drop table photoGood;



