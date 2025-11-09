# ⚠️ BEFORE YOU START: Install Node.js

## The VS Code debugger failed because Node.js is not installed!

### Quick Fix (2 minutes):

1. **Download Node.js LTS:**
   - Visit: **https://nodejs.org/**
   - Click the big green "LTS" button
   - Download and run the installer
   - ✅ Keep "Add to PATH" checked during installation

2. **Verify installation** (open a NEW PowerShell window):
   ```powershell
   node --version
   npm --version
   ```

3. **Install dependencies:**
   ```powershell
   cd backend
   npm install
   cd ..
   ```

4. **Press F5 in VS Code** to start debugging!

---

## Need More Help?

- **Detailed installation guide:** [INSTALL_NODEJS.md](INSTALL_NODEJS.md)
- **Full development setup:** [DEV_SETUP.md](DEV_SETUP.md)
- **Quick command reference:** [QUICK_REFERENCE.md](QUICK_REFERENCE.md)

## Check Your Environment

Run this script anytime to verify everything is set up correctly:

```powershell
.\check-environment.ps1
```

It will tell you exactly what's missing and how to fix it.

---

**After installing Node.js, restart VS Code and try debugging again with F5!**
