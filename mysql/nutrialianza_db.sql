CREATE DATABASE IF NOT EXISTS nutrialianza_db;
USE nutrialianza_db;

CREATE TABLE IF NOT EXISTS formulas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_formula VARCHAR(100) NOT NULL,
    ingrediente_principal VARCHAR(100) NOT NULL,
    cantidad_kg DECIMAL(10,2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    stock_kg DECIMAL(10,2) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

INSERT INTO formulas (nombre_formula, ingrediente_principal, cantidad_kg)
VALUES
('Formula Engorde A', 'Maiz', 500.00),
('Formula Lechera B', 'Soya', 350.00),
('Formula Avicola C', 'Trigo', 420.00);

INSERT INTO inventario (producto, stock_kg, ubicacion)
VALUES
('Maiz', 15000.00, 'Bodega Central'),
('Soya', 9000.00, 'Bodega Central'),
('Trigo', 12000.00, 'Bodega Norte');
USE nutrialianza_db;

-- ============================================================

-- NutriAlianza S.A.

-- Generación reproducible de 335,000 registros de fórmulas

-- ============================================================

-- Elimina los registros de prueba existentes y reinicia el ID.

TRUNCATE TABLE formulas;

-- Genera exactamente 335,000 fórmulas.

INSERT INTO formulas (

    nombre_formula,

    ingrediente_principal,

    cantidad_kg,

    fecha_creacion

)

SELECT

    CASE

        WHEN numero = 1 THEN 'Formula Engorde A'

        WHEN numero = 2 THEN 'Formula Lechera B'

        WHEN numero = 3 THEN 'Formula Avicola C'

        ELSE CONCAT(

            'Formula NutriAlianza ',

            LPAD(numero, 6, '0')

        )

    END AS nombre_formula,

    CASE MOD(numero - 1, 10)

        WHEN 0 THEN 'Maiz'

        WHEN 1 THEN 'Soya'

        WHEN 2 THEN 'Trigo'

        WHEN 3 THEN 'Sorgo'

        WHEN 4 THEN 'Cebada'

        WHEN 5 THEN 'Avena'

        WHEN 6 THEN 'Harina de pescado'

        WHEN 7 THEN 'Melaza'

        WHEN 8 THEN 'Sal mineral'

        ELSE 'Calcio'

    END AS ingrediente_principal,

    CASE

        WHEN numero = 1 THEN 500.00

        WHEN numero = 2 THEN 350.00

        WHEN numero = 3 THEN 420.00

        ELSE ROUND(

            100 + MOD(numero * 37, 490001) / 100,

            2

        )

    END AS cantidad_kg,

    TIMESTAMPADD(

        SECOND,

        MOD(numero * 113, 31536000),

        '2025-01-01 00:00:00'

    ) AS fecha_creacion

FROM (

    SELECT

        ones.n

        + tens.n * 10

        + hundreds.n * 100

        + thousands.n * 1000

        + ten_thousands.n * 10000

        + hundred_thousands.n * 100000

        + 1 AS numero

    FROM

        (

            SELECT 0 AS n UNION ALL

            SELECT 1 UNION ALL

            SELECT 2 UNION ALL

            SELECT 3 UNION ALL

            SELECT 4 UNION ALL

            SELECT 5 UNION ALL

            SELECT 6 UNION ALL

            SELECT 7 UNION ALL

            SELECT 8 UNION ALL

            SELECT 9

        ) AS ones

    CROSS JOIN

        (

            SELECT 0 AS n UNION ALL

            SELECT 1 UNION ALL

            SELECT 2 UNION ALL

            SELECT 3 UNION ALL

            SELECT 4 UNION ALL

            SELECT 5 UNION ALL

            SELECT 6 UNION ALL

            SELECT 7 UNION ALL

            SELECT 8 UNION ALL

            SELECT 9

        ) AS tens

    CROSS JOIN

        (

            SELECT 0 AS n UNION ALL

            SELECT 1 UNION ALL

            SELECT 2 UNION ALL

            SELECT 3 UNION ALL

            SELECT 4 UNION ALL

            SELECT 5 UNION ALL

            SELECT 6 UNION ALL

            SELECT 7 UNION ALL

            SELECT 8 UNION ALL

            SELECT 9

        ) AS hundreds

    CROSS JOIN

        (

            SELECT 0 AS n UNION ALL

            SELECT 1 UNION ALL

            SELECT 2 UNION ALL

            SELECT 3 UNION ALL

            SELECT 4 UNION ALL

            SELECT 5 UNION ALL

            SELECT 6 UNION ALL

            SELECT 7 UNION ALL

            SELECT 8 UNION ALL

            SELECT 9

        ) AS thousands

    CROSS JOIN

        (

            SELECT 0 AS n UNION ALL

            SELECT 1 UNION ALL

            SELECT 2 UNION ALL

            SELECT 3 UNION ALL

            SELECT 4 UNION ALL

            SELECT 5 UNION ALL

            SELECT 6 UNION ALL

            SELECT 7 UNION ALL

            SELECT 8 UNION ALL

            SELECT 9

        ) AS ten_thousands

    CROSS JOIN

        (

            SELECT 0 AS n UNION ALL

            SELECT 1 UNION ALL

            SELECT 2 UNION ALL

            SELECT 3 UNION ALL

            SELECT 4 UNION ALL

            SELECT 5 UNION ALL

            SELECT 6 UNION ALL

            SELECT 7 UNION ALL

            SELECT 8 UNION ALL

            SELECT 9

        ) AS hundred_thousands

) AS secuencia

WHERE numero <= 335000
ORDER BY numero;

-- Verificación automática al finalizar.

SELECT COUNT(*) AS total_formulas

FROM formulas;

SELECT

    MIN(id) AS primer_id,

    MAX(id) AS ultimo_id

FROM formulas;
