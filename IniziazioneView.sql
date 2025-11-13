/* 1️⃣  Vista: vw_studentiCorsiVoti
   ---------------------------------
   Mostra il nome dello studente, il voto e un giudizio testuale
   sull’esito in base al valore del voto.
*/
CREATE VIEW vw_studentiCorsiVoti AS
SELECT 
    s.NomeStudente,
    v.Voto,
    CASE
        WHEN v.Voto >= 28 THEN 'Ottimo'
        WHEN v.Voto >= 24 THEN 'Buono'
        WHEN v.Voto >= 18 THEN 'Sufficiente'
        ELSE 'Insufficiente'
    END AS Esito
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
JOIN Corso AS c ON i.CorsoId = c.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId;

/*  -- È possibile ordinare i risultati in una SELECT:
    SELECT * FROM vw_studentiCorsiVoti ORDER BY NomeStudente DESC;
*/


/* 2️⃣  Vista: vw_VotiDettaglio
   ---------------------------------
   Combina tutte le informazioni sui voti con dettagli
   sugli studenti e sui corsi.
*/
CREATE VIEW vw_VotiDettaglio AS
SELECT 
    v.VotoId,            -- Identificativo del voto
    s.NomeStudente,      -- Nome dello studente
    c.NomeCorso,         -- Nome del corso
    v.Voto,              -- Punteggio ottenuto
    i.DataIscrizione     -- Data di iscrizione
FROM Voto AS v
JOIN Iscrizione AS i ON v.IscrizioneId = i.IscrizioneId
JOIN Studente AS s ON i.StudenteId = s.StudenteId
JOIN Corso AS c ON i.CorsoId = c.CorsoId;


/* ✅ Esempio di consultazione */
SELECT * FROM vw_VotiDettaglio;


/* ✅ Esempio di filtro e ordinamento */
SELECT * 
FROM vw_VotiDettaglio
WHERE Voto >= 27
ORDER BY NomeCorso, Voto DESC;


/* 3️⃣  Vista: vw_StudenteBase
   ---------------------------------
   Vista semplificata per la gestione dei dati base
   degli studenti (CRUD: Create, Read, Update, Delete).
*/
CREATE VIEW vw_StudenteBase AS
SELECT 
    StudenteId,
    NomeStudente,
    DataNascita
FROM Studente;


/* ✅ Aggiornamento di un record tramite la vista */
UPDATE vw_StudenteBase
SET NomeStudente = 'Moussa Diallo Junior'
WHERE StudenteId = 1;


/* ✅ Inserimento di un nuovo studente tramite la vista */
INSERT INTO vw_StudenteBase (NomeStudente, DataNascita)
VALUES ('Guglielmo Rossi', '2001-07-15');


/* ✅ Eliminazione di uno studente tramite la vista */
DELETE FROM vw_StudenteBase 
WHERE StudenteId = 31;


/* ===========================================================
   🔚 Fine Script
   =========================================================== */
