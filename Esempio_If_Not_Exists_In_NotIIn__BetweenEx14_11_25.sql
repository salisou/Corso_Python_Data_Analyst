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


