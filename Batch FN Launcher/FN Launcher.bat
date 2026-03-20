@echo off
setlocal enabledelayedexpansion

cls
title Ducki67's Batch FN Launcher
:: Launcher made by Ducki67#0 on Discord
color 0b
chcp 65001 >nul
echo ╔╗ ┌─┐┌┬┐┌─┐┬ ┬  ╔═╗╔╗╔  ╦  ┌─┐┬ ┬┌┐┌┌─┐┬ ┬┌─┐┬─┐
echo ╠╩╗├─┤ │ │  ├─┤  ╠╣ ║║║  ║  ├─┤│ │││││  ├─┤├┤ ├┬┘
echo ╚═╝┴ ┴ ┴ └─┘┴ ┴  ╚  ╝╚╝  ╩═╝┴ ┴└─┘┘└┘└─┘┴ ┴└─┘┴└─
echo =========================================
echo ----{  Ducki67's Batch FN Launcher  }----
echo ----{++Batch+FN+Launcher+Release-1.0}----
echo =========================================
echo.

:: Single Player Mode Toggle | set ot "False" to ask for your Custom credentials every time you use the launcher
set "SINGLE_PLAYER_ACCOUNT=true"
set "SP_EMAIL=Player@gmail.com"
set "SP_PASSWORD=123456789"

if /i "%SINGLE_PLAYER_ACCOUNT%"=="true" (
    set "USER_EMAIL=%SP_EMAIL%"
    set "USER_PASS=%SP_PASSWORD%"
) else (
    set /p "USER_EMAIL=Email: "
    set /p "USER_PASS=Password: "
)

echo.
echo [+] Launching in process...
echo.

:: Config for launcher made folder and game exe name (dont change this!!!)
set "FOLDER=Assets"
set "EXE_NAME=FortniteClient-Win64-Shipping.exe"

set "BASE_DIR=%~dp0"

echo [+] Searching for the game in the build folder...
set "FINAL_EXE_PATH="
for /r "%BASE_DIR%" %%f in (%EXE_NAME%) do (if exist "%%f" set "FINAL_EXE_PATH=%%f")

if not defined FINAL_EXE_PATH (
    echo [!] ERROR: The game could not be found! Copy the script to the build folder!
    pause & exit
)

for %%i in ("%FINAL_EXE_PATH%") do set "FINAL_BIN_DIR=%%~dpi"

:: DLL and Injector config
set "EXE_URL=Put a URL to the injector exe if you  upload it"
set "DLL_URL=Put a URL to the Starfall.dll OR any other DLL if you  upload it BTW you must rename the dll or do it int his code"

if not exist "%FOLDER%" mkdir "%FOLDER%"
echo [+] Updating Launcher assets...
curl -sL -o "%FOLDER%\injector.exe" "%EXE_URL%"
curl -sL -o "%FOLDER%\Starfall.dll" "%DLL_URL%"

:: Launcher args
set "ARGS=-epicapp=Fortnite -epicenv=Prod -epiclocale=en-us -epicportal -nobe -fromfl=eac -fltoken=h1cdhchd10150221h130eB56 -skippatchcheck -AUTH_LOGIN=%USER_EMAIL% -AUTH_PASSWORD=%USER_PASS% -AUTH_TYPE=epic"

echo [+] Launching Fortnite...
pushd "%FINAL_BIN_DIR%"
start "" "%EXE_NAME%" %ARGS%
popd

echo [+] Waiting for the game process...

:WaitLoop
tasklist /NH /FI "IMAGENAME eq %EXE_NAME%" 2>NUL | find /I "%EXE_NAME%" >NUL
if errorlevel 1 (
    tasklist /NH | find /I "FortniteClient" >NUL
    if errorlevel 1 (
        timeout /t 1 /nobreak >nul
        goto WaitLoop
    )
)

echo [+] GAME PROCESS FOUND!
echo [+] Waiting for the Patching screen to finish (8 sec)...
timeout /t 8 /nobreak >nul

:: Injector and DLL config
set "INJ_PATH=%~dp0%FOLDER%\injector.exe"
set "DLL_PATH=%~dp0%FOLDER%\Starfall.dll"

echo [+] Starting injection...
if exist "%INJ_PATH%" (
    echo ------------------------------------------
    "%INJ_PATH%" "%EXE_NAME%" "%DLL_PATH%"
    echo ------------------------------------------
    echo [+] Injection completed.
) else (
    echo [!] ERROR: injector.exe not found!
)

echo.
echo [+] Fortnite was launched successfully.
pause