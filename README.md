# 📊 Proyecto TSQL: Análisis de Transacciones Minoristas
![SQL Badge](https://img.shields.io/badge/TSQL-Server-blue)

![Database Badge](https://img.shields.io/badge/Database-Relational-green)

![ETL Badge](https://img.shields.io/badge/Process-ETL-orange)

## Descripción del Proyecto

Este proyecto TSQL demuestra habilidades avanzadas en gestión de bases de datos, incluyendo creación de tablas, importación de datos, limpieza de datos y aplicación de restricciones de integridad. El objetivo es procesar y analizar datos de transacciones minoristas para garantizar su calidad y utilidad en análisis empresarial.

## Habilidades Demostradas

1. **Diseño y Creación de Bases de Datos**:
   - Creación de tablas con estructura adecuada para almacenar datos de transacciones
   - Verificación previa de existencia de tablas para evitar errores

2. **Importación de Datos**:
   - Uso de `BULK INSERT` para cargar eficientemente datos desde un archivo CSV
   - Configuración de formatos específicos (codificación UTF-8, delimitadores, saltos de línea)

3. **Limpieza y Transformación de Datos**:
   - Normalización de formatos de fecha (conversión a ISO 8601)
   - Eliminación de registros con fechas inválidas
   - Consolidación de categorías (métodos de pago no reconocidos)
   - División de campos compuestos (dirección, estado, código postal)

4. **Integridad de Datos**:
   - Implementación de restricciones NOT NULL en campos críticos
   - Definición de clave primaria compuesta
   - Aplicación de restricciones CHECK para validar rangos (cantidad, precio, descuentos)

5. **Documentación y Pruebas**:
   - Consultas de verificación después de cada modificación importante
   - Enfoque metódico con pruebas previas a implementaciones

## 🧵 Estructura del Proyecto

1. **Configuración Inicial**:
   - Selección de la base de datos RetailTransaction
   - Creación de la tabla RetailTransactionTable con estructura adecuada

2. **Carga de Datos**:
   - Importación desde archivo CSV con configuración específica
   - Verificación de la carga inicial

3. **Validación y Limpieza**:
   - Normalización de formatos
   - Eliminación de datos inválidos
   - Consolidación de categorías

4. **Mejora de Estructura**:
   - División de campos compuestos
   - Adición de nuevas columnas derivadas

## Cómo Utilizar

1. Ejecutar los scripts en orden secuencial
2. Verificar los resultados después de cada paso importante
3. Las consultas SELECT al final de cada sección permiten validar los cambios

## 📌 Resultados Clave
✅ Datos listos para análisis con calidad garantizada

✅ Estructura optimizada para consultas eficientes

✅ Sistema de restricciones que previene datos corruptos

✅ Documentación completa del proceso ETL

Este proyecto muestra competencia en manejo completo de bases de datos SQL Server, desde diseño hasta limpieza y optimización, habilidades valiosas para roles de analista de datos, ingeniero de datos o administrador de bases de datos.

📌 **Nota: Todos los scripts incluyen verificaciones intermedias para garantizar resultados consistentes.**
