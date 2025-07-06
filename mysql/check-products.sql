-- Quick check and fix for product availability
-- Execute this to ensure all products are active and have stock

-- Check current status of products
SELECT id, product_code, name, stock_quantity, is_active 
FROM products 
ORDER BY id;

-- Update all products to be active if not already
UPDATE products SET is_active = TRUE WHERE is_active IS NULL OR is_active = FALSE;

-- Verify the update
SELECT 'After Update:' as status;
SELECT id, product_code, name, stock_quantity, is_active 
FROM products 
WHERE stock_quantity > 0
ORDER BY id;
