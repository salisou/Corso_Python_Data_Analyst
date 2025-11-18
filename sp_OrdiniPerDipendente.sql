CREATE PROCEDURE sp_OrdiniPerDipendente
AS
BEGIN
    SELECT 
        d.DipendenteId,
        d.Nome + ' ' + d.Cognome AS Dipendente,
        COUNT(o.CodiceOrdine) AS NumeroOrdini
    FROM Dipendenti d
    LEFT JOIN Ordini o ON d.DipendenteId = o.DipendenteId
    GROUP BY d.DipendenteId, d.Nome, d.Cognome
    ORDER BY NumeroOrdini DESC;
END


EXEC sp_OrdiniPerDipendente
