# Enhanced Sales Application - E-commerce Platform

A production-ready, full-stack e-commerce application inspired by [Hades.vn](https://hades.vn/) with advanced features including payment processing, inventory management, analytics, and real-time notifications.

## 🚀 Features

### Core E-commerce Features
- **Product Catalog**: Categories, products, images, variants, pricing
- **Shopping Cart**: Persistent cart, quantity management, price calculations
- **Order Management**: Order processing, status tracking, fulfillment
- **Customer Management**: Customer profiles, order history, preferences
- **Payment Processing**: Stripe, PayPal, MoMo, VNPay integration
- **Inventory Management**: Stock tracking, low-stock alerts, reorder points

### Advanced Features
- **Analytics & Reporting**: Sales reports, product analytics, revenue trends
- **Real-time Notifications**: Email, SMS, in-app notifications
- **Search & Filtering**: Elasticsearch-powered product search
- **Caching**: Redis-based caching for performance
- **File Management**: AWS S3 integration for file uploads
- **Multi-language Support**: Internationalization (i18n)
- **Role-based Access**: Admin, Sales, Customer roles
- **Monitoring**: Prometheus metrics, Grafana dashboards

### Technical Features
- **Microservices Ready**: Modular architecture
- **API Documentation**: OpenAPI 3.0 with Swagger UI
- **Security**: JWT authentication, CORS, input validation
- **Performance**: Optimized builds, CDN-ready, compression
- **Scalability**: Horizontal scaling support
- **Monitoring**: Health checks, metrics, logging

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Backend      │    │   Database      │
│   (Angular)     │◄──►│  (Spring Boot)  │◄──►│    (MySQL)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │   Redis Cache   │              │
         │              └─────────────────┘              │
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │  Elasticsearch  │              │
         │              └─────────────────┘              │
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │   RabbitMQ      │              │
         │              └─────────────────┘              │
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │   AWS S3        │              │
         │              └─────────────────┘              │
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │   Prometheus    │              │
         │              │   + Grafana     │              │
         │              └─────────────────┘              │
```

## 🛠️ Technology Stack

### Backend
- **Framework**: Spring Boot 3.2.0
- **Language**: Java 17
- **Database**: MySQL 8.0
- **ORM**: Spring Data JPA
- **Security**: Spring Security + JWT
- **Cache**: Redis
- **Search**: Elasticsearch
- **Message Queue**: RabbitMQ
- **File Storage**: AWS S3
- **Payment**: Stripe, PayPal, MoMo, VNPay
- **Documentation**: OpenAPI 3.0
- **Monitoring**: Micrometer + Prometheus
- **Build Tool**: Maven

### Frontend
- **Framework**: Angular 17
- **Language**: TypeScript
- **UI Library**: Angular Material
- **State Management**: NgRx
- **Charts**: ngx-charts
- **Internationalization**: ngx-translate
- **Payment**: Stripe Elements
- **Notifications**: ngx-toastr
- **Build Tool**: Angular CLI

### Infrastructure
- **Containerization**: Docker
- **Orchestration**: Docker Compose
- **Web Server**: Nginx
- **Monitoring**: Prometheus + Grafana
- **CI/CD**: Ready for GitHub Actions

## 📦 Quick Start

### Prerequisites
- Docker & Docker Compose
- Node.js 18+ (for local development)
- Java 17+ (for local development)
- Maven 3.9+ (for local development)

### 1. Clone and Setup
```bash
git clone <repository-url>
cd sales-application
```

### 2. Environment Configuration
```bash
# Copy environment template
cp env.example .env

# Edit environment variables
nano .env
```

### 3. Start Application
```bash
# Start all services
docker-compose up --build

# Or start in background
docker-compose up -d --build
```

### 4. Access Applications
- **Frontend**: http://localhost:4200
- **Backend API**: http://localhost:8080
- **API Documentation**: http://localhost:8080/swagger-ui.html
- **Grafana**: http://localhost:3000 (admin/admin)
- **Prometheus**: http://localhost:9090
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)

### 5. Default Credentials
- **Admin User**: admin / admin123
- **Database**: sales_user / sales_password

## 🔧 Development

### Backend Development
```bash
cd backend

# Run with Maven
mvn spring-boot:run

# Run tests
mvn test

# Build
mvn clean package
```

### Frontend Development
```bash
cd frontend

# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build:prod

# Run tests
npm test
```

### Database Management
```bash
# Access MySQL
docker exec -it sales-mysql mysql -u sales_user -p sales_app

# View logs
docker-compose logs mysql
```

## 📊 API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/refresh` - Refresh token
- `POST /api/auth/logout` - User logout

### Products
- `GET /api/products` - List products
- `GET /api/products/{id}` - Get product details
- `POST /api/products` - Create product (Admin)
- `PUT /api/products/{id}` - Update product (Admin)
- `DELETE /api/products/{id}` - Delete product (Admin)

### Orders
- `GET /api/orders` - List orders
- `GET /api/orders/{id}` - Get order details
- `POST /api/orders` - Create order
- `PUT /api/orders/{id}/status` - Update order status

### Cart
- `GET /api/cart` - Get user cart
- `POST /api/cart/items` - Add item to cart
- `PUT /api/cart/items/{id}` - Update cart item
- `DELETE /api/cart/items/{id}` - Remove cart item

### Payments
- `POST /api/payments/stripe` - Process Stripe payment
- `POST /api/payments/paypal` - Process PayPal payment
- `POST /api/payments/momo` - Process MoMo payment
- `POST /api/payments/vnpay` - Process VNPay payment

### Reports
- `GET /api/reports/sales` - Sales reports
- `GET /api/reports/products` - Product analytics
- `GET /api/reports/customers` - Customer analytics

## 🗄️ Database Schema

### Core Tables
- `users` - User accounts and authentication
- `roles` - User roles and permissions
- `products` - Product catalog
- `categories` - Product categories
- `customers` - Customer information
- `orders` - Order management
- `order_items` - Order line items
- `cart_items` - Shopping cart

### Advanced Tables
- `payments` - Payment transactions
- `notifications` - User notifications
- `inventory_logs` - Stock movement tracking
- `product_reviews` - Customer reviews
- `wishlist` - User wishlists
- `coupons` - Discount coupons
- `product_images` - Product images

## 🔒 Security Features

- **JWT Authentication**: Secure token-based authentication
- **Role-based Access Control**: Fine-grained permissions
- **Input Validation**: Comprehensive validation on all inputs
- **CORS Configuration**: Secure cross-origin requests
- **SQL Injection Prevention**: Parameterized queries
- **XSS Protection**: Input sanitization
- **CSRF Protection**: Cross-site request forgery prevention
- **Rate Limiting**: API rate limiting (configurable)
- **Secure Headers**: Security headers in responses

## 📈 Monitoring & Observability

### Health Checks
- Application health: `/actuator/health`
- Database connectivity
- Redis connectivity
- Elasticsearch connectivity

### Metrics
- Application metrics: `/actuator/metrics`
- Prometheus format: `/actuator/prometheus`
- Custom business metrics
- Performance metrics

### Logging
- Structured JSON logging
- Log levels: DEBUG, INFO, WARN, ERROR
- Log rotation and archiving
- Centralized log management

## 🚀 Production Deployment

### Environment Variables
```bash
# Database
DB_HOST=your-db-host
DB_PORT=3306
DB_USER=your-db-user
DB_PASSWORD=your-db-password

# JWT
JWT_SECRET=your-super-secret-jwt-key

# Payment Gateways
STRIPE_SECRET_KEY=sk_live_your-stripe-key
PAYPAL_CLIENT_SECRET=your-paypal-secret

# AWS S3
AWS_ACCESS_KEY_ID=your-aws-key
AWS_SECRET_ACCESS_KEY=your-aws-secret
AWS_S3_BUCKET=your-bucket-name
```

### Docker Production
```bash
# Build production images
docker-compose -f docker-compose.prod.yml build

# Deploy
docker-compose -f docker-compose.prod.yml up -d
```

### Kubernetes Deployment
```bash
# Apply Kubernetes manifests
kubectl apply -f k8s/

# Check deployment status
kubectl get pods
kubectl get services
```

## 🧪 Testing

### Backend Tests
```bash
# Unit tests
mvn test

# Integration tests
mvn verify

# Test coverage
mvn jacoco:report
```

### Frontend Tests
```bash
# Unit tests
npm test

# E2E tests
npm run e2e

# Test coverage
npm run test:coverage
```

### API Tests
```bash
# Using curl
curl -X GET http://localhost:8080/api/products

# Using Postman
# Import the provided Postman collection
```

## 🔧 Configuration

### Application Properties
- `application.yml` - Main configuration
- `application-dev.yml` - Development profile
- `application-prod.yml` - Production profile

### Environment Variables
- Database connection
- JWT configuration
- Payment gateway settings
- AWS credentials
- Email configuration

### Feature Flags
- Analytics enabled/disabled
- Notifications enabled/disabled
- Payment methods enabled/disabled
- Cache settings

## 📚 Documentation

- **API Documentation**: http://localhost:8080/swagger-ui.html
- **Database Schema**: See `mysql/init.sql`
- **Architecture**: See architecture diagram above
- **Deployment Guide**: See production deployment section

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

- **Issues**: Create an issue on GitHub
- **Documentation**: Check the README and API docs
- **Community**: Join our community discussions

## 🔄 Changelog

### v1.0.0 (Current)
- Initial release with core e-commerce features
- Advanced payment processing
- Real-time notifications
- Analytics and reporting
- Production-ready deployment
- Comprehensive monitoring

---

**Built with ❤️ for modern e-commerce** 