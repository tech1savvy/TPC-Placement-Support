# Development Guide

## First-Time Setup

Run these commands in order:

```bash
just db       # 1. Start MongoDB + Redis (Docker)
just seed     # 2. Seed Admin & TPC users (one-time only)
just dev      # 3. Start backend + frontend
```

## Daily Development

```bash
just db       # Start databases (if not already running)
just dev      # Start backend + frontend
```

## URLs

| Service      | URL                       |
|--------------|---------------------------|
| Frontend     | http://localhost:3000      |
| Backend API  | http://localhost:5000      |
| Login page   | http://localhost:3000/login |
| Register     | http://localhost:3000/register |

## Login Credentials

| Role    | Student ID | Password     | How to create       |
|---------|------------|--------------|---------------------|
| Admin   | `10000000` | `admin@12345`| `just seed` (seeded)|
| TPC     | `10000001` | `tpc@12345`  | `just seed` (seeded)|
| Student | any 8-digit | your choice | Register via UI     |

> **Note:** TPC and Admin accounts cannot self-register. Run `just seed` once after the DB is up.

## All Available Commands

| Command               | Description                                |
|-----------------------|--------------------------------------------|
| `just`                | List all available recipes                 |
| `just db`             | Start MongoDB + Redis in background        |
| `just db-stop`        | Stop database containers                   |
| `just db-reset`       | Stop + **wipe** all DB data ⚠️             |
| `just seed`           | Create Admin & TPC users (run once)        |
| `just backend`        | Start backend only (dev/nodemon)           |
| `just backend-prod`   | Start backend in production mode           |
| `just frontend`       | Start frontend only                        |
| `just build-frontend` | Build frontend for production              |
| `just dev`            | Start backend + frontend concurrently      |
| `just install`        | Install all npm dependencies               |
| `just install-backend`| Install backend deps only                  |
| `just install-frontend`| Install frontend deps only               |
| `just test`           | Run all tests                              |
| `just test-backend`   | Run backend tests                          |
| `just test-backend-cov`| Run backend tests with coverage           |
| `just test-frontend`  | Run frontend tests                         |
| `just setup`          | Full first-time setup (install + .env)     |
