﻿
CREATE      Proc [BulkFountain].[usp_Get_Size] (@QuantityRequired smallint)
as
/*
exec BulkFountain.[usp_Get_Size] 1000
*/

	Declare	@NextSK int,
			@MaxSK int

	Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end,
			@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Size'

	Update	SystemControl.ReferenceControl
	Set		[LastAllocatedReferenceSK] = case ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((@QuantityRequired + (@NextSK - 1)) % @MaxSK) end
	where	[ReferenceTableName] = 'Size'

	Select	f.Size
	from	Reference.Number n
	join	Reference.[Size] f	on	f.SizeSK = case ((n.Number + (@NextSK - 1)) % @MaxSK) when 0 then @MaxSK else ((n.Number + (@NextSK - 1)) % @MaxSK) end
	where	n.Number <= @QuantityRequired
	order by n.Number