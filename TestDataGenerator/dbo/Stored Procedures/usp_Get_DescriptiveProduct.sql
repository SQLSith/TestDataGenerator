Create proc usp_Get_DescriptiveProduct (@DescriptiveProduct varchar(150) out)
as
/*
Declare	@DescriptiveProduct varchar(150) 
exec usp_Get_DescriptiveProduct @DescriptiveProduct out
Select @DescriptiveProduct
*/


Declare	@Rand int = ceiling(Rand() * 3)
Declare	@Product varchar(50),
		@Size varchar(50),
		@Colour varchar(50)



if @Rand in (1,3) 
begin
	exec usp_Get_Size @Size out
end 

if @Rand in (2,3) 
begin
	exec usp_Get_Colour @Colour out
end 

exec usp_Get_Product @Product out

Select @DescriptiveProduct = isnull(@Size + ' ', '') + isnull(@Colour + ' ','') + @Product