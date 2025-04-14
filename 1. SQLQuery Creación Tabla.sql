-- 1. Seleccionar la base de datos RetailTransaction. La base de datos ya existe.

USE RetailTransaction;

-- 2. Verificar si la tabla no existe antes de crearla.

IF OBJECT_ID(N'RetailTransactionTable', N'U') IS NULL
BEGIN

-- 3. Crear la estructura de la tabla.

CREATE TABLE RetailTransactionTable (
    CustomerID INT,
    ProductID CHAR(1),
    Quantity INT,
    Price DECIMAL(10,2),
    TransactionDate DATETIME,
    PaymentMethod VARCHAR(50),
    StoreLocation VARCHAR(255),
    ProductCategory VARCHAR(100),
    DiscountApplied DECIMAL(5,2),
    TotalAmount DECIMAL(10,2)
);
END;

-- 4. Configurar formato de fecha para coincidir con el CSV (MM/dd/yyyy).

SET DATEFORMAT MDY;
GO

 -- 5. Importar datos usando BULK INSERT.

BULK INSERT dbo.RetailTransactionTable
FROM 'C:\Users\josue\Desktop\Análisis de datos\Proyectos\SQL\Retail_Transaction_Dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',     -- Salto de línea tipo UNIX
    FIELDQUOTE = '"',           -- Para campos con comas internas
    FIRSTROW = 2,               -- El CSV tiene encabezados, empezar en la fila 2
    CODEPAGE = '65001'          -- Codificación UTF-8
);
GO

-- 6. Comprobar que los datos se han importado sin errores.

SELECT *
FROM RetailTransaction.dbo.RetailTransactionTable