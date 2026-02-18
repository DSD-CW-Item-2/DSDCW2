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
  run_area VARCHAR(10) NOT NULL,
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

-- INSERTs
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Mady', 'Hambribe', '9511 East Hill', 'mhambribe0@addthis.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Yalonda', 'Collacombe', '91769 Summit Court', 'ycollacombe1@123-reg.co.uk');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Joye', 'Whall', '045 Bayside Plaza', 'jwhall2@naver.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Boycie', 'Carp', '9108 Lukken Avenue', 'bcarp3@amazon.co.jp');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Guglielmo', 'Rudloff', '7 Maywood Crossing', 'grudloff4@jimdo.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Tabbie', 'Stribbling', '886 Toban Court', 'tstribbling5@hhs.gov');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Bentlee', 'Brunini', '3 Northfield Circle', 'bbrunini6@toplist.cz');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Simona', 'Bernucci', '1 Manley Park', 'sbernucci7@intel.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Jessee', 'Thrussell', '28520 Donald Lane', 'jthrussell8@amazon.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Kane', 'Vales', '054 Homewood Terrace', 'kvales9@java.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Francesca', 'Burgoyne', '077 Crescent Oaks Lane', 'fburgoynea@reuters.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Franchot', 'Messager', '54379 Jana Pass', 'fmessagerb@amazonaws.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Arturo', 'Lovitt', '01 Mosinee Pass', 'alovittc@japanpost.jp');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Jeffy', 'Ohrtmann', '9 Upham Pass', 'johrtmannd@tinyurl.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Hube', 'Dionis', '9143 Colorado Trail', 'hdionise@pen.io');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Pedro', 'Warboy', '04988 Manitowish Point', 'pwarboyf@wp.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Steward', 'Kennefick', '38 Petterle Way', 'skennefickg@google.ru');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Bond', 'Boddington', '0 Golf View Plaza', 'bboddingtonh@nba.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Trefor', 'Gruszecki', '30472 Red Cloud Center', 'tgruszeckii@hp.com');
INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_email) VALUES ('Viva', 'Conkay', '1568 Montana Hill', 'vconkayj@booking.com');

INSERT INTO outlet (outlet_address, customer_id) VALUES ('9444 Ridgeview Crossing', 1);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('21999 Buena Vista Lane', 2);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('148 Anzinger Circle', 3);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('8 Westend Parkway', 4);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('255 Eagle Crest Trail', 5);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('660 Nevada Lane', 6);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('2644 Lakewood Park', 7);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('4 Miller Drive', 8);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('3 Lakewood Parkway', 9);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('9 Blue Bill Park Pass', 10);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('450 Dryden Alley', 11);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('9 Beilfuss Park', 12);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('07 Pond Hill', 13);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('873 Namekagon Place', 14);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('1631 Green Ridge Lane', 15);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('71 Chive Point', 16);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('8 Canary Circle', 17);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('9 Sutteridge Trail', 18);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('46 Dixon Crossing', 19);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('78 Dahle Terrace', 20);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('7011 Gina Junction', 1);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('2511 Hudson Point', 2);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('065 Sutteridge Junction', 3);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('8320 Manufacturers Court', 4);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('23045 Logan Terrace', 5);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('6286 Logan Park', 6);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('18 Moland Park', 7);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('3009 Brentwood Way', 8);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('4 Waywood Lane', 9);
INSERT INTO outlet (outlet_address, customer_id) VALUES ('90049 Onsgard Park', 10);

INSERT INTO product (prod_name, prod_price) VALUES ('Cheese - St. Andre', 44.97);
INSERT INTO product (prod_name, prod_price) VALUES ('Foam Espresso Cup Plain White', 48.1);
INSERT INTO product (prod_name, prod_price) VALUES ('Laundry - Bag Cloth', 43.39);
INSERT INTO product (prod_name, prod_price) VALUES ('Wine - Pinot Noir Stoneleigh', 10.02);
INSERT INTO product (prod_name, prod_price) VALUES ('Artichokes - Knobless, White', 98.49);
INSERT INTO product (prod_name, prod_price) VALUES ('Muffin Chocolate Individual Wrap', 72.8);
INSERT INTO product (prod_name, prod_price) VALUES ('Rice - Sushi', 0.51);
INSERT INTO product (prod_name, prod_price) VALUES ('Eggs - Extra Large', 38.39);
INSERT INTO product (prod_name, prod_price) VALUES ('Cream - 18%', 41.52);
INSERT INTO product (prod_name, prod_price) VALUES ('Club Soda - Schweppes, 355 Ml', 59.07);
INSERT INTO product (prod_name, prod_price) VALUES ('Extract - Vanilla,artificial', 89.33);
INSERT INTO product (prod_name, prod_price) VALUES ('Pepper - Green Thai', 44.2);
INSERT INTO product (prod_name, prod_price) VALUES ('Beans - Navy, Dry', 35.82);
INSERT INTO product (prod_name, prod_price) VALUES ('Appetizer - Smoked Salmon / Dill', 41.45);
INSERT INTO product (prod_name, prod_price) VALUES ('Sage - Ground', 14.27);
INSERT INTO product (prod_name, prod_price) VALUES ('Ice Cream Bar - Oreo Sandwich', 81.4);
INSERT INTO product (prod_name, prod_price) VALUES ('Chocolate - Pistoles, Lactee, Milk', 37.21);
INSERT INTO product (prod_name, prod_price) VALUES ('Oysters - Smoked', 34.84);
INSERT INTO product (prod_name, prod_price) VALUES ('Lettuce - Belgian Endive', 70.15);
INSERT INTO product (prod_name, prod_price) VALUES ('Pork - Caul Fat', 13.87);
INSERT INTO product (prod_name, prod_price) VALUES ('Pepsi - Diet, 355 Ml', 7.02);
INSERT INTO product (prod_name, prod_price) VALUES ('Onions - White', 80.76);
INSERT INTO product (prod_name, prod_price) VALUES ('Plaintain', 69.04);
INSERT INTO product (prod_name, prod_price) VALUES ('Beer - Heinekin', 1.44);
INSERT INTO product (prod_name, prod_price) VALUES ('Split Peas - Green, Dry', 98.43);
INSERT INTO product (prod_name, prod_price) VALUES ('Spring Roll Wrappers', 19.26);
INSERT INTO product (prod_name, prod_price) VALUES ('Soup - Campbells Beef Stew', 60.99);
INSERT INTO product (prod_name, prod_price) VALUES ('Ecolab - Hobart Washarm End Cap', 69.87);
INSERT INTO product (prod_name, prod_price) VALUES ('Croissants Thaw And Serve', 39.3);


INSERT INTO vehicle (van_plate, van_capacity) VALUES ('KJ23LXM', 458);
INSERT INTO vehicle (van_plate, van_capacity) VALUES ('BT71QRF', 454);
INSERT INTO vehicle (van_plate, van_capacity) VALUES ('MN19ZWD', 259);
INSERT INTO vehicle (van_plate, van_capacity) VALUES ('YL68HCP', 341);
INSERT INTO vehicle (van_plate, van_capacity) VALUES ('DV24TGS', 256);

INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Pennie Vasyaev', '393 Buhler Way', '07821511889');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Bree Elbourn', '75 Lotheville Point', '07910849192');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Wilow Doleman', '674 Green Circle', '07964950522');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Christy Doret', '680 Manitowish Junction', '07029049042');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Kurtis Markussen', '47813 Dottie Drive', '07023068344');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Gillian Landman', '1584 Fallview Terrace', '07848123601');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Maddie Hayle', '043 Kropf Parkway', '07921260875');
INSERT INTO driver (driver_name, driver_address, phone_number) VALUES ('Pauline Mussington', '666 Beilfuss Circle', '07082791839');

INSERT INTO vehicle_driver (van_id, driver_id) VALUES (1, 1);
INSERT INTO vehicle_driver (van_id, driver_id) VALUES (2, 2);
INSERT INTO vehicle_driver (van_id, driver_id) VALUES (3, 3);
INSERT INTO vehicle_driver (van_id, driver_id) VALUES (4, 7);
INSERT INTO vehicle_driver (van_id, driver_id) VALUES (5, 6);

INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 1', 'pending', 3);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 2', 'delivered', 1);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 3', 'out_for_delivery', 5);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 4', 'cancelled', 2);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 5', 'pending', 8);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 6', 'out_for_delivery', 4);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 7', 'delivered', 6);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 8', 'pending', 7);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 9', 'cancelled', 3);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 10', 'out_for_delivery', 1);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 11', 'delivered', 5);
INSERT INTO delivery_run (run_area, delivery_status, driver_id) VALUES ('Zone 12', 'pending', 2);

INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave at front door', 'pending', 3, 1);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Ring bell twice', 'out_for_delivery', 12, 5);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Fragile - glass inside', 'delivered', 7, 3);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Customer not home before 5pm', 'pending', 18, 8);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Call on arrival', 'delivered', 25, 2);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Deliver to back entrance', 'out_for_delivery', 9, 6);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Do not bend', 'pending', 14, 4);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Hand to customer only', 'cancelled', 2, 7);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave with receptionist', 'delivered', 30, 9);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Priority shipment', 'out_for_delivery', 11, 10);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Gate code required', 'pending', 6, 12);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Large package', 'delivered', 20, 11);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Small parcel', 'pending', 27, 3);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Business hours delivery', 'out_for_delivery', 15, 5);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Customer requested delay', 'cancelled', 4, 2);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave at side gate', 'pending', 1, 1);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Fragile, handle carefully', 'out_for_delivery', 2, 2);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Call before delivery', 'delivered', 3, 3);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Deliver after 6 PM', 'pending', 4, 4);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave at reception', 'pending', 5, 5);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Fragile item inside', 'out_for_delivery', 6, 6);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Express delivery', 'delivered', 7, 7);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Do not stack', 'pending', 8, 8);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Customer will pick up', 'cancelled', 9, 9);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave at porch', 'out_for_delivery', 10, 10);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Ring bell twice', 'pending', 11, 11);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Handle with care', 'delivered', 12, 12);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Call if late', 'pending', 13, 1);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Gate code required', 'out_for_delivery', 14, 2);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Business hours delivery', 'delivered', 15, 3);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave with doorman', 'pending', 16, 4);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Customer requested delay', 'cancelled', 17, 5);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Standard shipping', 'pending', 18, 6);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Large package', 'delivered', 19, 7);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Small parcel', 'pending', 20, 8);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Call on arrival', 'out_for_delivery', 21, 9);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave at back entrance', 'pending', 22, 10);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Gift order', 'delivered', 23, 11);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Priority customer order', 'out_for_delivery', 24, 12);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Heavy package', 'pending', 25, 1);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Weekend delivery', 'delivered', 26, 2);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Leave with receptionist', 'pending', 27, 3);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Express shipping', 'out_for_delivery', 28, 4);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Customer pickup backup', 'cancelled', 29, 5);
INSERT INTO orders (order_notes, delivery_status, outlet_id, tracking_id) VALUES ('Awaiting dispatch', 'pending', 30, 6);

INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 12, 1);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 5, 2);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (7, 19, 3);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 1, 4);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (4, 22, 5);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 9, 6);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (5, 14, 7);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 3, 8);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 18, 9);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 11, 10);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (6, 7, 11);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 25, 12);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (4, 2, 13);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 16, 14);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (5, 10, 15);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 29, 16);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 6, 17);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 8, 18);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (7, 21, 19);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 13, 20);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (4, 4, 21);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 17, 22);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 9, 23);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (6, 1, 24);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 27, 25);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 5, 26);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (4, 11, 27);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 15, 28);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 20, 29);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (5, 23, 30);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 8, 31);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 14, 32);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 19, 33);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 2, 34);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (4, 12, 35);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 6, 36);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 18, 37);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (5, 9, 38);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 22, 39);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 3, 40);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (4, 16, 41);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (3, 7, 42);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (2, 25, 43);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (5, 1, 44);
INSERT INTO order_line (quantity, prod_id, order_id) VALUES (1, 11, 45);

