CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO products (name, price)
VALUES
('Laptop', 55000.00),
('Mouse', 799.00),
('Keyboard', 1499.00);
