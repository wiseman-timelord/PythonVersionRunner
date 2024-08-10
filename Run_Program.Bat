@echo off
setlocal

:: Search Parameters
set PYTHON_VERSION=310
set SEARCH_DIRS=%SYSTEM_DRIVE%\Users\%USERNAME%\AppData\Roaming\Python %SYSTEM_DRIVE%\Progra~1

:: Initialization
set SYSTEM_DRIVE=%~d0
set PYTHON=

:: Search Python versions
for %%D in (%SEARCH_DIRS%) do (
    for /D %%P in (%%D\Python3%PYTHON_VERSION%) do (
        set "PYTHON=%%P\python.exe"
        echo Found Python: %%P
    )
)
if not defined PYTHON (
    echo Python 3.%PYTHON_VERSION% not found!
    echo Install Python 3.%PYTHON_VERSION% to, default user folder or all users default,
    exit /b 1
)
echo Using Python: %PYTHON%

:: Launch the PowerShell script to update environment variables
SET SCRIPT_PATH=.\main_script.ps1

echo.
echo This will launch the PowerShell script to switch Python versions.
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

:: Run the Python script with the correct Python version
%PYTHON% yourscript.py

:: End of batch code
endlocal
