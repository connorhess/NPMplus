#!/usr/bin/env node

/**
 * Simple development server for NPMplus frontend
 * Serves the built frontend and proxies API requests to the backend
 */

const express = require('express');
const path = require('path');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const PORT = process.env.FRONTEND_PORT || 8080;
const BACKEND_URL = process.env.BACKEND_URL || 'http://127.0.0.1:3000';

// Proxy API requests to backend
app.use('/api', createProxyMiddleware({
  target: BACKEND_URL,
  changeOrigin: true,
  logLevel: 'debug'
}));

// Serve static files from dist directory
app.use(express.static(path.join(__dirname, 'dist')));

// SPA fallback - serve index.html for all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`NPMplus Frontend Dev Server running at http://localhost:${PORT}`);
  console.log(`Proxying API requests to ${BACKEND_URL}`);
  console.log('');
  console.log('Login credentials:');
  console.log('  Email: admin@example.org');
  console.log('  Password: changeme');
});
