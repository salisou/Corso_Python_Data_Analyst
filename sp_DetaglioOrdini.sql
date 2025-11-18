-- DETAGLIO COMPLETO ORDINI 
CREATE PROCEDURE sp_DetaglioOrdini
AS
BEGIN
	SELECT 
		o.CodiceOrdine,
		o.Data_Ordine,
		c.Nome as 'Nome del cliente',
		dip.Nome + ' ' + dip.Cognome AS Dipendente,
		p.NomeProdotto AS 'Nome del prodotto',
		det.Quantita AS 'Quantità del prodotto',
		det.Prezzo_Unitario,
		(det.Quantita * det.Prezzo_Unitario) AS TotaleRiga
	FROM Ordini AS o
	INNER JOIN Clienti AS c ON o.ClienteId = c.ClienteId 
	INNER JOIN Dipendenti AS dip ON o.DipendenteId = dip.DipendenteId
	INNER JOIN DetaglioOrdine AS det ON o.CodiceOrdine = det.CodiceOrdine
	INNER JOIN Prodotti AS p ON det.ProdottoId = p.ProdottoId 
END


EXEC sp_DetaglioOrdini