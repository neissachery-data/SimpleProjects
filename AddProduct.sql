CREATE PROCEDURE AddProduct 
    @ProductId DECIMAL(12),
    @VendorId DECIMAL(12),
    @Name VARCHAR(128),
    @ReceivedDate DATE,
    @Quantity DECIMAL(4),
    @OrderStatus VARCHAR(10),
    @Price DECIMAL(6,2),
    @Category VARCHAR(50), -- Category for subtype tables
    @CategoryType VARCHAR(10) -- 'Haircare', 'Skincare', or 'Makeup'
AS
BEGIN
    -- Add the product to the Product table
    INSERT INTO Product (ProductId, VendorId, Name, ReceivedDate, Quantity, OrderStatus, Price)
    VALUES (@ProductId, @VendorId, @Name, @ReceivedDate, @Quantity, @OrderStatus, @Price);

    
    IF @CategoryType = 'Haircare'
    BEGIN
        INSERT INTO Haircare (ProductId, HaircareCategory)
        VALUES (@ProductId, @Category);
    END
    ELSE IF @CategoryType = 'Skincare'
    BEGIN
        INSERT INTO Skincare (ProductId, SkincareCategory)
        VALUES (@ProductId, @Category);
    END
    ELSE IF @CategoryType = 'Makeup'
    BEGIN
        INSERT INTO Makeup (ProductId, MakeupCategory)
        VALUES (@ProductId, @Category);
    END
END;
