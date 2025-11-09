#!/usr/bin/env powershell
# Frontend Setup Script for NPMplus Development

Write-Host "================================" -ForegroundColor Cyan
Write-Host "NPMplus Frontend Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

$frontendPath = Join-Path $PSScriptRoot "frontend-old"

# Check if node is available
try {
    $nodeVersion = & node --version
    Write-Host "✓ Node.js found: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js not found. Please install Node.js first." -ForegroundColor Red
    Write-Host "  See INSTALL_NODEJS.md for instructions." -ForegroundColor Yellow
    exit 1
}

# Navigate to frontend directory
Set-Location $frontendPath
Write-Host ""
Write-Host "Installing frontend dependencies..." -ForegroundColor Yellow

# Install dependencies
try {
    & npm install
    if ($LASTEXITCODE -ne 0) {
        throw "npm install failed"
    }
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Building frontend..." -ForegroundColor Yellow

# Build frontend
try {
    & npm run build
    if ($LASTEXITCODE -ne 0) {
        throw "npm run build failed"
    }
    Write-Host "✓ Frontend built successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to build frontend" -ForegroundColor Red
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "✓ Setup Complete!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Press F5 in VS Code" -ForegroundColor White
Write-Host "  2. Select 'NPMplus Full Stack (Dev)'" -ForegroundColor White
Write-Host "  3. Open http://localhost:8080 in your browser" -ForegroundColor White
Write-Host ""
Write-Host "Login credentials:" -ForegroundColor Yellow
Write-Host "  Email: admin@example.org" -ForegroundColor White
Write-Host "  Password: changeme" -ForegroundColor White
Write-Host ""
