ALTER PROCEDURE AddSale 
    @CustomerId DECIMAL(12),
    @EmployeeId DECIMAL(12),
    @OrderDate DATE,
    @TotalAmount DECIMAL(6,2)
AS
BEGIN
     
    DECLARE @OrderId DECIMAL(12);
    SELECT @OrderId = ISNULL(MAX(OrderId), 0) + 1 FROM Sales;

    
    INSERT INTO Sales (OrderId, CustomerId, OrderDate, EmployeeId, TotalAmount)
    VALUES (@OrderId, @CustomerId, @OrderDate, @EmployeeId, @TotalAmount);
END;
