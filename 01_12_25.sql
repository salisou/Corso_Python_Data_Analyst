CREATE PROCEDURE sp_UpdateStudente
	@StudenteId INT,
	@NomeStudente NVARCHAR(100),
	@CognomeStudente NVARCHAR(100),
	@DataNascita DATE,
	@Email NVARCHAR(150)
AS
BEGIN
	UPDATE Studente 
    SET NomeStudente = @NomeStudente, 
		CognomeStudente = @CognomeStudente, 
		DataNascita = @DataNascita, 
		Email = @Email
    WHERE StudenteId = @StudenteId
END
GO

          