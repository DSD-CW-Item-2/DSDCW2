CREATE TYPE delivery_status_enum AS ENUM ('pending', 'delivered', 'cancelled');

CREATE TABLE outlet (
    outlet_id SERIAL PRIMARY KEY,
    outlet_address VARCHAR(70) UNIQUE NOT NULL
);

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    customer_first_name VARCHAR(50) NOT NULL,
    customer_last_name VARCHAR(50) NOT NULL,
    customer_address VARCHAR(70) NOT NULL,
    customer_email VARCHAR(50) UNIQUE NOT NULL,
    outlet_id INT REFERENCES outlet(outlet_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_notes VARCHAR(60),
    delivery_address VARCHAR(50) NOT NULL,
    delivery_status delivery_status_enum,
    customer_id INT REFERENCES customer(customer_id)
);

CREATE TABLE product (
    prod_id SERIAL PRIMARY KEY,
    prod_name VARCHAR(50) NOT NULL,
    prod_price DECIMAL(10, 2) NOT NULL,
    CHECK (prod_price > 0)
);

CREATE TABLE order_line (
    order_line_id SERIAL PRIMARY KEY,
    quantity INT NOT NULL,
    prod_id INT REFERENCES product(prod_id),
    order_id INT REFERENCES orders(order_id),
    CHECK (quantity > 0)
);

CREATE TABLE vehicle (
    van_id SERIAL PRIMARY KEY,
    van_plate VARCHAR(30) UNIQUE NOT NULL,
    van_capacity INT NOT NULL,
    CHECK (van_capacity > 0)
);

CREATE TABLE driver (
    driver_id SERIAL PRIMARY KEY,
    driver_name VARCHAR(50) NOT NULL,
    driver_address VARCHAR(70) NOT NULL,
    phone_number VARCHAR(11) NOT NULL,
    CHECK (phone_number ~ '^[0-9]{11}$')
);

CREATE TABLE vehicle_driver (
    van_id INT REFERENCES vehicle(van_id),
    driver_id INT REFERENCES driver(driver_id),
    PRIMARY KEY (van_id, driver_id)
);

CREATE TABLE delivery_run (
    tracking_id SERIAL PRIMARY KEY,
    run_area VARCHAR(60) NOT NULL,
    delivery_status delivery_status_enum NOT NULL,
    order_id INT REFERENCES orders(order_id),
    van_id INT REFERENCES vehicle(van_id),
    driver_id INT REFERENCES driver(driver_id)
);

CREATE TABLE delivery_stops (
    stop_id SERIAL PRIMARY KEY,
    stop_num INT NOT NULL,
    time_delivered TIMESTAMPTZ,
    tracking_id INT REFERENCES delivery_run(tracking_id),
    order_id INT REFERENCES orders(order_id),
    CHECK (stop_num > 0)
);

-- Indexes
CREATE INDEX idx_customer_name ON customer(customer_last_name, customer_first_name);

CREATE INDEX idx_product_name ON product(prod_name);

CREATE INDEX idx_delivery_stops_time ON delivery_stops(time_delivered);
