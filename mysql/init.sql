-- Enhanced Sales Application Database Initialization Script
-- Based on Hades.vn e-commerce functionality

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS sales_app;
USE sales_app;

-- Roles table
CREATE TABLE IF NOT EXISTS roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Permissions table
CREATE TABLE IF NOT EXISTS permissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    resource VARCHAR(50),
    action VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Role permissions junction table
CREATE TABLE IF NOT EXISTS role_permissions (
    role_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);

-- Users table (enhanced)
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    avatar_url VARCHAR(255),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    phone_verified BOOLEAN NOT NULL DEFAULT FALSE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- User roles junction table
CREATE TABLE IF NOT EXISTS user_roles (
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Categories table (enhanced)
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    image_url VARCHAR(255),
    parent_id BIGINT NULL,
    sort_order INT DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id)
);

-- Products table (enhanced for e-commerce)
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    short_description VARCHAR(500),
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    sale_price DECIMAL(10,2) NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    min_stock_level INT DEFAULT 10,
    max_stock_level INT DEFAULT 1000,
    weight DECIMAL(8,2) DEFAULT 0,
    dimensions VARCHAR(100),
    sku VARCHAR(50) UNIQUE,
    barcode VARCHAR(50) UNIQUE,
    category_id BIGINT,
    brand VARCHAR(100),
    model VARCHAR(100),
    color VARCHAR(50),
    size VARCHAR(20),
    material VARCHAR(100),
    tags VARCHAR(500),
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    is_virtual BOOLEAN DEFAULT FALSE,
    requires_shipping BOOLEAN DEFAULT TRUE,
    tax_rate DECIMAL(5,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Product images table
CREATE TABLE IF NOT EXISTS product_images (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    sort_order INT DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Customers table (enhanced)
CREATE TABLE IF NOT EXISTS customers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_code VARCHAR(20) NOT NULL UNIQUE,
    user_id BIGINT NULL,
    company_name VARCHAR(100),
    contact_person VARCHAR(100),
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50) DEFAULT 'Vietnam',
    tax_id VARCHAR(50),
    customer_type ENUM('INDIVIDUAL', 'BUSINESS', 'WHOLESALE') DEFAULT 'INDIVIDUAL',
    credit_limit DECIMAL(12,2) DEFAULT 0,
    payment_terms INT DEFAULT 30,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Cart items table
CREATE TABLE IF NOT EXISTS cart_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
);

-- Orders table (enhanced)
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(20) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'CONFIRMED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED', 'REFUNDED') DEFAULT 'PENDING',
    payment_status ENUM('PENDING', 'PAID', 'FAILED', 'REFUNDED', 'PARTIALLY_REFUNDED') DEFAULT 'PENDING',
    shipping_status ENUM('PENDING', 'SHIPPED', 'DELIVERED', 'RETURNED') DEFAULT 'PENDING',
    subtotal DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    shipping_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'VND',
    shipping_address TEXT,
    billing_address TEXT,
    shipping_method VARCHAR(100),
    tracking_number VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order items table (enhanced)
CREATE TABLE IF NOT EXISTS order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    product_sku VARCHAR(50),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Payments table
CREATE TABLE IF NOT EXISTS payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    payment_method ENUM('CASH', 'BANK_TRANSFER', 'CREDIT_CARD', 'PAYPAL', 'MOMO', 'ZALOPAY', 'VNPAY') NOT NULL,
    transaction_id VARCHAR(100) UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'VND',
    status ENUM('PENDING', 'COMPLETED', 'FAILED', 'CANCELLED', 'REFUNDED') DEFAULT 'PENDING',
    gateway_response TEXT,
    payment_date TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('INFO', 'SUCCESS', 'WARNING', 'ERROR', 'SYSTEM') DEFAULT 'INFO',
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP NULL,
    action_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Inventory logs table
CREATE TABLE IF NOT EXISTS inventory_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    action ENUM('STOCK_IN', 'STOCK_OUT', 'ADJUSTMENT', 'TRANSFER', 'RETURN') NOT NULL,
    quantity INT NOT NULL,
    previous_stock INT NOT NULL,
    new_stock INT NOT NULL,
    reference_type ENUM('ORDER', 'PURCHASE', 'ADJUSTMENT', 'TRANSFER') NULL,
    reference_id BIGINT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Product reviews table
CREATE TABLE IF NOT EXISTS product_reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    order_id BIGINT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(200),
    comment TEXT,
    is_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Wishlist table
CREATE TABLE IF NOT EXISTS wishlist (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
);

-- Coupons table
CREATE TABLE IF NOT EXISTS coupons (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    discount_type ENUM('PERCENTAGE', 'FIXED_AMOUNT') NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_amount DECIMAL(10,2) DEFAULT 0,
    max_discount_amount DECIMAL(10,2) NULL,
    usage_limit INT NULL,
    used_count INT DEFAULT 0,
    valid_from TIMESTAMP NOT NULL,
    valid_until TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Coupon usage table
CREATE TABLE IF NOT EXISTS coupon_usage (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    coupon_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL,
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Insert default roles
INSERT INTO roles (name, description) VALUES
('ADMIN', 'System Administrator'),
('SALES', 'Sales Representative'),
('CUSTOMER', 'Customer'),
('MANAGER', 'Store Manager');

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password, first_name, last_name, phone, email_verified, is_active) VALUES
('admin', 'admin@salesapp.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Admin', 'User', '0123456789', TRUE, TRUE);

-- Assign admin role to admin user
INSERT INTO user_roles (user_id, role_id) VALUES (1, 1);

-- Insert default categories (based on Hades.vn)
INSERT INTO categories (name, slug, description, sort_order) VALUES
('SHOP ALL', 'shop-all', 'All products', 1),
('TOPS', 'tops', 'T-shirts, polo shirts, tank tops', 2),
('BOTTOMS', 'bottoms', 'Pants, shorts, jeans', 3),
('OUTERWEARS', 'outerwears', 'Jackets, hoodies, sweaters', 4),
('UNDERWEARS', 'underwears', 'Underwear, socks', 5),
('BAGS', 'bags', 'Backpacks, bags, accessories', 6),
('ACCESSORIES', 'accessories', 'Caps, belts, jewelry', 7),
('SALE', 'sale', 'Discounted products', 8);

-- Insert sample products (based on Hades.vn products)
INSERT INTO products (product_code, name, slug, description, short_description, price, cost, stock_quantity, category_id, brand, color, material, tags, is_featured) VALUES
('HADES001', 'HADES SPLICE POLO - BROWN', 'hades-splice-polo-brown', 'Premium polo shirt with unique splice design', 'Comfortable and stylish polo shirt', 520000, 300000, 50, 2, 'HADES', 'Brown', 'Cotton', 'polo,premium,comfortable', TRUE),
('HADES002', 'HADES CHAMPION TANK TOP - BLACK', 'hades-champion-tank-top-black', 'Athletic tank top for champions', 'Perfect for workouts and casual wear', 420000, 200000, 75, 2, 'HADES', 'Black', 'Polyester', 'tank-top,athletic,workout', TRUE),
('HADES003', 'HADES COZY STRIPE POLO SWEATER - RED', 'hades-cozy-stripe-polo-sweater-red', 'Warm and cozy striped sweater', 'Perfect for cold weather', 1150000, 600000, 30, 4, 'HADES', 'Red', 'Wool', 'sweater,warm,cozy', TRUE),
('HADES004', 'HADES ROCK SOLID ZIP HOODIE', 'hades-rock-solid-zip-hoodie', 'Durable zip-up hoodie', 'Rock solid quality for everyday wear', 850000, 450000, 40, 4, 'HADES', 'Black', 'Cotton', 'hoodie,zip-up,durable', TRUE),
('HADES005', 'HADES DISTRICT 1 CAP', 'hades-district-1-cap', 'Stylish cap with District 1 design', 'Represent your district in style', 320000, 150000, 100, 7, 'HADES', 'Black', 'Cotton', 'cap,district-1,stylish', TRUE),
('HADES006', 'HADES BLACK WAX BIKER JACKET', 'hades-black-wax-biker-jacket', 'Classic biker jacket with wax finish', 'Timeless style with modern comfort', 1190000, 700000, 25, 4, 'HADES', 'Black', 'Leather', 'jacket,biker,classic', TRUE),
('HADES007', 'HADES RUGGED LEOPARD SHORTS', 'hades-rugged-leopard-shorts', 'Rugged shorts with leopard print', 'Wild style for adventurous souls', 620000, 350000, 60, 3, 'HADES', 'Leopard', 'Cotton', 'shorts,leopard,rugged', FALSE),
('HADES008', 'HADES VOID DRIFTER PANTS', 'hades-void-drifter-pants', 'Comfortable drifting pants', 'Perfect for urban exploration', 790000, 400000, 45, 3, 'HADES', 'Black', 'Cotton', 'pants,drifter,comfortable', FALSE),
('HADES009', 'HADES VOID DRIFTER ZIP HOODIE', 'hades-void-drifter-zip-hoodie', 'Matching zip hoodie for drifters', 'Complete your drifting look', 850000, 450000, 35, 4, 'HADES', 'Black', 'Cotton', 'hoodie,drifter,matching', FALSE),
('HADES010', 'HADES CLASSIC KNICKERS - BLACK', 'hades-classic-knickers-black', 'Classic underwear in black', 'Comfortable everyday wear', 190000, 80000, 200, 5, 'HADES', 'Black', 'Cotton', 'underwear,classic,comfortable', FALSE),
('HADES011', 'HADES CLASSIC KNICKERS - WHITE', 'hades-classic-knickers-white', 'Classic underwear in white', 'Clean and comfortable', 190000, 80000, 200, 5, 'HADES', 'White', 'Cotton', 'underwear,classic,clean', FALSE),
('HADES012', 'HADES Y-BACK SPORTS BRA - WHITE', 'hades-y-back-sports-bra-white', 'Supportive sports bra', 'Perfect for active lifestyle', 290000, 120000, 80, 5, 'HADES', 'White', 'Polyester', 'sports-bra,supportive,active', FALSE);

-- Insert sample customers
INSERT INTO customers (customer_code, company_name, contact_person, email, phone, address, city, state, country) VALUES
('CUST001', 'Tech Solutions Inc', 'John Smith', 'john@techsolutions.com', '0123456789', '123 Tech Street', 'Ho Chi Minh City', 'District 1', 'Vietnam'),
('CUST002', 'Fashion Retail Co', 'Jane Doe', 'jane@fashionretail.com', '0987654321', '456 Fashion Ave', 'Ha Noi', 'Dong Da', 'Vietnam'),
('CUST003', 'Book Store Plus', 'Bob Wilson', 'bob@bookstore.com', '0111222333', '789 Book Lane', 'Da Nang', 'Hai Chau', 'Vietnam');

-- Insert sample coupons
INSERT INTO coupons (code, name, description, discount_type, discount_value, min_order_amount, valid_from, valid_until) VALUES
('WELCOME10', 'Welcome Discount', '10% off for new customers', 'PERCENTAGE', 10.00, 500000, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('SAVE50K', 'Save 50K', 'Save 50,000 VND on orders over 500K', 'FIXED_AMOUNT', 50000.00, 500000, NOW(), DATE_ADD(NOW(), INTERVAL 60 DAY)),
('SUMMER20', 'Summer Sale', '20% off summer collection', 'PERCENTAGE', 20.00, 1000000, NOW(), DATE_ADD(NOW(), INTERVAL 90 DAY));

-- Insert permissions
INSERT INTO permissions (name, description, resource, action) VALUES
-- Product permissions
('product:read', 'View products', 'product', 'read'),
('product:write', 'Create/Update products', 'product', 'write'),
('product:delete', 'Delete products', 'product', 'delete'),

-- Order permissions
('order:read', 'View orders', 'order', 'read'),
('order:write', 'Create/Update orders', 'order', 'write'),
('order:delete', 'Delete orders', 'order', 'delete'),
('order:process', 'Process orders', 'order', 'process'),

-- Customer permissions
('customer:read', 'View customers', 'customer', 'read'),
('customer:write', 'Create/Update customers', 'customer', 'write'),
('customer:delete', 'Delete customers', 'customer', 'delete'),

-- User permissions
('user:read', 'View users', 'user', 'read'),
('user:write', 'Create/Update users', 'user', 'write'),
('user:delete', 'Delete users', 'user', 'delete'),

-- Category permissions
('category:read', 'View categories', 'category', 'read'),
('category:write', 'Create/Update categories', 'category', 'write'),
('category:delete', 'Delete categories', 'category', 'delete'),

-- Report permissions
('report:read', 'View reports', 'report', 'read'),
('report:write', 'Generate reports', 'report', 'write'),

-- System permissions
('system:admin', 'System administration', 'system', 'admin');

-- Assign permissions to roles
-- CUSTOMER role permissions
INSERT INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'CUSTOMER' AND p.name IN ('product:read', 'order:read', 'order:write');

-- SALES role permissions
INSERT INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'SALES' AND p.name IN ('product:read', 'order:read', 'order:write', 'order:process', 'customer:read', 'customer:write', 'category:read');

-- MANAGER role permissions (same as SALES plus some admin)
INSERT INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'MANAGER' AND p.name IN ('product:read', 'product:write', 'order:read', 'order:write', 'order:process', 'customer:read', 'customer:write', 'category:read', 'category:write', 'report:read', 'report:write');

-- ADMIN role permissions (all permissions)
INSERT INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'ADMIN'; 