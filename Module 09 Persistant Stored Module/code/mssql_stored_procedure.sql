CREATE PROCEDURE GetPassengerByFlight
	@no int
AS
	SELECT PassengerName, Age, Grade
	FROM Passenger INNER JOIN Reservation ON Passenger.PassengerNo = Reservation.PassengerNo
		INNER JOIN Flight ON Flight.FlightNo = Reservation.FlightNo
	WHERE Flight.FlightNo = @No
GO

EXEC GetPassengerByFlight 1