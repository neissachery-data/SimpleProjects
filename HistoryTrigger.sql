CREATE TRIGGER trg_PriceChange
ON Product
AFTER UPDATE
AS
BEGIN
    DECLARE @NextPriceHistoryID DECIMAL(12,0);

    
    SELECT @NextPriceHistoryID = ISNULL(MAX(PriceHistoryID), 0) + 1 FROM PriceHistory;

    
    INSERT INTO PriceHistory (PriceHistoryID, ProductID, ChangeDate, OldPrice, NewPrice)
    SELECT 
        @NextPriceHistoryID, 
        i.ProductID,
        GETDATE(), 
        d.Price AS OldPrice,
        i.Price AS NewPrice
    FROM 
        inserted i
    JOIN 
        deleted d
    ON 
        i.ProductID = d.ProductID
    WHERE 
        i.Price <> d.Price;
END;

