-- =============================================================
-- RMS Migration — add Features 1-6
-- Safe to run on the existing rms_db (uses IF NOT EXISTS / IF NOT EXISTS column checks)
-- Run: mysql -u root -p rms_db < migrate.sql
-- =============================================================

USE rms_db;

-- Feature 5: add food_image column to menu_items (skip if already exists)
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS food_image VARCHAR(255) DEFAULT NULL;

-- Feature 1: customers table
CREATE TABLE IF NOT EXISTS customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  mobile_number VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Feature 2: tables table
CREATE TABLE IF NOT EXISTS tables (
  id INT AUTO_INCREMENT PRIMARY KEY,
  table_number VARCHAR(20) NOT NULL UNIQUE,
  capacity INT NOT NULL DEFAULT 4,
  status ENUM('available','booked') NOT NULL DEFAULT 'available'
);

-- Feature 3: table_bookings
CREATE TABLE IF NOT EXISTS table_bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  table_id INT NOT NULL,
  booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('active','cancelled','completed') NOT NULL DEFAULT 'active',
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  FOREIGN KEY (table_id)    REFERENCES tables(id)    ON DELETE CASCADE
);

-- Seed some tables if the table is empty
INSERT INTO tables (table_number, capacity)
SELECT * FROM (
  SELECT 'T1', 2 UNION ALL SELECT 'T2', 2 UNION ALL
  SELECT 'T3', 4 UNION ALL SELECT 'T4', 4 UNION ALL
  SELECT 'T5', 6 UNION ALL SELECT 'T6', 6
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM tables LIMIT 1);
