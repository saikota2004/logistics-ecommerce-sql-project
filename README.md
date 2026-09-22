# Logistics & E-commerce Order Management System

A practical MySQL database project designed to simulate a real-world
logistics and e-commerce operation.

The project manages customers, products, orders, payments, warehouses,
employees, inventory, deliveries, returns and suppliers.

## Project Overview

This project demonstrates how SQL can be used to design a relational
database, manage realistic business data, validate data integrity and
perform business analysis.

## Technologies

- MySQL
- MySQL Workbench
- SQL
- Git
- GitHub

## Database Tables

The database contains 11 related tables:

1. Customers
2. Products
3. Orders
4. Order Items
5. Payments
6. Warehouses
7. Employees
8. Deliveries
9. Inventory
10. Returns
11. Suppliers

## Dataset

| Table | Records |
|---|---:|
| Customers | 50 |
| Products | 30 |
| Orders | 600 |
| Payments | 600 |
| Warehouses | 10 |
| Employees | 30 |
| Deliveries | 600 |
| Inventory | 300 |
| Suppliers | 10 |
| Order Items | ~1,800 |
| Returns | Generated from returned orders |

## Key SQL Concepts

- CREATE DATABASE
- CREATE TABLE
- Primary Keys
- Foreign Keys
- UNIQUE Constraints
- NOT NULL Constraints
- JOIN
- LEFT JOIN
- GROUP BY
- ORDER BY
- Aggregate Functions
- Subqueries
- Date Functions
- CASE expressions
- Data Validation
- Business Analysis

## Business Analysis

The project answers practical business questions such as:

- What is the total revenue?
- What is the average order value?
- How are sales changing month by month?
- Which products generate the most revenue?
- Which customers spend the most?
- Which warehouses process the most orders?
- What is the average delivery time?
- How do courier companies compare by delivery time?
- What are the most common payment statuses?
- What are the main reasons for product returns?
- Which products need inventory replenishment?
- Which suppliers provide the most products?

## Data Validation

Data integrity checks were performed to identify:

- Orders without customers
- Orders without warehouses
- Orders without order items
- Payment amount mismatches
- Incorrect order totals
- Invalid delivery dates
- Duplicate customer emails
- Invalid order totals
- Products below reorder levels

## Project Structure

```text
logistics-ecommerce-sql-project
│
├── README.md
│
└── sql
    ├── warehouse_project.sql
    ├── 02_business_queries.sql
    └── 03_data_validation.sql

## SQL Files

### warehouse_project.sql

Complete database export containing the database tables and
project data.

### 02_business_queries.sql

Contains business analysis queries for sales, customers,
products, warehouses, deliveries, payments, returns,
inventory and suppliers.

### 03_data_validation.sql

Contains SQL queries used to validate relationships,
calculations and data quality.

## Skills Demonstrated

- Relational Database Design
- SQL Querying
- Data Analysis
- Data Validation
- Business Problem Solving
- Database Relationships
- Git & GitHub

## Objective

To demonstrate practical SQL and database skills through a realistic
logistics and e-commerce business scenario.

## Author

Sai Kota

B.Tech - Computer Science & Engineering (Artificial Intelligence)