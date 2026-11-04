SELECT
    products.product_name,
    categories.category_name
FROM products
JOIN categories
    ON products.category_id = categories.category_id
ORDER BY products.product_name;