-- =============================================
-- Author:		Docente: Moussa
-- Create date: 18-11-25
-- Description:	Modifica cliente
-- =============================================
CREATE PROCEDURE sp_ModificaCliente
    @ClienteId INT,
    @Nome NVARCHAR(100),
    @IndirizzoMail NVARCHAR(100),
    @Telefono NVARCHAR(50),
    @Indirizzo NVARCHAR(255)
AS
BEGIN
    UPDATE Clienti
    SET Nome = @Nome,
        IndirizzoMail = @IndirizzoMail,
        Telefono = @Telefono,
        Indirizzo = @Indirizzo
    WHERE ClienteId = @ClienteId;
END;

DECLARE	@return_value int


DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_ModificaCliente]
		@ClienteId = 1002,
		@Nome = N'Alice pippo',
		@IndirizzoMail = N'p.alice@gmail.com',
		@Telefono = N'3241890578',
		@Indirizzo = N'Via 20 settembre, FE'

SELECT	'Return Value' = @return_value

GO

Select * from Clienti