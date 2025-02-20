use Module06;

DELIMITER $$
CREATE PROCEDURE GetPassengerByFlight (
	no int
)
BEGIN
	SELECT PassengerName, Age, Grade
	FROM Passenger NATURAL JOIN Reservation NATURAL JOIN Flight
	WHERE FlightNo = no;
END $$
DELIMITER ;


CALL GetPassengerByFlight(1);