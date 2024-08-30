show tables;

/*계절별 산책로 사진및 추천 테이블로 사용*/
create table season(
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	title varchar(50) not null,
	content text not null,
	expl text not null,
	thumbnail	varchar(50) not null,			
	part varchar(20) not null,/*봄,여름,가을,겨울*/
	primary key(idx),
	foreign key(mid) references member(mid)
);