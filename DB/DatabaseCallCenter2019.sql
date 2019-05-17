create database callcenter2019 default character set utf8 collate utf8_spanish_ci;

use callcenter2019;

-- agents

create table agents 
(
	id int primary key not null,
	name varchar(45) not null,
	photo varchar(10) null,
	pin int not null
)engine = innodb character set utf8 collate utf8_spanish_ci;

insert into agents (id, name, photo, pin) values
(1001, 'Adam Alberts', '1001.png', 2001),
(1002, 'Brian Brown', '1002.png', 2002),
(1003, 'Charles Connors', '1003.png', 2003),
(1004, 'Derek Davis', '1004.png', 2004),
(1005, 'Erick Edwards', '1005.png', 2005),
(1006, 'Fred Flowers', '1006.png', 2006),
(1007, 'Gaby Goldsmith', '1007.png', 2007),
(1008, 'Henry Hill', '1008.png', 2008),
(1009, 'Irving Ingram', '1009.png', 2009),
(1010, 'John Jackson', '1010.png', 2010),
(1011, 'Kevin King', '1011.png', 2011),
(1012, 'Larry Long', '1012.png', 2012),
(1013, 'Michael Moore', '1013.png', 2013),
(1014, 'Nancy Neil', '1014.png', 2014),
(1015, 'Oscar Oneil', '1015.png', 2015),
(1016, 'Paty Pierce', '1016.png', 2016),
(1017, 'Quinn Quaker', '1017.png', 2017),
(1018, 'Rachel Rivers', '1018.png', 2018),
(1019, 'Sarah Sanders', '1019.png', 2019),
(1020, 'Thomas Thompson', '1020.png', 2020),
(1021, 'Ursula Unger', '1021.png', 2021),
(1022, 'Vanessa Valentine', '1022.png', 2022),
(1023, 'William Walker', '1023.png', 2023),
(1024, 'Xavier Xing', '1024.png', 2024),
(1025, 'Yvonne Yates', '1025.png', 2025),
(1026, 'Zach Zappa', '1026.png', 2026);

-- stations 

create table stations 
(
	id int primary key not null,
	rowNumber int not null,
	deskNumber int not null,
	ipAddress varchar(20) not null,
	active boolean not null default true
)engine = innodb character set utf8 collate utf8_spanish_ci;

insert into stations (id, rowNumber, deskNumber, ipAddress, active) values
(1, 1, 1, '192.168.0.1', true),
(2, 1, 2, '192.168.0.2', true),
(3, 1, 3, '192.168.0.3', true),
(4, 1, 4, '192.168.0.4', true),
(5, 1, 5, '192.168.0.5', true),
(6, 2, 1, '192.168.0.6', true),
(7, 2, 2, '192.168.0.7', true),
(8, 2, 3, '192.168.0.8', true),
(9, 2, 4, '192.168.0.9', true),
(10, 2, 5, '192.168.0.10', true),
(11, 3, 1, '192.168.0.11', false),
(12, 3, 2, '192.168.0.12', true),
(13, 3, 3, '192.168.0.13', true),
(14, 3, 4, '192.168.0.14', true),
(15, 3, 5, '192.168.0.15', true),
(16, 4, 1, '192.168.0.16', true),
(17, 4, 2, '192.168.0.17', true),
(18, 4, 3, '192.168.0.18', true),
(19, 4, 4, '192.168.0.19', true),
(20, 4, 5, '192.168.0.20', false),
(21, 5, 1, '192.168.0.21', true),
(22, 5, 2, '192.168.0.22', true),
(23, 5, 3, '192.168.0.23', true),
(24, 5, 4, '192.168.0.24', true),
(25, 5, 5, '192.168.0.25', true),
(26, 6, 1, '192.168.0.26', true),
(27, 6, 2, '192.168.0.27', true),
(28, 6, 3, '192.168.0.28', true),
(29, 6, 4, '192.168.0.29', true),
(30, 6, 5, '192.168.0.30', true);

-- sessions

create table sessions
(
	id int primary key auto_increment not null,
	dateTimeLogin datetime not null default now(),
	dateTimeLogout datetime null,
	idAgent int not null,
	idStation int not null,
	idCurrentCall int null,
	active boolean not null default true
)engine = innodb character set utf8 collate utf8_spanish_ci;

create table statusSessionLog
(
	id int primary key not null,
	description varchar(20) not null,
	available boolean not null
)engine = innodb character set utf8 collate utf8_spanish_ci;

insert into statusSessionLog (id, description, available) values
(1, 'Available', true),
(2, 'On Call', false),
(3, 'On Hold', false);

create table sessionLog
(
	id int primary key auto_increment not null,
	idSession int not null,
	dateTimeStart datetime not null default now(),
	dateTimeEnd datetime null,
	idStatus int not null default 1
)engine = innodb character set utf8 collate utf8_spanish_ci;

-- calls

create table statusCall
(
	id int primary key not null,
	description varchar(20) not null,
	waiting boolean not null
)engine = innodb character set utf8 collate utf8_spanish_ci;

insert into statusCall (id, description, waiting) values
(1, 'Queue', true),
(2, 'Answered', false),
(3, 'Ended', false);

create table statusCallEnd 
(
	id int primary key not null,
	description varchar(20) not null
)engine = innodb character set utf8 collate utf8_spanish_ci;

insert into statusCallEnd (id, description) values
(1, 'Customer Ended'),
(2, 'Agent Ended'),
(3, 'Call Dropped'),
(4, 'Transfered');

create table calls 
(
	id int primary key auto_increment not null,
	datetimeReceived datetime not null default now(),
	datetimeAnswered datetime null,
	datetimeEnded datetime null,
	phoneNumber varchar(10) not null,
	idSession int null,
	idStatus int not null default 1,
	idStatusEnd int null
)engine = innodb character set utf8 collate utf8_spanish_ci;

-- configuration

create table config
(
	standardHandleTime double not null,
	standardWaitTime double not null,
	idDefaultSessionLogStatus int not null,
	idDefaultCallReceiveStatus int not null,
	idDefaultCallAnswerStatus int not null,
	idDefaultCallEndStatus int not null
)engine = innodb character set utf8 collate utf8_spanish_ci;

insert into config (standardHandleTime, standardWaitTime, idDefaultSessionLogStatus, idDefaultCallReceiveStatus, idDefaultCallAnswerStatus, idDefaultCallEndStatus) values
(7, 5, 1, 1, 2, 3);

-- call totals

create table callHourlyTotals 
(
	id int primary key auto_increment not null,
	date date not null,
	hour int not null,
	callsReceived int not null default 0,
	averageHandleTime double not null default 0,
	averageWaitTime double not null default 0
)engine = innodb character set utf8 collate utf8_spanish_ci;

create table callDailyTotals 
(
	id int primary key auto_increment not null,
	date date not null,
	hour int not null,
	callsReceived int not null default 0,
	averageHandleTime double not null default 0,
	averageWaitTime double not null default 0
)engine = innodb character set utf8 collate utf8_spanish_ci;

-- foreing keys

-- config

alter table config add constraint fkDefaultSessionLogStatus foreign key (idDefaultSessionLogStatus) references statusSessionLog (id);
alter table config add constraint fkDefaultCallReceiveStatus foreign key (idDefaultCallReceiveStatus) references statusCall (id);
alter table config add constraint fkDefaultCallAnswerStatus foreign key (idDefaultCallAnswerStatus) references statusCall (id);
alter table config add constraint fkDefaultCallEndStatus foreign key (idDefaultCallEndStatus) references statusCall (id);

-- sessions

alter table sessions add constraint fkSessionAgent foreign key (idAgent) references agents (id);
alter table sessions add constraint fkSessionStation foreign key (idStation) references stations (id);
alter table sessions add constraint fkSessionCurrentCall foreign key (idCurrentCall) references calls (id);
alter table sessionLog add constraint fkSessionLogSession foreign key (idSession) references sessions (id);
alter table sessionLog add constraint fkSessionLogStatus foreign key (idStatus) references statusSessionLog (id);

-- calls

alter table calls add constraint fkCallSession foreign key (idSession) references sessions (id);
alter table calls add constraint fkCallStatus foreign key (idStatus) references statusCall (id);
alter table calls add constraint fkCallStatusEnd foreign key (idStatusEnd) references statusCallEnd (id);