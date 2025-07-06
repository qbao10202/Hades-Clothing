# Database Setup Guide

This guide will help you set up and update the Sales Application database with the new role-based authentication system.

## Prerequisites

- MySQL 8.0 or higher
- MySQL command line client or MySQL Workbench

## Option 1: Fresh Database Setup

If you're setting up the database for the first time:

1. **Start MySQL service**
2. **Run the initialization script:**
   ```bash
   mysql -u root -p < mysql/init.sql
   ```

This will:
- Create the `sales_app` database
- Create all tables including the new permissions system
- Insert sample data (roles, permissions, users, products, etc.)
- Set up role-permission relationships

## Option 2: Update Existing Database

If you already have a database and need to add the new role and permission system:

1. **Run the migration script:**
   ```bash
   mysql -u root -p sales_app < mysql/migration.sql
   ```

Or use the provided batch script:
   ```bash
   update-database.bat
   ```

This will:
- Add the missing `permissions` table
- Add the missing `role_permissions` junction table
- Insert default permissions
- Assign permissions to existing roles
- Ensure the admin user has the admin role

## Database Schema Overview

### Core Tables
- `users` - User accounts with authentication info
- `roles` - User roles (ADMIN, SALES, CUSTOMER, MANAGER)
- `permissions` - System permissions (product:read, order:write, etc.)
- `user_roles` - Many-to-many relationship between users and roles
- `role_permissions` - Many-to-many relationship between roles and permissions

### Business Tables
- `products` - Product catalog
- `categories` - Product categories
- `customers` - Customer information
- `orders` - Order management
- `order_items` - Order line items
- `payments` - Payment transactions

### Additional Tables
- `notifications` - User notifications
- `inventory_logs` - Stock movement tracking
- `product_reviews` - Customer reviews
- `wishlist` - User wishlists
- `coupons` - Discount coupons
- `cart_items` - Shopping cart

## Role and Permission System

### Default Roles
1. **ADMIN** - Full system access
2. **SALES** - Order and customer management
3. **CUSTOMER** - Basic product viewing and order creation
4. **MANAGER** - Sales plus some administrative functions

### Default Permissions
- `product:read` - View products
- `product:write` - Create/update products
- `product:delete` - Delete products
- `order:read` - View orders
- `order:write` - Create/update orders
- `order:process` - Process orders
- `customer:read` - View customers
- `customer:write` - Create/update customers
- `customer:delete` - Delete customers
- `category:read` - View categories
- `category:write` - Create/update categories
- `report:read` - View reports
- `system:admin` - System administration

### Role-Permission Assignments

| Role | Permissions |
|------|-------------|
| CUSTOMER | product:read, order:read, order:write |
| SALES | product:read, order:read, order:write, order:process, customer:read, customer:write, category:read |
| MANAGER | product:read, product:write, order:read, order:write, order:process, customer:read, customer:write, category:read, category:write, report:read, report:write |
| ADMIN | All permissions |

## Default Users

### Admin User
- **Username:** admin
- **Password:** admin123
- **Email:** admin@salesapp.com
- **Role:** ADMIN

## Testing the Setup

1. **Start your application**
2. **Test login with admin user:**
   ```
   POST /api/auth/login
   {
     "username": "admin",
     "password": "admin123"
   }
   ```
3. **Test role-based access:**
   - Try accessing `/api/products` (should work for all authenticated users)
   - Try creating a product (should only work for users with `product:write` permission)
   - Try deleting a product (should only work for users with `product:delete` permission)

## Troubleshooting

### Common Issues

1. **"Table doesn't exist" error:**
   - Make sure you ran the correct script (init.sql for new DB, migration.sql for existing DB)

2. **"Access denied" error:**
   - Check your MySQL user permissions
   - Make sure you're using the correct username/password

3. **"Duplicate entry" error:**
   - This is normal if data already exists
   - The scripts use `INSERT IGNORE` to handle duplicates

4. **Application can't connect to database:**
   - Check your `application.yml` database configuration
   - Ensure MySQL is running
   - Verify the database name is correct

### Verification Queries

Run these queries to verify the setup:

```sql
-- Check if permissions table exists
SHOW TABLES LIKE 'permissions';

-- Check if roles exist
SELECT * FROM roles;

-- Check if permissions exist
SELECT * FROM permissions;

-- Check role-permission assignments
SELECT r.name as role, p.name as permission 
FROM roles r 
JOIN role_permissions rp ON r.id = rp.role_id 
JOIN permissions p ON rp.permission_id = p.id 
ORDER BY r.name, p.name;

-- Check admin user and role
SELECT u.username, r.name as role 
FROM users u 
JOIN user_roles ur ON u.id = ur.user_id 
JOIN roles r ON ur.role_id = r.id 
WHERE u.username = 'admin';
```

## Next Steps

After setting up the database:

1. **Start your Spring Boot application**
2. **Test the authentication system**
3. **Create additional users with different roles**
4. **Test role-based access control**

For more information, see the main README.md file. 