
CREATE   Proc Composite.[usp_Get_Address] (@AddressLine1 varchar(100) out, @PostAreaName varchar(50) out, @PostCode varchar(10) out)
as
/*
Declare	@AddressLine1 varchar(100), @PostAreaName varchar(50), @PostCode varchar(10)
exec	Composite.usp_Get_Address @AddressLine1 out, @PostAreaName out, @PostCode out
Select	@AddressLine1, @PostAreaName, @PostCode
*/



Declare	@PostArea varchar(2),
		@Number1 char(1),
		@Number2 char(2),
		@Number3 varchar(3),
		@Letter1 char(1),
		@Letter2 char(1),
		@Street	varchar(50)

exec SingleValue.usp_Get_PostArea @PostArea = @PostArea out, @PostAreaName = @PostAreaName out
exec SingleValue.usp_Get_Number @MinValue = 9, @Number = @Number1 out
exec SingleValue.usp_Get_Number @MinValue = 99, @Number = @Number2 out
exec SingleValue.usp_Get_Number @MinValue = 99, @Number = @Number3 out
exec SingleValue.usp_Get_Street @Street = @Street out
exec SingleValue.usp_Get_Letter @Letter = @Letter1 out
exec SingleValue.usp_Get_Letter @Letter = @Letter2 out

Select	@PostCode = @PostArea + @Number2 + ' ' + @Number1 + @Letter1 + @Letter2,
		@AddressLine1 = @Number3 + ' ' + @Street