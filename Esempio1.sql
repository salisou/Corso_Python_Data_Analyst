-- Come cancellare il db Attenzione! non dovete mai fare quest in un azienda di produzione !!!!
-- DROP DATABASE ScuolaDb;


-- Crea unovo Database (F5 per eseguire il query)
CREATE DATABASE ScuolaDb;

-- Utilizzare il DB creato 
--use ScuolaDb;

-- Come creare una tabella 
	-- int per i numeri interi
	-- varchar testo (un insieme di char 'A')
	-- nvarchar testo (un insieme di char) 
	-- Date (Data)
CREATE TABLE Studente
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	NomeStudente NVARCHAR(50) NOT NULL, -- Questa colonna non pu� essere nullo
	CognomeStudente NVARCHAR(50) NOT NULL,  -- Questa colonna pu� essere nullo
	DataNascita Date,
	Email VARCHAR(25)
);

SELECT * FROM Studente


-----------------Modifica 1---------------