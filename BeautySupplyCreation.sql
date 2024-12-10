DROP TABLE IF EXISTS PriceHistory;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS RewardsAccount;
DROP TABLE IF EXISTS BasicAccount;
DROP TABLE IF EXISTS CustomerAccount;
DROP TABLE IF EXISTS Haircare;
DROP TABLE IF EXISTS Skincare;
DROP TABLE IF EXISTS Makeup;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS Employee;


-- Create the Vendor table
CREATE TABLE Vendor (
    VendorId DECIMAL(12) PRIMARY KEY,
    VendorName VARCHAR(128)
);

-- Create the Product table
CREATE TABLE Product (
    ProductId DECIMAL(12) PRIMARY KEY,
    VendorId DECIMAL(12) FOREIGN KEY REFERENCES Vendor(VendorId),
    Name VARCHAR(128),
    ReceivedDate DATE,
    Quantity DECIMAL(4),
    OrderStatus VARCHAR(10),
    Price DECIMAL(6,2)
);

-- Create the Haircare table (subtype of Product)
CREATE TABLE Haircare (
    ProductId DECIMAL(12) PRIMARY KEY,
    HaircareCategory VARCHAR(50),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

-- Create the Skincare table (subtype of Product)
CREATE TABLE Skincare (
    ProductId DECIMAL(12) PRIMARY KEY,
    SkincareCategory VARCHAR(50),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

-- Create the Makeup table (subtype of Product)
CREATE TABLE Makeup (
    ProductId DECIMAL(12) PRIMARY KEY,
    MakeupCategory VARCHAR(50),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

-- Create the Employee table
CREATE TABLE Employee (
    EmployeeId DECIMAL(12) PRIMARY KEY,
    EmployeeName VARCHAR(128)
);

-- Create the CustomerAccount table
CREATE TABLE CustomerAccount (
    CustomerId DECIMAL(12) PRIMARY KEY,
    TotalOrders DECIMAL(4),
    EmployeeId DECIMAL(12) FOREIGN KEY REFERENCES Employee(EmployeeId)
);

-- Create the RewardsAccount table (subtype of CustomerAccount)
CREATE TABLE RewardsAccount (
    CustomerId DECIMAL(12) PRIMARY KEY,
    TotalOrders DECIMAL(3),
    RewardsAccountNumber DECIMAL(9),
    EmployeeId DECIMAL(12) FOREIGN KEY REFERENCES Employee(EmployeeId),
    RewardPoints DECIMAL(6),
    FOREIGN KEY (CustomerId) REFERENCES CustomerAccount(CustomerId)
);

-- Create the BasicAccount table (subtype of CustomerAccount)
CREATE TABLE BasicAccount (
    CustomerId DECIMAL(12) PRIMARY KEY,
    TotalOrders DECIMAL(3),
    EmployeeId DECIMAL(12),
    FOREIGN KEY (CustomerId) REFERENCES CustomerAccount(CustomerId)
);

-- Create the Sales table
CREATE TABLE Sales (
    OrderId DECIMAL(12) PRIMARY KEY,
    CustomerId DECIMAL(12) FOREIGN KEY REFERENCES CustomerAccount(CustomerId),
    OrderDate DATE,
    EmployeeId DECIMAL(12) FOREIGN KEY REFERENCES Employee(EmployeeId),
    TotalAmount DECIMAL(6,2)
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailsId DECIMAL(12) PRIMARY KEY,
    OrderId DECIMAL(12) FOREIGN KEY REFERENCES Sales(OrderId),
    ProductId DECIMAL(12) FOREIGN KEY REFERENCES Product(ProductId),
    Quantity DECIMAL(3),
    Price DECIMAL(6,2)
);

CREATE TABLE PriceHistory (
    PriceHistoryID DECIMAL(12) PRIMARY KEY,
    ProductID DECIMAL(12) FOREIGN KEY REFERENCES Product(ProductID),
    ChangeDate DATE NOT NULL,
    OldPrice DECIMAL(6,2) NOT NULL,
    NewPrice DECIMAL(6,2) NOT NULL
);


-- Create indexes
CREATE INDEX idx_Product_Name ON Product(Name);
CREATE INDEX idx_Product_ReceivedDate ON Product(ReceivedDate);
CREATE INDEX idx_Product_OrderStatus ON Product(OrderStatus);
CREATE INDEX idx_Product_VendorID ON Product(VendorId)

CREATE INDEX idx_OrderDetails_OrderId ON OrderDetails(OrderId);
CREATE INDEX idx_OrderDetails_ProductId ON OrderDetails(ProductId);

CREATE INDEX idx_Sales_CustomerId ON Sales(CustomerId);
CREATE INDEX idx_Sales_EmployeeId ON Sales(EmployeeId);
CREATE INDEX idx_Sales_OrderDate ON Sales(OrderDate);

CREATE INDEX idx_CustomerAccount_EmployeeId ON CustomerAccount(EmployeeId);
CREATE INDEX idx_CustomerAccount_TotalOrders ON CustomerAccount(TotalOrders);

CREATE INDEX idx_RewardsAccount_EmployeeId ON RewardsAccount(EmployeeId);
CREATE INDEX idx_RewardsAccount_RewardsAccountNumber ON RewardsAccount(RewardsAccountNumber);
CREATE INDEX idx_RewardsAccount_RewardPoints ON RewardsAccount(RewardPoints);

CREATE INDEX idx_BasicAccount_EmployeeId ON BasicAccount(EmployeeId);

-- Insert sample data into Vendor with manually specified VendorIds
INSERT INTO Vendor (VendorId, VendorName) 
VALUES 
    (101, 'LOréal'), 
    (102, 'Maybelline'), 
    (103, 'Neutrogena'),
    (104, 'MAC Cosmetics'),
    (105, 'SheaMoisture');

-- Insert sample data into Product with manually specified ProductIds
INSERT INTO Product (ProductId, VendorId, Name, ReceivedDate, Quantity, OrderStatus, Price)
VALUES 
    (201, 101, 'LOréal Paris Voluminous Mascara', '2024-07-01', 200, 'In Stock', 8.99),
    (202, 102, 'Maybelline Fit Me Matte + Poreless Foundation', '2024-07-02', 150, 'In Stock', 7.99),
    (203, 103, 'Neutrogena Hydro Boost Water Gel', '2024-07-03', 100, 'In Stock', 16.99),
    (204, 104, 'MAC Lipstick in Ruby Woo', '2024-07-04', 50, 'In Stock', 19.99),
    (205, 105, 'SheaMoisture Coconut & Hibiscus Curl Enhancing Smoothie', '2024-07-05', 75, 'In Stock', 11.99);

-- Insert sample data into Haircare with manually specified ProductIds
INSERT INTO Haircare (ProductId, HaircareCategory) 
VALUES 
    (205, 'Curl Enhancer');

-- Insert sample data into Skincare with manually specified ProductIds
INSERT INTO Skincare (ProductId, SkincareCategory) 
VALUES 
    (203, 'Moisturizer');

-- Insert sample data into Makeup with manually specified ProductIds
INSERT INTO Makeup (ProductId, MakeupCategory) 
VALUES 
    (201, 'Mascara'), 
    (202, 'Foundation'), 
    (204, 'Lipstick');

-- Insert sample data into Employee with manually specified EmployeeIds
INSERT INTO Employee (EmployeeId, EmployeeName) 
VALUES 
    (301, 'John Doe'), 
    (302, 'Jane Smith'), 
    (303, 'Emily Davis');

-- Insert sample data into CustomerAccount with manually specified CustomerIds
INSERT INTO CustomerAccount (CustomerId, TotalOrders, EmployeeId) 
VALUES 
    (401, 5, 301), 
    (402, 3, 302), 
    (403, 7, 303);

-- Insert sample data into RewardsAccount with manually specified CustomerIds
INSERT INTO RewardsAccount (CustomerId, TotalOrders, RewardsAccountNumber, EmployeeId, RewardPoints) 
VALUES 
    (401, 5, 123456789, 301, 500),
    (403, 7, 987654321, 303, 1200);

-- Insert sample data into BasicAccount with manually specified CustomerIds
INSERT INTO BasicAccount (CustomerId, TotalOrders, EmployeeId) 
VALUES 
    (402, 3, 302);

-- Insert sample data into Sales with manually specified OrderIds
INSERT INTO Sales (OrderId, CustomerId, OrderDate, EmployeeId, TotalAmount) 
VALUES 
    (501, 401, '2024-07-10', 301, 36.97), 
    (502, 402, '2024-07-11', 302, 19.98),
    (503, 403, '2024-07-12', 303, 19.99);

-- Insert sample data into OrderDetails with manually specified OrderDetailsIds
INSERT INTO OrderDetails (OrderDetailsId, OrderId, ProductId, Quantity, Price) 
VALUES 
    (601, 501, 201, 2, 8.99), 
    (602, 501, 203, 1, 16.99), 
    (603, 502, 202, 1, 7.99), 
    (604, 502, 205, 1, 11.99),
    (605, 503, 204, 1, 19.99);

SELECT 
    CASE 
        WHEN hc.ProductId IS NOT NULL THEN 'Haircare'
        WHEN sc.ProductId IS NOT NULL THEN 'Skincare'
        WHEN mk.ProductId IS NOT NULL THEN 'Makeup'
        ELSE 'Other'
    END AS ProductCategory,
    FORMAT(AVG(od.Price * od.Quantity), 'N2') AS AverageSales
FROM 
    Product p
LEFT JOIN 
    Haircare hc ON p.ProductId = hc.ProductId
LEFT JOIN 
    Skincare sc ON p.ProductId = sc.ProductId
LEFT JOIN 
    Makeup mk ON p.ProductId = mk.ProductId
LEFT JOIN 
    OrderDetails od ON p.ProductId = od.ProductId
GROUP BY 
    CASE 
        WHEN hc.ProductId IS NOT NULL THEN 'Haircare'
        WHEN sc.ProductId IS NOT NULL THEN 'Skincare'
        WHEN mk.ProductId IS NOT NULL THEN 'Makeup'
        ELSE 'Other'
    END
ORDER BY 
    AverageSales DESC;

SELECT 
    p.Name AS ProductName,
    p.ProductId,
    SUM(ph.NewPrice - ph.OldPrice) AS TotalPriceChange,
    CASE 
        WHEN SUM(ph.NewPrice - ph.OldPrice) > 0 THEN 'Increased'
        WHEN SUM(ph.NewPrice - ph.OldPrice) < 0 THEN 'Decreased'
        ELSE 'No Change'
    END AS ChangeDirection
FROM 
    PriceHistory ph
JOIN 
    Product p ON ph.ProductID = p.ProductId
GROUP BY 
    p.Name,
    p.ProductId
ORDER BY 
    TotalPriceChange DESC;

SELECT 
    v.VendorName,
    SUM(od.Price * od.Quantity) AS TotalRevenue
FROM 
    Sales s
JOIN 
    OrderDetails od ON s.OrderId = od.OrderId
JOIN 
    Product p ON od.ProductId = p.ProductId
JOIN 
    Vendor v ON p.VendorId = v.VendorId
GROUP BY 
    v.VendorName
ORDER BY 
    TotalRevenue DESC;

