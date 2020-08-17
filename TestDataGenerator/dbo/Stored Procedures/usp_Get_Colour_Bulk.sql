

CREATE      Proc [dbo].[usp_Get_Colour_Bulk] (@QuantityRequired smallint)
as
/*
exec [usp_Get_Colour_Bulk] 1000
*/


Declare	@NextSK int,
		@MaxSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end,
		@MaxSK = [MaxReferenceSK]
from	ReferenceControl
where	[ReferenceTableName] = 'Colour'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = case ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) end
where	[ReferenceTableName] = 'Colour'

Select	f.Colour
from	Number n
join	[dbo].[Colour] f	on	f.ColourSK = case ((number + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((number + (@NextSK - 1)) % @MaxSK) end
where	n.Number <= @QuantityRequired
order by n.Number