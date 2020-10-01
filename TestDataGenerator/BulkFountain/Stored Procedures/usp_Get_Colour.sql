
CREATE      Proc [BulkFountain].[usp_Get_Colour] (@QuantityRequired smallint)
as
	Set Xact_Abort on
	Set Nocount on

/*
exec BulkFountain.[usp_Get_Colour] 1000
*/


	Declare	@NextSK int,
			@MaxSK int

	Begin tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end,
				@MaxSK = [MaxReferenceSK]
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Colour'

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = case ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) end
		where	[ReferenceTableName] = 'Colour'
	commit tran

	Select	f.Colour
	from	Reference.Number n
	join	Reference.[Colour] f	on	f.ColourSK = case ((n.Number + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((n.Number + (@NextSK - 1)) % @MaxSK) end
	where	n.Number <= @QuantityRequired
	order by n.Number