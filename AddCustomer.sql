CREATE PROCEDURE AddCustomer 
    @CustomerId DECIMAL(12),
    @TotalOrders DECIMAL(4),
    @EmployeeId DECIMAL(12)
AS
BEGIN
    -- Insert a new customer into the CustomerAccount table
    INSERT INTO CustomerAccount (CustomerId, TotalOrders, EmployeeId)
    VALUES (@CustomerId, @TotalOrders, @EmployeeId);
END;

