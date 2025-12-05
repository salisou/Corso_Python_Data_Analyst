-- Databse ScuolaDb
-- 1 Corsi
-- 2 Docenti
-- 3 Iscrizioni
-- 4 Studenti
-- 5 Voto
use ScuolaDb

-- Select 
select * from Studente;

-- Select WHERE 
select * from Studente where StudenteId = 1033

-- Select con Operatori (==, !=, <,>, Max, Min, Sum, Count, ecc...)
-- Select WHERE 
select NomeStudente, CognomeStudente from Studente where StudenteId = 1033 

-- Select WHERE 
select NomeStudente, CognomeStudente from Studente where StudenteId <> 1033 

-- Select WHERE 
select NomeStudente, CognomeStudente from Studente where StudenteId <> 1033 AND StudenteId <> 3

-- Select con join
-- Restituisci la lista degli studenti che sono scritti almeno ad un corso
SELECT
	* 
FROM Studente AS s
INNER JOIN Iscrizione I On i.IscrizioneId = s.StudenteId


SELECT * FROM Iscrizione
-- Restituisci la lista degli studenti che on sono scritti ad un corso
SELECT * 
FROM Studente as s
LEFT JOIN Iscrizione as i ON i.StudenteId = s.StudenteId
WHERE I.IscrizioneId IS NULL

-- Select con join
-- Restituisci la lista degli studenti che sono scritti al corso di OOP e Design Patterns
SELECT *
FROM Iscrizione as i
INNER JOIN Studente AS s ON s.StudenteId = i.StudenteId
INNER JOIN Corso AS c ON i.CorsoId = c.CorsoId
where NomeCorso = 'OOP e Design Patterns'


-- Mostra gli studenti iscritti al corso con ID = 1 Campi da visualizzare Nome, cognome
SELECT 
	s.NomeStudente,
	s.CognomeStudente
FROM Studente s
INNER JOIN Iscrizione i ON i.StudenteId = s.StudenteId
WHERE I.CorsoId = 1

-- Visualizza la media dei voti per corso 
-- Trova i corsi CHE HANNO UNA MEDIA VOTI >= 27 
SELECT 
	c.NomeCorso,
	AVG(v.Voto) AS MediaCorso
FROM Corso c
JOIN Iscrizione i ON i.CorsoId = c.CorsoId
JOIN Voto v ON v.IscrizioneId = i.IscrizioneId
GROUP BY c.NomeCorso
HAVING AVG(v.Voto) >= 27

-- Trova i corsi con più di Iscrizioni
-- Mostra i corsi che hanno almeno 6 Iscrizioni
SELECT
	c.NomeCorso,
	COUNT(*) as NumeroScritti
FROM Corso c
JOIN Iscrizione AS i On c.CorsoId = i.CorsoId
GROUP BY c.NomeCorso
HAVING COUNT(*) >= 6

select * from Corso 
select * from Iscrizione
select * from Docente
select * from Studente
select * from Voto


-- Create una Vista con Studenti, Corsi e Voti (Studente-Corso-Docente-Voti)
CREATE VIEW vw_StudentiCorsiVotiDocenti
AS
	SELECT 
		s.NomeStudente as 'Nome Studente',
		s.CognomeStudente AS 'Cognome Studente',
		c.NomeCorso,
		d.NomeDocente + ' ' + d.CognomeDocente AS 'Docente',
		v.Voto 
	FROM Studente AS s
	INNER JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
	INNER JOIN Corso AS c ON c.CorsoId = i.CorsoId
	INNER JOIN Docente AS d ON d.DocenteId = c.CorsoId
	INNER JOIN  Voto AS v ON v.IscrizioneId = i.IscrizioneId

select * from vw_StudentiCorsiVotiDocenti

-- Studenti con voto superiore alla media del corso
-- TROVA GLI STUDENTI CON VOTO > MEDIA CORSO SENZA SUBQUERY, USA JOIN MA LA SUBQUERY(con la subquery)
SELECT 
	s.NomeStudente,
	s.CognomeStudente,
	v.Voto
FROM Studente AS s
	INNER JOIN Iscrizione AS i ON i.StudenteId = s.StudenteId
	INNER JOIN Corso AS c ON c.CorsoId = i.CorsoId
	INNER JOIN Voto AS v ON v.IscrizioneId = i.IscrizioneId 
	INNER JOIN (
				SELECT 
					I.CorsoId,
					AVG(v.Voto) AS MediaCorso
				FROM Iscrizione AS i
					INNER JOIN Voto AS v ON v.IscrizioneId = i.IscrizioneId
					GROUP BY I.CorsoId
				) AS m ON m.CorsoId = c.CorsoId
WHERE v.Voto > m.MediaCorso


-- Aggiungere la colonna Promosso/Bocciato
-- Mostra Studente-Corso-Voto-Stato(Promosso se >= 18)
SELECT 
	s.NomeStudente + ' ' + s.CognomeStudente AS 'Studente',
	c.NomeCorso,
	v.Voto,
	CASE
		WHEN v.Voto >= 18 THEN 'Promosso'
		ELSE 'Bocciato'
	END AS Stato
FROM Studente AS s
INNER JOIN Iscrizione AS i ON i.StudenteId = s.StudenteId
INNER JOIN Corso AS c ON c.CorsoId = i.CorsoId
INNER JOIN Voto AS v ON v.IscrizioneId = i.IscrizioneId


SELECT * FROM Docente
-- Modifica il Nome e cognome del 2° Docente con "Daniela, Cela"  
UPDATE Docente
SET NomeDocente = 'Daniela',
	CognomeDocente = 'Cela'
WHERE DocenteId = 2

select * from Corso
-- INSERIRE UN NUOVO ASSEGNATO AL DOCENTE 1 (Programmazione Web)
INSERT INTO Corso (NomeCorso, Descrizione, Crediti, DocenteId)
VALUES ('Programmazione Web', 'Programmazione OOP', 15, 1)