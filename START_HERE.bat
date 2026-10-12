@echo off
setlocal EnableExtensions
set "FRISK_ROOT=E:\Frisk"
set "FRISK_APP=E:\Frisk\app"
set "FRISK_RUNTIME=E:\Frisk\runtime"
set "FRISK_BOOT_LOG=%FRISK_RUNTIME%\logs\bootstrap_console.log"
set "FRISK_MEMORY_DIR=%FRISK_RUNTIME%\memory"
set "FRISK_MEMORY_FILE=%FRISK_MEMORY_DIR%\frisk_memory.json"
set "FRISK_BRAIN_FILE=%FRISK_MEMORY_DIR%\frisk_brain.json"
set "FRISK_DATABASE_FILE=%FRISK_MEMORY_DIR%\frisk.db"

if not exist "E:\" (
    echo [FRISK ERROR] E: drive is required.
    echo.
    pause
    exit /b 1
)

if not exist "%FRISK_RUNTIME%\logs" mkdir "%FRISK_RUNTIME%\logs" >nul 2>&1
if not exist "%FRISK_MEMORY_DIR%" mkdir "%FRISK_MEMORY_DIR%" >nul 2>&1

cd /d "%FRISK_APP%"
echo ======================================================================
echo [FRISK] START_HERE - ORIGINAL FRISK V106.0
echo [FRISK] This release is NOT FriskDesktop.
echo [FRISK] Python is user-owned. Frisk will not install or search for Python.
echo ======================================================================
echo.

echo [FRISK] Starting bootstrap... 
rem Keep the bootstrap console visible. Also preserve a copy for diagnosis.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0BOOTSTRAP_FRISK_E.ps1" -Launch
set "RC=%ERRORLEVEL%"

echo.
if not "%RC%"=="0" (
    echo [FRISK ERROR] Bootstrap/Frisk exited with code %RC%.
    echo [FRISK ERROR] The window is being kept open so the actual error is visible.
    echo [FRISK ERROR] Check E:\Frisk\runtime\logs\ for the startup report.
    echo.
    pause
) else (
    echo [FRISK] Frisk exited normally.
)
endlocal & exit /b %RC%
