# main_script - the main script.

# Global variables
$global:pythonPath = "C:\Users\$env:USERNAME\AppData\Local\Programs\Python"
$global:backupPath = ".\general_settings.psd1"

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to get the installed Python versions
function Get-PythonVersions {
    if (Test-Path $global:pythonPath) {
        return Get-ChildItem -Directory $global:pythonPath | Select-Object -ExpandProperty Name
    } else {
        Write-Error "Python installation directory not found."
        return $null
    }
}

# Function to update environment variables
function Update-EnvironmentVariables {
    param (
        [string]$selectedVersion
    )
    $userFolder = "$global:pythonPath\$selectedVersion"
    $pythonExePath = "$userFolder\Python.exe"
    
    if (-not (Test-Path $userFolder)) {
        Write-Error "Selected Python version folder not found: $userFolder"
        exit
    }
    
    # Backup current environment variables
    Export-EnvironmentVariables -filePath $global:backupPath

    # Update PYTHON environment variable
    [System.Environment]::SetEnvironmentVariable("PYTHON", $pythonExePath, [System.EnvironmentVariableTarget]::Machine)
    
    # Update PATH environment variable
    $path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    if (-not $path) {
        Write-Warning "No PATH environment variable found. Creating a new one."
        $path = ""
    }

    $pythonPaths = @(
        [regex]::Escape("C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python[0-9]{3}\Scripts\"),
        [regex]::Escape("C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python[0-9]{3}\")
    )
    
    $newPath = ($path -split ";") -notmatch ($pythonPaths -join "|")
    $newPath = @($newPath, "$userFolder", "$userFolder\Scripts") -join ";"
    
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    
    Write-Output "Environment variables updated successfully. Please restart your terminal."
}

# Function to export environment variables to a psd1 file
function Export-EnvironmentVariables {
    param (
        [string]$filePath
    )

    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    $currentPython = [System.Environment]::GetEnvironmentVariable("PYTHON", [System.EnvironmentVariableTarget]::Machine)

    $envVariables = @{
        Path   = $currentPath
        PYTHON = $currentPython
    }

    $envVariables | Export-Clixml -Path $filePath
}

# Function to import environment variables from a psd1 file
function Import-EnvironmentVariables {
    param (
        [string]$filePath
    )

    if (Test-Path $filePath) {
        $envVariables = Import-Clixml -Path $filePath

        if ($envVariables -and $envVariables.Path -and $envVariables.PYTHON) {
            [System.Environment]::SetEnvironmentVariable("Path", $envVariables.Path, [System.EnvironmentVariableTarget]::Machine)
            [System.Environment]::SetEnvironmentVariable("PYTHON", $envVariables.PYTHON, [System.EnvironmentVariableTarget]::Machine)
        } else {
            Write-Error "Invalid environment variables data in the file."
        }
    } else {
        Write-Error "Environment variables backup file not found."
    }
}

# Main script logic
if (-not (Test-Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$pythonVersions = Get-PythonVersions
if (-not $pythonVersions) {
    Write-Error "No Python versions found."
    exit
}

$selectedVersion = $pythonVersions | Out-GridView -Title "Select Python Version" -OutputMode Single
if (-not $selectedVersion) {
    Write-Error "No version selected."
    exit
}

Update-EnvironmentVariables -selectedVersion $selectedVersion
