set host=hboard.gentus.com.br
set port=5432
set dataBaseName=hForms
set userName=postgres
set password=hd4p!
set pathPgDump="c:\Program Files\PostgreSQL\10\bin\"
set pathSave=d:\backup\DataBase

@Echo Off
 @For /F "tokens=1,2,3,4 delims=/ " %%A in ('Date /t') do @(
 Set DayW=%%A
 Set Day=%%B
 Set Month=%%C
 Set Year=%%D
 Set All=%%A_%%B_%%C_%%D
 )
 @For /F "tokens=1,2,3 delims=:,. " %%A in ('echo %time%') do @(
 Set Hour=%%A
 Set Min=%%B
 Set Sec=%%C
 Set Allm=%%A.%%B.%%C
 )
 @For /F "tokens=3 delims=: " %%A in ('time /t ') do @(
 Set AMPM=%%A
 )
set datestr=%All%%Allm%%AMPM%
echo datestr is %datestr%

set BACKUP_FILE=%pathSave%\%dataBaseName%_%datestr%.backup

echo backup file name is %BACKUP_FILE%
SET PGPASSWORD=%password%
echo on
cd %pathPgDump%
pg_dump.exe -h  %host% -U %userName% -p %port% -F c -b -v %dataBaseName% > %BACKUP_FILE% 