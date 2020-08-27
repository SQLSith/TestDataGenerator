
Create      Proc [BulkFountain].[usp_Get_Surname] (@QuantityRequired smallint)
as
	Set Xact_Abort on
	Set Nocount on

/*
exec BulkFountain.[usp_Get_Surname] 1000
*/


	Declare	@NextSK int,
			@MaxSK int

	Begin tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end,
				@MaxSK = [MaxReferenceSK]
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Surname'

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = case ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) end
		where	[ReferenceTableName] = 'Surname'
	commit tran

	Select	f.Surname
	from	Reference.Number n
	join	Reference.[Surname] f	on	f.SurnameSK = case ((number + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((number + (@NextSK - 1)) % @MaxSK) end
	where	n.Number <= @QuantityRequired
	order by n.Number