/*
================================================================
 Archivo: Data.sql
 Desc:    Inserta datos de prueba en la BD "Gestor-He"
 Autor:   Angel Jarquin, Aracelly Castillo, Erick Zúniga
 Fecha:   9/11/2025
================================================================
*/

\echo 'Iniciando inserción de datos de prueba...'

-- =========== PASO 1: INSERTAR DATOS EN TABLAS "PADRE" ===========
-- (Tablas que no dependen de otras tablas)

\echo 'Poblando "Cliente"...'
INSERT INTO "Cliente" ("Nombre", "Telefono", "Correo") VALUES
('Juan Pérez', '88887777', 'juan@correo.com'),
('Ana López', '55554444', 'ana@correo.com'),
('Consumidor Final', '00000000', 'consumidor@final.com');

\echo 'Poblando "Mesa"...'
INSERT INTO "Mesa" ("NumeroMesa", "Capacidad", "Ocupada") VALUES
(1, 4, FALSE),
(2, 2, FALSE),
(3, 6, TRUE); -- (Una mesa ya ocupada)

\echo 'Poblando "Platillo"...'
INSERT INTO "Platillo" ("Nombre", "Descripcion", "Precio") VALUES
('Hamburguesa Clásica', 'Torta de res, queso, lechuga, tomate', 150.00),
('Ensalada César', 'Pollo a la plancha y aderezo césar', 120.50),
('Sopa de Pollo', 'Caldo de pollo y verduras', 80.00);

\echo 'Poblando "Proveedor"...'
INSERT INTO "Proveedor" ("nombre", "telefono", "correo") VALUES
('Carnes S.A.', '22223333', 'ventas@carnes.com'),
('Vegetales Frescos', '44445555', 'pedidos@vegetales.com');

\echo 'Poblando "Ingrediente"...'
INSERT INTO "Ingrediente" ("nombre", "unidad_de_medida", "stock") VALUES
('Torta de Res', 'unidad', 50),
('Lechuga', 'libra', 20),
('Tomate', 'libra', 30),
('Pechuga de Pollo', 'libra', 40);

\echo 'Poblando "Empleado"...'
-- (Contraseña es '12345'. Django la encriptaría, pero para SQL puro la ponemos en texto)
INSERT INTO "Empleado" ("Nombre", "Apellido", "Telefono", "Correo", "Cedula", "Rol", "Usuario", "password") VALUES
('Carlos', 'Ruiz', '77778888', 'carlos@restaurante.com', '001-010190-0001A', 'Mesero', 'carlosr', '12345'),
('Maria', 'Solis', '88889999', 'maria@restaurante.com', '001-010190-0002B', 'Cocinero', 'marias', '12345'),
('Admin', 'User', '12345678', 'admin@restaurante.com', '001-000000-0000X', 'Administrador', 'admin', 'admin123');


-- =========== PASO 2: INSERTAR DATOS EN TABLAS "HIJO" ===========
-- (Tablas que SÍ dependen de los IDs que acabamos de crear)

\echo 'Poblando "Pedido"...'
-- Pedido 1: De Juan Pérez (Cliente ID=1) en la Mesa 1 (Mesa ID=1)
INSERT INTO "Pedido" ("IdCliente_id", "IdMesa_id", "MetodoPago", "MontoTotal") VALUES
(1, 1, 'Efectivo', 270.50); -- Este pedido será el ID=1

-- Pedido 2: De Ana López (Cliente ID=2) en la Mesa 3 (Mesa ID=3)
INSERT INTO "Pedido" ("IdCliente_id", "IdMesa_id", "MetodoPago", "MontoTotal") VALUES
(2, 3, 'Tarjeta', 80.00); -- Este pedido será el ID=2


\echo 'Poblando "Pedido_Platillo"...'
-- Asignar los platillos al Pedido 1 (Hamburguesa y Ensalada)
INSERT INTO "Pedido_Platillo" ("IdPedido_id", "IdPlatillo_id", "Cantidad", "Estado") VALUES
(1, 1, 1, 'Listo'), -- Pedido 1, Hamburguesa (ID=1), 1 unidad, Estado 'Listo'
(1, 2, 1, 'Servido'); -- Pedido 1, Ensalada (ID=2), 1 unidad, Estado 'Servido'

-- Asignar platillos al Pedido 2 (Sopa)
INSERT INTO "Pedido_Platillo" ("IdPedido_id", "IdPlatillo_id", "Cantidad", "Estado") VALUES
(2, 3, 1, 'Registrado'); -- Pedido 2, Sopa (ID=3), 1 unidad, Estado 'Registrado'


\echo 'Poblando "Empleado_Pedido"...'
-- Asignar el Mesero (Empleado ID=1, 'carlosr') al Pedido 1
INSERT INTO "Empleado_Pedido" ("IdEmpleado_id", "IdPedido_id") VALUES
(1, 1);

-- Asignar el Mesero (Empleado ID=1, 'carlosr') al Pedido 2 también
INSERT INTO "Empleado_Pedido" ("IdEmpleado_id", "IdPedido_id") VALUES
(1, 2);


\echo 'Poblando "Platillo_Ingrediente"...'
-- Asignar ingredientes a la Hamburguesa (Platillo ID=1)
INSERT INTO "Platillo_Ingrediente" ("IdPlatillo_id", "IdIngrediente_id", "cantidad_usada") VALUES
(1, 1, 1),  -- Hamburguesa usa 1 Torta de Res (ID=1)
(1, 2, 0.1); -- Hamburguesa usa 0.1 libras de Lechuga (ID=2)

-- Asignar ingredientes a la Ensalada (Platillo ID=2)
INSERT INTO "Platillo_Ingrediente" ("IdPlatillo_id", "IdIngrediente_id", "cantidad_usada") VALUES
(2, 4, 0.5), -- Ensalada usa 0.5 libras de Pechuga de Pollo (ID=4)
(2, 2, 0.2); -- Ensalada usa 0.2 libras de Lechuga (ID=2)


\echo 'Poblando "Ingrediente_Proveedor"...'
-- Asignar proveedor al ingrediente 'Torta de Res'
INSERT INTO "Ingrediente_Proveedor" ("IdIngrediente_id", "IdProveedor_id") VALUES
(1, 1); -- Torta de Res (ID=1) es de Carnes S.A. (ID=1)

-- Asignar proveedor al ingrediente 'Lechuga'
INSERT INTO "Ingrediente_Proveedor" ("IdIngrediente_id", "IdProveedor_id") VALUES
(2, 2); -- Lechuga (ID=2) es de Vegetales Frescos (ID=2)


-- =========== PASO 3: VERIFICAR DATOS ===========
\echo 'Verificando datos insertados...'

SELECT * FROM "Cliente";
SELECT * FROM "Mesa";
SELECT * FROM "Platillo";
SELECT * FROM "Pedido";
SELECT * FROM "Pedido_Platillo" WHERE "IdPedido_id" = 1;


\echo '-----------------------------------------------'
\echo '¡Script Data.sql completado con éxito!'
\echo '-----------------------------------------------'
