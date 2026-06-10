@echo off
setlocal
cd /d "%~dp0"

set "CONVERTER=dist\png_to_cov.exe"

if not exist "%CONVERTER%" (
    echo Erro: "%CONVERTER%" nao foi encontrado nesta pasta.
    pause
    exit /b 1
)

:menu
cls
echo ==========================================
echo  Conversor de capas .PNG para .COV
echo ==========================================
echo.
echo Pasta atual:
echo %CD%
echo.
echo 1 - Converter todos os PNGs com resize automatico 112x144
echo 2 - Converter todos os PNGs sem resize automatico
echo 3 - Converter um PNG com resize automatico 112x144
echo 4 - Converter um PNG sem resize automatico
echo 5 - Creditos
echo 6 - Sair
echo.
set /p "CHOICE=Escolha uma opcao: "

if "%CHOICE%"=="1" goto all_auto
if "%CHOICE%"=="2" goto all_manual
if "%CHOICE%"=="3" goto one_auto
if "%CHOICE%"=="4" goto one_manual
if "%CHOICE%"=="5" goto credits
if "%CHOICE%"=="6" exit /b 0
goto menu

:all_auto
echo.
echo Convertendo todos os PNGs com resize automatico 112x144...
"%CONVERTER%" --all-png --resize auto
pause
goto menu

:all_manual
echo.
echo Convertendo todos os PNGs sem resize automatico...
echo As imagens precisam estar exatamente em 112x144.
"%CONVERTER%" --all-png --resize manual
pause
goto menu

:one_auto
echo.
set /p "INPUT=Digite o nome do PNG: "
if "%INPUT%"=="" goto menu
call :fix_png_name
"%CONVERTER%" "%INPUT%" --resize auto
pause
goto menu

:one_manual
echo.
set /p "INPUT=Digite o nome do PNG: "
if "%INPUT%"=="" goto menu
call :fix_png_name
echo A imagem precisa estar exatamente em 112x144.
"%CONVERTER%" "%INPUT%" --resize manual
pause
goto menu

:credits
cls
echo ==========================================
echo  Creditos
echo ==========================================
echo.
echo Desenvolvido por: tavinho.games
echo Siga no instagram: @tavinho.games
echo Agradecimentos: Canal thalescamara e ludufre
echo.
pause
goto menu

:fix_png_name
if exist "%INPUT%" exit /b 0
if exist "%INPUT%.png" set "INPUT=%INPUT%.png"
exit /b 0
