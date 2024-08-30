show tables;

create table board2(
	idx int not null auto_increment,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	title varchar(20) not null,
	content text not null,
	readNum int default 0,
	hostIp varchar(40) not null,
	openSw char(2) default 'Ok',
	wDate datetime default now(),
	good int default 0,
	complaint char(2) default 'NO',
	part varchar(20) not null,
	primary key(idx),
	foreign key(mid) references member(mid)
);

drop table board2;

insert into board2 values (default,'admin','관리맨','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.50.69',default,default,default,default,'공지사항');
insert into board2 values (default,'admin','관리맨','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.50.69',default,default,default,default,'자유게시판');
insert into board2 values (default,'admin','관리맨','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.50.69',default,default,default,default,'자유게시판');

update board2 set complaint = 'OK' where idx = 8;

select * from board2 where complaint='OK' order by idx desc;

select count(*) from board2 where complaint='OK' order by idx desc;

create table boardReply2 (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  boardIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  re_step   int not null,						/* 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다. 대댓글의 경우는 '부모re_step+1'로 처리한다. */
  re_order  int not null,						/* 댓글의 순서를 결정한다. 부모댓글을 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글은 re_order+1 처리하고, 자신은 부모댓글의 re_order보다 +1 처리한다.*/  
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  nickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  wDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  content		text not null,					/* 댓글 내용 */
  openSw char(2) default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
  primary key(idx),
  foreign key(boardIdx) references board2(idx)
  on update cascade
  on delete restrict
);

create table boardGood(
	idx int not null auto_increment,
	midIdx   varchar(20) not null,				
	boardIdx int not null,						
	primary key(idx),
	foreign key(boardIdx) references board2(idx),
	foreign key(midIdx) references member(mid)
);
drop table boardGood;

drop table boardReply2;
