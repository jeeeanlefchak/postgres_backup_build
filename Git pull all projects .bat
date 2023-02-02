@echo off
cls
:menu
cls
color F3

date /t
set mypath=%cd%
@echo %mypath%
echo Computador: %computername%        Usuario: %username%
 for /d %%d in (*.*) do (
    cd %mypath%\%%d
    echo  %mypath%\%%d
    call git pull
)
pause                  
