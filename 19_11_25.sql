-- CRUD per tutte le tabelle
-- 1. Clienti

-- CREATE
CREATE PROCEDURE sp_InserisciCliente
    @nome VARCHAR(100),
    @IndirizzoMail VARCHAR(150),
    @telefono VARCHAR(50),
    @indirizzo VARCHAR(255)
AS
BEGIN
    INSERT INTO Clienti (nome, IndirizzoMail, telefono, indirizzo, DataRegistrazione)
    VALUES (@nome, @IndirizzoMail, @telefono, @indirizzo, GETDATE());
END;
GO

-- READ
CREATE PROCEDURE sp_GetAllClienti
AS
BEGIN
    SELECT * FROM Clienti;
END;
GO

-- UPDATE
CREATE PROCEDURE sp_UpdateCliente
    @ClienteId INT,
    @telefono VARCHAR(50),
    @indirizzo VARCHAR(255)
AS
BEGIN
    UPDATE Clienti
    SET telefono = @telefono, indirizzo = @indirizzo
    WHERE ClienteId = ClienteId;
END;
GO

-- DELETE
CREATE PROCEDURE sp_DepeteCliente
    @id_cliente INT
AS
BEGIN
    DELETE FROM Clienti WHERE ClienteId = ClienteId;
END;
GO


-- 2. Dipendenti

-- CREATE
CREATE PROCEDURE sp_InsertDipendente
    @nome VARCHAR(100),
    @cognome VARCHAR(100),
    @ruolo VARCHAR(100),
    @stipendio DECIMAL(10,2),
    @dataAssunzione DATE
AS
BEGIN
    INSERT INTO Dipendenti (nome, cognome, ruolo, stipendio, DataAssunzione)
    VALUES (@nome, @cognome, @ruolo, @stipendio, @dataAssunzione);
END;
GO

-- READ
CREATE PROCEDURE sp_GetAllDipendenti
AS
BEGIN
    SELECT * FROM Dipendenti;
END;
GO

-- UPDATE
CREATE PROCEDURE sp_UpdateDipendente
    @dipendenteId INT,
    @stipendio DECIMAL(10,2)
AS
BEGIN
    UPDATE Dipendenti
    SET stipendio = @stipendio
    WHERE DipendenteId = @dipendenteId;
END;
GO

-- DELETE
CREATE PROCEDURE sp_DeleteDipendente
    @dipendenteId INT
AS
BEGIN
    DELETE FROM Dipendenti WHERE DipendenteId = @dipendenteId;
END;
GO

-- 3. Prodotti

-- CREATE
CREATE PROCEDURE sp_IsertProdotto
    @nomeprodotto VARCHAR(150),
    @descrizione TEXT,
    @prezzo DECIMAL(10,2),
    @quantita INT
AS
BEGIN
    INSERT INTO Prodotti (NomeProdotto, descrizione, prezzo, quantita)
    VALUES (@nomeprodotto, @descrizione, @prezzo, @quantita);
END;
GO

-- READ
CREATE PROCEDURE sp_GetAllProdotti
AS
BEGIN
    SELECT * FROM Prodotti;
END;
GO

-- UPDATE
CREATE PROCEDURE sp_UpdateProdotto
    @prodottoId INT,
    @prezzo DECIMAL(10,2),
    @quantita INT
AS
BEGIN
    UPDATE Prodotti
    SET prezzo = @prezzo, 
        quantita = @quantita
    WHERE ProdottoId = @prodottoId;
END;
GO;


-- DELETE
CREATE PROCEDURE sp_DeleteProdottoByName
    @NomeProdotto NVARCHAR(100)
AS
BEGIN
    DELETE FROM Prodotti WHERE NomeProdotto = @NomeProdotto;
END;
GO

CREATE PROCEDURE sp_DeleteProdottoById
    @prodottoId INT
AS
BEGIN
    DELETE FROM Prodotti WHERE ProdottoId = @prodottoId;
END;
GO

-- 4. Ordini

-- CREATE
CREATE PROCEDURE sp_InsertOrdine
    @clienteId INT,
    @dipendenteId INT,
    @totale DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Ordini (ClienteId, DipendenteId, Data_Ordine, totale)
    VALUES (@clienteId, @dipendenteId, GETDATE(), @totale);
END;
GO

-- READ
CREATE PROCEDURE sp_GetAllOrdini
AS
BEGIN
    SELECT * FROM Ordini;
END;
GO

-- UPDATE
CREATE PROCEDURE sp_UpdateOrdine
    @codiceOrdine INT,
    @totale DECIMAL(10,2)
AS
BEGIN
    UPDATE Ordini
    SET totale = @totale
    WHERE CodiceOrdine = @codiceOrdine;
END;
GO

-- DELETE
CREATE PROCEDURE sp_DeleteOrdinebyId
    @codiceOrdine INT
AS
BEGIN
    DELETE FROM Ordini WHERE CodiceOrdine = @codiceOrdine;
END;
GO


-- 5. Dettagli Ordine
-- CREATE
CREATE PROCEDURE sp_InsertDettaglioOrdine
    @codiceordine INT,
    @prodottoId INT,
    @quantita INT,
    @prezzo_unitario DECIMAL(10,2)
AS
BEGIN
    INSERT INTO DetaglioOrdine(CodiceOrdine, ProdottoId, Quantita, Prezzo_Unitario)
    VALUES (@codiceordine, @prodottoId, @quantita, @prezzo_unitario);
END;
GO

-- READ
CREATE PROCEDURE sp_GetAllDetaglioOrdini
AS
BEGIN
    SELECT * FROM DetaglioOrdine;
END;
GO

-- UPDATE
CREATE PROCEDURE UpdateDetaglioOrdine
    @dettaglioId INT,
    @quantita INT
AS
BEGIN
    UPDATE DetaglioOrdine
    SET quantita = @quantita
    WHERE DetaglioId = @dettaglioId;
END;
GO

-- DELETE
CREATE PROCEDURE DeleteDettaglioOrdineById
    @dettaglioId INT
AS
BEGIN
    DELETE FROM DetaglioOrdine WHERE DetaglioId = @dettaglioId;
END;
GO

-- 6. Fatture
-- CREATE
CREATE PROCEDURE sp_InsertFattura
    @codiceOrdine INT,
    @importo DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Fattura (CodiceOrdine, DataFattura, Importo)
    VALUES (@codiceOrdine, GETDATE(), @importo);
END;
GO

-- READ
CREATE PROCEDURE sp_GetAllFatture
AS
BEGIN
    SELECT * FROM Fattura;
END;
GO

-- UPDATE
CREATE PROCEDURE sp_UpdateFattura
    @fatturaId INT,
    @importo DECIMAL(10,2)
AS
BEGIN
    UPDATE Fattura
    SET importo = @importo
    WHERE FatturaId = @fatturaId;
END;
GO

-- DELETE
CREATE PROCEDURE sp_DeleteFattura
    @fatturaId INT
AS
BEGIN
    DELETE FROM Fattura WHERE FatturaId = @fatturaId;
END;
GO

--=SELECT, JOIN, HAVIN, GROUP BY, ORDER BY, SUM, AVG, MIN, MAX, TOP, IF NOT EXISTS, IN, NOT IN 
--=CASE WHEN ELSE, 
-- Totale speso da ogni cliente
/*
Nome del cliente
Email
Totale speso (somma delle fatture agli ordini)
*/
SELECT 
	c.Nome AS 'Nome del cliente',
	c.IndirizzoMail,
	SUM(f.Importo) AS 'Totale speso' 
FROM Clienti AS c
INNER JOIN Ordini AS o ON o.ClienteId = c.ClienteId
INNER JOIN Fattura AS f ON f.CodiceOrdine = o.CodiceOrdine
GROUP BY c.Nome, c.IndirizzoMail


--Uso del HAVING per filtrare solo i clienti che hanno speso più di 180€
SELECT 
	c.Nome AS 'Nome del cliente',
	c.IndirizzoMail,
	SUM(f.Importo) AS 'Totale speso' 
FROM Clienti c
INNER JOIN Ordini AS o ON o.ClienteId = c.ClienteId
INNER JOIN Fattura AS f ON f.CodiceOrdine = o.CodiceOrdine
GROUP BY c.Nome, c.IndirizzoMail
HAVING SUM(f.Importo) <= 180;




SELECT 
    c.Nome AS Cliente,
    c.IndirizzoMail,
    COUNT(DISTINCT o.CodiceOrdine) AS NumeroOrdini,
    SUM(do.Quantita) AS TotaleProdottiAcquistati,
    SUM(f.Importo) AS TotaleSpeso
FROM Clienti c
JOIN Ordini o ON c.ClienteId = o.ClienteId
JOIN Dipendenti d ON o.DipendenteId = d.DipendenteId
JOIN DetaglioOrdine do ON o.CodiceOrdine = do.CodiceOrdine
JOIN Fattura f ON o.CodiceOrdine = f.CodiceOrdine
GROUP BY c.Nome, c.IndirizzoMail
--- HAVING ........
ORDER BY TotaleSpeso

SELECT * FROM Clienti
SELECT * FROM Ordini
SELECT * FROM Fattura
SELECT * FROM DetaglioOrdine
SELECT * FROM Prodotti
SELECT * FROM Dipendenti