
Create Procedure [Reference].[usp_Maintain_Product]
as

	if object_id('tempdb..#Product') is not null
	begin
		Drop Table #Product
	end
	;

	CREATE TABLE #Product
	(
		[ProductSK_old] [int] NOT NULL,
		[Product] [varchar](50) NOT NULL,
		[ProductSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#Product ([ProductSK_old], [Product], [ProductSK_new])
	Select [ProductSK], 
			[Product],
			row_number() over (order by [ProductSK]) [ProductSK_new]
	from	[Reference].[Product]
	;

-- Truncate existing Data
	Truncate Table [Reference].[Product]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[Product] on
	;

	insert	[Reference].[Product] ([ProductSK], [Product])
	Select	c.ProductSK_new,
			c.[Product]
	from	#Product c
	order by c.[ProductSK_old]
	;

	Set Identity_Insert [Reference].[Product] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(ProductSK) from Reference.Product)
	where	ReferenceTableName = 'Product'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [ProductSK_new]
	from	SystemControl.ReferenceControl r
	join	#Product m	on	r.LastAllocatedReferenceSK = m.ProductSK_old
	where	ReferenceTableName = 'Product'
	;