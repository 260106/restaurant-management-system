-- Restaurant Management System Database
-- Run: mysql -u root -p < schema.sql

CREATE DATABASE IF NOT EXISTS rms_db;
USE rms_db;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'staff') NOT NULL DEFAULT 'staff',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS menu_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  category VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  available TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  table_number VARCHAR(20),
  total_amount DECIMAL(10,2) NOT NULL,
  created_by INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  item_name VARCHAR(150) NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- Seed users
-- Admin password: admin123  |  Staff password: staff123
INSERT INTO users (name, email, password, role) VALUES
('Admin User', 'admin@rms.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'admin'),
('Staff User', 'staff@rms.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'staff');

-- Seed menu items
INSERT INTO menu_items (name, category, price) VALUES
('Butter Chicken', 'Main Course', 280.00),
('Paneer Tikka', 'Starters', 180.00),
('Veg Biryani', 'Rice', 160.00),
('Chicken Biryani', 'Rice', 240.00),
('Dal Makhani', 'Main Course', 160.00),
('Garlic Naan', 'Breads', 50.00),
('Butter Naan', 'Breads', 40.00),
('Gulab Jamun', 'Desserts', 80.00),
('Mango Lassi', 'Beverages', 90.00),
('Spring Rolls', 'Starters', 120.00);
