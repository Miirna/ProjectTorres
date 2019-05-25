-- spLoginAgent

use callcenter2019;

drop procedure if exists spLoginAgent; 

delimiter $$

create procedure spLoginAgent
(
	-- parameters
	in agentId int,
	in agentPin int,
	in stationId int,
	out result int
)
begin
	-- variables
	declare stationActive boolean;
	declare sessionLogStatus int;
	declare sessionId int;

	-- error handling
	declare exit handler for sqlexception begin
		set result = 999; -- SQL error (duplicate PK, invalid FK, et)
		rollback; -- rollback all changes
	end;
	
	-- configuration
	select idDefaultSessionLogStatus into sessionLogStatus from config;

	-- validate
	set result = 0; -- no error
	
	-- authenticate agent
	select id from agents where id = agentId and pin = agentPin;
	if found_rows() = 0 then 
		set result = 1; -- invalid agent authentication
	end if;

	-- agent already logged in
	if result = 0 then
		select id from sessions where idAgent = agentId and active = true;
		if found_rows() > 0 then 
			set result = 2; -- agent logged in in another station
		end if;
	end if;

	-- station exists
	if result = 0 then
		select active into stationActive from stations where id = stationId;
		if found_rows() = 0 then 
			set result = 3; -- invalid station id
		else
			if stationActive = false then
				set result = 4; -- station not active
			end if;
		end if;
	end if;

	-- station already in use
	if result = 0 then
		select id from sessions where idStation = stationId and active = true;
		if found_rows() > 0 then 
			set result = 5; -- station already in use
		end if;
	end if;

	-- start transaction
	start transaction;

	if result = 0 then
		-- start session
		insert into sessions (idAgent, idStation) values (agentId, stationId);
		-- get session id
		set sessionId = last_insert_id();
		-- session log
		insert into sessionLog (idSession, idStatus) values (sessionId, sessionLogStatus);
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