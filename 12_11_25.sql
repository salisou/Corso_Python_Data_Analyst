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
