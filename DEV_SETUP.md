# NPMplus Development Setup

This guide will help you set up a local development environment for NPMplus.

## Prerequisites

- **Node.js** (v18 or later recommended) - **[Installation Guide](INSTALL_NODEJS.md)**
  - If you get "node is not recognized" errors, Node.js is not installed
  - See [INSTALL_NODEJS.md](INSTALL_NODEJS.md) for detailed installation instructions
- **npm** (comes with Node.js)
- **Git**
- **VS Code** (recommended, with launch configurations included)

## Quick Start

### 1. Clone and Install Dependencies

```powershell
# Navigate to the backend directory
cd backend

# Install dependencies
npm install
```

### 2. Set Up Environment

```powershell
# Copy the example environment file
Copy-Item ..\.env.example ..\.env

# Edit .env with your settings (optional for basic dev)
code ..\.env
```

### 3. Initialize Development Database

The application will automatically create a SQLite database on first run. By default, the dev configuration uses `.dev-data/npmplus/` to keep development data separate from any production setup.

```powershell
# Create the dev data directory
New-Item -ItemType Directory -Force -Path ..\.dev-data\npmplus
```

### 4. Run Database Migrations

```powershell
# Run migrations using VS Code debugger (recommended)
# Press F5 in VS Code and select "Run Migrations"

# OR run manually
node migrate.js
```

### 5. Start the Development Server

**Option A: Using VS Code Debugger (Recommended)**

1. Open VS Code
2. Press `F5` or go to Run and Debug
3. Select **"NPMplus Backend (Dev)"**
4. The debugger will start with breakpoint support

**Option B: Using Terminal**

```powershell
node index.js
```

### 6. Access the Application

The backend creates a Unix socket by default (`/run/npmplus.sock`). For Windows development, you may need to modify the listening behavior or use nginx/a reverse proxy to connect.

**Note:** The default configuration in `index.js` uses a Unix socket which doesn't work on Windows. For Windows development, you should modify the socket path or configure it to listen on a TCP port.

## VS Code Launch Configurations

The `.vscode/launch.json` includes several helpful configurations:

### Available Debug Configurations

1. **NPMplus Backend (Dev)** - Main development server with auto-restart
   - Uses development environment
   - SQLite database in `.dev-data/`
   - Debug logging enabled
   - Auto-restart on changes

2. **NPMplus Backend (Production Mode)** - Test production behavior
   - Production environment settings
   - Useful for testing before deployment

3. **Run Migrations** - Execute database migrations
   - Applies schema changes
   - Safe to run multiple times

4. **Password Reset** - Reset user password
   - Prompts for email and new password
   - Useful for recovering admin access

5. **Validate Schema** - Check API schema validity
   - Validates OpenAPI/JSON schemas
   - Run before committing schema changes

6. **Attach to Running Process** - Attach debugger to running Node process
   - Start your app with `node --inspect index.js`
   - Then use this configuration to attach

## Development Workflow

### Running with Auto-Reload

For a better development experience with auto-reload on file changes:

```powershell
# Install nodemon globally
npm install -g nodemon

# Run with nodemon
nodemon index.js
```

Or add to `backend/package.json` scripts:

```json
{
  "scripts": {
    "dev": "nodemon index.js",
    "start": "node index.js",
    "validate-schema": "node validate-schema.js",
    "migrate": "node migrate.js"
  }
}
```

### Database

- **SQLite** (default for dev): Stored in `.dev-data/npmplus/database.sqlite`
- **MySQL/MariaDB**: Configure via environment variables in `.env`
- **PostgreSQL**: Configure via environment variables in `.env`

### Migrations

Database migrations are in `backend/migrations/`. To create a new migration:

```powershell
# Create a new migration file (use Unix timestamp or Knex CLI if installed)
# Manual: create YYYYMMDDHHMMSS_description.js in migrations/

# Run migrations
npm run migrate
# OR use the VS Code "Run Migrations" debug configuration
```

### Linting and Code Style

```powershell
# Run ESLint
npx eslint .

# Auto-fix issues
npx eslint . --fix

# Validate schema
npm run validate-schema
```

## Troubleshooting

### Windows-Specific Issues

**Unix Socket Not Supported on Windows**

The default `index.js` tries to listen on `/run/npmplus.sock`. To work around this on Windows:

1. **Option 1:** Modify `backend/index.js` temporarily:
   ```javascript
   // Change from:
   const server = app.listen("/run/npmplus.sock", () => {
   
   // To:
   const server = app.listen(3000, "127.0.0.1", () => {
       logger.info("Backend PID " + process.pid + " listening on http://127.0.0.1:3000");
   ```

2. **Option 2:** Use WSL2 (Windows Subsystem for Linux) for a more authentic environment

### Database Issues

**Permission Errors**

Ensure the `.dev-data/npmplus/` directory exists and is writable:

```powershell
New-Item -ItemType Directory -Force -Path .\.dev-data\npmplus
```

**Database Locked**

If you get "database is locked" errors, ensure only one instance is running.

### Port Already in Use

If modifying to use TCP and port 3000 is taken:

```powershell
# Find what's using the port
netstat -ano | findstr :3000

# Kill the process (replace PID)
taskkill /PID <PID> /F
```

## Testing

Currently, the project doesn't have a test suite. Consider adding:

- Unit tests with Jest or Mocha
- Integration tests for API endpoints
- Migration tests

## Contributing

1. Create a feature branch from `develop`
2. Make your changes
3. Test thoroughly (including migrations)
4. Run linting: `npx eslint . --fix`
5. Commit with clear messages
6. Open a pull request to `develop`

## Additional Resources

- [Main README](../README.md) - Full project documentation
- [Knex.js Documentation](https://knexjs.org/) - Database query builder
- [Express.js Documentation](https://expressjs.com/) - Web framework
- [Better-SQLite3 Documentation](https://github.com/WiseLibs/better-sqlite3) - SQLite driver

## Environment Variables Reference

See `.env.example` for a complete list of available environment variables.

Key development variables:

- `NODE_ENV` - Set to `development` or `production`
- `TZ` - Timezone (e.g., `UTC`, `America/New_York`)
- `ACME_EMAIL` - Email for Let's Encrypt (can be dummy for dev)
- `DEBUG` - Enable debug logging
- `NPM_PORT` - Port for the NPM web UI (default: 81)
- `DB_MYSQL_*` / `DB_POSTGRES_*` - Database connection settings

## Next Steps

- Set up the frontend development environment (if working on UI)
- Configure nginx for local testing
- Set up CrowdSec for local testing (optional)
- Review the [Roadmap & Proposed Improvements](../README.md#roadmap--proposed-improvements) for feature ideas

## Getting Help

- [GitHub Discussions](https://github.com/ZoeyVid/NPMplus/discussions)
- [Discord](https://discord.gg/y8DhYhv427) (#support-npmplus channel)
- [GitHub Issues](https://github.com/ZoeyVid/NPMplus/issues) (for bugs)
