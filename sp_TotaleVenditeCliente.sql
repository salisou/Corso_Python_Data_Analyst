-- =============================================
-- Author:		Moussa
-- Create date: 18-11-25
-- Description:	Totale vendite per cliente
-- =============================================
CREATE PROCEDURE sp_TotaleVenditeCliente
AS
BEGIN
	SELECT 
		c.ClienteId AS 'Codice del cliente',
		c.Nome AS 'Nome del cliente',
		SUM(o.Totale) AS totaleSpeso
	FROM Clienti AS c
	LEFT JOIN Ordini AS o ON c.ClienteId = o.ClienteId 
	GROUP BY c.ClienteId, c.Nome
	ORDER BY totaleSpeso DESC
END
GO


-- Per richamere sp_TotaleVenditeCliente
EXEC sp_TotaleVenditeCliente;
