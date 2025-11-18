CREATE PROCEDURE sp_InsertCliente
	@Nome			 NVARCHAR(100),
	@IndirizzoeMail  NVARCHAR(100),
	@Telefono		 NVARCHAR(50),
	@Indirizzo		 NVARCHAR(255)
AS
BEGIN
	INSERT INTO 
		Clienti
			(Nome, IndirizzoMail, Telefono, Indirizzo, DataRegistrazione)
	VALUES 
			(@Nome, @IndirizzoeMail, @Telefono, @Indirizzo, CAST(GETDATE() AS DATE))
END
GO

-- Chiamate della sp_InsertCliente
DECLARE	@return_value int 

EXEC	@return_value = sp_InsertCliente
		@Nome = N'TEST',
		@IndirizzoeMail = N'PROVA',
		@Telefono = N'213254',
		@Indirizzo = N'VIA ONLINE 25'

SELECT	'Return Value' = @return_value

GO

SELECT * FROM Clienti																				