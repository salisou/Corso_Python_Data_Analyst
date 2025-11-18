-- Creazione database
CREATE DATABASE AziendaDB;
USE AziendaDB;

-- Tabella Clienti
CREATE TABLE Clienti (
    id_cliente INT PRIMARY KEY INDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(50),
    indirizzo VARCHAR(255),
    data_registrazione DATE DEFAULT CURRENT_DATE
);

-- Tabella Dipendenti
CREATE TABLE Dipendenti (
    id_dipendente INT PRIMARY KEY INDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    ruolo VARCHAR(100),
    stipendio DECIMAL(10,2),
    data_assunzione DATE
);

-- Tabella Prodotti
CREATE TABLE Prodotti (
    id_prodotto INT PRIMARY KEY INDENTITY(1,1),
    nome VARCHAR(150) NOT NULL,
    descrizione TEXT,
    prezzo DECIMAL(10,2) NOT NULL,
    quantita INT DEFAULT 0
);

-- Tabella Ordini
CREATE TABLE Ordini (
    id_ordine INT PRIMARY KEY INDENTITY(1,1),
    id_cliente INT NOT NULL,
    data_ordine DATE DEFAULT CURRENT_DATE,
    totale DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Clienti(id_cliente)
);

-- Tabella Dettagli Ordine
CREATE TABLE DettagliOrdine (
    id_dettaglio INT PRIMARY KEY INDENTITY(1,1),
    id_ordine INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita INT NOT NULL,
    prezzo_unitario DECIMAL(10,2),
    FOREIGN KEY (id_ordine) REFERENCES Ordini(id_ordine),
    FOREIGN KEY (id_prodotto) REFERENCES Prodotti(id_prodotto)
);

-- Tabella Fatture
CREATE TABLE Fatture (
    id_fattura INT PRIMARY KEY INDENTITY(1,1),
    id_ordine INT NOT NULL,
    data_fattura DATE DEFAULT CURRENT_DATE,
    importo DECIMAL(10,2),
    FOREIGN KEY (id_ordine) REFERENCES Ordini(id_ordine)
);


-- Aggiunta della colonna DipendentiId
ALTER TABLE Ordini
ADD DipendentiId INT NULL

ALTER TABLE Ordini
ADD CONSTRAINT FK_Ordini_Dipendenti
FOREIGN KEY (DipendenteId) REFERENCES  Dipendenti(DipendenteId)

SELECT * FROM Ordini