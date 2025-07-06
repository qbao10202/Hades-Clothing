-- Database migration script to remove unused columns from products table
-- Execute this script on your database to remove the deleted columns

USE sales_app;

-- Remove the unused columns from products table
ALTER TABLE products 
DROP COLUMN IF EXISTS weight,
DROP COLUMN IF EXISTS dimensions,
DROP COLUMN IF EXISTS sku,
DROP COLUMN IF EXISTS barcode,
DROP COLUMN IF EXISTS model,
DROP COLUMN IF EXISTS is_featured,
DROP COLUMN IF EXISTS is_virtual,
DROP COLUMN IF EXISTS requires_shipping,
DROP COLUMN IF EXISTS tax_rate;

-- Update existing products to ensure is_active is always true
UPDATE products SET is_active = TRUE WHERE is_active IS NULL OR is_active = FALSE;

-- Set default stock quantities for products that have NULL or 0 stock
UPDATE products SET stock_quantity = 50 WHERE stock_quantity IS NULL OR stock_quantity = 0;

-- Show current structure of products table
DESCRIBE products;

-- Show sample data to verify changes
SELECT id, product_code, name, price, stock_quantity, is_active FROM products LIMIT 10;
