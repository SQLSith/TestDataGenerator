
CREATE      Proc [BulkFountain].[usp_Get_PostArea] (@QuantityRequired smallint)
as
	Set Xact_Abort on
	Set Nocount on

/*
exec BulkFountain.[usp_Get_PostArea] 1000
*/


	Declare	@NextSK int,
			@MaxSK int

	Begin tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end,
				@MaxSK = [MaxReferenceSK]
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'PostArea'

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = case ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) end
		where	[ReferenceTableName] = 'PostArea'
	commit tran

	Select	f.PostArea, f.[PostAreaName]
	from	Reference.Number n
	join	Reference.[PostArea] f	on	f.PostAreaSK = case ((number + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((number + (@NextSK - 1)) % @MaxSK) end
	where	n.Number <= @QuantityRequired
	order by n.Number