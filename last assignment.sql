SELECT * FROM `e-commerce customer churn analysis`.customer_churn;
UPDATE your_table_name
SET WarehouseToHome = (
    SELECT ROUND(avg_value)
    FROM (
        SELECT AVG(WarehouseToHome) AS avg_value
        FROM your_table_name
    ) AS temp
)
WHERE WarehouseToHome IS NULL;

UPDATE your_table_name
SET WarehouseToHome = (
    SELECT avg_value FROM (
        SELECT ROUND(AVG(WarehouseToHome)) AS avg_value
        FROM your_table_name
    ) AS temp
)
WHERE WarehouseToHome IS NULL;

UPDATE your_table_name
SET HourSpendOnApp = (
    SELECT avg_value FROM (
        SELECT ROUND(AVG(HourSpendOnApp)) AS avg_value
        FROM your_table_name
    ) AS temp
)
WHERE HourSpendOnApp IS NULL;

UPDATE your_table_name
SET OrderAmountHikeFromlastYear = (
    SELECT avg_value FROM (
        SELECT ROUND(AVG(OrderAmountHikeFromlastYear)) AS avg_value
        FROM your_table_name
    ) AS temp
)
WHERE OrderAmountHikeFromlastYear IS NULL;

UPDATE your_table_name
SET DaySinceLastOrder = (
    SELECT avg_value FROM (
        SELECT ROUND(AVG(DaySinceLastOrder)) AS avg_value
        FROM your_table_name
    ) AS temp
)
WHERE DaySinceLastOrder IS NULL;

SELECT
    SUM(WarehouseToHome IS NULL) AS WarehouseToHome_Null,
    SUM(HourSpendOnApp IS NULL) AS HourSpendOnApp_Null,
    SUM(OrderAmountHikeFromlastYear IS NULL) AS OrderAmountHike_Null,
    SUM(DaySinceLastOrder IS NULL) AS DaySinceLastOrder_Null
FROM your_table_name;



UPDATE your_table_name
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';

UPDATE your_table_name
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';


SELECT DISTINCT PreferredLoginDevice
FROM your_table_name;

SELECT DISTINCT PreferedOrderCat
FROM your_table_name;


UPDATE your_table_name
SET PreferredPaymentMode = CASE
    WHEN PreferredPaymentMode = 'COD' THEN 'Cash on Delivery'
    WHEN PreferredPaymentMode = 'CC' THEN 'Credit Card'
    ELSE PreferredPaymentMode
END
WHERE PreferredPaymentMode IN ('COD', 'CC');



SELECT DISTINCT PreferredPaymentMode
FROM your_table_name;





ALTER TABLE your_table_name
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;

ALTER TABLE your_table_name
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;

DESCRIBE your_table_name;


ALTER TABLE your_table_name
ADD COLUMN ComplaintReceived VARCHAR(3);

UPDATE your_table_name
SET ComplaintReceived = CASE
    WHEN Complain = 1 THEN 'Yes'
    ELSE 'No'
END;
ALTER TABLE your_table_name
ADD COLUMN ChurnStatus VARCHAR(10);

UPDATE your_table_name
SET ChurnStatus = CASE
    WHEN Churn = 1 THEN 'Churned'
    ELSE 'Active'
END;


SELECT Complain, ComplaintReceived, Churn, ChurnStatus
FROM your_table_name;


ALTER TABLE your_table_name
DROP COLUMN Churn,
DROP COLUMN Complain;


DESCRIBE your_table_name;


SELECT
    ChurnStatus,
    COUNT(*) AS CustomerCount
FROM your_table_name
GROUP BY ChurnStatus;


SELECT
    AVG(Tenure) AS AverageTenure,
    SUM(CashbackAmount) AS TotalCashbackAmount
FROM your_table_name
WHERE ChurnStatus = 'Churned';


SELECT
    ROUND(
        SUM(CASE WHEN ComplaintReceived = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS ComplaintPercentage
FROM your_table_name
WHERE ChurnStatus = 'Churned';

SELECT
    CityTier,
    COUNT(*) AS ChurnedCustomerCount
FROM your_table_name
WHERE ChurnStatus = 'Churned'
  AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY ChurnedCustomerCount DESC
LIMIT 1;

SELECT
    PreferredPaymentMode,
    COUNT(*) AS CustomerCount
FROM your_table_name
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY CustomerCount DESC
LIMIT 1;

SELECT
    SUM(OrderAmountHikeFromlastYear) AS TotalOrderAmountHike
FROM your_table_name
WHERE MaritalStatus = 'Single'
  AND PreferredOrderCat = 'Mobile Phone';
  
 SELECT
    AVG(NumberOfDeviceRegistered) AS AverageDevicesRegistered
FROM your_table_name
WHERE PreferredPaymentMode = 'UPI';

SELECT
    CityTier,
    COUNT(*) AS CustomerCount
FROM your_table_name
GROUP BY CityTier
ORDER BY CustomerCount DESC
LIMIT 1;

SELECT
    Gender,
    SUM(CouponUsed) AS TotalCouponsUsed
FROM your_table_name
GROUP BY Gender
ORDER BY TotalCouponsUsed DESC
LIMIT 1;

SELECT
    PreferredOrderCat,
    COUNT(*) AS CustomerCount,
    MAX(HoursSpentOnApp) AS MaxHoursSpentOnApp
FROM your_table_name
GROUP BY PreferredOrderCat;

SELECT
    SUM(OrderCount) AS TotalOrderCount
FROM your_table_name
WHERE PreferredPaymentMode = 'Credit Card'
  AND SatisfactionScore = (
      SELECT MAX(SatisfactionScore)
      FROM your_table_name
  );
  
  SELECT
    ROUND(AVG(SatisfactionScore), 2) AS AverageSatisfactionScore
FROM your_table_name
WHERE ComplaintReceived = 'Yes';

SELECT
    PreferredOrderCat,
    COUNT(*) AS CustomerCount
FROM your_table_name
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat;

SELECT
    PreferredOrderCat,
    ROUND(AVG(CashbackAmount), 2) AS AverageCashback
FROM your_table_name
GROUP BY PreferredOrderCat
ORDER BY AverageCashback DESC
LIMIT 3;

SELECT
    PreferredPaymentMode,
    AVG(Tenure) AS AverageTenure,
    SUM(OrderCount) AS TotalOrders
FROM your_table_name
GROUP BY PreferredPaymentMode
HAVING AVG(Tenure) = 10
   AND SUM(OrderCount) > 500;
   
   SELECT
    CASE
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS DistanceCategory,
    ChurnStatus,
    COUNT(*) AS CustomerCount
FROM your_table_name
GROUP BY DistanceCategory, ChurnStatus
ORDER BY
    CASE DistanceCategory
        WHEN 'Very Close Distance' THEN 1
        WHEN 'Close Distance' THEN 2
        WHEN 'Moderate Distance' THEN 3
        WHEN 'Far Distance' THEN 4
    END,
    ChurnStatus;
    
    SELECT *
FROM your_table_name
WHERE MaritalStatus = 'Married'
  AND CityTier = 1
  AND OrderCount > (
      SELECT AVG(OrderCount)
      FROM your_table_name
  );
  
  
  USE ecomm;
  CREATE TABLE customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount DECIMAL(10,2)
);
INSERT INTO customer_returns
    (ReturnID, CustomerID, ReturnDate, RefundAmount)
VALUES
    (1001, 50022, '2023-01-01', 2130),
    (1002, 50316, '2023-01-23', 2000),
    (1003, 51099, '2023-02-14', 2290),
    (1004, 52321, '2023-03-08', 2510),
    (1005, 52928, '2023-03-20', 3000),
    (1006, 53749, '2023-04-17', 1740),
    (1007, 54206, '2023-04-21', 3250),
    (1008, 54838, '2023-04-30', 1990);
    
    
    SELECT * FROM customer_returns;
    
    SELECT
    cr.ReturnID,
    cr.CustomerID,
    cr.ReturnDate,
    cr.RefundAmount,
    e.* 
FROM customer_returns AS cr
INNER JOIN your_table_name AS e
    ON cr.CustomerID = e.CustomerID
WHERE e.ChurnStatus = 'Churned'
  AND e.ComplaintReceived = 'Yes';