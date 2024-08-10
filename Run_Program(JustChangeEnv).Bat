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
 
:: Run script with correct python.
%PYTHON% yourscript.py
 
:: End of batch code
endlocal