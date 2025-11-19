-- Creazione database
CREATE DATABASE AziendaDB;
USE AziendaDB;

-- Tabella Clienti
CREATE TABLE Clienti (
    ClienteId INT PRIMARY KEY INDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Telefono VARCHAR(50),
    Indirizzo VARCHAR(255),
    Data_Registrazione DATE DEFAULT CURRENT_DATE
);

-- Tabella Dipendenti
CREATE TABLE Dipendenti (
    DipendenteId INT PRIMARY KEY INDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Ruolo VARCHAR(100),
    Stipendio DECIMAL(10,2),
    Data_Assunzione DATE
);

-- Tabella Prodotti
CREATE TABLE Prodotti (
    ProdottoId INT PRIMARY KEY INDENTITY(1,1),
    Nome VARCHAR(150) NOT NULL,
    Descrizione TEXT,
    Prezzo DECIMAL(10,2) NOT NULL,
    Quantita INT DEFAULT 0
);

-- Tabella Ordini
CREATE TABLE Ordini (
    CodiceOrdine INT PRIMARY KEY INDENTITY(1,1),
    ClienteId INT NOT NULL,
    Data_Ordine DATE DEFAULT CURRENT_DATE,
    Totale DECIMAL(10,2),
    FOREIGN KEY (ClienteId) REFERENCES Clienti(ClienteId)
);

-- Tabella Dettagli Ordine
CREATE TABLE DettagliOrdine (
    DettaglioId INT PRIMARY KEY INDENTITY(1,1),
    CodiceOrdine INT NOT NULL,
    ProdottoId INT NOT NULL,
    Quantita INT NOT NULL,
    Prezzo_unitario DECIMAL(10,2),
    FOREIGN KEY (CodiceOrdine) REFERENCES Ordini(CodiceOrdine),
    FOREIGN KEY (ProdottoId) REFERENCES Prodotti(ProdottoId)
);

-- Tabella Fatture
CREATE TABLE Fatture (
    FatturaId INT PRIMARY KEY INDENTITY(1,1),
    CodiceOrdine INT NOT NULL,
    Data_Fattura DATE DEFAULT CURRENT_DATE,
    Importo DECIMAL(10,2),
    FOREIGN KEY (CodiceOrdine) REFERENCES Ordini(CodiceOrdine)
);


-- Aggiunta della colonna DipendentiId
ALTER TABLE Ordini
ADD DipendentiId INT NULL

ALTER TABLE Ordini
ADD CONSTRAINT FK_Ordini_Dipendenti
FOREIGN KEY (DipendenteId) REFERENCES  Dipendenti(DipendenteId)

SELECT * FROM Ordini