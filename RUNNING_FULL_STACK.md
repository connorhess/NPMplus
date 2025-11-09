# Running NPMplus Full Stack in Development

This guide shows you how to run both the backend and frontend together for development.

## Quick Start

### 1. Install Frontend Dependencies

First time only - install the frontend dependencies:

```powershell
cd frontend-old
npm install
```

### 2. Build the Frontend

```powershell
# Still in frontend-old directory
npm run build
```

### 3. Run Both Backend and Frontend

**Option A: Using VS Code (Recommended)**

1. Open VS Code
2. Press `F5` or go to Run and Debug
3. Select **"NPMplus Full Stack (Dev)"** from the dropdown
4. Both backend and frontend will start automatically

**Option B: Manual Terminal Commands**

Terminal 1 - Backend:
```powershell
cd backend
node index.js
```

Terminal 2 - Frontend Dev Server:
```powershell
cd frontend-old
npm run serve
```

### 4. Access the Application

- **Frontend UI**: http://localhost:8080
- **Backend API**: http://localhost:3000

### Default Login Credentials

- **Email**: `admin@example.org`
- **Password**: `changeme`

## VS Code Debug Configurations

### Individual Configurations

- **NPMplus Backend (Dev)** - Run backend only on port 3000
- **NPMplus Frontend (Dev)** - Run frontend dev server on port 8080
- **NPMplus Full Stack (Dev)** - Run both together (compound configuration)

### Other Useful Configurations

- **Run Migrations** - Apply database migrations
- **Password Reset** - Reset a user's password
- **Validate Schema** - Validate API schemas

## Development Workflow

### Making Frontend Changes

If you want to rebuild the frontend automatically when files change:

```powershell
# In frontend-old directory
npm run dev
```

This runs webpack in watch mode. Keep this running in one terminal, and run the dev server in another.

### Making Backend Changes

The backend configuration includes auto-restart, so changes will automatically reload when you save files.

### Hot Reload Setup

For the best development experience:

1. Run `npm run dev` in frontend-old (webpack watch mode)
2. Run the compound "NPMplus Full Stack (Dev)" configuration
3. Frontend will rebuild automatically on changes
4. Backend will restart automatically on changes
5. Just refresh your browser to see frontend changes

## Port Configuration

You can customize ports via environment variables:

- **Backend**: Set `BACKEND_PORT` (default: 3000)
- **Frontend**: Set `FRONTEND_PORT` (default: 8080)

Edit these in `.vscode/launch.json` under the respective configuration's `env` section.

## Troubleshooting

### Frontend shows "Cannot connect to backend"

1. Ensure backend is running on port 3000
2. Check backend terminal for errors
3. Verify `BACKEND_URL` in frontend configuration matches backend port

### Port already in use

```powershell
# Find what's using the port (e.g., 8080)
netstat -ano | findstr :8080

# Kill the process (replace PID)
taskkill /PID <PID> /F
```

### Frontend not updating

1. Make sure webpack is rebuilding (run `npm run dev`)
2. Hard refresh browser (Ctrl+Shift+R)
3. Clear browser cache

### Backend won't start

1. Ensure `.dev-data/npmplus/` directory exists
2. Run migrations: Use "Run Migrations" debug configuration
3. Check for database lock issues (ensure no other instance is running)

## Architecture

```
┌─────────────────┐         ┌─────────────────┐
│   Browser       │────────▶│  Frontend Dev   │
│  localhost:8080 │         │  Server (Node)  │
└─────────────────┘         └────────┬────────┘
                                     │
                                     │ Proxies /api
                                     ▼
                            ┌─────────────────┐
                            │  Backend API    │
                            │  localhost:3000 │
                            └────────┬────────┘
                                     │
                                     ▼
                            ┌─────────────────┐
                            │  SQLite DB      │
                            │  .dev-data/     │
                            └─────────────────┘
```

## Next Steps

- Set up nginx for local testing (optional)
- Configure HTTPS for local development (optional)
- Add test data via the UI
- See [DEV_SETUP.md](DEV_SETUP.md) for more detailed development information
