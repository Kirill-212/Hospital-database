CREATE PROC write_to_file
  @msg VARCHAR(100),
  @file VARCHAR(100),
  @overwrite BIT = 0
AS

/*
  Tested on: SQL Server Version 7.0, 2000
  Remarks: You should have permissions required through access file system through xp_cmdshell
           See SQL Server Books Online for xp_cmdshell if you are having problems with this procedure
*/

BEGIN

	SET NOCOUNT ON
	DECLARE @execstr VARCHAR(255)

	SET @execstr = RTRIM('echo ' + COALESCE(LTRIM(@msg),'-') + CASE WHEN (@overwrite = 1) THEN ' >>' ELSE ' >> ' END + RTRIM(@file))+'  -w -T'
	print @execstr
	EXEC xp_cmdshell @execstr
	SET NOCOUNT OFF
	
END

	EXEC master.dbo.sp_configure 'show advanced options', 1
	RECONFIGURE WITH OVERRIDE
	EXEC master.dbo.sp_configure 'xp_cmdshell', 1
	RECONFIGURE WITH OVERRIDE; 




DECLARE @cmd sysname, @var sysname;  
SET @var = 'Hello world';  
SET @cmd = 'echo ' + @var + ' >  C:\ycheba\3course1sem\курсач_бд\var_out.txt ';  
EXEC master..xp_cmdshell @cmd; 


drop PROC write_to_file
select db_name(dbid) as db, spid as idproc, loginame, program_name, status
from   sys.sysprocesses
USE master;
EXEC write_to_file 'ddfefr','C:\ycheba\3course1sem\курсач_бд\ff.txt',10

use courseDataBase
use [master]
go
-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE WITH OVERRIDE;  
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
     DECLARE @cmd sysname, @var sysname;          
  SET @var = 'Hello world';  
  SET @cmd = 'echo' + @var + '" queryout C:\ycheba\3course1sem\курсач_бд\var_out.txt -w -T';
SET @cmd = 'bcp "' + @var + '" queryout C:\ycheba\3course1sem\курсач_бд\var_out.txt -w -T';
print @cmd  
EXEC xp_cmdshell @cmd;     








exec ExportToJson
drop  ExportToJson;
use courseDataBase;
--Export to json
go
create procedure ExportToJson
as begin
select * from DEPARTMENT for json path, root('courseDataBase');

exec master.dbo.sp_configure 'show advanced options', 1
reconfigure with override
exec master.dbo.sp_configure 'xp_cmdshell', 1
reconfigure with override;

declare @cmd nvarchar(255);
select @cmd = '
bcp "use courseDataBase; select * from DEPARTMENT for json path, root(''courseDataBase'');" ' +
'queryout "C:\ycheba\3course1sem\курсач_бд\1.json" -S .\SQLEXPRESS01 -T -w -r -t';
exec xp_cmdshell @cmd;
end;                                                                                     