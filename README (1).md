# Online Bookstore Database Analysis using PostgreSQL

## About the Project

This is a SQL project built in PostgreSQL. It creates a database for an online bookstore and uses SQL queries to answer common business questions about books, customers, and orders.

## Database

The project uses a database named `OnlineBookstore` with three tables:

- **Books**: Book_ID, Title, Author, Genre, Published_Year, Price, Stock
- **Customers**: Customer_ID, Name, Email, Phone, City, Country
- **Orders**: Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount

Each order is linked to one customer and one book through foreign keys.

## What the Project Does

1. Creates the database and tables.
2. Imports customer and order data from CSV files using the `COPY` command.
3. Runs 11 basic queries, such as:
   - Finding books by genre or publication year
   - Listing customers from a country
   - Showing orders from a specific month
   - Calculating total stock and total revenue
   - Finding the most expensive book and the books with the lowest stock
4. Runs 9 advanced queries, such as:
   - Total books sold by genre and by author
   - Average price of Fantasy books
   - Customers with at least 2 orders
   - Most frequently ordered books
   - Customer who spent the most
   - Stock remaining after all orders are fulfilled

## SQL Concepts Used

SELECT, WHERE, BETWEEN, ORDER BY, LIMIT, DISTINCT, SUM, AVG, COUNT, GROUP BY, HAVING, INNER JOIN, LEFT JOIN, COALESCE, Primary Keys, Foreign Keys

## Files

- `PROJECT.sql`: all table creation, data import, and queries
- `Customers.csv`, `Orders.csv`: data files used for import

## How to Run

1. Install PostgreSQL.
2. Update the CSV file paths in the `COPY` commands in `PROJECT.sql`.
3. Run `PROJECT.sql` in psql or pgAdmin.
