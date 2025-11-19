-- =============================================
-- Author:		Docente: Moussa
-- Create date: 18-1125
-- Description:	Restituisce solo un client in base al ClienteId
-- =============================================
CREATE PROCEDURE sp_GetClienteById
	@ClienteId INT
AS
BEGIN
	SELECT * FROM Clienti
	WHERE ClienteId = @ClienteId
END
GO




DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_GetClienteById]
		@ClienteId = 1

SELECT	'Return Value' = @return_value

GO

