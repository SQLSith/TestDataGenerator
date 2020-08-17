
CREATE      Proc [dbo].[usp_Get_Size_Bulk] (@QuantityRequired smallint)
as
/*
exec [usp_Get_Size_Bulk] 1000
*/

Declare	@NextSK int,
		@MaxSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end,
		@MaxSK = [MaxReferenceSK]
from	ReferenceControl
where	[ReferenceTableName] = 'Size'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = case ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) end
where	[ReferenceTableName] = 'Size'

Select	f.Size
from	Number n
join	[dbo].[Size] f	on	f.SizeSK = case ((number + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((number + (@NextSK - 1)) % @MaxSK) end
where	n.Number <= @QuantityRequired
order by n.Number