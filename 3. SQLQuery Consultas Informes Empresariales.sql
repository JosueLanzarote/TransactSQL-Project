-- Ejemplos de Consultas para Informes Empresariales.

-- 1. Informe de Ventas por Categor�a.

SELECT 
    ProductCategory,
    SUM(Quantity) AS TotalUnidades,
    SUM(TotalAmount) AS VentasTotales,
    AVG(DiscountApplied) AS DescuentoPromedio
FROM [RetailTransaction].[dbo].[RetailTransactionTable]
GROUP BY ProductCategory
ORDER BY VentasTotales DESC;

-- 2. An�lisis de M�todos de Pago.

SELECT 
    PaymentMethod,
    COUNT(*) AS Transacciones,
    ROUND(SUM(TotalAmount), 0) AS MontoTotal,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 2) AS PorcentajeParticipaci�n -- Divide el n�mero de transacciones del m�todo espec�fico entre el total global y lo multiplica por 100 para obtener el porcentaje.
FROM [RetailTransaction].[dbo].[RetailTransactionTable]
GROUP BY PaymentMethod;

-- 3. Comparar el crecimiento de los rendimientos mensuales por estado.

WITH VentasPorEstado AS (	-- CTE (Common Table Expression) para calcular las ventas mensuales por estado.
    SELECT 
        StateLocation,
        DATEPART(MONTH, TransactionDate) AS Mes,	 -- Extrae el mes de la fecha de la transacci�n.
        SUM(TotalAmount) AS Ventas
    FROM [RetailTransaction].[dbo].[RetailTransactionTable]
    GROUP BY StateLocation, DATEPART(MONTH, TransactionDate)	-- Agrupa por estado y mes para sumar las ventas.
)
SELECT	-- Consulta principal que utiliza el CTE para calcular el crecimiento mensual de las ventas por estado.
    StateLocation,
    Mes,
    Ventas,
    Ventas - LAG(Ventas) OVER (PARTITION BY StateLocation ORDER BY Mes) AS CrecimientoMensual	-- Calcula el crecimiento mensual comparando las ventas actuales con las del mes anterior. Usando la funci�n LAG para obtener el valor previo dentro del mismo estado (PARTITION BY StateLocation).
FROM VentasPorEstado;

-- 3. Auditor�a sobre descuentos aplicados.

SELECT 
    CASE 
        WHEN DiscountApplied > 10 THEN 'Alto Descuento'
        WHEN DiscountApplied BETWEEN 3 AND 10 THEN 'Medio'
        ELSE 'Est�ndar'
    END AS Segmento,
    COUNT(*) AS Ocurrencias
FROM [RetailTransaction].[dbo].[RetailTransactionTable]
GROUP BY 
    CASE 
        WHEN DiscountApplied > 10 THEN 'Alto Descuento'
        WHEN DiscountApplied BETWEEN 3 AND 10 THEN 'Medio'
        ELSE 'Est�ndar'
    END
ORDER BY Segmento;