# TPC Placement Support System — Justfile
# Run `just` to see available recipes, or `just <recipe>` to execute one.

# Default: list all recipes
default:
    @just --list

# ─── Backend ────────────────────────────────────────────────────────────────

# Start backend in dev mode (nodemon)
backend:
    cd backend && npm run dev

# Start backend in production mode
backend-prod:
    cd backend && npm start

# Install backend dependencies
install-backend:
    cd backend && npm install

# Seed Admin and TPC users into the database (run once after first setup)
seed:
    cd backend && node scripts/seedAdminUsers.js

# Run backend tests
test-backend:
    cd backend && npm test

# Run backend tests with coverage
test-backend-cov:
    cd backend && npm run test:coverage

# ─── Frontend ───────────────────────────────────────────────────────────────

# Start frontend dev server
frontend:
    cd frontend && node node_modules/react-scripts/bin/react-scripts.js start

# Build frontend for production
build-frontend:
    cd frontend && npm run build

# Install frontend dependencies
install-frontend:
    cd frontend && npm install

# Run frontend tests
test-frontend:
    cd frontend && npm test

# ─── Combined ───────────────────────────────────────────────────────────────

# Install all dependencies (backend + frontend)
install:
    just install-backend
    just install-frontend

# Run both backend and frontend concurrently
dev:
    npx --yes concurrently --names "backend,frontend" --prefix-colors "cyan,magenta" \
        "cd backend && npm run dev" \
        "cd frontend && node node_modules/react-scripts/bin/react-scripts.js start"

# Run all tests
test:
    just test-backend
    just test-frontend

# ─── Docker (Databases) ─────────────────────────────────────────────────────

# Start MongoDB + Redis in the background
db:
    docker compose up -d

# Stop MongoDB + Redis
db-stop:
    docker compose down

# Stop and wipe all DB volumes (destructive!)
db-reset:
    docker compose down -v

# ─── Setup ──────────────────────────────────────────────────────────────────

# Initial project setup: install deps and copy .env files if missing
setup:
    #!/usr/bin/env bash
    set -e
    echo "Setting up backend..."
    cd backend
    npm install
    if [ ! -f .env ]; then
        cp .env.example .env
        echo "Created backend/.env from .env.example — update it with your MongoDB credentials!"
    else
        echo "backend/.env already exists, skipping."
    fi
    cd ..
    echo "Setting up frontend..."
    cd frontend
    npm install
    if [ ! -f .env ]; then
        cp .env.example .env
        echo "Created frontend/.env from .env.example"
    else
        echo "frontend/.env already exists, skipping."
    fi
    echo ""
    echo "✅ Setup complete!"
    echo "   Backend  → just backend   (http://localhost:5000)"
    echo "   Frontend → just frontend  (http://localhost:3000)"
    echo "   Both     → just dev"
