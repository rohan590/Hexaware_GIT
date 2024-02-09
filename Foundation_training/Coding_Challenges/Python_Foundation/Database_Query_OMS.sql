create database oms;
use oms;


CREATE TABLE Product (
    productId INT PRIMARY KEY,
    productName VARCHAR(255),
    description VARCHAR(255),
    price DOUBLE,
    quantityInStock INT,
    type VARCHAR(255)
);

CREATE TABLE Electronics (
    productId INT PRIMARY KEY,
    brand VARCHAR(255),
    warrantyPeriod INT,
    FOREIGN KEY (productId) REFERENCES Product(productId)
);


CREATE TABLE Clothing (
    productId INT PRIMARY KEY,
    size VARCHAR(255),
    color VARCHAR(255),
    FOREIGN KEY (productId) REFERENCES Product(productId)
);


CREATE TABLE User (
    userId INT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(255)
);

CREATE TABLE ProductOrder(
	orderid int primary key,
    userId INT,
    productId INT);
/*created this to add order details */
ALTER TABLE productorder
MODIFY COLUMN orderid INT AUTO_INCREMENT;

