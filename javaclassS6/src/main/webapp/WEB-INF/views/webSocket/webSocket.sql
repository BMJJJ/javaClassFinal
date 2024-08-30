create table webSocket(
	mid varchar(20) not null,
	yMid varchar(20) not null, /*상대방 아이디*/
	message text not null,
	cDate datetime not null default now(),
	foreign key(mid) references member(mid),
	foreign key(yMid) references member(mid)
);

drop table webSocket;
