DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,
    customerName        VARCHAR(20)
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Africa');
INSERT INTO category(categoryName) VALUES ('South America');
INSERT INTO category(categoryName) VALUES ('North America');
INSERT INTO category(categoryName) VALUES ('Asia');
INSERT INTO category(categoryName) VALUES ('Europe');
INSERT INTO category(categoryName) VALUES ('Oceania');



INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('South African National Lottery', 1, '2.5 Billion Rand!',5.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Give N Take',1,'20 million Naira!',9.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lotto Max',3,'CA$ 70 million!',2.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Državna Lutrija Srbije',5,'90 billion dinar!',2.75);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lotto New Zealand',6,'NZ$ 5 million!',3.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gosloto',5,'27 million rubles!',2500.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('La Primitiva',5,'50 billion Euros!',1.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hoosier Lotto',3,'$12 million!',4.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dia de Sorte',2,'700 million Reales',9.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Quina',2,'12 - 199 billion Reales!',1.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mark Six',4,'HK$ 90 million!',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Israel Lotto',4,'20 million shekels!',38000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SuperEnaLotto',5,'61.8 million Euros!',3.39);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sans Topu',4,'34 billion Lira!',150000.0);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lotto Maxima',5,'72 trillion Hryvnia!',0.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Viking Lotto',5,'100 billion Euros!',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mega Millions',2,'$4 quadrillion!',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Powerball',2,'Lifetime supply of ammo for your firearm of choice!',3.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cash4Life',2,'$5.5 million!',8.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hatoslotto',5,'24 billion forint!',1.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Megalot',5,'3 million Hryvnia!',27.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('El Gordo',5,'4 billion Euros!',4.00);

    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');




-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.png' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.png' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.png' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.png' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.png' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/18.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/19.png' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/20.jpg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/21.jpg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/22.jpg' WHERE ProductId = 22;

