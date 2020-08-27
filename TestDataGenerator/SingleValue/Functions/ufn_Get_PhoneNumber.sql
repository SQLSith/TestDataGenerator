
CREATE function [SingleValue].[ufn_Get_PhoneNumber]
(
)
RETURNS varchar(15)
AS
BEGIN
	Declare @Prefix varchar(2),
			@TypeNumber char(1),
			@Number1 char(1),
			@Number2 char(1),
			@Number3 char(1),
			@Number4 char(1),
			@Number5 char(1),
			@Number6 char(1),
			@Number7 char(1),
			@Number8 char(1),
			@Number9 char(1),
			@PhoneNumber varchar(15)

	Select top 1 @Prefix = Prefix
	from	[SingleValue].[vw_RandomNumber] r
	join	(values (1, '44'),(2, '0')) Prefix(Number, Prefix) 	on	ceiling(r.RandomNumber * 2.0) = prefix.Number
	;

	Select top 1 @TypeNumber = TypeNumber
	from	[SingleValue].[vw_RandomNumber] r
	join	(values (1, '1'),(2, '7')) TypeNumber(Number, TypeNumber) on	ceiling(r.RandomNumber * 2.0) = TypeNumber.Number
	;


	Select	@Number1 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number2 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number3 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number4 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number5 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number6 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number7 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number8 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]
	Select	@Number9 = ceiling(RandomNumber * 10) - 1 from SingleValue.[vw_RandomNumber]

	Select	@PhoneNumber = @Prefix + @TypeNumber + @Number1 + @Number2 + @Number3 + ' ' + @Number4 + @Number5 + @Number6 + @Number7 + @Number8 + @Number9

	RETURN @PhoneNumber

END