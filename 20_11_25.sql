-- CHECK

CREATE TABLE Voto
(
	VotoId int primary key identity(1,1),
	Voto int CHECK(Voto BETWEEN 0 AND 30) not null
)

ALTER TABLE Voto
ADD CONSTRAINT CK_Voto_valore CHECK(Voto BETWEEN 0 AND 30)

SELECT * FROM Voto
SELECT * FROM Iscrizione

-- BLOCCA VOTI COME 31, 35, -10, -1
-- ACCETTA SOLO VOTI DA 0 A 30
INSERT INTO Voto (IscrizioneId, Voto)
VALUES (1, 25);


UPDATE Voto SET Voto = 18 WHERE VotoId = 2

SELECT * FROM Voto WHERE Voto = 30;


-- UNIQUE - EVITA DUPLICATI
ALTER TABLE Studente
ADD CONSTRAINT UQ_Studente_Email
UNIQUE (Email)


select * from studente where DataNascita = '1987-10-10' 

INSERT INTO Studente (NomeStudente, CognomeStudente, DataNascita, Email)
VALUES ('Simone', 'Verdi', '1987-10-10', 'verdi.s@gmail.com')


-- DocenteId, NomeDocente, CognomeDocente, Email, Telefono, DataAssunzione