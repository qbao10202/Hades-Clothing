# SalesApp

A full-stack sales management platform with a modern Angular frontend and robust Spring Boot backend. Features include product management, order processing, authentication, analytics, and more.

---

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Development](#development)
  - [Production (Docker)](#production-docker)
- [Environment Variables](#environment-variables)
- [API Documentation](#api-documentation)
- [License](#license)

---

## Features
- User authentication (JWT, registration, login, roles, permissions)
- Product catalog with categories, images, and search
- Cart and checkout
- Order management (admin and user)
- Customer management
- Dashboard with analytics and charts
- File/image upload (local storage)
- Caching (simple/Redis)
- Prometheus metrics and health checks
- Responsive, modern Angular UI (admin & user)
- Dockerized for easy deployment

---

## Tech Stack

**Frontend:**
- Angular 17, Angular Material, NgRx, TailwindCSS, ngx-charts, ngx-toastr, etc.

**Backend:**
- Java 17, Spring Boot 3, Spring Security, Spring Data JPA, Spring Validation, Spring Cache, Spring Actuator, MapStruct, Lombok, JWT, Redis, MySQL, H2 (dev), Prometheus, Swagger/OpenAPI

**DevOps:**
- Docker, Docker Compose

---

## Project Structure

```
.
├── backend/         # Spring Boot backend (API, business logic, DB)
│   ├── src/
│   ├── Dockerfile
│   └── ...
├── frontend/        # Angular frontend (UI, SPA)
│   ├── src/
│   ├── Dockerfile
│   └── ...
├── docker-compose.yml
├── env.example      # Example environment variables
└── ...
```

---

## Getting Started

### Development

#### Prerequisites
- Node.js (v18+), npm
- Java 17+
- Maven
- MySQL (or Docker)
- Redis (optional, for caching)

#### 1. Clone the repository
```bash
git clone https://github.com/qbao10202/Hades-Clothing
cd Hades Clothing
```


### Production (Docker)

1. Build and run all services:
```bash
docker-compose up --build
```
- Frontend: http://localhost:4200
- Backend: http://localhost:8080
- MySQL: localhost:3307

---

## Environment Variables
See `env.example` for all available variables. Key ones:
- `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`
- `JWT_SECRET`, `JWT_EXPIRATION`
- `REDIS_*`
- `APP_NAME`, `APP_VERSION`, `APP_ENVIRONMENT`
- `CORS_ALLOWED_ORIGINS`

---




## License
This project is licensed under the MIT License. 