-- spReceiveCall

use callcenter2019;

drop procedure if exists spReceiveCall; 

delimiter $$

create procedure spReceiveCall
(
	-- parameters
	in phoneNumber varchar(10),
	out result int
)
begin
	-- variables
	declare callStatus int;

	-- error handling
	declare exit handler for sqlexception begin
		set result = 999; -- SQL error (duplicate PK, invalid FK, et)
		rollback; -- rollback all changes
	end;
	
	-- configuration
	select idDefaultCallReceiveStatus into callStatus from config;

	-- validate
	set result = 0; -- no error
	
	-- start transaction
	start transaction;

	if result = 0 then
		-- receive call
		insert into calls (phoneNumber, idStatus) values (phoneNumber, callStatus);
	
		-- totals
		-- check if there are call this hour
		select id from callhourlytotals where date = date(now()) and hour = hour(now());
		if found_rows() = 0 then
			-- new record in totals
			insert into callhourlytotals (date, hour, callsReceived, callsAnswered, callsEnded, handleTime, waitTime) 
			values (now(), hour(now()), 1, 0, 0, 0, 0);
		else
			-- update records in totals
			update callhourlytotals set callsReceived = callsReceived + 1 where date = date(now()) and hour = hour(now());
		end if;

		-- assign call fro queue to agent
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