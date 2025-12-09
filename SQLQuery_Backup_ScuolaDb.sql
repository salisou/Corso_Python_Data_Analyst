BACKUP DATABASE [ScuolaDb] 
TO  DISK = N'C:\Users\salis\ScuolaDb.bak' 
WITH  COPY_ONLY, NOFORMAT, NOINIT,  
NAME = N'ScuolaDb-Completo Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
