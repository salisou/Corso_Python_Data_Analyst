-- Esercizi Pratici Correzione e Documentazione Completa

-- 1 Trova gli studenti che hanno un voto superiore alla media del loro corso

SELECT 
    s.NomeStudente,     
    c.NomeCorso,        
    v.Voto              
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId   -- Collega Studente   ↔ Iscrizione
JOIN Corso AS c ON i.CorsoId = c.CorsoId              -- Collega Iscrizione ↔ Corso
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId     -- Collega Iscrizione ↔ Voto
WHERE 
    -- Filtro: il voto dello studente è maggiore della media di quel corso
    v.Voto > (
        SELECT 
            AVG(v2.Voto)                           -- Calcolo della media dei voti
        FROM Iscrizione AS i2
        JOIN Voto AS v2 ON i2.IscrizioneId = v2.IscrizioneId
        WHERE i2.CorsoId = i.CorsoId                  -- Media solo per lo stesso corso
    )
ORDER BY 
    c.NomeCorso, v.Voto ASC;                         -- Ordina per corso e voto decrescente



-- STUDENTI CON VOTI ALLA MEDIA GENERALE
SELECT 
    s.NomeStudente,
    v.Voto
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
WHERE v.Voto <= (SELECT AVG(Voto) FROM Voto)
GROUP BY s.NomeStudente, v.Voto


select top 1 * From Studente

-- Studenti scritti a corsi con "SQL"
SELECT 
    s.NomeStudente
FROM Studente AS s
WHERE EXISTS (
    SELECT 1
    FROM Iscrizione AS i
    JOIN Corso AS c ON i.CorsoId = c.CorsoId
    WHERE i.StudenteId = s.StudenteId
      AND c.NomeCorso LIKE 'oop%'
);


select * from corso where NomeCorso like 'oop%'

SELECT 
    s.NomeStudente,
    c.NomeCorso,
    i.DataIscrizione,
    v.Voto
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
JOIN Corso AS c ON i.CorsoId = c.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
/*
    FILTRA PER NOME DELLO STUDENT  
             E NOME DEL CORSO CHE CONTIENE UNA LETTERA 
             E I  VOTI CHE SONO MINORE O UGUALE A  (V.Voto <= 27)
*/
WHERE s.NomeStudente LIKE 'S%' 
        AND c.NomeCorso LIKE '%B%' 
        AND v.Voto <= 27 
-- ORDINARE PRE VOTO IN DESC(DESCENDENTE)
-- ORDINARE PRE NOME DELLO STUDENTE ASC(CRESCENTE(DEFAULT))
ORDER BY v.voto DESC, s.NomeStudente

-- COONDIZIONE 
/* 
    CASE è un'espressione di condizione in SQL Server (simile al "SE...ALLORA..(IF .... ELSE)")
         nei linguaggi di programmazione come (Python, C# ecc...)
         o Fogli Excel

    Serve per:
        . Valori diversi in base a condizioni logiche.
        . Aggiungere logica decisionale nella query SQL
*/

/*
    CASE
         WHEN condizione1 THEN risultato1
         WHEN condizione2 THEN risultato2
         ...
         ELSE restituisce_default
    END (Chiude il blocco CASE) AS ...
*/

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
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
ORDER BY s.NomeStudente DESC


--================ VIEW ===============================
/*
    Cos'è una VIEW?
        Una view è come una finesta su una query:
        salva le query complessa e la tratta come se fosse una tabella 
*/


SELECT 
    s.NomeStudente,
    c.NomeCorso,
    i.DataIscrizione,
    v.Voto
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
JOIN Corso AS c ON i.CorsoId = c.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
/*
    FILTRA PER NOME DELLO STUDENT  
             E NOME DEL CORSO CHE CONTIENE UNA LETTERA 
             E I  VOTI CHE SONO MINORE O UGUALE A  (V.Voto <= 27)
*/
WHERE s.NomeStudente LIKE 'S%' 
        AND c.NomeCorso LIKE '%B%' 
        AND v.Voto <= 27 
-- ORDINARE PRE VOTO IN DESC(DESCENDENTE)
-- ORDINARE PRE NOME DELLO STUDENTE ASC(CRESCENTE(DEFAULT))
ORDER BY v.voto DESC, s.NomeStudente
