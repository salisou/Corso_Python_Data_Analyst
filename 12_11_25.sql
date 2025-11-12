use ScuolaDb;

/*
	Raggruppare per studente (media voti)
		Risultato: una riga per studente, 
		con la media dei voti ordinata dal più alto al più basso.
*/
SELECT 
	s.NomeStudente AS 'Nome dello studente',
	i.DataIscrizione,
	AVG(v.Voto) AS MediaVoti
FROM Studente s
	INNER JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
	INNER JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
GROUP BY s.NomeStudente, DataIscrizione
ORDER BY MediaVoti DESC




/*
	Raggruppare per corso (media voti del corso)
	Ottieni:
		. Media dei voti per corso
		. Quante valutazioni ci sono state (COUNT)
		. Ordina dal corso con la media più alta.
*/
SELECT 
	c.NomeCorso AS 'Nome del corso',
	AVG(v.Voto) AS MediaCorso,
	COUNT(v.Voto) AS NumeroEsami
FROM Corso AS c
	JOIN Iscrizione AS i ON c.CorsoId = i.CorsoId
	JOIN Voto AS v ON v.IscrizioneId = i.IscrizioneId
GROUP BY c.NomeCorso
ORDER BY MediaCorso DESC

select * from Corso
/*
   Cos'è HAVING?
    HAVING si usa dopo GROUP BY 
		per filtrare i gruppi in base a condizioni 
		su funzioni aggregate (AVG, COUNT, SUM, MIN, MAX, ecc.).
    È simile a WHERE, ma WHERE filtra prima del raggruppamento, 
	mentre HAVING filtra dopo.

   ⚠️ HAVING si usa dopo il GROUP BY (mentre WHERE filtra le righe prima del raggruppamento).

	Differenza tra WHERE e HAVING

	Filtro su...		Usa WHERE	Usa HAVING
	Colonne normali	        ✅SI	     ❌NO
	Funzioni aggregate		❌NO		 ✅SI
	Prima del GROUP BY		✅SI		 ❌NO
	Dopo il GROUP BY		❌NO		 ✅SI
*/
SELECT 
    c.NomeCorso,
    AVG(v.Voto) AS MediaCorso
FROM Corso AS c
JOIN Iscrizione AS i ON c.CorsoId = i.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
GROUP BY c.NomeCorso
HAVING AVG(v.Voto) >= 27
ORDER BY MediaCorso Asc;

-- Esempio: con MIN e Max: renge dei voti per studente
SELECT 
    s.NomeStudente AS 'Nome dello studente',           -- Mostra il nome dello studente
    s.CognomeStudente AS 'Cognome dello studente',     -- Mostra il cognome dello studente
    MIN(v.Voto) AS VotoMinimo,                         -- Calcola il voto più basso ottenuto
    MAX(v.Voto) AS VotoMassimo                         -- Calcola il voto più alto ottenuto
FROM 
    Voto v                                             -- Tabella dei voti
    INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId   -- Collegamento ai corsi sostenuti
    INNER JOIN Studente s ON i.StudenteId = s.StudenteId         -- Collegamento agli studenti
GROUP BY 
    s.NomeStudente, s.CognomeStudente                  -- Raggruppa i risultati per studente
HAVING 
    MAX(v.Voto) >= 25                                  -- Mostra solo gli studenti con almeno un voto ≥ 25
ORDER BY 
    VotoMinimo ASC;                                    -- Ordina i risultati dal voto minimo più basso


--Verifica 
SELECT 
    s.NomeStudente,
    s.CognomeStudente,
    COUNT(v.Voto) AS NumeroVoti
FROM Voto v
    INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
    INNER JOIN Studente s ON i.StudenteId = s.StudenteId
GROUP BY 
    s.NomeStudente, s.CognomeStudente
HAVING COUNT(v.Voto) = 1;


/*
 Cos'è GROUP BY in SQL?
    GROUP BY è una clausola che serve per raggruppare i dati in base a uno o più campi, 
    così da poter calcolare valori aggregati (come somma, media, minimo, massimo, conteggio)
    per ciascun gruppo.


    In altre parole:
        Seleziona un criterio di raggruppamento, 
        e poi calcola qualcosa per ogni gruppo.

*/

-- Esempio semplice: numero di studenti per cognome

    SELECT 
        CognomeStudente,
        COUNT(*) AS NumeroStudenti
    FROM Studente
    GROUP BY CognomeStudente;

-- Esempio con JOIN: media voti per corso 
/*
Risultato:
    Un elenco di corsi.
    Per ogni corso, la media dei voti ottenuti dagli studenti.
*/

SELECT 
    C.NomeCorso,
    AVG(V.Voto) AS MediaVoti
FROM Voto V
    INNER JOIN Iscrizione I ON V.IscrizioneId = I.IscrizioneId
    INNER JOIN Corso C ON I.CorsoId = C.CorsoId
GROUP BY C.NomeCorso;


/*
    Regole fondamentali
    ___________________________________________________________________
    Comando	    |    Funzione                                          |
    -------------------------------------------------------------------|
    GROUP BY	|    Raggruppa righe con lo stesso valore              |
    SELECT	    |    Deve contenere solo colonne gruppate o aggregate  |
    HAVING	    |    Filtra i gruppi dopo il raggruppamento            |
    WHERE	    |    Filtra le righe prima del raggruppamento          |
*/

-- Esercizio: StudenteId(Matricola) Nome dello studente, Corso, Voto Min/Max filtrare se  il risultato <= 27  
SELECT 
    s.StudenteId AS Matricola,                      -- ID dello studente (matricola)
    s.NomeStudente AS 'Nome dello studente',        -- Nome
    s.CognomeStudente AS 'Cognome dello studente',  -- Cognome
    c.NomeCorso AS 'Corso',                         -- Nome del corso frequentato
    MIN(v.Voto) AS VotoMinimo,                      -- Voto più basso ottenuto
    MAX(v.Voto) AS VotoMassimo                      -- Voto più alto ottenuto
FROM Voto v
    INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
    INNER JOIN Studente s ON i.StudenteId = s.StudenteId
    INNER JOIN Corso c ON i.CorsoId = c.CorsoId
GROUP BY 
    s.StudenteId, s.NomeStudente, s.CognomeStudente, c.NomeCorso
HAVING 
    MAX(v.Voto) <= 27                               -- Mostra solo chi ha massimo voto ≤ 27
ORDER BY 
    VotoMassimo ASC;


/*

Esercizio:
    Mostra per ogni studente il numero di esami sostenuti:
*/