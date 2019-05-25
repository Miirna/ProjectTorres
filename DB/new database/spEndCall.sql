-- spEndCall

use callcenter2019;

drop procedure if exists spEndCall; 

delimiter $$

create procedure spEndCall
(
	-- parameters
	in callId int,
	in statusEndId int,
	out result int
)
begin
	-- variables
	declare callAnswerStatus int;
	declare callEndStatus int;
	declare callStatus int;
	declare sessionId int;
	declare sessionLogId int;
	declare sessionLogStatus int;
	declare callHandleTime time;

	-- error handling
	declare exit handler for sqlexception begin
		set result = 999; -- SQL error (duplicate PK, invalid FK, et)
		rollback; -- rollback all changes
	end;
	
	-- configuration
	select idDefaultCallAnswerStatus, idDefaultCallEndStatus, idDefaultSessionLogStatus into callAnswerStatus, callEndStatus, sessionLogStatus from config;
	
	-- validate
	set result = 0; -- no error

	-- call exists
	if result = 0 then
		select idSession, idStatus into sessionId, callStatus from calls where id = callId;
		if found_rows() = 0 then 
			set result = 1; -- invalid call id
		else
			if callStatus <> callAnswerStatus then
				set result = 2; -- call not active
			end if;
		end if;
	end if;

	-- call end status exists
	if result = 0 then
		select id from statusCallEnd where id = statusEndId;
		if found_rows() = 0 then 
			set result = 3; -- invalid status end id
		end if;
	end if;
	
	-- start transaction
	start transaction;

	if result = 0 then
		-- update call
		update calls set dateTimeEnded = now(), idStatus = callEndStatus, idStatusEnd = statusEndId where id = callId;
		-- update session
		update sessions set idCurrentCall = null where id = sessionId;
		-- update log (finish previous activity)
		select id into sessionLogId from sessionLog where idSession = sessionId and dateTimeEnd is null order by id desc limit 0,1;
		update sessionLog set dateTimeEnd = now() where id = sessionLogId;
		-- new entry in session log
		insert into sessionLog (idSession, idStatus) values (sessionId, sessionLogStatus);
		-- add to totals
		-- handle time
		select sec_to_time(time_to_sec(timediff(dateTimeEnded, dateTimeAnswered))) into callHandleTime from calls where id = callId;
		-- totals
		update callHourlyTotals set callsEnded = callsEnded + 1, handleTime = handleTime + callHandleTime where date = date(now()) and hour = hour(now());
		-- if new day
		
		-- assign call from queue to agent
		call spAssignCall(result);
	end if;

	-- commit changes
	if result = 0 then
		commit; -- commit transaction
	else
		rollback; -- rollback changes
	end if;
end$$

delimiter ;