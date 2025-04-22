-- 📝 Assignment: Database Design and Normalization

-- Question 1: Transforming to First Normal Form (1NF)
-- Original table: ProductDetail(OrderID, CustomerName, Products)
-- Issue: Products column contains multiple values (violates 1NF)

-- Solution: Create new table with atomic values
CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    PRIMARY KEY (OrderID, Product)
);

-- Insert normalized data
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Transforming to Second Normal Form (2NF)
-- Original table: OrderDetails(OrderID, CustomerName, Product, Quantity)
-- Issue: CustomerName depends only on OrderID (partial dependency)

-- Solution: Split into two tables to remove partial dependencies
-- Table 1: Orders (OrderID is PK)
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Table 2: OrderItems (OrderID + Product is composite PK)
CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Insert data into normalized tables
INSERT INTO Orders_2NF (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);