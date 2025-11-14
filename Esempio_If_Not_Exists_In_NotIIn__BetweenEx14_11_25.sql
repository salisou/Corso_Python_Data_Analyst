--- IF NOT EXISTS , NOT,  IN, NOT IN, BETWEEN, TOP
SELECT 
	NomeStudente, 
	CognomeStudente
FROM Studente
WHERE NomeStudente IN ('Mousssa', 'Anna', 'Marco', 'Giulia')

-- Mostra solo i primi 5 studenti
select top 5 * from Studente


-- BETWEEN: Serve aper filtrare vaòori in un intervallo.
SELECT * 
FROM Voto
WHERE Voto BETWEEN 25 AND 30 -- trova voti tra 25 e 30
ORDER BY Voto desc


-- Creazione tabella solo se non esiste
IF NOT EXISTS (SELECT * FROM sys.objects where object_id = OBJECT_ID('[dbo].[Prova]') AND type = 'U')
BEGIN 
	CREATE TABLE Prova
	(
		ProvaId int not null PRIMARY KEY IDENTITY(200, 1),
		Nome nvarchar(25) not null,
		Cognome NVARCHAR(250)
	); 
END

--============== Esempio completo ===========
-- 1 Studenti scritti a corsi a specifici(IN)
SELECT 
	s.StudenteId AS 'Matricola',
	s.NomeStudente AS 'Nome dello Studente',
	s.CognomeStudente AS 'Cognome dello Studente',
	c.NomeCorso AS 'Nome del Corso'
FROM Iscrizione i
	INNER JOIN Studente s ON i.StudenteId = s.StudenteId  
	INNER JOIN Corso c ON i.CorsoId = c.CorsoId
WHERE i.CorsoId IN (1,2,3)
ORDER BY s.NomeStudente DESC

SELECT * FROM Corso


-- 2 Stundeti non scritti a determinate corsi(NOT IN)
SELECT -- Mostra studenti scritti a corsi diversi da 1,2,3
	s.StudenteId AS 'Matricola',
	s.NomeStudente AS 'Nome dello Studente',
	s.CognomeStudente AS 'Cognome dello Studente',
	c.NomeCorso AS 'Nome del Corso'
FROM Iscrizione i
	INNER JOIN Studente s ON i.StudenteId = s.StudenteId  
	INNER JOIN Corso c ON i.CorsoId = c.CorsoId
WHERE i.CorsoId NOT IN (1,2,3)
ORDER BY s.NomeStudente DESC


-- Verifica della tabella 
select * from Corso where NomeCorso in ('Programmazione', 'Database Relazionali')

-- 3 Studenti che hanno perso un voto in corsi specifici (IN con JOIN)
SELECT 
	s.NomeStudente AS 'Nome dello Studente',
	s.CognomeStudente AS 'Cognome dello Studente',
	c.NomeCorso AS 'Nome del Corso',
	v.Voto
FROM Voto v
	INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
	INNER JOIN Studente s ON i.StudenteId = s.StudenteId  
	INNER JOIN Corso c ON i.CorsoId = c.CorsoId
WHERE c.NomeCorso IN ('Programmazione', 'Database Relazionali')
ORDER BY v.Voto DESC;

-- 4 Studento che non hanno acora ricevuto voti (NOT IN Con Subquery)
SELECT 
	s.StudenteId AS 'Matricola',
	s.NomeStudente AS 'Nome dello Studente',
	s.CognomeStudente AS 'Cognome dello Studente'
FROM Studente s 
WHERE s.StudenteId IN 
			(SELECT
			 i.StudenteId
			 FROM Iscrizione i
			 WHERE i.IscrizioneId NOT IN (SELECT IscrizioneId FROM Voto)
      	    );


-- Esercizio: 1 Restutuire la lista degli studenti con almeno 2 voti in corsi specifici(IN+GROUP BY+HAVING)
SELECT 
    s.StudenteId,
    s.NomeStudente,
    s.CognomeStudente,
    COUNT(v.VotoId) AS NumeroVoti
FROM Voto v
    INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
    INNER JOIN Studente s ON i.StudenteId = s.StudenteId
    INNER JOIN Corso c ON i.CorsoId = c.CorsoId
WHERE c.CorsoId IN (1,2,3)
GROUP BY s.StudenteId, s.NomeStudente, s.CognomeStudente
HAVING COUNT(v.VotoId) >= 2
ORDER BY NumeroVoti DESC


-- Esercizio: 2 Restutuire la lista degli studenti che hanno voti solo in corsi tecnici(NOT INT+GROUP BY)
SELECT 
    s.StudenteId,
    s.NomeStudente,
    s.CognomeStudente,
    COUNT(v.VotoId) AS NumeroVoti
FROM Voto v
    INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
    INNER JOIN Studente s ON i.StudenteId = s.StudenteId
    INNER JOIN Corso c ON i.CorsoId = c.CorsoId
WHERE c.NomeCorso NOT IN ('Programmazione C#', 'Entity Framework Core', 'ASP.NET Core MVC')
GROUP BY s.StudenteId, s.NomeStudente, s.CognomeStudente
HAVING COUNT(v.VotoId) >= 1;


-- Esercizio: 3 Restutuire la media dei voti per corso, solo per corsi selezionati(AVG+ GROUP BY+ HAVING CON ORDERBY)
SELECT 
    c.NomeCorso,
    AVG(v.Voto) AS MediaVoti
FROM Voto v
    INNER JOIN Iscrizione i ON v.IscrizioneId = i.IscrizioneId
    INNER JOIN Corso c ON i.CorsoId = c.CorsoId
WHERE c.NomeCorso IN ('HTML e CSS', 'UX/UI Design', 'Git e Controllo Versione')
GROUP BY c.NomeCorso
HAVING AVG(v.Voto) >= 25
ORDER BY MediaVoti DESC;

-- 4 Restituisce la lista degli studenti con voti in corsi selezionati, 
-- ma non in altri (IN+ NOT IN Con Subquery) 
SELECT 
	s.StudenteId,
	s.NomeStudente, 
	s.CognomeStudente
FROM Studente s
WHERE s.StudenteId IN (-- Corsi selezionati
	SELECT i.IscrizioneId FROM Iscrizione i WHERE CorsoId IN (1,2,3)
)
AND s.StudenteId NOT IN (-- corsi de escludere 
	SELECT StudenteId FROM Iscrizione WHERE CorsoId	IN (4,5,6) 
);
