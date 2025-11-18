-- =============================================
-- Author:		Docente: Moussa
-- Create date: 18-11-25
-- Description:	Elimina Cliente
-- =============================================
CREATE PROCEDURE sp_EliminaCliente
    @ClienteId INT
AS
BEGIN
    DELETE FROM Clienti
    WHERE ClienteId = @ClienteId;
END;


DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_EliminaCliente]
		@ClienteId = 1002

SELECT	'Return Value' = @return_value

GO


SELECT * FROM Clienti;