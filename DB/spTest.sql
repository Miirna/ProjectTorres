-- test
call spLoginAgent(1003, 2003, 1, @result); select @result;
call spLoginAgent(1001, 2001, 7, @result); select @result;
call spReceiveCall('6642372637', @result); select @result;
call spLoginAgent(1005, 2005, 5, @result); select @result;
call spReceiveCall('6645564564', @result); select @result;
call spAssignCall(@result); select @result;
call spReceiveCall('6641128298', @result); select @result;
call spAssignCall(@result); select @result;
call spReceiveCall('6642283725', @result); select @result;
call spReceiveCall('6643228371', @result); select @result;
call spLoginAgent(1002, 2002, 2, @result); select @result;
call spLoginAgent(1004, 2004, 4, @result); select @result;
call spLoginAgent(1009, 2009, 9, @result); select @result;
call spReceiveCall('6649982738', @result); select @result;
call spEndCall(3, 2, @result); select @result;
call spReceiveCall('6646675656', @result); select @result;
call spEndCall(1, 1, @result); select @result;