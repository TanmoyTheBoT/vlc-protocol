<#
.SYNOPSIS
    Automates downloading and registering custom VLC protocol batch files.

.DESCRIPTION
    This script:
    1. Ensures it's run with administrator privileges.
    2. Verifies VLC installation in the default directory.
    3. Downloads required batch files from a specified base URL.
    4. Registers the VLC protocol by running the appropriate batch file.

.NOTES
    - Requires PowerShell 5.0 or later.
    - Internet connectivity is required to download the batch files.
    - Must be run as Administrator.

.AUTHOR
    TanmoyTheBoT
#>

# Define base URL for downloading batch files
$baseURL = "https://tanmoythebot.github.io/vlc-protocol/bat"

# Function to check for Administrator privileges
function Test-AdminPrivileges {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "ERROR: This script must be run as Administrator." -ForegroundColor Red
        exit 1
    }
}

# Function to retrieve the VLC installation directory
function Get-VLCInstallPath {
    $keys = @("HKLM:\Software\VideoLAN\VLC", "HKLM:\Software\WOW6432Node\VideoLAN\VLC")
    foreach ($key in $keys) {
        try {
            $path = (Get-ItemProperty -Path $key -ErrorAction SilentlyContinue).InstallDir
            if ($path) { return $path }
        } catch {
            Write-Host "ERROR: Unable to access registry key $key" -ForegroundColor Red
        }
    }
    return $null
}

# Function to download required batch files
function Get-BatchFiles {
    param (
        [string[]]$files,
        [string]$destinationDir
    )

    foreach ($file in $files) {
        $fileURL = "$baseURL/$file"
        $destinationPath = Join-Path -Path $destinationDir -ChildPath $file

        Write-Host "Downloading $file..."
        try {
            Invoke-WebRequest -Uri $fileURL -OutFile $destinationPath -ErrorAction Stop
            Write-Host "SUCCESS: $file downloaded to $destinationPath." -ForegroundColor Green
        } catch {
            Write-Host "ERROR: Unable to download $file from $fileURL. Check your internet connection or the URL." -ForegroundColor Red
            exit 1
        }
    }
}

# Function to register the VLC protocol using a batch file
function Register-VLCProtocol {
    param (
        [string]$vlcDir
    )

    $registerScript = Join-Path -Path $vlcDir -ChildPath "vlc-protocol-register.bat"
    if (-not (Test-Path $registerScript)) {
        Write-Host "ERROR: $registerScript not found. Ensure the batch file is downloaded correctly." -ForegroundColor Red
        exit 1
    }

    Write-Host "Registering VLC protocol..."
    try {
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$registerScript`"" -Verb RunAs -Wait
        Write-Host "SUCCESS: VLC protocol registered successfully." -ForegroundColor Green
    } catch {
        Write-Host "ERROR: Failed to run $registerScript. Ensure you have Administrator privileges." -ForegroundColor Red
        exit 1
    }
}

# Main Script Execution
Clear-Host
Write-Host "=== VLC Protocol Setup Script ===" -ForegroundColor Cyan

# Step 1: Check for Administrator privileges
Test-AdminPrivileges

# Step 2: Check VLC installation path
$vlcDir = Get-VLCInstallPath
if (-not $vlcDir) {
    Write-Host "ERROR: VLC installation not found. Please install VLC and try again." -ForegroundColor Red
    exit 1
}

# Step 3: Download necessary batch files
$batchFiles = @(
    "vlc-protocol-deregister.bat",
    "vlc-protocol-register.bat",
    "vlc-protocol.bat"
)
Get-BatchFiles -files $batchFiles -destinationDir $vlcDir

# Step 4: Register VLC protocol
Register-VLCProtocol -vlcDir $vlcDir

Write-Host "=== Setup Complete ===" -ForegroundColor Cyan
