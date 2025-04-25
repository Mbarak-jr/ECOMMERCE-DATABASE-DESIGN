-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS product_attribute, attribute_type, attribute_category,
product_image, product_item, product, product_variation,
size_option, size_category, color, brand, product_category;

-- ===========================================
-- Table: product_category
-- ===========================================
CREATE TABLE product_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- ===========================================
-- Table: brand
-- ===========================================
CREATE TABLE brand (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- ===========================================
-- Table: product
-- ===========================================
CREATE TABLE product (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  brand_id INT,
  category_id INT,
  base_price DECIMAL(10,2),
  description TEXT,
  FOREIGN KEY (brand_id) REFERENCES brand(id),
  FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- ===========================================
-- Table: product_image
-- ===========================================
CREATE TABLE product_image (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  image_url VARCHAR(255),
  FOREIGN KEY (product_id) REFERENCES product(id)
);

-- ===========================================
-- Table: color
-- ===========================================
CREATE TABLE color (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  hex_code VARCHAR(7)
);

-- ===========================================
-- Table: size_category
-- ===========================================
CREATE TABLE size_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- ===========================================
-- Table: size_option
-- ===========================================
CREATE TABLE size_option (
  id INT AUTO_INCREMENT PRIMARY KEY,
  size_category_id INT,
  label VARCHAR(20) NOT NULL,
  FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);

-- ===========================================
-- Table: product_item
-- ===========================================
CREATE TABLE product_item (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  color_id INT,
  size_option_id INT,
  sku VARCHAR(50),
  price DECIMAL(10,2),
  stock INT,
  FOREIGN KEY (product_id) REFERENCES product(id),
  FOREIGN KEY (color_id) REFERENCES color(id),
  FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

-- ===========================================
-- Table: attribute_type
-- ===========================================
CREATE TABLE attribute_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- ===========================================
-- Table: attribute_category
-- ===========================================
CREATE TABLE attribute_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- ===========================================
-- Table: product_attribute
-- ===========================================
CREATE TABLE product_attribute (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  attribute_type_id INT,
  attribute_category_id INT,
  name VARCHAR(100),
  value VARCHAR(255),
  FOREIGN KEY (product_id) REFERENCES product(id),
  FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id),
  FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id)
);

-- ===========================================
-- Sample Data
-- ===========================================

-- product_category
INSERT INTO product_category (name) VALUES
('Clothing'), ('Electronics');

-- brand
INSERT INTO brand (name) VALUES
('Nike'), ('Samsung');

-- product
INSERT INTO product (name, brand_id, category_id, base_price, description) VALUES
('Air Max Sneakers', 1, 1, 79.99, 'Popular running sneakers'),
('Galaxy S21', 2, 2, 799.99, 'Latest Samsung smartphone');

-- color
INSERT INTO color (name, hex_code) VALUES
('Red', '#FF0000'), ('Blue', '#0000FF');

-- size_category
INSERT INTO size_category (name) VALUES
('Clothing Size');

-- size_option
INSERT INTO size_option (size_category_id, label) VALUES
(1, 'S'), (1, 'M'), (1, 'L');

-- product_item
INSERT INTO product_item (product_id, color_id, size_option_id, sku, price, stock) VALUES
(1, 1, 1, 'NIKE-AM-S-RED', 79.99, 50),
(1, 2, 2, 'NIKE-AM-M-BLU', 79.99, 30);

-- attribute_type
INSERT INTO attribute_type (name) VALUES
('Text'), ('Number'), ('Boolean');

-- attribute_category
INSERT INTO attribute_category (name) VALUES
('Physical'), ('Technical');

-- product_attribute
INSERT INTO product_attribute (product_id, attribute_type_id, attribute_category_id, name, value) VALUES
(1, 1, 1, 'Material', 'Mesh'),
(2, 2, 2, 'Battery Life', '24');

-- product_image
INSERT INTO product_image (product_id, image_url) VALUES
(1, 'https://example.com/images/airmax.png'),
(2, 'https://example.com/images/galaxys21.png');
