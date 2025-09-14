# install-sui.ps1
# Sui CLI Auto-Setup Script for Smart Contract Development
# Run this script in PowerShell as Administrator

# Set error action preference
$ErrorActionPreference = "Stop"

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

Write-Host "`n🚀 Starting Sui CLI Smart Contract Development Setup...`n" -ForegroundColor Yellow
Write-Host "This script will install all necessary tools for Sui smart contract development:`n" -ForegroundColor White
Write-Host "  • Chocolatey (Package Manager)" -ForegroundColor Gray
Write-Host "  • Git (Version Control)" -ForegroundColor Gray
Write-Host "  • Sui CLI (Blockchain Development)" -ForegroundColor Gray
Write-Host "  • Rust Toolchain (Move Compiler)" -ForegroundColor Gray
Write-Host "  • VS Code Extensions (Development Environment)`n" -ForegroundColor Gray

# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ Please run this script as Administrator!" -ForegroundColor Red
    exit 1
}

# Function to check if a command exists
function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Function to install with error handling
function Install-WithChocolatey {
    param($PackageName, $Description)
    
    if (Test-Command $PackageName) {
        Write-Host "✅ $Description already installed." -ForegroundColor Green
        return $true
    }
    
    Write-Host "Installing $Description..." -ForegroundColor Cyan
    try {
        choco install $PackageName -y --no-progress
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ $Description installed successfully!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ $Description installation failed." -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "❌ Error installing $Description : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Step 1: Install Chocolatey if not already installed
if (Test-Command choco) {
    Write-Host "✅ Chocolatey already installed." -ForegroundColor Green
} else {
    Write-Host "Step 1: Installing Chocolatey..." -ForegroundColor Cyan
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        # Verify choco installation
        Write-Host "Verifying Chocolatey installation..." -ForegroundColor Yellow
        if (Test-Command choco) {
            Write-Host "✅ Chocolatey installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "❌ Chocolatey installation failed. Exiting..." -ForegroundColor Red
            exit 1
        }
    } catch {
        Write-Host "❌ Error installing Chocolatey: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Step 2: Install Git
Write-Host "`nStep 2: Installing Git..." -ForegroundColor Cyan
if (-not (Install-WithChocolatey "git" "Git")) {
    Write-Host "❌ Git installation failed. Exiting..." -ForegroundColor Red
    exit 1
}

# Step 3: Install Sui CLI
Write-Host "`nStep 3: Installing Sui CLI..." -ForegroundColor Cyan
if (-not (Install-WithChocolatey "sui" "Sui CLI")) {
    Write-Host "❌ Sui CLI installation failed. Exiting..." -ForegroundColor Red
    exit 1
}

# Step 4: Install Rust Toolchain (required for Move development)
Write-Host "`nStep 4: Installing Rust Toolchain..." -ForegroundColor Cyan
if (Test-Command rustc) {
    Write-Host "✅ Rust already installed." -ForegroundColor Green
} else {
    Write-Host "Installing Rust via rustup..." -ForegroundColor Cyan
    try {
        # Download and run rustup installer
        Invoke-WebRequest -Uri "https://win.rustup.rs/x86_64" -OutFile "rustup-init.exe"
        .\rustup-init.exe -y --default-toolchain stable
        Remove-Item "rustup-init.exe" -Force
        
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        if (Test-Command rustc) {
            Write-Host "✅ Rust installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "❌ Rust installation failed." -ForegroundColor Red
            exit 1
        }
    } catch {
        Write-Host "❌ Error installing Rust: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Step 5: Install VS Code and Extensions (optional but recommended)
Write-Host "`nStep 5: Setting up VS Code for Move development..." -ForegroundColor Cyan
if (Test-Command code) {
    Write-Host "✅ VS Code already installed." -ForegroundColor Green
} else {
    Write-Host "Installing VS Code..." -ForegroundColor Cyan
    if (Install-WithChocolatey "vscode" "Visual Studio Code") {
        Write-Host "✅ VS Code installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  VS Code installation failed, but continuing..." -ForegroundColor Yellow
    }
}

# Install VS Code extensions for Move development
if (Test-Command code) {
    Write-Host "Installing recommended VS Code extensions..." -ForegroundColor Cyan
    $extensions = @(
        "move.move-analyzer",
        "rust-lang.rust-analyzer",
        "ms-vscode.powershell"
    )
    
    foreach ($extension in $extensions) {
        try {
            code --install-extension $extension --force
            Write-Host "✅ Installed extension: $extension" -ForegroundColor Green
        } catch {
            Write-Host "⚠️  Failed to install extension: $extension" -ForegroundColor Yellow
        }
    }
}

# Step 6: Verification and Testing
Write-Host "`nStep 6: Verifying installations..." -ForegroundColor Cyan

# Refresh environment variables one more time
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Test all installations
$tools = @(
    @{Name="Git"; Command="git --version"},
    @{Name="Sui CLI"; Command="sui --version"},
    @{Name="Rust"; Command="rustc --version"},
    @{Name="Cargo"; Command="cargo --version"}
)

$allInstalled = $true
foreach ($tool in $tools) {
    try {
        $output = Invoke-Expression $tool.Command 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ $($tool.Name): $output" -ForegroundColor Green
        } else {
            Write-Host "❌ $($tool.Name): Installation verification failed" -ForegroundColor Red
            $allInstalled = $false
        }
    } catch {
        Write-Host "❌ $($tool.Name): Not found in PATH" -ForegroundColor Red
        $allInstalled = $false
    }
}

# Step 7: Create a test Sui project
Write-Host "`nStep 7: Creating test Sui project..." -ForegroundColor Cyan
try {
    $testDir = "sui-test-project"
    if (Test-Path $testDir) {
        Remove-Item $testDir -Recurse -Force
    }
    
    # Create a new Sui project
    sui move new $testDir
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Test Sui project created successfully!" -ForegroundColor Green
        Write-Host "   Project location: $(Get-Location)\$testDir" -ForegroundColor Gray
    } else {
        Write-Host "⚠️  Could not create test project (this is normal if Sui CLI needs restart)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️  Could not create test project: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Final Summary
Write-Host "`n" + "="*60 -ForegroundColor Cyan
Write-Host "🎉 SUI CLI SMART CONTRACT DEVELOPMENT SETUP COMPLETE!" -ForegroundColor Green
Write-Host "="*60 -ForegroundColor Cyan

if ($allInstalled) {
    Write-Host "`n✅ All tools installed successfully!" -ForegroundColor Green
} else {
    Write-Host "`n⚠️  Some tools may need a terminal restart to be available." -ForegroundColor Yellow
}

Write-Host "`n📚 NEXT STEPS FOR BEGINNERS:" -ForegroundColor Yellow
Write-Host "1. Restart your terminal/PowerShell to refresh PATH variables" -ForegroundColor White
Write-Host "2. Run 'sui --version' to verify Sui CLI is working" -ForegroundColor White
Write-Host "3. Create your first project: 'sui move new my-first-project'" -ForegroundColor White
Write-Host "4. Navigate to your project: 'cd my-first-project'" -ForegroundColor White
Write-Host "5. Build your project: 'sui move build'" -ForegroundColor White
Write-Host "6. Test your project: 'sui move test'" -ForegroundColor White

Write-Host "`n🔗 HELPFUL RESOURCES:" -ForegroundColor Yellow
Write-Host "• Sui Documentation: https://docs.sui.io/" -ForegroundColor Blue
Write-Host "• Move Language Guide: https://move-language.github.io/move/" -ForegroundColor Blue
Write-Host "• Sui Examples: https://github.com/MystenLabs/sui/tree/main/sui_programmability/examples" -ForegroundColor Blue
Write-Host "• Sui Discord: https://discord.gg/sui" -ForegroundColor Blue

Write-Host "`n💡 TIP: Open VS Code in your project folder for the best development experience!" -ForegroundColor Cyan
Write-Host "   Command: 'code my-first-project'" -ForegroundColor Gray

Write-Host "`n🚀 Happy coding! Welcome to the Sui ecosystem!" -ForegroundColor Green
