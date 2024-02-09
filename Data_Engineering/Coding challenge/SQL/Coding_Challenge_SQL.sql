/*Create a database*/
CREATE DATABASE IF NOT EXISTS coding_challenge_1;
USE coding_challenge_1;

/*Create a sample table*/
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

/*Insert some sample data*/
INSERT INTO orders VALUES
(1, 101, '2024-01-01', 100.00),
(2, 102, '2024-01-02', 150.00),
(3, 101, '2024-01-03', 200.00),
(4, 103, '2024-01-04', 120.00);

/*Use OVER and PARTITION BY  to calculate the total order 
amount for each customer*/
SELECT order_id,customer_id,order_amount,
    SUM(order_amount) OVER (PARTITION BY customer_id) 
    AS total_amount_per_customer
FROM orders;


/*Use GROUP BY to create subtotals and total aggregations*/
SELECT customer_id,
    SUM(order_amount) AS total_order_amount, COUNT(order_id) AS total_orders,
    AVG(order_amount) AS avg_order_amount, MAX(order_amount) AS max_order_amount,
    MIN(order_amount) AS min_order_amount FROM orders
GROUP BY customer_id WITH ROLLUP ORDER BY min_order_amount desc;




/*Create additional tables To implement joins*/
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO customers VALUES
(101, 'Rohan'),
(102, 'Rohit'),
(103, 'Rushikesh');


CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO order_details VALUES
(1, 1, 2),
(1, 2, 1),
(2, 1, 3),
(2, 3, 2),
(3, 2, 1),
(4, 1, 2),
(4, 3, 1);

/*INNER JOIN*/
SELECT *
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id;

/*LEFT JOIN*/
SELECT *
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id;

/*RIGHT JOIN*/
SELECT *
FROM orders
RIGHT JOIN customers ON orders.customer_id = customers.customer_id;

/*CROSS JOIN*/
SELECT *
FROM orders
CROSS JOIN customers;

-- SELF JOIN
SELECT *
FROM orders o1
JOIN orders o2 ON o1.customer_id = o2.customer_id AND o1.order_id <> o2.order_id;

/*Full join*/
SELECT *
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;


