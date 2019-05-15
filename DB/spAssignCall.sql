-- spAssignCall

use callcenter2019;

drop procedure if exists spAssignCall; 

delimiter $$

create procedure spAssignCall
(
	-- parameters
	out result int
)
begin
	-- variables
	declare callReceiveStatus int;
	declare callAnswerStatus int;
	declare callId int;
	declare sessionId int;
	declare sessionLogId int;
	declare dateTimeStart dateTime;

	-- error handling
	declare exit handler for sqlexception begin
		set result = 999; -- SQL error (duplicate PK, invalid FK, et)
		rollback; -- rollback all changes
	end;
	
	-- configuration
	select idDefaultCallReceiveStatus, idDefaultCallAnswerStatus into callReceiveStatus, callAnswerStatus from config;

	-- validate
	set result = 0; -- no error
	
	-- start transaction
	start transaction;

	if result = 0 then
		-- find calls in queue with longest wait
		select id into callId from calls where idStatus = callReceiveStatus order by datetimeReceived asc limit 0,1; 
		if found_rows() > 0 then
			-- find logged in agent with longest idle time
			-- active session, session log with available status 
			select s.id, sl.id, sl.dateTimeStart into sessionId, sessionLogId, dateTimeStart
			from sessions as s join sessionLog as sl on s.id = sl.idSession join statussessionlog as stsl on sl.idStatus = stsl.id 
			where s.active = true and stsl.available = true and dateTimeEnd is null order by sl.dateTimeStart asc limit 0,1;
			-- assign call to session
			update sessions set idCurrentCall = callId where id = sessionId;
			-- update log (finish previous activity)
			update sessionLog set dateTimeEnd = now() where id = sessionLogId;
			-- new entry in session log
			insert into sessionLog (idSession, idStatus) values (sessionId, callAnswerStatus);
			-- update call
			update calls set dateTimeAnswered = now(), idSession = sessionId, idStatus = callAnswerStatus where id = callId;
		end if;
	end if;

	-- commit changes
	if result = 0 then
		-- commit transaction
		commit;
	end if;
end$$

delimiter ;