@echo off
SET SCRIPT_PATH=.\main_script.ps1

echo This will launch the PowerShell script to switch Python versions.
echo.
echo Current PowerShell script path: %SCRIPT_PATH%
echo.
set /p "confirm=Do you want to proceed? (y/n): "

if /i "%confirm%" NEQ "y" (
    echo Operation canceled.
    pause
    exit /b 1
)

echo.
echo Launching PowerShell script...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo PowerShell script encountered an error.
    pause
    exit /b 1
)

echo.
echo PowerShell script completed successfully.
pause
