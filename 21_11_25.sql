-- IF EXISTS
-- PRINT
-- RAISERROR
-- RETURN
-- TRY CATCH
-- VARIABLI DI TABELLE 

/*
CREATE PROCEDURE sp_InsertStudente
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
*/


-- InserisciStudente (controllo email duplicata)

CREATE PROCEDURE sp_InserisciCorso
    @NomeCorso NVARCHAR(100),
    @Descrizione NVARCHAR(100),
    @Crediti INT
AS
BEGIN
    BEGIN TRY
        -- Controlla se il corso esiste già
        IF EXISTS (SELECT 1 FROM Corso WHERE NomeCorso = @NomeCorso)
        BEGIN
            PRINT 'Corso già esistente. Nessun inserimento effettuato.';
            RETURN;
        END

        -- Inserisce il corso
        INSERT INTO Corso (NomeCorso, Descrizione, Crediti)
        VALUES (@NomeCorso, @Descrizione, @Crediti);

        PRINT 'Corso inserito correttamente.';
    END TRY
    BEGIN CATCH
    END CATCH
END;
GO



EXEC InsertStudente
	@Nome = '',
	@Cognome = '',
	@DataNascita ='',
	@Email = '';

GO

-- InserisciIscrizione (controllo studente e corso)
CREATE PROCEDURE sp_InserisciIscrizione
    @StudenteId INT,
    @CorsoId INT,
    @DataIscrizione DATE
AS
BEGIN
    BEGIN TRY
        -- Controlla se lo studente esiste
        IF NOT EXISTS (SELECT 1 FROM Studente WHERE StudenteId = @StudenteId)
        BEGIN
            RAISERROR('Studente non trovato.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Controlla se il corso esiste
        IF NOT EXISTS (SELECT 1 FROM Corso WHERE CorsoId = @CorsoId)
        BEGIN
            RAISERROR('Corso non trovato.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Controlla se lo studente è già iscritto a questo corso
        IF EXISTS (SELECT 1 FROM Iscrizione WHERE StudenteId = @StudenteId AND CorsoId = @CorsoId)
        BEGIN
            RAISERROR('Lo studente è già iscritto a questo corso.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Inserisce l'iscrizione
        INSERT INTO Iscrizione (StudenteId, CorsoId, DataIscrizione)
        VALUES (@StudenteId, @CorsoId, @DataIscrizione);

        COMMIT TRANSACTION;
        PRINT 'Iscrizione inserita correttamente.';
    END TRY
    BEGIN CATCH
        -- Se erroe, rollack
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        --Stampa l'errore
        PRINT 'Errore durante l’inserimento dell’iscrizione.';
        PRINT ERROR_MESSAGE(); -- Mostra il messsaggio di errore SQL 
    END CATCH
END;
GO

SELECT * FROM Iscrizione

EXEC sp_InserisciIscrizione
    @StudenteId = 1, 
    @CorsoId = 2, 
    @DataIscrizione = '2025-11-21';


