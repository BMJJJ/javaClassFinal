show tables;

create table pds2 (
	idx int not null auto_increment,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	fName varchar(200) not null,
	fSName varchar(200) not null,
	fSize int not null,
	title varchar(100) not null,
	part varchar(20) not null,
	fDate datetime default now(),
	downNum int default 0,
	openSw char(3) default '공개',
	content text,
	thumbNail varchar(200) not null,
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc pds2;