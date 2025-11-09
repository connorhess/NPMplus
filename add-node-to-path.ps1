# Add Node.js to PATH permanently
# Run this script as Administrator

Write-Host "Adding Node.js to your PATH..." -ForegroundColor Cyan

$nodePath = "C:\Program Files\nodejs"

# Check if Node.js is installed
if (-not (Test-Path "$nodePath\node.exe")) {
    Write-Host "ERROR: Node.js not found at $nodePath" -ForegroundColor Red
    Write-Host "Please verify Node.js installation location." -ForegroundColor Yellow
    exit 1
}

# Get current PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

# Check if Node.js is already in PATH
if ($currentPath -like "*$nodePath*") {
    Write-Host "Node.js is already in your PATH!" -ForegroundColor Green
} else {
    try {
        # Add Node.js to PATH
        $newPath = "$currentPath;$nodePath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Host "SUCCESS: Node.js added to PATH!" -ForegroundColor Green
        Write-Host "Please restart VS Code for changes to take effect." -ForegroundColor Yellow
    } catch {
        Write-Host "ERROR: Failed to update PATH" -ForegroundColor Red
        Write-Host "You need to run this script as Administrator!" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Right-click PowerShell and select 'Run as Administrator', then run:" -ForegroundColor Cyan
        Write-Host "  cd '$PWD'" -ForegroundColor White
        Write-Host "  .\add-node-to-path.ps1" -ForegroundColor White
        exit 1
    }
}

Write-Host ""
Write-Host "Verifying Node.js installation:" -ForegroundColor Cyan
& "$nodePath\node.exe" --version
& "$nodePath\npm.cmd" --version
