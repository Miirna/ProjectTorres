-- view call
use callcenter2019;

drop view if exists viewCalls; 

-- view
create view viewCalls as
	select c.id as callId, c.dateTimeReceived as dateTimeReceived, c.dateTimeAnswered as dateTimeAnswered, c.dateTimeEnded as dateTimeEnded,
	c.phoneNumber as phoneNumber, c.idSession as sessionId, sc.id as callStatusId, sc.description as statusDescription, sc.availableToAnswer,
	sce.id as idStatusEnd, sce.description as statusEndDescription,
	sec_to_time(time_to_sec(timediff(dateTimeEnded, dateTimeAnswered))) as handleTime,
	sec_to_time(time_to_sec(timediff(dateTimeAnswered, datetimeReceived))) as waitTime
	from calls as c left join statuscall as sc on c.idStatus = sc.id  
	left join statusCallEnd as sce on c.idStatusEnd = sce.id order by callId;




