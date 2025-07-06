@echo off
chcp 65001 >nul

REM Enhanced Sales Application Startup Script for Windows
REM E-commerce Platform with Advanced Features

echo 🚀 Starting Enhanced Sales Application...
echo ==========================================

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not running. Please start Docker Desktop first.
    pause
    exit /b 1
)

REM Check if Docker Compose is available
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker Compose is not installed. Please install Docker Compose first.
    pause
    exit /b 1
)

REM Create .env file if it doesn't exist
if not exist .env (
    echo 📝 Creating .env file from template...
    copy env.example .env
    echo ⚠️  Please edit .env file with your configuration before starting.
    echo    You can run: notepad .env
    pause
)

REM Stop any existing containers
echo 🛑 Stopping existing containers...
docker-compose down

REM Build and start services
echo 🔨 Building and starting services...
docker-compose up --build -d

REM Wait for services to be ready
echo ⏳ Waiting for services to be ready...
timeout /t 30 /nobreak >nul

REM Check service health
echo 🔍 Checking service health...

REM Check MySQL
docker-compose exec mysql mysqladmin ping -h localhost --silent >nul 2>&1
if errorlevel 1 (
    echo ❌ MySQL is not ready
) else (
    echo ✅ MySQL is ready
)

REM Check Redis
docker-compose exec redis redis-cli ping >nul 2>&1
if errorlevel 1 (
    echo ❌ Redis is not ready
) else (
    echo ✅ Redis is ready
)

REM Check Elasticsearch
curl -f http://localhost:9200/_cluster/health >nul 2>&1
if errorlevel 1 (
    echo ❌ Elasticsearch is not ready
) else (
    echo ✅ Elasticsearch is ready
)

REM Check RabbitMQ
curl -f http://localhost:15672/api/overview >nul 2>&1
if errorlevel 1 (
    echo ❌ RabbitMQ is not ready
) else (
    echo ✅ RabbitMQ is ready
)

REM Check Backend
curl -f http://localhost:8080/actuator/health >nul 2>&1
if errorlevel 1 (
    echo ❌ Backend is not ready
) else (
    echo ✅ Backend is ready
)

REM Check Frontend
curl -f http://localhost:4200 >nul 2>&1
if errorlevel 1 (
    echo ❌ Frontend is not ready
) else (
    echo ✅ Frontend is ready
)

echo.
echo 🎉 Application is starting up!
echo ==========================================
echo 📱 Frontend:     http://localhost:4200
echo 🔧 Backend API:  http://localhost:8080
echo 📚 API Docs:     http://localhost:8080/swagger-ui.html
echo 📊 Grafana:      http://localhost:3000 (admin/admin)
echo 📈 Prometheus:   http://localhost:9090
echo 🐰 RabbitMQ:     http://localhost:15672 (guest/guest)
echo ==========================================
echo.
echo 🔑 Default Admin Credentials:
echo    Username: admin
echo    Password: admin123
echo.
echo 📋 Useful Commands:
echo    View logs:     docker-compose logs -f
echo    Stop app:      docker-compose down
echo    Restart:       docker-compose restart
echo    Update:        docker-compose pull ^&^& docker-compose up -d
echo.
echo 🚀 Happy shopping! 🛒
pause 