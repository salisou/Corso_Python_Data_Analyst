use ScuolaDb;

/*
	Raggruppare per studente (media voti)
		Risultato: una riga per studente, 
		con la media dei voti ordinata dal più alto al più basso.
*/
SELECT 
	s.NomeStudente AS 'Nome dello studente',
	AVG(v.Voto) AS MediaVoti
FROM Studente s
	INNER JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
	INNER JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
GROUP BY s.NomeStudente
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

/*
   ⚠️ HAVING si usa dopo il GROUP BY (mentre WHERE filtra le righe prima del raggruppamento).
*/
SELECT 
    c.NomeCorso,
    AVG(v.Voto) AS MediaCorso
FROM Corso AS c
JOIN Iscrizione AS i ON c.CorsoId = i.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
GROUP BY c.NomeCorso
HAVING AVG(v.Voto) >= 27
ORDER BY MediaCorso DESC;
