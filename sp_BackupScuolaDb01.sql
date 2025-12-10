--BACKUP DATABASE ScuolaDb
--TO  DISK = N'H:\Dev\TalentForm\Corso_SqlServer\ScuolaDb.bak' 
--WITH INIT;



-- Codice completo della store procedure Back-up 
-- sp_BackupScuolaDb01

-- =============================================
-- Author:		Docente Moussa
-- Create date: 09/12/25
-- Description:	Back-Up SuolaDb 
-- =============================================
CREATE OR ALTER PROCEDURE sp_BackupScuolaDb01
    @BackupPath NVARCHAR(300) = 'H:\Dev\TalentForm\Corso_SqlServer\' 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @DbName SYSNAME = 'ScuolaDb',
        @Timestamp NVARCHAR(20),
        @BackupFile NVARCHAR(400),
        @SQL NVARCHAR(MAX);

    BEGIN TRY
        
        PRINT '⌛ Avvio backup del database ScuolaDb...';

        -- Timestamp per il nome del file
        SET @Timestamp = REPLACE(CONVERT(VARCHAR(20), GETDATE(), 120), ':', '-');

        -- Nome completo del file
        SET @BackupFile =
            @BackupPath + @DbName + '_FULL_' + @Timestamp + '.bak';

        -- Comando valido per SQL Express
        SET @SQL = '
            BACKUP DATABASE [' + @DbName + ']
            TO DISK = ''' + @BackupFile + '''
            WITH INIT';  -- Nessuna COMPRESSION, DIFFERENTIAL o LOG

        -- Esecuzione del backup
        EXEC(@SQL);

        PRINT '✔ Back-up completato con successo: 🎉🎉🎉🎉' + @BackupFile;

    END TRY
    BEGIN CATCH
        DECLARE 
            @ErrMsg NVARCHAR(4000),
            @ErrSeverity INT;

        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY();

        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END
GO

EXEC sp_BackupScuolaDb01 



/*
	Messaggio 3201, livello 16, stato 1, riga 48
	Cannot open backup device 'C:\SQLBackups\ScuolaDb_FULL.bak'. Operating system error 3(Impossibile trovare il percorso specificato.).
	Messaggio 3013, livello 16, stato 1, riga 48
	BACKUP DATABASE is terminating abnormally.
*/

/*
Messaggio 1844, livello 16, stato 1, riga 48
BACKUP DATABASE WITH COMPRESSION is not supported on Express Edition (64-bit).
Messaggio 3013, livello 16, stato 1, riga 48
BACKUP DATABASE is terminating abnormally.
*/

