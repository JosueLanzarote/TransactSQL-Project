-- Limpieza de datos: La base de datos que estamos usando esta completa y no necesita aplicar técnicas de limpieza.

-- Validación de Integridad Estructural.

-- 1. No permitir valores nulos en las columnas CustomerID, TransactionDate.

ALTER TABLE [RetailTransaction].[dbo].[RetailTransactionTable]
ALTER COLUMN CustomerID INT NOT NULL;

ALTER TABLE [RetailTransaction].[dbo].[RetailTransactionTable]
ALTER COLUMN TransactionDate DATETIME NOT NULL;

-- 2. Agregar restricciones a la tabla RetailTransactionTable.

ALTER TABLE [RetailTransaction].[dbo].[RetailTransactionTable]
ADD CONSTRAINT PK_Transaction PRIMARY KEY (CustomerID, TransactionDate),	-- Clave primaria como combinación de las dos variables.
    CONSTRAINT CHK_Quantity CHECK (Quantity > 0),	-- Quantitity debe ser mayor a 0, evita registros con valores inválidos o negativos en esta columna.
    CONSTRAINT CHK_Price CHECK (Price BETWEEN 0.01 AND 10000), --Validar que (Price) esté dentro de un rango razonable.
    CONSTRAINT CHK_Discount CHECK (DiscountApplied BETWEEN 0 AND 100);	-- validar que (DiscountApplied) esté dentro del rango permitido entre 0% y 100%. Esto evita valores fuera de rango, como descuentos negativos o superiores al 100%.

-- 3. Actualizar formato de fecha a ISO 8601 (YYYY-MM-DD).

UPDATE [RetailTransaction].[dbo].[RetailTransactionTable]
SET TransactionDate = CONVERT(DATETIME, TransactionDate, 103)
WHERE ISDATE(TransactionDate) = 1;


-- 4. Eliminar transacciones con fechas inválidas.

DELETE FROM [RetailTransaction].[dbo].[RetailTransactionTable]
WHERE ISDATE(TransactionDate) = 0;

-- 5. Consolidar métodos de pago no reconocidos.

UPDATE [RetailTransaction].[dbo].[RetailTransactionTable]
SET PaymentMethod = 'Unknown'
WHERE PaymentMethod NOT IN ('Cash', 'Credit Card', 'Debit Card', 'Paypal');

-- 6. Dividir la columna 'StoreLocation' en tres: 'AddressPart', 'StateLocation' y 'Zipcode'

-- 6.1. Prueba para comprobar que funciona:

SELECT
    StoreLocation,
    -- Dirección (excluyendo los últimos 8 caracteres)
    CASE 
        WHEN LEN(StoreLocation) > 8 
        THEN LEFT(StoreLocation, LEN(StoreLocation) - 8)
        ELSE NULL 
    END AS AddressPart,
    -- Estado (primeros 2 caracteres de StateZip)
    SUBSTRING(RIGHT(StoreLocation, 8), 1, 2) AS StateLocation,
    -- Código postal (últimos 5 caracteres de StateZip)
    SUBSTRING(RIGHT(StoreLocation, 8), 4, 5) AS ZipCode
FROM [RetailTransaction].[dbo].[RetailTransactionTable]
ORDER BY StateLocation;

	-- 6.2. Agregar las nuevas columnas.

ALTER TABLE [RetailTransaction].[dbo].[RetailTransactionTable]
ADD AddressPart NVARCHAR(MAX),
    StateLocation NVARCHAR(2),
    ZipCode NVARCHAR(5);

	-- 6.3. Actualizar las nuevas columnas con los valores calculados.

UPDATE [RetailTransaction].[dbo].[RetailTransactionTable]
SET AddressPart = CASE 
                    WHEN LEN(StoreLocation) > 8 
                    THEN LEFT(StoreLocation, LEN(StoreLocation) - 8)
                    ELSE NULL 
                 END,
    StateLocation = SUBSTRING(RIGHT(StoreLocation, 8), 1, 2),
    ZipCode = SUBSTRING(RIGHT(StoreLocation, 8), 4, 5);

-- 7. Comprobar si muestra los cambios aplicados:

SELECT *
FROM RetailTransaction.dbo.RetailTransactionTable;
