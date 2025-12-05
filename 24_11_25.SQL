-- STORE PROCEDURE 
CREATE PROCEDURE sp_AggiornamentoVoto
    @VotoId INT,
    @NuovoVoto INT
AS
BEGIN
    BEGIN TRY 
        -- Validazione del voto
        IF @NuovoVoto < 18 OR @NuovoVoto > 30
        BEGIN 
            RAISERROR ('Il voto deve essere compreso tra 18 e 30', 16, 1);
            ROLLBACK TRANSACTION -- QUELLO che stiamo facendo nella IF
        END
        --Ora aggiorniamo il voto
        UPDATE Voto 
        SET Voto = @NuovoVoto
        WHERE VotoId = @VotoId;
        
        COMMIT TRANSACTION
        PRINT 'Voto Aggiornato Correttamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 -- tutte le transizioni fatte 
            ROLLBACK TRANSACTION
        PRINT 'Errore durante aggiornamento';
        print ERROR_MESSAGE();
        
    END CATCH
END


-----============= TRIGGER ========================
/*

Il blocco CATCH fa 4 cose:
    | Cosa fa                | Significa                                       |
    | ---------------------- | ------------------------------------------------|
    | 1️ Cattura l’errore     | legge il messaggio dell’errore originale        |
    | 2️ Cattura la gravità   | serve per riproporre lo stesso tipo di errore   |
    | 3️ Rilancia l’errore    | fa vedere al client il messaggio completo       |
    | 4️ Rollback             | annulla la transazione, impedendo danni ai dati |
    
*/


CREATE TRIGGER trg_NoDeleteDocente 
ON Docente
instead OF DELETE 
AS 
BEGIN
	BEGIN TRY
	-- Controllo: il dencente ha corsi asociati?
	IF EXISTS(
		SELECT 1
		FROM Corso c 
		JOIN deleted d ON c.DocenteId = d.DocenteId	
		)
		BEGIN
			RAISERROR('Imposibile eliminare il docente: ha un corso asociato', 16, 1)
			-- Serve bloccare il delete 
			ROLLBACK TRANSACTION;
			RETURN;
		END;
	-- Se non ha corsi -> allora elimina il docente 
	DELETE FROM Docente
	WHERE DocenteId IN(SELECT DocenteId FROM deleted)
	END TRY 
	BEGIN CATCH
		-- In caso di errore 
		DECLARE 
			@ErrMessage NVARCHAR(4000), 
			@ErrSecurity INT;
		-- CREATE TRIGGER trg_NoDeleteDocente 
		SELECT 
			@ErrMessage = ERROR_MESSAGE(),
			@ErrSecurity = ERROR_SEVERITY();
		RAISERROR(@ErrMessage, @ErrSecurity, 1);
		ROLLBACK TRANSACTION;
	END CATCH
END;


SELECT * FROM Docente

DELETE FROM Docente WHERE DocenteId = 2;

--- TRIGGER COMPLETO per non cacellare uno studente de ha un voto

CREATE TRIGGER trg_NoDeleteStudente
ON Studente
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY

        -- Controllo se lo studente ha iscrizioni
        IF EXISTS (
            SELECT 1
            FROM Iscrizione i
            JOIN deleted d ON i.StudenteId = d.StudenteId
        )
        BEGIN
            RAISERROR('Impossibile eliminare lo studente: ha iscrizioni associate.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Controllo se lo studente ha voti (tramite iscrizione)
        IF EXISTS (
            SELECT 1
            FROM Voto v
            JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
            JOIN deleted d ON i.StudenteId = d.StudenteId
        )
        BEGIN
            RAISERROR('Impossibile eliminare lo studente: ha voti registrati.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Se non ha iscrizioni né voti → eliminazione consentita
        DELETE FROM Studente
        WHERE StudenteId IN (SELECT StudenteId FROM deleted);

    END TRY

    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000), 
        @ErrSeverity INT;

        -- Recupera l’errore originale
        SELECT  
            @ErrMsg = ERROR_MESSAGE(),       -- testo del messaggio di errore
            @ErrSeverity = ERROR_SEVERITY(); -- livello di gravità dell’errore (da 1 a 25)

        RAISERROR(@ErrMsg, @ErrSeverity, 1); -- Rilanci l'errore (Rilanci l'error catturato con lo stesso messaggio)
        ROLLBACK TRANSACTION; -- Questo annulla l’azione che era in esecuzione.
    END CATCH
END;


DELETE FROM Studente WHERE StudenteId = 5;


--TRIGGER: Blocca la cancellazione di uno studente che frequenta un corso

CREATE TRIGGER trg_NoDeleteStudenteCorso
ON Studente
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        
        -- Controllo: studente iscritto ad almeno un corso?
        IF EXISTS (
            SELECT 1
            FROM Iscrizione i
            JOIN deleted d ON i.StudenteId = d.StudenteId
        )
        BEGIN
            RAISERROR('Impossibile eliminare lo studente: è ancora iscritto a uno o più corsi.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Eliminazione consentita solo se NON iscritto a nessun corso
        DELETE FROM Studente
        WHERE StudenteId IN (SELECT StudenteId FROM deleted);

    END TRY

    BEGIN CATCH
        -- codice che gestisce gli errori
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;

        SELECT 
            @ErrMsg = ERROR_MESSAGE(),       -- testo del messaggio di errore
            @ErrSeverity = ERROR_SEVERITY(); -- livello di gravità dell’errore (da 1 a 25)

        RAISERROR(@ErrMsg, @ErrSeverity, 1);
        ROLLBACK TRANSACTION;
    END CATCH
END;

DELETE FROM Studente WHERE StudenteId = 5;

