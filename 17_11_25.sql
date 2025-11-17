-- Join Non facile da capire 
SELECT 
	s.StudenteId as 'Matricola',
	s.NomeStudente as 'Nome dello studente',
	s.CognomeStudente as 'Cognome dello studente',
	c.NomeCorso as 'Nome del corsi'
FROM Iscrizione AS i, Corso AS c, Studente AS s
WHERE i.CorsoId = c.CorsoId and 
	  i.StudenteId = s.StudenteId



