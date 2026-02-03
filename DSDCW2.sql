CREATE DATABASE DSDCW2;

CREATE TABLE outlet (
    outlet_id SERIAL PRIMARY KEY,
    outlet_address VARCHAR(70) NOT NULL UNIQUE
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_first_name VARCHAR(70) NOT NULL,
    customer_address  VARCHAR(60) NOT NULL,
    customer_email VARCHAR(50) UNIQUE NOT NULL
);

CREATE INDEX idx_customer_email on customers(customer_email);

CREATE TABLE customer_order (
    order_id INT REFERENCES orders(order_id),
    customer_id INT REFERENCES customers(customer_id),
    customer_pricing VARCHAR(250),
    
    PRIMARY KEY (order_id, customer_id)
);

CREATE TABLE order (
    ORDER_ID SERIAL PRIMARY KEY,
    order_name VARCAHR(50) NOT NULL,
    order_note VARCHAR(60)
);

CREATE TABLE product_order (
    prod_id INT REFERENCES products(prod_id),
    order_id INT REFERENCES orders(order_id),

    PRIMARY KEY (prod_id, order_id)
);

CREATE TABLE prodcuts (
    prod_id SERIAL PRIMARY KEY,
    prod_name VARCHAR(50),
    prod_price DECIMAL(12,4)
);

CREATE TABLE product_vehicle (
    prod_id INT REFERENCES products(prod_id),
    van_cap INT REFERENCES vehicle(van_cap),

    PRIMARY KEY (prod_id, van_cap)
);

CREATE TABLE vehicle (
    van_id SERIAL PRIMARY KEY,
    van_plate VARCHAR(30) NOT NULL UNIQUE,
    van_cap INT
);

CREATE TABLE driver (
    order_id SERIAL PRIMARY KEY,
    driver_name VARCHAR(50) NOT NULL,
    driver_address VARACHAR(60) NOT NULL UNIQUE
);

CREATE TABLE delivery_runs (
    run_id SERIAL PRIMARY KEY,
    run_area VARCHAR(60),
    van_id INT REFERENCES vehicle(van_id),
    driver_id INT REFERENCES driver(driver_id)
);
