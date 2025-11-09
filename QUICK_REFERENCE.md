# NPMplus Development Quick Reference

Quick commands and shortcuts for NPMplus development.

## Initial Setup (One-Time)

```powershell
# 1. Create dev data directory
New-Item -ItemType Directory -Force -Path .\.dev-data\npmplus

# 2. Copy environment file
Copy-Item .env.example .env

# 3. Install dependencies
cd backend
npm install
cd ..

# 4. Run migrations (creates database)
cd backend
node migrate.js
cd ..
```

## Daily Development

### Start Backend (VS Code)
- Press `F5`
- Select **"NPMplus Backend (Dev)"**
- Or use Command Palette: `Debug: Start Debugging`

### Start Backend (Terminal)
```powershell
cd backend
node index.js
```

### Start with Auto-Reload (nodemon)
```powershell
cd backend
npx nodemon index.js
```

### Run Migrations
```powershell
cd backend
node migrate.js
```

### Validate Schema
```powershell
cd backend
npm run validate-schema
```

### Lint Code
```powershell
cd backend
npx eslint .              # Check for issues
npx eslint . --fix        # Auto-fix issues
```

## VS Code Tasks

Use `Ctrl+Shift+B` or `Terminal > Run Task...` to access:

- **Setup Dev Environment** - One-time setup (creates dirs, installs deps)
- **Run Backend Dev Server** - Start the server
- **Run Backend Dev Server (with nodemon)** - Start with auto-reload
- **Run Database Migrations** - Apply DB changes
- **Validate Schema** - Check API schemas
- **ESLint Check** - Lint code
- **ESLint Fix** - Auto-fix lint issues
- **Clean Dev Database** - Delete local database (fresh start)
- **Docker Compose: Up** - Start Docker containers
- **Docker Compose: Down** - Stop Docker containers
- **Docker Compose: Logs** - View container logs

## VS Code Debug Configurations

Available in Debug panel (`Ctrl+Shift+D`):

1. **NPMplus Backend (Dev)** - Main dev server with auto-restart
2. **NPMplus Backend (Production Mode)** - Test production mode
3. **Run Migrations** - Execute migrations
4. **Password Reset** - Reset user password (prompts for input)
5. **Validate Schema** - Check schemas
6. **Attach to Running Process** - Attach to running Node process

## Database Operations

### Fresh Database
```powershell
# Delete existing database
Remove-Item .\.dev-data\npmplus\*.sqlite* -Force

# Recreate with migrations
cd backend
node migrate.js
cd ..
```

### Reset Admin Password
```powershell
cd backend
node password-reset.js admin@example.org NewPassword123
cd ..
```

Or use the **Password Reset** debug configuration (prompts for input).

### View Database
Install SQLite extension, then:
1. `Ctrl+Shift+P`
2. Type "SQLite: Open Database"
3. Select `.dev-data/npmplus/database.sqlite`

## Docker Commands

### Development Build
```powershell
docker build -t npmplus:dev .
```

### Run with Docker Compose
```powershell
# Start
docker compose up -d

# View logs
docker compose logs -f npmplus

# Stop
docker compose down

# Rebuild and restart
docker compose up -d --build
```

### Enter Container
```powershell
docker exec -it npmplus sh
```

## Git Workflow

```powershell
# Create feature branch from develop
git checkout develop
git pull
git checkout -b feature/my-feature

# Make changes, commit
git add .
git commit -m "Add feature: description"

# Push to remote
git push -u origin feature/my-feature

# Create PR to develop branch
```

## Common File Locations

### Development Data
- Database: `.dev-data/npmplus/database.sqlite`
- Keys: `.dev-data/npmplus/keys.json`
- Config: `.dev-data/npmplus/default.json` (if used)

### Backend Code
- Entry point: `backend/index.js`
- App setup: `backend/app.js`
- Routes: `backend/routes/`
- Models: `backend/models/`
- Migrations: `backend/migrations/`
- Schema: `backend/schema/`

### Configuration
- Environment: `.env`
- VS Code: `.vscode/`
- Package: `backend/package.json`
- ESLint: `backend/eslint.config.mjs`

## Environment Variables (Quick)

Edit `.env` file:

```bash
# Required
TZ=UTC
ACME_EMAIL=dev@example.com

# Common Dev Overrides
NPM_PORT=81                    # Admin UI port
DEBUG=true                     # Debug logging
NODE_ENV=development           # Development mode

# Database (defaults to SQLite)
# DB_MYSQL_HOST=localhost
# DB_POSTGRES_HOST=localhost
```

## Troubleshooting

### Port Already in Use
```powershell
# Find process on port (e.g., 3000)
netstat -ano | findstr :3000

# Kill process by PID
taskkill /PID <PID> /F
```

### Database Locked
```powershell
# Ensure no other instances running
Get-Process node | Stop-Process -Force

# Delete lock files
Remove-Item .\.dev-data\npmplus\*.sqlite-wal -Force
Remove-Item .\.dev-data\npmplus\*.sqlite-shm -Force
```

### Dependencies Out of Date
```powershell
cd backend
npm install
cd ..
```

### Fresh Start
```powershell
# Clean everything
Remove-Item -Recurse -Force .\.dev-data
Remove-Item -Recurse -Force backend\node_modules

# Reinstall
cd backend
npm install
cd ..

# Setup again
New-Item -ItemType Directory -Force -Path .\.dev-data\npmplus
cd backend
node migrate.js
cd ..
```

## Useful VS Code Shortcuts

- `F5` - Start debugging
- `Shift+F5` - Stop debugging
- `Ctrl+Shift+D` - Open debug panel
- `Ctrl+Shift+B` - Run build task
- `Ctrl+Shift+P` - Command palette
- `Ctrl+`` ` `` - Toggle terminal
- `Ctrl+Shift+E` - Explorer
- `Ctrl+Shift+F` - Search in files
- `Ctrl+P` - Quick file open
- `F12` - Go to definition
- `Shift+F12` - Find references

## API Testing

### Using REST Client Extension

Create a `.http` file:

```http
### Get Health
GET http://localhost:3000/health

### Login
POST http://localhost:3000/api/tokens
Content-Type: application/json

{
  "identity": "admin@example.org",
  "secret": "password"
}
```

### Using curl
```powershell
# Health check
curl http://localhost:3000/health

# Login
curl -X POST http://localhost:3000/api/tokens `
  -H "Content-Type: application/json" `
  -d '{"identity":"admin@example.org","secret":"password"}'
```

## Logs

### View Backend Logs
- In debug mode: View in Debug Console
- In terminal mode: Logs print to stdout

### Enable Access Logs
Set in `.env`:
```bash
LOGROTATE=true
```

Logs will be in `/opt/npmplus/nginx/access.log` (container) or configure local path.

## Additional Resources

- Full setup guide: [DEV_SETUP.md](DEV_SETUP.md)
- Project README: [README.md](README.md)
- Roadmap: [README.md#roadmap--proposed-improvements](README.md#roadmap--proposed-improvements)

---

**Tip:** Keep this file open in a VS Code split pane for quick reference while developing!
