-- Consulta simple (todas las columnas de una tabla)
SELECT * FROM platillo;

-- Consulta con columnas específicas y filtro (WHERE)
SELECT nombre, precio
FROM platillo
WHERE precio > 100;

-- Consulta con Unión (JOIN)
SELECT
    p.idpedido,
    p.fecha,
    c.nombre AS nombrecliente
FROM
    pedido AS p
JOIN
    cliente AS c ON p.idcliente_id = c.idcliente;

-- Consulta con Agregación (GROUP BY) y Orden (ORDER BY)
SELECT
    e.usuario AS mesero,
    COUNT(ep.idpedido_id) AS totalpedidosatendidos
FROM
    empleado AS e
JOIN
    empleado_pedido AS ep ON e.idempleado = ep.idempleado_id
GROUP BY
    e.usuario
ORDER BY
    totalpedidosatendidos DESC;
