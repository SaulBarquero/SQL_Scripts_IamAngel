-- =========== . CREACIÓN Y USO DE VISTAS ===========

DROP VIEW IF EXISTS vistapedidosdetallados;
DROP VIEW IF EXISTS vistasumencliente;
DROP VIEW IF EXISTS vistareportemeseros;

-- VISTA 1: Pedidos con todos los detalles
CREATE VIEW vistapedidosdetallados AS
SELECT
    p.idpedido,
    p.fecha,
    c.nombre AS cliente,
    m.numeromesa AS mesa,
    pl.nombre AS platillo,
    pp.cantidad,
    pp.estado
FROM
    pedido AS p
LEFT JOIN
    cliente AS c ON p.idcliente_id = c.idcliente
LEFT JOIN
    mesa AS m ON p.idmesa_id = m.idmesa
LEFT JOIN
    pedido_platillo AS pp ON p.idpedido = pp.idpedido_id
LEFT JOIN
    platillo AS pl ON pp.idplatillo_id = pl.idplatillo;

-- VISTA 2: Reporte de gastos por cliente
CREATE VIEW vistasumencliente AS
SELECT
    c.nombre AS cliente,
    COUNT(p.idpedido) AS numerodepedidos,
    SUM(p.montototal) AS totalgastado
FROM
    cliente AS c
JOIN
    pedido AS p ON c.idcliente = p.idcliente_id
GROUP BY
    c.nombre
ORDER BY
    totalgastado DESC;

-- VISTA 3: Reporte de desempeño de meseros
CREATE VIEW vistareportemeseros AS
SELECT
    e.usuario AS mesero,
    e.nombre,
    e.apellido,
    COUNT(ep.idpedido_id) AS totalpedidosatendidos
FROM
    empleado AS e
JOIN
    empleado_pedido AS ep ON e.idempleado = ep.idempleado_id
WHERE
    e.rol ILIKE 'Mesero'
GROUP BY
    e.idempleado, e.usuario, e.nombre, e.apellido
ORDER BY
    totalpedidosatendidos DESC;
