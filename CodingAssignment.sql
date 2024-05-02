Create database Coding_challenge
-- Creating Customers Table

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- Creating Products Table

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description TEXT,
    stockQuantity INT);

-- Creating Cart Table

CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id));

-- Create Orders Table

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    shipping_address VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (product_id, name, description, price, stockQuantity) 
VALUES 
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

 alter table customers
 add address text ;

INSERT INTO Customers (customer_id, name, email, address) 
VALUES 
(1, 'John Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia Adams', 'olivia@example.com', '765 Fir St, Territory');

Select * from orders

INSERT INTO Orders (order_id, customer_id, order_date, total_price) 
VALUES 
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);


Select * from Order_Items

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_amount) 
VALUES 
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);

INSERT INTO Cart (cart_id, customer_id, product_id, quantity) 
VALUES 
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);


--solving queries

--1. Update refrigerator product price to 800.

UPDATE Products 
SET price = 800.00 
WHERE name = 'Refrigerator';

--2. Remove all cart items for a specific customer.

DELETE FROM Cart 
WHERE customer_id = 2;

--3.Retrieve Products Priced Below $100.

SELECT * 
FROM Products 
WHERE price < 100.00;

--4. Find Products with Stock Quantity Greater Than 5.

SELECT * 
FROM Products 
WHERE stockQuantity > 5;

--5. Retrieve Orders with Total Amount Between $500 and $1000.

SELECT * 
FROM Orders 
WHERE total_price Between 500.00 and 1000.00;

--6. Find Products which name end with letter 'r'.

SELECT * 
FROM Products 
WHERE name LIKE '%r';

--7. Retrieve Cart Items for Customer 5.

SELECT * 
FROM Cart 
WHERE customer_id = 5;

--8. Find Customers Who Placed Orders in 2023.

SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

--9.Determine the Minimum Stock Quantity for Each Product Category.

SELECT name, MIN(stockQuantity) AS min_stock
FROM Products
GROUP BY name;

--10.Calculate the Total Amount Spent by Each Customer.

SELECT c.customer_id, c.name, SUM(o.total_price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

--11.Find the Average Order Amount for Each Customer.

SELECT customer_id, AVG(total_price) AS average_order_amount
FROM Orders
GROUP BY customer_id;

--12. Count the Number of Orders Placed by Each Customer.

SELECT customer_id, COUNT(*) AS number_of_orders
FROM Orders
GROUP BY customer_id;

--13. Find the Maximum Order Amount for Each Customer.


SELECT customer_id, MAX(total_price) AS max_order_amount
FROM Orders
GROUP BY customer_id;

--14. Get Customers Who Placed Orders Totaling Over $1000.

SELECT c.*
FROM Customers c
JOIN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING SUM(total_price) > 1000
) AS o ON c.customer_id = o.customer_id;

--15. Subquery to Find Products Not in the Cart.

SELECT *
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Cart);


--16. Subquery to Find Customers Who Haven't Placed Orders.

SELECT *
FROM Customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);


--17. Subquery to Calculate the Percentage of Total Revenue for a Product.

SELECT name,
       price,
       (price * 100) / (SELECT SUM(total_price) FROM Orders) AS revenue_percentage
FROM Products;


--18. Subquery to Find Products with Low Stock.

SELECT *
FROM Products
WHERE stockQuantity < (SELECT AVG(stockQuantity) FROM Products);


--19. Subquery to Find Customers Who Placed High-Value Orders.

SELECT *
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE total_price > 1000
);












