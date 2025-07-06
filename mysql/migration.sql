-- Migration script for existing sales_app database
-- Run this script if you have an existing database that needs the new role and permission system

USE sales_app;

-- Add permissions table if it doesn't exist
CREATE TABLE IF NOT EXISTS permissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    resource VARCHAR(50),
    action VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add role_permissions junction table if it doesn't exist
CREATE TABLE IF NOT EXISTS role_permissions (
    role_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);

-- Insert permissions (only if they don't exist)
INSERT IGNORE INTO permissions (name, description, resource, action) VALUES
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

-- Assign permissions to roles (only if not already assigned)
-- CUSTOMER role permissions
INSERT IGNORE INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'CUSTOMER' AND p.name IN ('product:read', 'order:read', 'order:write');

-- SALES role permissions
INSERT IGNORE INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'SALES' AND p.name IN ('product:read', 'order:read', 'order:write', 'order:process', 'customer:read', 'customer:write', 'category:read');

-- MANAGER role permissions
INSERT IGNORE INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'MANAGER' AND p.name IN ('product:read', 'product:write', 'order:read', 'order:write', 'order:process', 'customer:read', 'customer:write', 'category:read', 'category:write', 'report:read', 'report:write');

-- ADMIN role permissions (all permissions)
INSERT IGNORE INTO role_permissions (role_id, permission_id) 
SELECT r.id, p.id FROM roles r, permissions p 
WHERE r.name = 'ADMIN';

-- Ensure admin user has admin role
INSERT IGNORE INTO user_roles (user_id, role_id) 
SELECT u.id, r.id FROM users u, roles r 
WHERE u.username = 'admin' AND r.name = 'ADMIN';

-- Add missing columns to existing tables if they don't exist
-- Add missing columns to products table
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS slug VARCHAR(200) UNIQUE AFTER name,
ADD COLUMN IF NOT EXISTS short_description VARCHAR(500) AFTER description,
ADD COLUMN IF NOT EXISTS sale_price DECIMAL(10,2) NULL AFTER cost,
ADD COLUMN IF NOT EXISTS min_stock_level INT DEFAULT 10 AFTER stock_quantity,
ADD COLUMN IF NOT EXISTS max_stock_level INT DEFAULT 1000 AFTER min_stock_level,
ADD COLUMN IF NOT EXISTS weight DECIMAL(8,2) DEFAULT 0 AFTER max_stock_level,
ADD COLUMN IF NOT EXISTS dimensions VARCHAR(100) AFTER weight,
ADD COLUMN IF NOT EXISTS sku VARCHAR(50) UNIQUE AFTER dimensions,
ADD COLUMN IF NOT EXISTS barcode VARCHAR(50) UNIQUE AFTER sku,
ADD COLUMN IF NOT EXISTS brand VARCHAR(100) AFTER category_id,
ADD COLUMN IF NOT EXISTS model VARCHAR(100) AFTER brand,
ADD COLUMN IF NOT EXISTS color VARCHAR(50) AFTER model,
ADD COLUMN IF NOT EXISTS size VARCHAR(20) AFTER color,
ADD COLUMN IF NOT EXISTS material VARCHAR(100) AFTER size,
ADD COLUMN IF NOT EXISTS tags VARCHAR(500) AFTER material,
ADD COLUMN IF NOT EXISTS is_featured BOOLEAN DEFAULT FALSE AFTER tags,
ADD COLUMN IF NOT EXISTS is_virtual BOOLEAN DEFAULT FALSE AFTER is_featured,
ADD COLUMN IF NOT EXISTS requires_shipping BOOLEAN DEFAULT TRUE AFTER is_virtual,
ADD COLUMN IF NOT EXISTS tax_rate DECIMAL(5,2) DEFAULT 0 AFTER requires_shipping,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;

-- Add missing columns to categories table
ALTER TABLE categories 
ADD COLUMN IF NOT EXISTS slug VARCHAR(100) UNIQUE AFTER name,
ADD COLUMN IF NOT EXISTS image_url VARCHAR(255) AFTER description,
ADD COLUMN IF NOT EXISTS parent_id BIGINT NULL AFTER image_url,
ADD COLUMN IF NOT EXISTS sort_order INT DEFAULT 0 AFTER parent_id,
ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT TRUE AFTER sort_order,
ADD FOREIGN KEY IF NOT EXISTS (parent_id) REFERENCES categories(id);

-- Add missing columns to customers table
ALTER TABLE customers 
ADD COLUMN IF NOT EXISTS user_id BIGINT NULL AFTER country,
ADD COLUMN IF NOT EXISTS tax_id VARCHAR(50) AFTER user_id,
ADD COLUMN IF NOT EXISTS customer_type ENUM('INDIVIDUAL', 'BUSINESS', 'WHOLESALE') DEFAULT 'INDIVIDUAL' AFTER tax_id,
ADD COLUMN IF NOT EXISTS credit_limit DECIMAL(12,2) DEFAULT 0 AFTER customer_type,
ADD COLUMN IF NOT EXISTS payment_terms INT DEFAULT 30 AFTER credit_limit,
ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT TRUE AFTER payment_terms,
ADD COLUMN IF NOT EXISTS notes TEXT AFTER is_active,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at,
ADD FOREIGN KEY IF NOT EXISTS (user_id) REFERENCES users(id);

-- Add missing columns to orders table
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS payment_status ENUM('PENDING', 'PAID', 'FAILED', 'REFUNDED', 'PARTIALLY_REFUNDED') DEFAULT 'PENDING' AFTER status,
ADD COLUMN IF NOT EXISTS shipping_status ENUM('PENDING', 'SHIPPED', 'DELIVERED', 'RETURNED') DEFAULT 'PENDING' AFTER payment_status,
ADD COLUMN IF NOT EXISTS shipping_amount DECIMAL(10,2) NOT NULL DEFAULT 0 AFTER tax_amount,
ADD COLUMN IF NOT EXISTS currency VARCHAR(3) DEFAULT 'VND' AFTER total_amount,
ADD COLUMN IF NOT EXISTS shipping_address TEXT AFTER currency,
ADD COLUMN IF NOT EXISTS billing_address TEXT AFTER shipping_address,
ADD COLUMN IF NOT EXISTS shipping_method VARCHAR(100) AFTER billing_address,
ADD COLUMN IF NOT EXISTS tracking_number VARCHAR(100) AFTER shipping_method,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;

-- Add missing columns to order_items table
ALTER TABLE order_items 
ADD COLUMN IF NOT EXISTS product_name VARCHAR(200) NOT NULL AFTER product_id,
ADD COLUMN IF NOT EXISTS product_sku VARCHAR(50) AFTER product_name,
ADD COLUMN IF NOT EXISTS discount_amount DECIMAL(10,2) DEFAULT 0 AFTER total_price,
ADD COLUMN IF NOT EXISTS tax_amount DECIMAL(10,2) DEFAULT 0 AFTER discount_amount;

-- Add missing columns to users table
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS phone VARCHAR(20) AFTER last_name,
ADD COLUMN IF NOT EXISTS avatar_url VARCHAR(255) AFTER phone,
ADD COLUMN IF NOT EXISTS email_verified BOOLEAN NOT NULL DEFAULT FALSE AFTER is_active,
ADD COLUMN IF NOT EXISTS phone_verified BOOLEAN NOT NULL DEFAULT FALSE AFTER email_verified,
ADD COLUMN IF NOT EXISTS last_login TIMESTAMP NULL AFTER phone_verified,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;

-- Update existing products to have slugs if they don't have them
UPDATE products SET slug = LOWER(REPLACE(name, ' ', '-')) WHERE slug IS NULL OR slug = '';

-- Update existing categories to have slugs if they don't have them
UPDATE categories SET slug = LOWER(REPLACE(name, ' ', '-')) WHERE slug IS NULL OR slug = ''; 