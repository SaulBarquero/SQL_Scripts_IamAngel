/*
================================================================
 Archivo: Schema.sql
 Desc:    Crea toda la estructura (tablas) de la BD "Gestor-He"
 Autor:   Angel Jarquin, Aracelly Castillo, Erick Zúniga
 Fecha:   09/11/2025
================================================================
*/


-- =========== PASO 1: BORRAR TABLAS (EN ORDEN INVERSO) ===========
-- (Esto permite que el script se pueda ejecutar varias veces sin errores)

DROP TABLE IF EXISTS "Ingrediente_Proveedor" CASCADE;
DROP TABLE IF EXISTS "Platillo_Ingrediente" CASCADE;
DROP TABLE IF EXISTS "Empleado_Pedido" CASCADE;
DROP TABLE IF EXISTS "Pedido_Platillo" CASCADE;
DROP TABLE IF EXISTS "Pedido" CASCADE;
DROP TABLE IF EXISTS "Empleado" CASCADE;
DROP TABLE IF EXISTS "Ingrediente" CASCADE;
DROP TABLE IF EXISTS "Proveedor" CASCADE;
DROP TABLE IF EXISTS "Platillo" CASCADE;
DROP TABLE IF EXISTS "Mesa" CASCADE;
DROP TABLE IF EXISTS "Cliente" CASCADE;


-- =========== PASO 2: CREAR TABLAS PRINCIPALES (PADRES) ===========

-- 10. Modelo Cliente
CREATE TABLE "Cliente" (
    "IdCliente"     SERIAL PRIMARY KEY,
    "Nombre"        VARCHAR(100) NOT NULL,
    "Telefono"      VARCHAR(15) NULL,
    "Correo"        VARCHAR(100) NULL
);

-- 11. Modelo Mesa
CREATE TABLE "Mesa" (
    "IdMesa"        SERIAL PRIMARY KEY,
    "NumeroMesa"    INTEGER NOT NULL UNIQUE,
    "Capacidad"     INTEGER NOT NULL DEFAULT 4,
    "Ocupada"       BOOLEAN NOT NULL DEFAULT FALSE
);

-- 2. Modelo Platillo
CREATE TABLE "Platillo" (
    "IdPlatillo"    SERIAL PRIMARY KEY,
    "Nombre"        VARCHAR(100) NOT NULL UNIQUE,
    "Descripcion"   TEXT NULL,
    "Precio"        NUMERIC(10, 2) NOT NULL
);

-- 6. Modelo Proveedor
CREATE TABLE "Proveedor" (
    "IdProveedor"   SERIAL PRIMARY KEY,
    "nombre"        VARCHAR(100) NOT NULL UNIQUE,
    "telefono"      VARCHAR(15) NULL UNIQUE,
    "correo"        VARCHAR(254) NOT NULL UNIQUE
);

-- 7. Modelo Ingrediente
CREATE TABLE "Ingrediente" (
    "IdIngrediente"      SERIAL PRIMARY KEY,
    "nombre"             VARCHAR(100) NOT NULL UNIQUE,
    "unidad_de_medida"   VARCHAR(20) NOT NULL,
    "stock"              INTEGER NOT NULL DEFAULT 0
);

-- 1. Modelo Empleado
CREATE TABLE "Empleado" (
    "IdEmpleado"   SERIAL PRIMARY KEY,
    "Nombre"       VARCHAR(20) NOT NULL,
    "Apellido"     VARCHAR(20) NOT NULL,
    "Telefono"     VARCHAR(11) NULL,
    "Correo"       VARCHAR(254) NOT NULL UNIQUE,
    "Cedula"       VARCHAR(16) NOT NULL UNIQUE,
    "Rol"          VARCHAR(50) NOT NULL,
    "Usuario"      VARCHAR(50) NOT NULL UNIQUE,
    "password"     VARCHAR(128) NOT NULL, -- Django añade esto
    "last_login"   TIMESTAMPTZ NULL,      -- Django añade esto
    "is_active"    BOOLEAN NOT NULL DEFAULT TRUE,
    "is_staff"     BOOLEAN NOT NULL DEFAULT FALSE,
    "is_superuser" BOOLEAN NOT NULL DEFAULT FALSE,
    "date_joined"  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


-- =========== PASO 3: CREAR TABLAS INTERMEDIAS (HIJOS) ===========

-- 3. Modelo Pedido (Depende de Cliente y Mesa)
CREATE TABLE "Pedido" (
    "IdPedido"      SERIAL PRIMARY KEY,
    "Fecha"         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "MontoTotal"    NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    "MetodoPago"    VARCHAR(50) NULL,
    
    -- Foreign Keys (Django añade "_id" al nombre del campo)
    "IdCliente_id"  INTEGER NOT NULL,
    "IdMesa_id"     INTEGER NULL,

    FOREIGN KEY ("IdCliente_id") REFERENCES "Cliente"("IdCliente") ON DELETE CASCADE,
    FOREIGN KEY ("IdMesa_id") REFERENCES "Mesa"("IdMesa") ON DELETE SET NULL
);

-- 4. Modelo Pedido_Platillo (Depende de Pedido y Platillo)
CREATE TABLE "Pedido_Platillo" (
    "IdPedido_Platillo" SERIAL PRIMARY KEY,
    "Estado"            VARCHAR(20) NOT NULL DEFAULT 'Registrado',
    "Cantidad"          INTEGER NOT NULL DEFAULT 1,
    
    -- Foreign Keys
    "IdPedido_id"       INTEGER NOT NULL,
    "IdPlatillo_id"     INTEGER NOT NULL,

    FOREIGN KEY ("IdPedido_id") REFERENCES "Pedido"("IdPedido") ON DELETE CASCADE,
    FOREIGN KEY ("IdPlatillo_id") REFERENCES "Platillo"("IdPlatillo") ON DELETE RESTRICT
);

-- 5. Modelo Empleado_Pedido (Depende de Empleado y Pedido)
CREATE TABLE "Empleado_Pedido" (
    "IdEmpleado_Pedido" SERIAL PRIMARY KEY,
    "FechaAsignacion"   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Foreign Keys
    "IdEmpleado_id"     INTEGER NOT NULL,
    "IdPedido_id"       INTEGER NOT NULL,

    FOREIGN KEY ("IdEmpleado_id") REFERENCES "Empleado"("IdEmpleado") ON DELETE RESTRICT,
    FOREIGN KEY ("IdPedido_id") REFERENCES "Pedido"("IdPedido") ON DELETE CASCADE,
    
    -- Restricción Única
    UNIQUE ("IdEmpleado_id", "IdPedido_id")
);

-- 8. Modelo Platillo_Ingrediente (Depende de Platillo e Ingrediente)
CREATE TABLE "Platillo_Ingrediente" (
    "IdPlatillo_Ingrediente" SERIAL PRIMARY KEY,
    "cantidad_usada"         NUMERIC(10, 2) NOT NULL,

    -- Foreign Keys
    "IdPlatillo_id"          INTEGER NOT NULL,
    "IdIngrediente_id"       INTEGER NOT NULL,
    
    FOREIGN KEY ("IdPlatillo_id") REFERENCES "Platillo"("IdPlatillo") ON DELETE CASCADE,
    FOREIGN KEY ("IdIngrediente_id") REFERENCES "Ingrediente"("IdIngrediente") ON DELETE RESTRICT,

    -- Restricción Única
    UNIQUE ("IdPlatillo_id", "IdIngrediente_id")
);

-- 9. Modelo Ingrediente_Proveedor (Depende de Ingrediente y Proveedor)
CREATE TABLE "Ingrediente_Proveedor" (
    "IdIngrediente_Proveedor" SERIAL PRIMARY KEY,

    -- Foreign Keys
    "IdIngrediente_id"        INTEGER NOT NULL,
    "IdProveedor_id"          INTEGER NOT NULL,
    
    FOREIGN KEY ("IdIngrediente_id") REFERENCES "Ingrediente"("IdIngrediente") ON DELETE CASCADE,
    FOREIGN KEY ("IdProveedor_id") REFERENCES "Proveedor"("IdProveedor") ON DELETE CASCADE,

    -- Restricción Única
    UNIQUE ("IdIngrediente_id", "IdProveedor_id")
);

-- Notificación de éxito
\echo '-----------------------------------------------'
\echo '¡Script Schema.sql completado con éxito!'
\echo '-----------------------------------------------'
