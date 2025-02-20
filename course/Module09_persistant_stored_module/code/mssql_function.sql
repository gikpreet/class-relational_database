USE Module06
GO

CREATE FUNCTION GetDepartureDate (
	@no int
) RETURNS datetime
AS
BEGIN
	DECLARE @returnvalue datetime
	SELECT @returnvalue = FlightDate
    FROM Flight
    WHERE FlightNo = @no;
    RETURN @returnvalue
END
GO

SELECT dbo.GetDepartureDate(1)