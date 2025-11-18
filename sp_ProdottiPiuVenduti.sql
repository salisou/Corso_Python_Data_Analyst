-- =============================================
-- Author:		Docente: Moussa
-- Create date: 18-11-25
-- Description:	Pordotti più venduti 
-- =============================================
CREATE PROCEDURE sp_ProdottiPiuVenduti
AS
BEGIN
	SELECT 
		P.ProdottoId,
		P.NomeProdotto,
		SUM(do.Quantita) AS QuantitaVenduta
	FROM Prodotti AS p
	INNER JOIN DetaglioOrdine AS do ON p.ProdottoId = do.ProdottoId
	GROUP BY p.ProdottoId, p.NomeProdotto
	ORDER BY QuantitaVenduta DESC
END
GO

EXEC sp_ProdottiPiuVenduti