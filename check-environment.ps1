# NPMplus Development Environment Check
# Run this script to verify your development environment is ready

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "NPMplus Development Environment Check" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$allGood = $true

# Check Node.js
Write-Host "Checking Node.js..." -NoNewline
try {
    $nodeVersion = & node --version 2>$null
    if ($nodeVersion) {
        Write-Host " FOUND: $nodeVersion" -ForegroundColor Green

        # Check if version is acceptable (v18+)
        $versionNumber = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
        if ($versionNumber -lt 18) {
            Write-Host "  WARNING: Node.js v18 or higher is recommended (you have $nodeVersion)" -ForegroundColor Yellow
        }
    } else {
        throw "Not found"
    }
} catch {
    Write-Host " NOT FOUND" -ForegroundColor Red
    Write-Host "  -> Install Node.js from: https://nodejs.org/" -ForegroundColor Yellow
    Write-Host "  -> See INSTALL_NODEJS.md for detailed instructions" -ForegroundColor Yellow
    $allGood = $false
}

# Check npm
Write-Host "Checking npm..." -NoNewline
try {
    $npmVersion = & npm --version 2>$null
    if ($npmVersion) {
        Write-Host " FOUND: v$npmVersion" -ForegroundColor Green
    } else {
        throw "Not found"
    }
} catch {
    Write-Host " NOT FOUND" -ForegroundColor Red
    Write-Host "  -> npm comes with Node.js installation" -ForegroundColor Yellow
    $allGood = $false
}

# Check Git
Write-Host "Checking Git..." -NoNewline
try {
    $gitVersion = & git --version 2>$null
    if ($gitVersion) {
        Write-Host " FOUND: $gitVersion" -ForegroundColor Green
    } else {
        throw "Not found"
    }
} catch {
    Write-Host " NOT FOUND" -ForegroundColor Red
    Write-Host "  -> Install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    $allGood = $false
}

# Check if we're in the right directory
Write-Host "Checking project structure..." -NoNewline
if (Test-Path "backend\package.json") {
    Write-Host " FOUND backend directory" -ForegroundColor Green
} else {
    Write-Host " Cannot find backend\package.json" -ForegroundColor Red
    Write-Host "  -> Make sure you're running this from the NPMplus root directory" -ForegroundColor Yellow
    $allGood = $false
}

# Check if dependencies are installed
Write-Host "Checking backend dependencies..." -NoNewline
if (Test-Path "backend\node_modules") {
    Write-Host " Dependencies installed" -ForegroundColor Green
} else {
    Write-Host " NOT INSTALLED" -ForegroundColor Yellow
    Write-Host "  -> Run: cd backend; npm install" -ForegroundColor Cyan
}

# Check dev data directory
Write-Host "Checking dev data directory..." -NoNewline
if (Test-Path ".dev-data\npmplus") {
    Write-Host " Directory exists" -ForegroundColor Green
} else {
    Write-Host " NOT CREATED" -ForegroundColor Yellow
    Write-Host "  -> Run: New-Item -ItemType Directory -Force -Path .\.dev-data\npmplus" -ForegroundColor Cyan
}

# Check .env file
Write-Host "Checking .env file..." -NoNewline
if (Test-Path ".env") {
    Write-Host " Found" -ForegroundColor Green
} else {
    Write-Host " NOT FOUND" -ForegroundColor Yellow
    Write-Host "  -> Run: Copy-Item .env.example .env" -ForegroundColor Cyan
}

Write-Host "`n========================================" -ForegroundColor Cyan

if ($allGood) {
    Write-Host "All required tools are installed!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan

    if (-not (Test-Path "backend\node_modules")) {
        Write-Host "  1. Install dependencies:" -ForegroundColor White
        Write-Host "     cd backend" -ForegroundColor Gray
        Write-Host "     npm install" -ForegroundColor Gray
        Write-Host "     cd .." -ForegroundColor Gray
    }

    if (-not (Test-Path ".dev-data\npmplus")) {
        Write-Host "  2. Create dev data directory:" -ForegroundColor White
        Write-Host "     New-Item -ItemType Directory -Force -Path .\.dev-data\npmplus" -ForegroundColor Gray
    }

    if (-not (Test-Path ".env")) {
        Write-Host "  3. Create .env file:" -ForegroundColor White
        Write-Host "     Copy-Item .env.example .env" -ForegroundColor Gray
    }

    Write-Host "`n  Then press F5 in VS Code to start debugging!" -ForegroundColor Green
} else {
    Write-Host "Some required tools are missing" -ForegroundColor Red
    Write-Host "`nPlease install the missing tools and run this script again." -ForegroundColor Yellow
}

Write-Host "========================================`n" -ForegroundColor Cyan
