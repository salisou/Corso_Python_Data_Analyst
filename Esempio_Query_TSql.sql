
-- select all from student
Select * from Studente;


-- Distinct viene utilizzato per restituire solo valori unici
-- Eempio
SELECT DISTINCT 
	NomeStudente as Nome,
	CognomeStudente as Cogome,
	Email 
FROM
	Studente

-- Cancellare la tabella Corso
-- Drop Table corso;

-- Creazione della tabella dei corsi
--CREATE TABLE Corso
--(
--	CorsoId INT PRIMARY KEY IDENTITY(1,1),
--	NomeCorso NVARCHAR(100) NOT NULL,
--	Descrizione NVARCHAR(255) NOT NULL,
--	Crediti INT
--);



--CREATE TABLE Iscrizione
--(
--	IscrizioneId INT PRIMARY KEY IDENTITY(1,1),
--	StudenteId INT,
--	CorsoId INT,
--	DataIscrizione Date,
--	FOREIGN KEY (StudenteId) REFERENCES Studente(Id),
--	FOREIGN KEY (CorsoId) REFERENCES Corso(CorsoId)
--); 


-- Create la tabella Voto(VotoId, IscrizioneId, Voto, DataEsame)

--CREATE TABLE Voto
--(
--	VodoId INT PRIMARY KEY IDENTITY(1,1),
--	IscrizioneId INT,
--	Voto INT,
--	DataEsame Date,
--	FOREIGN KEY (IscrizioneId) REFERENCES Iscrizione(IscrizioneId)
--);

INSERT INTO 
		Corso(NomeCorso, Descrizione, Crediti) 
	VALUES 
		('Storia', 'Programmazione in Python', 5 )

Select * from Studente;
SELECT * FROM Corso;
SELECT * FROM Iscrizione;
SELECT * FROM Voto;


INSERT INTO Iscrizione(StudenteId, CorsoId,DataIscrizione) 
			VALUES (2,2,'2024-09-01');
INSERT INTO Iscrizione(StudenteId, CorsoId,DataIscrizione) 
			VALUES (3,3,'2024-09-01');
INSERT INTO Iscrizione(StudenteId, CorsoId,DataIscrizione) 
			VALUES (4,4,'2025-11-10');
INSERT INTO Iscrizione(StudenteId, CorsoId,DataIscrizione) 
			VALUES (5,2,'2022-09-01');
INSERT INTO Iscrizione(StudenteId, CorsoId,DataIscrizione) 
			VALUES (1,3,'2024-09-01');


-- Inserimeno dei voti
INSERT INTO Voto (IscrizioneID, Voto, DataEsame)
	VALUES
		(1, 28, '2022-12-15'),
		(2, 30, '2022-12-16'),
		(3, 25, '2022-12-17'),
		(4, 27, '2022-12-18'),
		(5, 29, '2022-12-19'),
		(6, 26, '2022-12-20')