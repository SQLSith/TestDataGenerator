

CREATE function [SingleValue].[ufn_Get_Street]
(
)
RETURNS varchar(50)
AS
BEGIN
	Declare	@MaxSK int,
			@ChosenSK int,
			@Street varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Street'
	;

	Select	@ChosenSK = ceiling(RandomNumber * @MaxSK)
	from	SingleValue.[vw_RandomNumber]

	Select	@Street = [Street]
	from	[Reference].[Street]
	where	[StreetSK] = @ChosenSK

	Return @Street
END