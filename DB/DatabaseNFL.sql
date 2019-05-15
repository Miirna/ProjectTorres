create database nfl character set utf8 collate utf8_spanish_ci;
use nfl;

create table conferences 
(
	id varchar(5) primary key not null,
    name varchar(50) not null,
	logo varchar(50) not null
)engine=InnoDB character set utf8 collate utf8_spanish_ci;

insert into conferences (id, name, logo) values
('AFC', 'American Football Conference', 'afc.png'),
('NFC', 'National Football Conference', 'nfc.png');

create table divisions 
(
	id varchar(5) primary key not null,
    name varchar(50) not null,
	idConference varchar(5) not null
)engine=InnoDB character set utf8 collate utf8_spanish_ci;

insert into divisions (id, name, idConference) values
('AFCE', 'AFC East', 'AFC'),
('AFCN', 'AFC North', 'AFC'),
('AFCS', 'AFC South', 'AFC'),
('AFCW', 'AFC West', 'AFC'),
('NFCE', 'NFC East', 'NFC'),
('NFCN', 'NFC North', 'NFC'),
('NFCS', 'NFC South', 'NFC'),
('NFCW', 'NFC West', 'NFC');

alter table divisions add constraint fkDivisionConference foreign key (idConference) references conferences (id);

create table teams
(
	id varchar(5) primary key not null,
    name varchar(50) not null,
	logo varchar(50) not null,
	idDivision varchar(5)
)engine=InnoDB character set utf8 collate utf8_spanish_ci;

insert into teams (id, name, logo, idDivision) values
('BUF', 'Buffalo Bills', 'bills.png', 'AFCE'),
('MIA', 'Miami Dolphins', 'dolphins.png','AFCE'),
('NE', 'New England Patriots', 'patriots.png','AFCE'),
('NYJ', 'New York Jets', 'jets.png','AFCE');
insert into teams (id, name, logo, idDivision) values
('DAL', 'Dallas Cowboy', 'cowboys.png', 'NFCE'),
('NYG', 'New York Giants', 'giants.png','NFCE'),
('PHI', 'Philadelphia Eagles', 'eagles.png','NFCE'),
('WAS', 'Washington Redskins', 'redskins.png','NFCE');
insert into teams (id, name, logo, idDivision) values
('BAL', 'Baltimore Ravens', 'ravens.png', 'AFCN'),
('CIN', 'Cincinnati Bengals', 'bengals.png','AFCN'),
('CLE', 'Cleveland Browns', 'browns.png','AFCN'),
('PIT', 'Pittsburgh Steelers', 'steelers.png','AFCN');
insert into teams (id, name, logo, idDivision) values
('CHI', 'Chicago Bears', 'bears.png', 'NFCN'),
('DET', 'Detroit Lions', 'lions.png', 'NFCN'),
('GB', 'Green Bay Packers', 'packers.png', 'NFCN'),
('MIN', 'Minnesota Vikings', 'vikings.png', 'NFCN');
insert into teams (id, name, logo, idDivision) values
('HOU', 'Houston Texans', 'texans.png', 'AFCS'),
('IND', 'Indianapolis Colts', 'colts.png', 'AFCS'),
('JAX', 'Jacksonville Jaguars', 'jaguars.png', 'AFCS'),
('TEN', 'Tennessee Titans', 'titans.png', 'AFCS');
insert into teams (id, name, logo, idDivision) values
('ATL', 'Atlanta Falcons', 'falcons.png', 'NFCS'),
('CAR', 'Carolina Panthers', 'panthers.png', 'NFCS'),
('NO', 'New Orleans Saints', 'saints.png', 'NFCS'),
('TB', 'Tampa Bay Buccaneers', 'buccaneers.png', 'NFCS');
insert into teams (id, name, logo, idDivision) values
('DEN', 'Denver Broncos', 'broncos.png', 'AFCW'),
('KC', 'Kansas City Chiefs', 'chiefs.png', 'AFCW'),
('LAC', 'Los Angeles Chargers', 'chargers.png', 'AFCW'),
('OAK', 'Oakland Raiders', 'raiders.png', 'AFCW');
insert into teams (id, name, logo, idDivision) values
('ARI', 'Arizona Cardinals', 'cardinals.png', 'NFCW'),
('LAR', 'Los Angeles Rams', 'rams.png', 'NFCW'),
('SF', 'San Francisco 49ers', '49ers.png', 'NFCW'),
('SEA', 'Seattle Seahawks', 'seahawks.png', 'NFCW');