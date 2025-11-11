-- ==========================================
-- CREAZIONE DATABASE SCUOLADB
-- ==========================================
CREATE DATABASE ScuolaDb;
GO

USE ScuolaDb;
GO

-- ==========================================
-- TABELLA: STUDENTI
-- ==========================================
CREATE TABLE Studenti (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    DataNascita DATE NULL,
    Classe NVARCHAR(10) NULL
);
GO

-- ==========================================
-- TABELLA: DOCENTI
-- ==========================================
CREATE TABLE Docenti (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    MateriaPrincipale NVARCHAR(100) NULL
);
GO

-- ==========================================
-- TABELLA: CORSI
-- ==========================================
CREATE TABLE Corsi (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NomeCorso NVARCHAR(100) NOT NULL,
    Descrizione NVARCHAR(255) NULL,
    DocenteId INT NULL,
    CONSTRAINT FK_Corsi_Docenti FOREIGN KEY (DocenteId) REFERENCES Docenti(Id)
);
GO

-- ==========================================
-- TABELLA: ISCRIZIONI (Relazione N:N Studenti–Corsi)
-- ==========================================
CREATE TABLE Iscrizioni (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudenteId INT NOT NULL,
    CorsoId INT NOT NULL,
    DataIscrizione DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Iscrizioni_Studenti FOREIGN KEY (StudenteId) REFERENCES Studenti(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Iscrizioni_Corsi FOREIGN KEY (CorsoId) REFERENCES Corsi(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Iscrizioni UNIQUE (StudenteId, CorsoId)
);
GO

-- ==========================================
-- TABELLA: VOTI
-- ==========================================
CREATE TABLE Voti (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudenteId INT NOT NULL,
    CorsoId INT NOT NULL,
    Valutazione DECIMAL(4,2) NOT NULL CHECK (Valutazione BETWEEN 0 AND 10),
    DataVoto DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Voti_Studenti FOREIGN KEY (StudenteId) REFERENCES Studenti(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Voti_Corsi FOREIGN KEY (CorsoId) REFERENCES Corsi(Id) ON DELETE CASCADE
);
GO

-- ==========================================
-- DATI DI ESEMPIO (PER TEST DIDATTICI)
-- ==========================================
INSERT INTO Studenti (Nome, Cognome, Email, Classe) VALUES
('Marco', 'Rossi', 'marco.rossi@example.com', '3A'),
('Lida', 'Bianchi', 'lida.bianchi@example.com', '4B'),
('Alessandro', 'Verdi', 'alessandro.verdi@example.com', '3A'),
('Ilaria', 'Neri', 'ilaria.neri@example.com', '5C');

INSERT INTO Docenti (Nome, Cognome, Email, MateriaPrincipale) VALUES
('Lucia', 'Conti', 'lucia.conti@example.com', 'Matematica'),
('Gianni', 'Russo', 'gianni.russo@example.com', 'Informatica'),
('Elena', 'Ferrari', 'elena.ferrari@example.com', 'Inglese');

INSERT INTO Corsi (NomeCorso, Descrizione, DocenteId) VALUES
('Matematica', 'Corso base di matematica generale', 1),
('Informatica', 'Programmazione base in C#', 2),
('Inglese', 'Lingua inglese intermedia', 3);

INSERT INTO Iscrizioni (StudenteId, CorsoId) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 3),
(4, 3);

INSERT INTO Voti (StudenteId, CorsoId, Valutazione) VALUES
(1, 1, 8.5),
(1, 2, 7.0),
(2, 2, 9.2),
(3, 3, 6.8),
(4, 3, 8.0);
GO
