
Create   Proc usp_Get_PhoneNumber (@PhoneNumber varchar(15) out)
as
/*
Declare @PhoneNumber varchar(15)
exec usp_Get_PhoneNumber @PhoneNumber out
Select @PhoneNumber
*/
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
		@Number9 char(1)

Select top 1 @Prefix = Prefix
from	(values ('44'),('0')) Prefix(Prefix)
order by newid()

Select top 1 @TypeNumber = TypeNumber
from	(values ('1'),('7')) TypeNumber(TypeNumber)
order by newid()

exec usp_Get_Number 9, @Number1 out
exec usp_Get_Number 9, @Number2 out
exec usp_Get_Number 9, @Number3 out
exec usp_Get_Number 9, @Number4 out
exec usp_Get_Number 9, @Number5 out
exec usp_Get_Number 9, @Number6 out
exec usp_Get_Number 9, @Number7 out
exec usp_Get_Number 9, @Number8 out
exec usp_Get_Number 9, @Number9 out

Select	@PhoneNumber = @Prefix + @TypeNumber + @Number1 + @Number2 + @Number3 + ' ' + @Number4 + @Number5 + @Number6 + @Number7 + @Number8 + @Number9