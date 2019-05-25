-- test
call spLoginAgent(1001, 2001, 1, @result); select @result;
call spReceiveCall('6641111111', @result); select @result;
call spReceiveCall('6642222222', @result); select @result;
call spLoginAgent(1002, 2002, 2, @result); select @result;
call spReceiveCall('6643333333', @result); select @result;
call spLoginAgent(1003, 2003, 3, @result); select @result;
call spReceiveCall('6644444444', @result); select @result;
call spLoginAgent(1004, 2004, 4, @result); select @result;
call spReceiveCall('6646666666', @result); select @result;
call spEndCall(3, 1, @result); select @result;
