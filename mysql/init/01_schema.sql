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
