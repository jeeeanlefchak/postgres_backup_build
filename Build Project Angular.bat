@echo off
cls
:menu
cls
color F3

date /t

echo Computador: %computername%        Usuario: %username%
                   
echo            MENU TAREFAS
echo  ===========================================
echo * 1. Compilar                              * 
echo * 2. Publicar para                         *
echo * 4. Baixar ultima versao                  *
echo * 5. Executar npm install                  *
echo * 6. Sair                                  * 
echo * 7. Baixar, Compilar, Publicar (2,3)      * 
echo  ===========================================

set sourceDir=D:\Sources\{PROJECT_NAME}
set targetDir=D:\Compilados\{PROJECT_NAME}
set publishDir=D:\Production\{PROJECT_NAME}

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 4 goto opcao4
if %opcao% equ 5 goto opcao5
if %opcao% equ 6 goto opcao6
if %opcao% equ 7 goto opcao7
if %opcao% GEQ 8 goto opcao8

:opcao1
cls
cd /d %sourceDir%
echo %cd%
pause
call node --max_old_space_size=8192 node_modules/@angular/cli/bin/ng build --prod --aot=true  --base-href / --output-path %targetDir%
pause
goto menu

:opcao2
cls
del /Q /S %publishDir%\*
cls
xcopy /E /C %targetDir%\*.* %publishDir%
cls
xcopy /C D:\Compilados\web.config %publishDir%
cls
echo ==================================
echo *      {PROJECT_NAME} Publicado       *
echo ==================================
pause
goto menu

:opcao4
cls
cd /d "%sourceDir%"
echo %cd%
pause
call git pull
pause
goto menu

:opcao5
cls
cd /d "%sourceDir%"
pause
call npm install
pause
goto menu

:opcao6
cls
exit

:opcao7
echo 1 de 4 Baixando
cd /d "%sourceDir%"
echo %cd%
call git pull

echo 2 de 4 Compilando
cd /d %sourceDir%
echo %cd%
call node --max_old_space_size=8192 node_modules/@angular/cli/bin/ng build --prod --aot=true --base-href / --output-path %targetDir%

echo 3 de 4 Publicando
del /Q /S %publishDir%\*
xcopy /E /C %targetDir%\*.* %publishDir%
xcopy /C D:\Compilados\web.config %publishDir%
echo ==================================
echo *      {PROJECT_NAME} Publicado       *
echo ==================================

echo 4 de 4 Publicando
del /Q /S "%targetDir%Internal\*
xcopy /E /C %targetDir%\*.* "%publishDir%Internal"
xcopy /C D:\Compilados\web.config "%publishDir%Internal"
echo ==================================
echo *   {PROJECT_NAME}Internal Publicado  *
echo ==================================

pause
goto menu


:opcao8
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu