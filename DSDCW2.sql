CREATE TYPE delivery_status_enum AS ENUM ('pending', 'out_for_delivery', 'delivered', 'cancelled');

CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  customer_first_name VARCHAR(50) NOT NULL,
  customer_last_name VARCHAR(50) NOT NULL,
  customer_address VARCHAR(70) NOT NULL,
  customer_email VARCHAR(50) UNIQUE NOT NULL,
  customer_phone_number VARCHAR(11) UNIQUE,
  CHECK (customer_phone_number ~ '^[0-9]{11}$')
);

CREATE TABLE outlet (
  outlet_id SERIAL PRIMARY KEY,
  outlet_address VARCHAR(70) UNIQUE NOT NULL,
  customer_id INT NOT NULL REFERENCES customer(customer_id)
);

CREATE TABLE product (
  prod_id SERIAL PRIMARY KEY,
  prod_name VARCHAR(50) NOT NULL,
  prod_price DECIMAL(10, 2) NOT NULL,
  CHECK (prod_price >= 0)
);

CREATE TABLE vehicle (
  van_id SERIAL PRIMARY KEY,
  van_plate VARCHAR(7) UNIQUE NOT NULL,
  van_capacity INT NOT NULL,
  CHECK (van_capacity > 0)
);

CREATE TABLE driver (
  driver_id SERIAL PRIMARY KEY,
  driver_name VARCHAR(50) NOT NULL,
  driver_address VARCHAR(70) NOT NULL,
  phone_number VARCHAR(11) UNIQUE NOT NULL,
  CHECK (phone_number ~ '^[0-9]{11}$')
);

CREATE TABLE vehicle_driver (
  van_id INT NOT NULL REFERENCES vehicle(van_id),
  driver_id INT NOT NULL REFERENCES driver(driver_id),
  PRIMARY KEY (van_id, driver_id)
);

CREATE TABLE delivery_run (
  tracking_id SERIAL PRIMARY KEY,
  run_area VARCHAR(40) NOT NULL,
  delivery_status delivery_status_enum NOT NULL DEFAULT 'pending',
  driver_id INT NOT NULL REFERENCES driver(driver_id)
);


CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  order_notes VARCHAR(60),
  delivery_status delivery_status_enum NOT NULL DEFAULT 'pending',
  outlet_id INT NOT NULL REFERENCES outlet(outlet_id),
  tracking_id INT REFERENCES delivery_run(tracking_id)
);

CREATE TABLE order_line (
  order_line_id SERIAL PRIMARY KEY,
  quantity INT NOT NULL,
  prod_id INT NOT NULL REFERENCES product(prod_id),
  order_id INT NOT NULL REFERENCES orders(order_id),
  CHECK (quantity > 0)
);

CREATE TABLE delivery_stops (
  stop_id SERIAL PRIMARY KEY,
  stop_num INT NOT NULL,
  time_delivered TIMESTAMPTZ,
  tracking_id INT NOT NULL REFERENCES delivery_run(tracking_id),
  order_id INT NOT NULL REFERENCES orders(order_id),
  CHECK (stop_num > 0),
  UNIQUE (tracking_id, stop_num)
);

-- Indexes
CREATE INDEX idx_customer_first_name ON customer(customer_first_name);

CREATE INDEX idx_customer_last_name ON customer(customer_last_name);

CREATE INDEX idx_product_name ON product(prod_name);

CREATE INDEX idx_delivery_stops_time ON delivery_stops(time_delivered);

-- Inserts
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Mady', 'Hambribe', '9511 East Hill', 'mhambribe0@addthis.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Yalonda', 'Collacombe', '91769 Summit Court', 'ycollacombe1@123-reg.co.uk');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Joye', 'Whall', '045 Bayside Plaza', 'jwhall2@naver.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Boycie', 'Carp', '9108 Lukken Avenue', 'bcarp3@amazon.co.jp');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Guglielmo', 'Rudloff', '7 Maywood Crossing', 'grudloff4@jimdo.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Tabbie', 'Stribbling', '886 Toban Court', 'tstribbling5@hhs.gov');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Bentlee', 'Brunini', '3 Northfield Circle', 'bbrunini6@toplist.cz');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Simona', 'Bernucci', '1 Manley Park', 'sbernucci7@intel.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Jessee', 'Thrussell', '28520 Donald Lane', 'jthrussell8@amazon.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Kane', 'Vales', '054 Homewood Terrace', 'kvales9@java.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Francesca', 'Burgoyne', '077 Crescent Oaks Lane', 'fburgoynea@reuters.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Franchot', 'Messager', '54379 Jana Pass', 'fmessagerb@amazonaws.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Arturo', 'Lovitt', '01 Mosinee Pass', 'alovittc@japanpost.jp');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Jeffy', 'Ohrtmann', '9 Upham Pass', 'johrtmannd@tinyurl.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Hube', 'Dionis', '9143 Colorado Trail', 'hdionise@pen.io');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Pedro', 'Warboy', '04988 Manitowish Point', 'pwarboyf@wp.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Steward', 'Kennefick', '38 Petterle Way', 'skennefickg@google.ru');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Bond', 'Boddington', '0 Golf View Plaza', 'bboddingtonh@nba.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Trefor', 'Gruszecki', '30472 Red Cloud Center', 'tgruszeckii@hp.com');
insert into customer (customer_first_name, customer_last_name, customer_address, customer_email) values ('Viva', 'Conkay', '1568 Montana Hill', 'vconkayj@booking.com');


insert into outlet (outlet_address, customer_id) values ('9444 Ridgeview Crossing', 1);
insert into outlet (outlet_address, customer_id) values ('21999 Buena Vista Lane', 2);
insert into outlet (outlet_address, customer_id) values ('148 Anzinger Circle', 3);
insert into outlet (outlet_address, customer_id) values ('8 Westend Parkway', 4);
insert into outlet (outlet_address, customer_id) values ('255 Eagle Crest Trail', 5);
insert into outlet (outlet_address, customer_id) values ('660 Nevada Lane', 6);
insert into outlet (outlet_address, customer_id) values ('2644 Lakewood Park', 7);
insert into outlet (outlet_address, customer_id) values ('4 Miller Drive', 8);
insert into outlet (outlet_address, customer_id) values ('3 Lakewood Parkway', 9);
insert into outlet (outlet_address, customer_id) values ('9 Blue Bill Park Pass', 10);
insert into outlet (outlet_address, customer_id) values ('450 Dryden Alley', 11);
insert into outlet (outlet_address, customer_id) values ('9 Beilfuss Park', 12);
insert into outlet (outlet_address, customer_id) values ('07 Pond Hill', 13);
insert into outlet (outlet_address, customer_id) values ('873 Namekagon Place', 14);
insert into outlet (outlet_address, customer_id) values ('1631 Green Ridge Lane', 15);
insert into outlet (outlet_address, customer_id) values ('71 Chive Point', 16);
insert into outlet (outlet_address, customer_id) values ('8 Canary Circle', 17);
insert into outlet (outlet_address, customer_id) values ('9 Sutteridge Trail', 18);
insert into outlet (outlet_address, customer_id) values ('46 Dixon Crossing', 19);
insert into outlet (outlet_address, customer_id) values ('78 Dahle Terrace', 20);
insert into outlet (outlet_address, customer_id) values ('7011 Gina Junction', 1);
insert into outlet (outlet_address, customer_id) values ('2511 Hudson Point', 2);
insert into outlet (outlet_address, customer_id) values ('065 Sutteridge Junction', 3);
insert into outlet (outlet_address, customer_id) values ('8320 Manufacturers Court', 4);
insert into outlet (outlet_address, customer_id) values ('23045 Logan Terrace', 5);
insert into outlet (outlet_address, customer_id) values ('6286 Logan Park', 6);
insert into outlet (outlet_address, customer_id) values ('18 Moland Park', 7);
insert into outlet (outlet_address, customer_id) values ('3009 Brentwood Way', 8);
insert into outlet (outlet_address, customer_id) values ('4 Waywood Lane', 9);
insert into outlet (outlet_address, customer_id) values ('90049 Onsgard Park', 10);

insert into product (prod_name, prod_price) values ('Cheese - St. Andre', 44.97);
insert into product (prod_name, prod_price) values ('Foam Espresso Cup Plain White', 48.1);
insert into product (prod_name, prod_price) values ('Laundry - Bag Cloth', 43.39);
insert into product (prod_name, prod_price) values ('Wine - Pinot Noir Stoneleigh', 10.02);
insert into product (prod_name, prod_price) values ('Artichokes - Knobless, White', 98.49);
insert into product (prod_name, prod_price) values ('Muffin Chocolate Individual Wrap', 72.8);
insert into product (prod_name, prod_price) values ('Rice - Sushi', 0.51);
insert into product (prod_name, prod_price) values ('Eggs - Extra Large', 38.39);
insert into product (prod_name, prod_price) values ('Cream - 18%', 41.52);
insert into product (prod_name, prod_price) values ('Club Soda - Schweppes, 355 Ml', 59.07);

insert into vehicle (van_plate, van_capacity) values ('KJ23LXM', 458);
insert into vehicle (van_plate, van_capacity) values ('BT71QRF', 454);
insert into vehicle (van_plate, van_capacity) values ('MN19ZWD', 259);
insert into vehicle (van_plate, van_capacity) values ('YL68HCP', 341);
insert into vehicle (van_plate, van_capacity) values ('DV24TGS', 256);

insert into driver (driver_name, driver_address, phone_number) values ('Pennie Vasyaev', '393 Buhler Way', '07821511889');
insert into driver (driver_name, driver_address, phone_number) values ('Bree Elbourn', '75 Lotheville Point', '07910849192');
insert into driver (driver_name, driver_address, phone_number) values ('Wilow Doleman', '674 Green Circle', '07964950522');
insert into driver (driver_name, driver_address, phone_number) values ('Christy Doret', '680 Manitowish Junction', '07029049042');
insert into driver (driver_name, driver_address, phone_number) values ('Kurtis Markussen', '47813 Dottie Drive', '07023068344');
insert into driver (driver_name, driver_address, phone_number) values ('Gillian Landman', '1584 Fallview Terrace', '07848123601');
insert into driver (driver_name, driver_address, phone_number) values ('Maddie Hayle', '043 Kropf Parkway', '07921260875');
insert into driver (driver_name, driver_address, phone_number) values ('Pauline Mussington', '666 Beilfuss Circle', '07082791839');

insert into vehicle_driver (van_id, driver_id) values (1, 1);
insert into vehicle_driver (van_id, driver_id) values (2, 2);
insert into vehicle_driver (van_id, driver_id) values (3, 3);
insert into vehicle_driver (van_id, driver_id) values (4, 7);
insert into vehicle_driver (van_id, driver_id) values (5, 6);