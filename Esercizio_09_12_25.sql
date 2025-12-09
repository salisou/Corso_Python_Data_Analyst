SELECT * FROM Corso
SELECT * FROM Iscrizione

-- Visualizzare i Corsi senza Iscrizione (Nome e descrizione del Corso, data dell'iscrizione) 
SELECT 
	c.NomeCorso + ' - ' + c.Descrizione AS 'Nome e descrizione del Corso',
	i.DataIscrizione AS 'data dell"iscrizione'
FROM Corso AS c 
LEFT JOIN Iscrizione AS i ON c.CorsoId = i.CorsoId
where i.IscrizioneId IS NULL;

SELECT * FROM STUDENTE

CREATE PROCEDURE sp_AggiornaStudente
	@ID INT,
	@Email nvarchar(50)
AS
BEGIN
	UPDATE Studente
	SET Email = @Email
	WHERE StudenteId = @ID 
END

EXEC sp_AggiornaStudente 1038, 'pippo@gmail.com'

SELECT * FROM Studente WHERE StudenteId = 1038;

SELECT 
	s.StudenteId,
	s.NomeStudente, 
	v.Voto
FROM Studente AS s
INNER JOIN iscrizione AS i On s.StudenteId = i.StudenteId
INNER JOIN voto AS v ON i.IscrizioneId = v.IscrizioneId
/*
CURSOR-SCUOLADB 
	Creamo un CURSOR che legge tutti gli studenti
	Per ogni studente calcola la media dei voti
	Scrivere il risultato nella tabella "ReportMedia"
*/

-- Creazione della tabella ReportMedia
CREATE TABLE ReportMedia
(
	StudenteId INT,
	NomeStudente NVARCHAR(100),
	CognomeStudente NVARCHAR(100),
	MediaVoti DECIMAL(5,2)
)


-- Creazione del CURSOR Completo

-- Dichiaraione delle variabili
DECLARE
    @StudenteId INT,
    @NomeStudente NVARCHAR(100),
    @CognomeStudente NVARCHAR(100),
    @MediaVoti DECIMAL(5,2);

-- Dichiarazione del cursor
DECLARE cur_MediaStudente CURSOR FOR
    SELECT
        s.StudenteId,
        s.NomeStudente, 
        s.CognomeStudente
    FROM Studente AS s;

    -- Apre il cursor
    OPEN cur_MediaStudente;

    -- Legge la prima riga
    FETCH NEXT FROM cur_MediaStudente
    INTO 
        @StudenteId,
        @NomeStudente,
        @CognomeStudente;
    /*
        @@FETCH_STATUS restituisce:
        0 = tutto ok, riga trovata
        -1 = nessuna riga
        -2 = errore
    */
    WHILE @@FETCH_STATUS = 0

    BEGIN
        -- Calcola della media per sigolo studente
        SELECT 
            @MediaVoti = AVG(v.Voto)
        FROM Iscrizione AS i
        INNER JOIN Voto AS v on i.IscrizioneId = v.IscrizioneId
        WHERE i.StudenteId = @StudenteId;

        -- Insermento nella tabella ReportMedia
        INSERT INTO ReportMedia
            (StudenteId, NomeStudente, CognomeStudente, MediaVoti)
        VALUES
            (@StudenteId, @NomeStudente, @CognomeStudente, @MediaVoti);

        -- Niente @MediaVoti qui!

        -- Vai alla riga successiva 
        FETCH NEXT FROM cur_MediaStudente
        INTO 
            @StudenteId, 
            @NomeStudente,
            @CognomeStudente;
    END;

    -- Chiude e libera il curso
    CLOSE cur_MediaStudente; -- chiude ma mantiene in memoria 
    DEALLOCATE cur_MediaStudente; -- Elimina e libera Ram

select * from ReportMedia