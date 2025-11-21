-- IF EXISTS
-- PRINT
-- RAISERROR
-- RETURN
-- TRY CATCH
-- VARIABLI DI TABELLE 



CREATE PROCEDURE InsertStudente
	@Nome NVARCHAR(100),
	@Cognome NVARCHAR(100),
	@DataNascita DATE,
	@Email NVARCHAR(50)
AS
BEGIN
	-- Controlla se l'mail esite già nella tabella Studente
	IF EXISTS (SELECT 1 FROM Studente WHERE Email = @Email) 
	BEGIN
		PRINT 'Email già registrata. Nessun inserimento efftuato😭'
		RETURN; -- Termina la procedura se la condizione è vera 
	END
   -- SE NON ESISTE, INSERISCE IL NUOVO STUDENTE
	INSERT INTO Studente (NomeStudente, CognomeStudente, DataNascita, Email)
	   VALUES (@Nome, @Cognome, @DataNascita, @Email)
	PRINT 'STUDENTE INSERTO CORRETTAMENTE'
END;
GO



EXEC InsertStudente
	@Nome = '',
	@Cognome = '',
	@DataNascita ='',
	@Email = '' 