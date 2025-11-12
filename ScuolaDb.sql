-- Rimozione vincoli da Iscrizione
ALTER TABLE [dbo].[Iscrizione] DROP CONSTRAINT [FK__Iscrizion__Stude__72C60C4A];
ALTER TABLE [dbo].[Iscrizione] DROP CONSTRAINT [FK__Iscrizion__Corso__73BA3083];

-- Rimozione vincolo da Voto
ALTER TABLE [dbo].[Voto] DROP CONSTRAINT [FK__Voto__Iscrizione__778AC167];
GO

-- Eliminazione tabelle
DROP TABLE IF EXISTS [dbo].[Voto];
DROP TABLE IF EXISTS [dbo].[Iscrizione];
DROP TABLE IF EXISTS [dbo].[Corso];
DROP TABLE IF EXISTS [dbo].[Studente];
GO


CREATE TABLE [dbo].[Studente](
    [StudenteId] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
    [NomeStudente] NVARCHAR(100)  NOT NULL,
    [CognomeStudente] NVARCHAR(100)  NOT NULL,
    [DataNascita] DATE NULL,
    [Email] NVARCHAR(50) NOT NULL
);

CREATE TABLE [dbo].[Corso](
    [CorsoId] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    [NomeCorso] NVARCHAR(100) NOT NULL,
    [Descrizione] NVARCHAR(100) NOT NULL,
    [Crediti] INT NULL,
);

CREATE TABLE [dbo].[Iscrizione](
    [IscrizioneId] [int] IDENTITY(1,1) NOT NULL,
    [StudenteId] [int] NULL,
    [CorsoId] [int] NULL,
    [DataIscrizione] [date] NULL,
PRIMARY KEY CLUSTERED ([IscrizioneId] ASC)
) ON [PRIMARY];
GO

-- Vincoli FK
ALTER TABLE [dbo].[Iscrizione] WITH CHECK ADD FOREIGN KEY([StudenteId])
REFERENCES [dbo].[Studente] ([StudenteId]);
GO

ALTER TABLE [dbo].[Iscrizione] WITH CHECK ADD FOREIGN KEY([CorsoId])
REFERENCES [dbo].[Corso] ([CorsoId]);
GO


CREATE TABLE [dbo].[Voto](
    [VotoId] [int] IDENTITY(1,1) NOT NULL,
    [IscrizioneId] [int] NULL,
    [Voto] [int] NULL,
    [DataEsame] [date] NULL,
PRIMARY KEY CLUSTERED ([VotoId] ASC)
) ON [PRIMARY];
GO

-- Vincolo FK
ALTER TABLE [dbo].[Voto] WITH CHECK ADD FOREIGN KEY([IscrizioneId])
REFERENCES [dbo].[Iscrizione] ([IscrizioneId]);
GO


--===================Inerimenti=========================

-- Studenti Insert
INSERT INTO [dbo].[Studente] ([NomeStudente], [CognomeStudente], [DataNascita], [Email])
VALUES 
('Ilaria', 'Colombraro', '2000-12-12', 'ilaria.colombraro@gmail.com'),
('Anna', 'Lukianiuk', '2001-12-12', 'anna.lukianiuk@gamil.com'),
('Moussa', 'Salisou', '1999-12-12', 'm.salisou@gmail.com'),
('Marco', 'Cogoni', '2000-12-12', 'm.cogoni@gamil.com'),
('Sara', 'Rocco', '2002-12-12', 'roccco.s@gamil.com'),
('Di Donni', 'Marco', '2001-11-11', 'm.didonni@gamil.com'),
('Amina', 'Rossi', '2002-05-10', 'amina.rossi@gamail.it'),
('Luca', 'Bianchi', '2001-03-22', 'luca@info.com'),
('Sara', 'Verdi', '2003-07-15', 's.verdi@gmail.com'),
('Marco', 'Neri', '2000-11-30', 'marco.neri@gmail.com'),
('Giulia', 'Gallo', '2002-01-05', 'giulia.gallo@gmail.it'),
('Elena', 'Costa', '2001-06-18', 'elena.costa@italia.it'),
('Davide', 'Ferrari', '2003-09-09', 'd.ferrari1@formulauno.it'),
('Chiara', 'Russo', '2002-04-25', 'chiara.russo@gmail.com'),
('Andrea', 'Conti', '2000-08-08', 'andrea255@gmail.com'),
('Francesco', 'Romano', '2001-10-10', 'francesco.romano@edu.it'),
('Martina', 'Greco', '2002-02-02', 'martina.greco@scuola.it'),
('Simone', 'Moretti', '2000-06-06', 'simone.moretti@info.it'),
('Valentina', 'De Luca', '2003-03-03', 'valentina.deluca@gmail.com'),
('Alessandro', 'Vitale', '2001-04-04', 'alessandro.vitale@edu.it'),
('Federica', 'Mariani', '2002-07-07', 'federica.mariani@scuola.it'),
('Giorgio', 'Barbieri', '2000-09-09', 'giorgio.barbieri@info.it'),
('Laura', 'Pellegrini', '2003-01-01', 'laura.pellegrini@gmail.com'),
('Stefano', 'Grassi', '2001-05-05', 'stefano.grassi@edu.it'),
('Beatrice', 'Fontana', '2002-08-08', 'beatrice.fontana@scuola.it'),
('Nicola', 'Riva', '2000-10-10', 'nicola.riva@info.it'),
('Alessia', 'Ferri', '2003-04-04', 'alessia.ferri@gmail.com'),
('Tommaso', 'Martini', '2001-06-06', 'tommaso.martini@edu.it'),
('Elisa', 'Sartori', '2002-11-11', 'elisa.sartori@scuola.it'),
('Daniele', 'Serra', '2000-07-07', 'daniele.serra@info.it');

-- Insert Corsi
INSERT INTO [dbo].[Corso] ([NomeCorso], [Descrizione], [Crediti])
VALUES 
('Programmazione C#', 'Introduzione alla programmazione con C# e .NET', 6),
('Sviluppo Web con Blazor', 'Creazione di applicazioni web interattive con Blazor WebAssembly', 6),
('Database Relazionali', 'Progettazione e interrogazione di database con SQL Server', 6),
('HTML e CSS', 'Fondamenti di markup e stile per il web', 3),
('JavaScript Avanzato', 'Tecniche moderne di sviluppo frontend con JavaScript', 6),
('OOP e Design Patterns', 'Principi di programmazione orientata agli oggetti e pattern architetturali', 6),
('Entity Framework Core', 'Accesso ai dati con EF Core in ambienti .NET', 4),
('ASP.NET Core MVC', 'Sviluppo di applicazioni web con ASP.NET Core MVC', 6),
('Git e Controllo Versione', 'Gestione del codice sorgente con Git e GitHub', 3),
('Testing e Debugging', 'Tecniche di test unitario e debugging in C#', 4),
('Sicurezza Web', 'Principi di sicurezza nelle applicazioni web', 3),
('REST API con .NET', 'Creazione e consumo di API RESTful con ASP.NET Core', 5),
('UX/UI Design', 'Progettazione dell’esperienza utente e interfacce grafiche', 3),
('Progetto Finale', 'Sviluppo di un’applicazione completa in team', 6),
('Cloud Computing', 'Introduzione ai servizi cloud con Azure', 4);

-- Insert Iscrizioni
INSERT INTO [dbo].[Iscrizione] ([StudenteId], [CorsoId], [DataIscrizione])
VALUES
(1, 1, '2024-09-01'), (2, 2, '2024-09-01'), (3, 3, '2024-09-01'), (4, 4, '2024-09-01'),
(5, 5, '2024-09-01'), (6, 6, '2024-09-01'), (7, 7, '2024-09-01'), (8, 8, '2024-09-01'),
(9, 9, '2024-09-01'), (10, 10, '2024-09-01'), (11, 11, '2024-09-01'), (12, 12, '2024-09-01'),
(13, 13, '2024-09-01'), (14, 14, '2024-09-01'), (15, 15, '2024-09-01'), (16, 1, '2024-09-01'),
(17, 2, '2024-09-01'), (18, 3, '2024-09-01'), (19, 4, '2024-09-01'), (20, 5, '2024-09-01'),
(21, 6, '2024-09-01'), (22, 7, '2024-09-01'), (23, 8, '2024-09-01'), (24, 9, '2024-09-01'),
(25, 10, '2024-09-01'), (26, 11, '2024-09-01'), (27, 12, '2024-09-01'), (28, 13, '2024-09-01'),
(29, 14, '2024-09-01'), (30, 15, '2024-09-01'), (1, 2, '2024-09-01'), (2, 3, '2024-09-01'),
(3, 4, '2024-09-01'), (4, 5, '2024-09-01'), (5, 6, '2024-09-01'), (6, 7, '2024-09-01'),
(7, 8, '2024-09-01'), (8, 9, '2024-09-01'), (9, 10, '2024-09-01'), (10, 11, '2024-09-01');


-- Insert dei Voti
INSERT INTO [dbo].[Voto] ([IscrizioneId], [Voto], [DataEsame])
VALUES
(1, 28, '2025-01-15'), (2, 30, '2025-01-16'), (3, 26, '2025-01-17'), (4, 18, '2025-01-18'),
(5, 24, '2025-01-19'), (6, 30, '2025-01-20'), (7, 22, '2025-01-21'), (8, 27, '2025-01-22'),
(9, 29, '2025-01-23'), (10, 25, '2025-01-24'), (11, 30, '2025-01-25'), (12, 19, '2025-01-26'),
(13, 28, '2025-01-27'), (14, 30, '2025-01-28'), (15, 21, '2025-01-29'), (16, 26, '2025-01-30'),
(17, 30, '2025-01-31'), (18, 27, '2025-02-01'), (19, 29, '2025-02-02'), (20, 30, '2025-02-03'),
(21, 25, '2025-02-04'), (22, 30, '2025-02-05'), (23, 28, '2025-02-06'), (24, 30, '2025-02-07'),
(25, 26, '2025-02-08'), (26, 30, '2025-02-09'), (27, 29, '2025-02-10'), (28, 30, '2025-02-11'),
(29, 30, '2025-02-12'), (30, 30, '2025-02-13');

