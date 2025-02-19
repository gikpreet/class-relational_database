DROP DATABASE IF EXISTS Module02;
CREATE DATABASE Module02;
USE Module02;

CREATE TABLE Category (
    CategoryNo INTEGER,
    CategoryName VARCHAR(20)
);

ALTER TABLE Category ADD CONSTRAINT pk_Category PRIMARY KEY(CategoryNo);

CREATE TABLE Product (
    ProductNo	INTEGER,
    ProductName	NVARCHAR(30),
    Price		DECIMAL,
    CategoryNo	INTEGER
);

ALTER TABLE Product ADD CONSTRAINT pk_Product PRIMARY KEY(ProductNo);

INSERT INTO Category VALUES (1, 'Novel');
INSERT INTO Category VALUES (3, 'History');

ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo);

INSERT INTO Product (ProductNo, ProductName, Price) VALUES (20101927, 'The Second World War', 37800);
UPDATE Product SET CategoryNo = 3 WHERE ProductNo = 20101927;
INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (97422537, 'Hobbit', 28800, 1);
INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (97422515, 'Lord of the Rings 1', 28800, 1);

INSERT INTO Category VALUES (2, 'Science');
INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (2312211, 'Cosmos', 28800, 2);
