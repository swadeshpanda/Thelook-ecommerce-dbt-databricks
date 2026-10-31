-- =====================================================================
-- Load raw TheLook e-commerce data into Databricks (Unity Catalog)
-- Source: Kaggle "Looker Ecommerce BigQuery Dataset" (7 CSV files)
-- Run in the Databricks SQL editor. Safe to re-run (CREATE OR REPLACE).
-- =====================================================================

-- 1. Raw schema and a volume (governed folder) for the CSV files
CREATE SCHEMA IF NOT EXISTS workspace.thelook_raw;
CREATE VOLUME IF NOT EXISTS workspace.thelook_raw.landing;

-- 2. Upload the 7 CSVs to: Catalog > workspace > thelook_raw > Volumes > landing

-- 3. Turn each file into a Delta table
CREATE OR REPLACE TABLE workspace.thelook_raw.orders AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/orders.csv', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.thelook_raw.order_items AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/order_items.csv', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.thelook_raw.products AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/products.csv', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.thelook_raw.users AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/users.csv', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.thelook_raw.inventory_items AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/inventory_items.csv', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.thelook_raw.distribution_centers AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/distribution_centers.csv', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.thelook_raw.events AS
SELECT * FROM read_files('/Volumes/workspace/thelook_raw/landing/events.csv', format => 'csv', header => true);

-- 4. Sanity check: every table should have rows
SELECT 'orders' AS table_name, count(*) AS row_count FROM workspace.thelook_raw.orders
UNION ALL SELECT 'order_items', count(*) FROM workspace.thelook_raw.order_items
UNION ALL SELECT 'products', count(*) FROM workspace.thelook_raw.products
UNION ALL SELECT 'users', count(*) FROM workspace.thelook_raw.users
UNION ALL SELECT 'inventory_items', count(*) FROM workspace.thelook_raw.inventory_items
UNION ALL SELECT 'distribution_centers', count(*) FROM workspace.thelook_raw.distribution_centers
UNION ALL SELECT 'events', count(*) FROM workspace.thelook_raw.events;