# install-sui.ps1
# Run this script in PowerShell as Administrator

# ASCII Banner
Write-Host @"
  ______       _            _  _    _                        _ _                
 / _____)     (_)          | |(_)  (_)             _        | | |               
( (____  _   _ _ _____ ____| | _    _ ____   ___ _| |_ _____| | | _____  ____   
 \____ \| | | | | (_____) ___) || |  | |  _ \ /___|_   _|____ | | || ___ |/ ___)  
 _____) ) |_| | |    ( (___| || |  | | | | |___ | | |_/ ___ | | || ____| |      
(______/|____/|_|     \____)\_)_|  |_|_| |_(___/   \__)_____|\_)_)_____)_|      
                                                                                
 ______           _______ _           _______                                   
(____  \         (_______) |         (_______)        _                         
 ____)  )_   _       _   | |__  _____ _     _  ____ _| |_ ___  ____  _   _  ___ 
|  __  (| | | |     | |  |  _ \| ___ | |   | |/ ___|_   _) _ \|  _ \| | | |/___)
| |__)  ) |_| |     | |  | | | | ____| |___| ( (___  | || |_| | |_| | |_| |___ |
|______/ \__  |     |_|  |_| |_|_____)\_____/ \____)  \__)___/|  __/|____/(___/ 
        (____/                                                |_|               
"@ -ForegroundColor Cyan

Write-Host "`n🚀 Starting Sui CLI Installation Process...`n" -ForegroundColor Yellow

# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ Please run this script as Administrator!" -ForegroundColor Red
    exit 1
}

# Step 1: Install Chocolatey if not already installed
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Host "✅ Chocolatey already installed." -ForegroundColor Green
} else {
    Write-Host "Step 1: Installing Chocolatey..." -ForegroundColor Cyan
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Verify choco installation
    Write-Host "Verifying Chocolatey installation..." -ForegroundColor Yellow
    choco -v
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Chocolatey installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Chocolatey installation failed. Exiting..." -ForegroundColor Red
        exit 1
    }
}

# Step 2: Install Git if not installed
if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host "✅ Git already installed." -ForegroundColor Green
} else {
    Write-Host "Step 2: Installing Git with Chocolatey..." -ForegroundColor Cyan
    choco install git -y

    Write-Host "Verifying Git installation..." -ForegroundColor Yellow
    git --version
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Git installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Git installation failed. Exiting..." -ForegroundColor Red
        exit 1
    }
}

# Step 3: Install Sui CLI if not installed
if (Get-Command sui -ErrorAction SilentlyContinue) {
    Write-Host "✅ Sui CLI already installed." -ForegroundColor Green
} else {
    Write-Host "Step 3: Installing Sui CLI with Chocolatey..." -ForegroundColor Cyan
    choco install sui -y

    Write-Host "Verifying Sui CLI installation..." -ForegroundColor Yellow
    sui --version
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Sui CLI installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Sui CLI installation failed." -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n🎉 Setup completed successfully! You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Cyan
