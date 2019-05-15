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
		-- assign call fro queue to agent
		call spAssignCall(result);
	end if;

	-- commit changes
	if result = 0 then
		-- commit transaction
		commit;
	end if;
end$$

delimiter ;