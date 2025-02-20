USE Module06;

# 옵션 지정
SET GLOBAL log_bin_trust_function_creators = 1; 

DELIMITER $$
CREATE FUNCTION GetDepartureDate(no int) 
	RETURNS datetime
BEGIN
	DECLARE returnvalue datetime;
    SET returnvalue = now();
	SELECT FlightDate into returnvalue
    FROM Flight
    WHERE FlightNo = no;
    
    RETURN returnvalue;
END $$
DELIMITER ;

SELECT GetDepartureDate(1);