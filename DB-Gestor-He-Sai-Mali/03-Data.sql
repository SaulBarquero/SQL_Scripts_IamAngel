-- =========== 3. INSERCIÓN DE DATOS DE PRUEBA ===========

-- Clientes
INSERT INTO cliente (nombre, telefono, correo) VALUES
('Juan Pérez', '88887777', 'juan@correo.com'),
('Ana López', '55554444', 'ana@correo.com'),
('Consumidor Final', '00000000', 'consumidor@final.com');

-- Mesas
INSERT INTO mesa (numeromesa, capacidad, ocupada) VALUES
(1, 4, FALSE),
(2, 2, FALSE),
(3, 6, TRUE);

-- Platillos
INSERT INTO platillo (nombre, descripcion, precio) VALUES
('Hamburguesa Clásica', 'Torta de res, queso, lechuga, tomate', 150.00),
('Ensalada César', 'Pollo a la plancha y aderezo césar', 120.50),
('Sopa de Pollo', 'Caldo de pollo y verduras', 80.00);

-- Proveedores
INSERT INTO proveedor (nombre, telefono, correo) VALUES
('Carnes S.A.', '22223333', 'ventas@carnes.com'),
('Vegetales Frescos', '44445555', 'pedidos@vegetales.com');

-- Ingredientes
INSERT INTO ingrediente (nombre, unidad_de_medida, stock) VALUES
('Torta de Res', 'unidad', 50),
('Lechuga', 'libra', 20),
('Tomate', 'libra', 30),
('Pechuga de Pollo', 'libra', 40);

-- Empleados
INSERT INTO empleado (nombre, apellido, telefono, correo, cedula, rol, usuario, password) VALUES
('Carlos', 'Ruiz', '77778888', 'carlos@restaurante.com', '001-010190-0001A', 'Mesero', 'carlosr', '12345'),
('Maria', 'Solis', '88889999', 'maria@restaurante.com', '001-010190-0002B', 'Cocinero', 'marias', '12345'),
('Admin', 'User', '12345678', 'admin@restaurante.com', '001-000000-0000X', 'Administrador', 'admin', 'admin123');

-- Pedidos (Usando los IDs creados arriba)
INSERT INTO pedido (idcliente_id, idmesa_id, metodopago, montototal) VALUES
(1, 1, 'Efectivo', 270.50), -- Pedido 1
(2, 3, 'Tarjeta', 80.00);    -- Pedido 2

-- Items del Pedido (pedido_platillo)
INSERT INTO pedido_platillo (idpedido_id, idplatillo_id, cantidad, estado) VALUES
(1, 1, 1, 'Listo'),     -- Pedido 1, Hamburguesa
(1, 2, 1, 'Servido'),   -- Pedido 1, Ensalada
(2, 3, 1, 'Registrado'); -- Pedido 2, Sopa

-- Asignación de Meseros (empleado_pedido)
INSERT INTO empleado_pedido (idempleado_id, idpedido_id) VALUES
(1, 1), -- Carlos atiende Pedido 1
(1, 2); -- Carlos atiende Pedido 2

-- Recetas (platillo_ingrediente)
INSERT INTO platillo_ingrediente (idplatillo_id, idingrediente_id, cantidad_usada) VALUES
(1, 1, 1),   -- Hamburguesa usa 1 Torta de Res
(1, 2, 0.1), -- Hamburguesa usa 0.1 Lechuga
(2, 4, 0.5), -- Ensalada usa 0.5 Pechuga de Pollo
(2, 2, 0.2); -- Ensalada usa 0.2 Lechuga

-- Suministros (ingrediente_proveedor)
INSERT INTO ingrediente_proveedor (idingrediente_id, idproveedor_id) VALUES
(1, 1), -- Torta de Res es de Carnes S.A.
(2, 2); -- Lechuga es de Vegetales Frescos
