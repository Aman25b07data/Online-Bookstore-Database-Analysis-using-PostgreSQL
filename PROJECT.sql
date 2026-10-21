-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM Orders;



 
-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Orders.csv' 
CSV HEADER;
-- BASIC QUERY

-- 1) RETRIEVE ALL THE BOOKS IN THE 'FRICTION' GENRE:
SELECT * FROM Books
WHERE genre='Fiction'

--2) FIND BOOKS PUBLISH AFTER THE YEAR 1950s;
SELECT * FROM Books
WHERE published_year > 1950;

-- 3) LIST ALL THE CUSTOMERS FROM THE CANADA;
SELECT * FROM Customers
WHERE country = 'Canada'

-- 4) SHOW ORDERS PLACED IN NOVEMBER 2023;
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5) Retrieve the total stocks of books available;
SELECT SUM(stock) AS Total_stocks
FROM Books;

-- 6) FIND THE DETAILS OF THE MOST EXPENSIVE BOOKS;
SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

-- 7) SHOW ALL CUSTOMERS WHO ORDERED MORE THEN 1 QUANTITY OF A BOOK;
SELECT * FROM orders
WHERE quantity > 1

-- 8) RETRIEVE ALL THE ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20;
SELECT * FROM orders
WHERE total_amount > 20

-- 9) LIST ALL THE GENRES AVAILABLE IN THE BOOKS TABLE;
SELECT DISTINCT genre FROM books

-- 10) FIND THE BOOKS WITH THE LOWEST STOCK:
SELECT * FROM books
ORDER BY stock 
LIMIT 5

-- 11) CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS
SELECT SUM(total_amount)
AS total_revenue 
FROM orders

SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM Orders;



-- ADVANCE QUESTIONS

--1) RETRIEVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE:
SELECT b.genre,SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre


-- 2) FIND THE AVERAGE PRICE OF BOOKS IN THE 'FANTASY' GENRE
SELECT AVG(price) AS Average_price
FROM books
WHERE genre = 'Fantasy'

-- 3) LIST CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS
SELECT o.customer_id ,c.name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id,c.name
HAVING 
COUNT(order_id) >= 2

-- 4) FIND THE MOST FREQUENTLY ORDERED BOOKS
SELECT o.book_id,b.title,COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id,b.title
ORDER BY COUNT(o.order_id) DESC
LIMIT 8

-- 5) SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'FANTASY' GENRE
SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3


-- 6) RETRIEVE THE TOTAL QUANTITY OF BOOKS SOLD BY EACH AUTHOR
SELECT b.author,SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author

-- 7) LIST THE CITIES WHERE CUSTOMERS WHO SPENT OVER $30 ARE LOCATED:
SELECT DISTINCT c.city,total_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;


-- 8) FIND THE CUSTOMERS WHO SPENT THE MOST ON ORDERS;
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spend
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id 
GROUP BY c.customer_id ,c.name
ORDER BY total_spend DESC LIMIT 1

-- 9) CALCULATE THE STOCK REMAINING AFTER FULFILLING ALL ORDERS;
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS order_quantity,
b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id

CREATE DATABASE project_2


