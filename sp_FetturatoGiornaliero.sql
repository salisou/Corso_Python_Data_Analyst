-- =============================================
-- Author:		Docente: Moussa
-- Create date: 18-11-25
-- Description:	Fatturato giornaliero
-- =============================================
CREATE PROCEDURE sp_FetturatoGiornaliero
AS
BEGIN
	SELECT 
		Data_Ordine,
		SUM(Totale) AS Fatturato
	FROM Ordini
	GROUP BY Data_Ordine
	ORDER BY Data_Ordine
END
GO

EXEC sp_FetturatoGiornaliero