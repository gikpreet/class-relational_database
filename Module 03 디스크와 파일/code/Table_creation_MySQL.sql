DROP DATABASE IF EXISTS Module03;

CREATE DATABASE Module03;

USE Module03;

CREATE TABLE Category (
	CategoryNo int,
    CategoryName varchar(50) NOT NULL,
    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
);

CREATE TABLE Product (
    ProductNo int PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    UnitPrice int DEFAULT 0 NOT NULL,
    Description text,
    CategoryNo int,
    CONSTRAINT fk_Product_CategoryID FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
);

CREATE TABLE Customer (
    CustomerNo int,
    CustomerName nvarchar(10),
    Email varchar(40),
    Password varchar(16),
    CONSTRAINT pk_Customer PRIMARY KEY(CustomerNo)
);

CREATE TABLE Orders (
	OrderNo int,
    OrderDate Date,
    CustomerNo int,

    CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
    CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo) REFERENCES Customer(CustomerNo)
);

CREATE TABLE OrderDetail (
	ProductNo	int,
	OrderNo	int,
    Quantity int,

    CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo)
);