-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  sp_SelectNameCliente
	@Nome NVARCHAR(50)
AS
BEGIN
	SELECT * from Clienti where Nome = @Nome
END
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_SelectNameCliente]
		@Nome = N'Giuseppe verdi'

SELECT	'Return Value' = @return_value

GO