-- Join Non facile da capire 
--SELECT
--	s.StudenteId as 'Matricola',
--	s.NomeStudente as 'Nome dello studente',
--	s.CognomeStudente as 'Cognome dello studente',
--	c.NomeCorso as 'Nome del corsi',
--	v.Voto
--FROM Iscrizione AS i, Corso AS c, Studente AS s, Voto AS v
--WHERE i.CorsoId = c.CorsoId and 
--	  i.StudenteId = s.StudenteId


--================ Modifiche aggiunta Colonne ====================
EXEC sp_rename 'Clienti.NomeCliente', 'Nome', 'COLUMN';


-- Aggiunta delle colonne  
ALTER TABLE Clienti
ADD Indirizzo VARCHAR(255),
    DataRegistrazione DATE DEFAULT CURRENT_DATE;

-- Aggiunta di una colonna se non esiste
ALTER TABLE Clienti
ADD Telefono nvarchar(50) NOT NULL 
    CONSTRAINT UQ_Clienti_Telefono UNIQUE;

-- MODIFICARE il vincolo UNIQUE:
ALTER TABLE Clienti
ADD CONSTRAINT UQ_Clienti_Telefono UNIQUE (Telefono);


-- Definire le relazione tra tabelle 
ALTER TABLE Ordini
ADD CONSTRAINT FK_Ordini_Clienti 
FOREIGN KEY (ClienteId) REFERENCES Clienti(ClienteId);

ALTER TABLE DetaglioOrdine
ADD CONSTRAINT FK_DetaglioOrdine_Ordini
FOREIGN KEY (CodiceOrdine) REFERENCES Ordini(CodiceOrdine);

ALTER TABLE DetaglioOrdine
ADD CONSTRAINT FK_DetaglioOrdine_Prodotti
FOREIGN KEY (ProdottoId) REFERENCES Prodotti(ProdottoId);

-- =========== Tabella dei dipenteti ===
CREATE TABLE Dipendenti
(
    DipendenteId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,
    Cognome NVARCHAR(100) NOT NULL,
    Ruolo NVARCHAR(150) NOT NULL,
    Stipendio DECIMAL(10, 2),
    DataAssunzione DATE 
);


-- ======== TABELLA FATTURE =============
CREATE TABLE Fattura 
(
	FatturaId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CodiceOrdine INT NOT NULL,
	DataFattura Date DEFAULT CURRENT_DATE,
	Importo DECIMAL(10 ,2),
	FOREIGN KEY (CodiceOrdine) REFERENCES Ordini(CodiceOrdine)
);

SELECT * FROM Clienti;
-- ================== Insert Clienti ==================
INSERT INTO Clienti (Nome, IndirizzoMail, Telefono, Indirizzo, DataRegistrazione)
VALUES 
('Antonino Rossi', 'antonio.rosso@gmail.com', '0123456789', 'Via Milano 10, Roma', CAST(GETDATE() AS DATE));

INSERT INTO Clienti (Nome, IndirizzoMail, Telefono, Indirizzo, DataRegistrazione)
VALUES 
('Luaura Bianchi', 'l.bianchi@volvo.it', '9876543210', 'Via Torino 22, Milano', '2022-11-20');

INSERT INTO Clienti (Nome, IndirizzoMail, Telefono, Indirizzo)
VALUES 
('Giuseppe verdi', 'giuseppe789@gmail.com', '3254789112', 'Via Napoli 5, Napoli');

-- ================== Insert Dipendenti ==================
INSERT INTO Dipendenti (Nome, Cognome, Ruolo, Stipendio, DataAssunzione)
Values 
('Sara', 'Colombo', 'Risponsabile Vendite', 2200.00, '2021-04-20'),
('Marco', 'Ferrari', 'Commesso', 1500.00, '2022-10-30')

SELECT * FROM Dipendenti;

-- =================== Insert Prodotti ====================
INSERT INTO Prodotti (NomeProdotto, Descrizione, Prezzo, Quantita)
VALUES ('Laptop Hp', 'Notebook 15.6 pollici', 899.99, 10),
       ('Mouse Logitech', 'Mouse wireless', 75.99, 50),
       ('Monitor Samsung', 'Monitor 36 pollici', 449.99, 45)

SELECT * FROM Prodotti;

-- =================== Insert Ordini ====================
INSERT INTO Ordini (ClienteId, Dara_Ordine, Totale)
VALUES (1, CAST(GETDATE() AS DATE), 1200);

SELECT * FROM Ordini;