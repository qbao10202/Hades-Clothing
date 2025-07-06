#!/bin/bash

# Enhanced Sales Application Startup Script
# E-commerce Platform with Advanced Features

echo "🚀 Starting Enhanced Sales Application..."
echo "=========================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp env.example .env
    echo "⚠️  Please edit .env file with your configuration before starting."
    echo "   You can run: nano .env"
    read -p "Press Enter to continue or Ctrl+C to exit..."
fi

# Stop any existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Remove old volumes (optional - uncomment if you want fresh start)
# echo "🗑️  Removing old volumes..."
# docker-compose down -v

# Build and start services
echo "🔨 Building and starting services..."
docker-compose up --build -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 30

# Check service health
echo "🔍 Checking service health..."

# Check MySQL
if docker-compose exec mysql mysqladmin ping -h localhost --silent; then
    echo "✅ MySQL is ready"
else
    echo "❌ MySQL is not ready"
fi

# Check Redis
if docker-compose exec redis redis-cli ping > /dev/null 2>&1; then
    echo "✅ Redis is ready"
else
    echo "❌ Redis is not ready"
fi

# Check Elasticsearch
if curl -f http://localhost:9200/_cluster/health > /dev/null 2>&1; then
    echo "✅ Elasticsearch is ready"
else
    echo "❌ Elasticsearch is not ready"
fi

# Check RabbitMQ
if curl -f http://localhost:15672/api/overview > /dev/null 2>&1; then
    echo "✅ RabbitMQ is ready"
else
    echo "❌ RabbitMQ is not ready"
fi

# Check Backend
if curl -f http://localhost:8080/actuator/health > /dev/null 2>&1; then
    echo "✅ Backend is ready"
else
    echo "❌ Backend is not ready"
fi

# Check Frontend
if curl -f http://localhost:4200 > /dev/null 2>&1; then
    echo "✅ Frontend is ready"
else
    echo "❌ Frontend is not ready"
fi

echo ""
echo "🎉 Application is starting up!"
echo "=========================================="
echo "📱 Frontend:     http://localhost:4200"
echo "🔧 Backend API:  http://localhost:8080"
echo "📚 API Docs:     http://localhost:8080/swagger-ui.html"
echo "📊 Grafana:      http://localhost:3000 (admin/admin)"
echo "📈 Prometheus:   http://localhost:9090"
echo "🐰 RabbitMQ:     http://localhost:15672 (guest/guest)"
echo "=========================================="
echo ""
echo "🔑 Default Admin Credentials:"
echo "   Username: admin"
echo "   Password: admin123"
echo ""
echo "📋 Useful Commands:"
echo "   View logs:     docker-compose logs -f"
echo "   Stop app:      docker-compose down"
echo "   Restart:       docker-compose restart"
echo "   Update:        docker-compose pull && docker-compose up -d"
echo ""
echo "🚀 Happy shopping! 🛒" 