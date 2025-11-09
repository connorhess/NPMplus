# Node.js Installation Guide for NPMplus Development

## You Need to Install Node.js First!

The VS Code debugger requires Node.js to be installed on your system. Here's how to install it:

## Option 1: Official Node.js Installer (Recommended)

1. **Download Node.js**
   - Visit: https://nodejs.org/
   - Download the **LTS (Long Term Support)** version
   - Choose the Windows Installer (.msi) for your system:
     - 64-bit (most common): `node-v20.x.x-x64.msi`
     - 32-bit: `node-v20.x.x-x86.msi`

2. **Run the Installer**
   - Double-click the downloaded `.msi` file
   - Follow the installation wizard
   - **Important:** Keep the option "Add to PATH" checked
   - Accept the default installation location

3. **Verify Installation**
   - Open a **NEW** PowerShell window (important - close any old ones)
   - Run:
     ```powershell
     node --version
     npm --version
     ```
   - You should see version numbers like `v20.11.0` and `10.2.4`

## Option 2: Using Volta (Developer Tool Manager)

Volta is a hassle-free way to manage Node.js versions:

1. **Install Volta**
   - Visit: https://volta.sh/
   - Download and run the Windows installer
   - Or use this PowerShell command:
     ```powershell
     # Run in PowerShell as Administrator
     iwr https://get.volta.sh/windows | iex
     ```

2. **Install Node.js with Volta**
   ```powershell
   volta install node
   ```

3. **Verify**
   ```powershell
   node --version
   npm --version
   ```

## Option 3: Using Windows Package Manager (winget)

If you have Windows 11 or recent Windows 10:

```powershell
# Install Node.js LTS
winget install OpenJS.NodeJS.LTS

# Verify (in a NEW PowerShell window)
node --version
npm --version
```

## Option 4: Using Chocolatey

If you have Chocolatey package manager:

```powershell
# Run PowerShell as Administrator
choco install nodejs-lts

# Verify (in a NEW PowerShell window)
node --version
npm --version
```

## Option 5: Using NVM for Windows

If you need to manage multiple Node.js versions:

1. **Install NVM for Windows**
   - Visit: https://github.com/coreybutler/nvm-windows/releases
   - Download `nvm-setup.exe`
   - Run the installer

2. **Install Node.js**
   ```powershell
   nvm install lts
   nvm use lts
   ```

3. **Verify**
   ```powershell
   node --version
   npm --version
   ```

## After Installation

### 1. Restart VS Code
Close and reopen VS Code to pick up the new PATH changes.

### 2. Verify in VS Code
Open the integrated terminal in VS Code (`Ctrl+`` ` ``) and run:
```powershell
node --version
npm --version
```

### 3. Install Backend Dependencies
```powershell
cd backend
npm install
```

### 4. Try Debugging Again
- Press `F5`
- Select "NPMplus Backend (Dev)"
- It should now launch successfully!

## Troubleshooting

### "node is not recognized" After Installation

**Solution 1: Restart Everything**
1. Close ALL PowerShell/Command Prompt windows
2. Close VS Code completely
3. Reopen VS Code
4. Try again

**Solution 2: Check PATH Manually**
1. Open Windows Settings
2. Search for "Environment Variables"
3. Click "Edit the system environment variables"
4. Click "Environment Variables..." button
5. In "System variables", find and select "Path"
6. Click "Edit..."
7. Verify there's an entry like: `C:\Program Files\nodejs\`
8. If missing, click "New" and add it
9. Click OK on all dialogs
10. Restart VS Code

**Solution 3: Specify Full Path in launch.json**
If Node.js is installed but not in PATH, you can specify the full path:

Edit `.vscode/launch.json` and change `runtimeExecutable`:
```json
"runtimeExecutable": "C:\\Program Files\\nodejs\\node.exe",
```

### Still Having Issues?

**Check Node.js Installation Location:**
```powershell
Get-Command node | Select-Object -ExpandProperty Source
```

**Manually Test Node:**
```powershell
& "C:\Program Files\nodejs\node.exe" --version
```

**Check if another Node version is conflicting:**
```powershell
Get-Command node -All
```

## Recommended Version

- **Node.js LTS (Long Term Support)**: Currently v20.x or v22.x
- **Minimum Required**: v18.x
- **Not Recommended**: Older versions (v16 and below)

## Next Steps

Once Node.js is installed and working:

1. Install backend dependencies:
   ```powershell
   cd backend
   npm install
   ```

2. Set up the development environment:
   - See [DEV_SETUP.md](DEV_SETUP.md) for full instructions

3. Start debugging:
   - Press `F5` in VS Code
   - Select "NPMplus Backend (Dev)"

## Quick Test Script

Save this as `test-node.ps1` and run it to verify everything:

```powershell
# Test Node.js Installation
Write-Host "Testing Node.js installation..." -ForegroundColor Cyan

try {
    $nodeVersion = node --version
    Write-Host "✓ Node.js is installed: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js is NOT installed or not in PATH" -ForegroundColor Red
    Write-Host "  Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}

try {
    $npmVersion = npm --version
    Write-Host "✓ npm is installed: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ npm is NOT installed or not in PATH" -ForegroundColor Red
    exit 1
}

Write-Host "`nNode.js is ready for development!" -ForegroundColor Green
Write-Host "You can now run: cd backend; npm install" -ForegroundColor Cyan
```

Run it:
```powershell
.\test-node.ps1
```

## Additional Resources

- [Node.js Official Documentation](https://nodejs.org/docs/)
- [npm Documentation](https://docs.npmjs.com/)
- [VS Code Node.js Debugging Guide](https://code.visualstudio.com/docs/nodejs/nodejs-debugging)
