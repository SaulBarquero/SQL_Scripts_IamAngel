-- =========== 2. CREACIÓN DE LAS TABLAS ===========

-- (Borra las tablas si ya existen, para poder re-ejecutar el script)
DROP TABLE IF EXISTS ingrediente_proveedor CASCADE;
DROP TABLE IF EXISTS platillo_ingrediente CASCADE;
DROP TABLE IF EXISTS empleado_pedido CASCADE;
DROP TABLE IF EXISTS pedido_platillo CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS ingrediente CASCADE;
DROP TABLE IF EXISTS proveedor CASCADE;
DROP TABLE IF EXISTS platillo CASCADE;
DROP TABLE IF EXISTS mesa CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;


-- Tablas Principales (Padres)
CREATE TABLE cliente (
    idcliente     SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    telefono      VARCHAR(15) NULL,
    correo        VARCHAR(100) NULL
);

CREATE TABLE mesa (
    idmesa        SERIAL PRIMARY KEY,
    numeromesa    INTEGER NOT NULL UNIQUE,
    capacidad     INTEGER NOT NULL DEFAULT 4,
    ocupada       BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE platillo (
    idplatillo    SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL UNIQUE,
    descripcion   TEXT NULL,
    precio        NUMERIC(10, 2) NOT NULL
);

CREATE TABLE proveedor (
    idproveedor   SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL UNIQUE,
    telefono      VARCHAR(15) NULL UNIQUE,
    correo        VARCHAR(254) NOT NULL UNIQUE
);

CREATE TABLE ingrediente (
    idingrediente      SERIAL PRIMARY KEY,
    nombre             VARCHAR(100) NOT NULL UNIQUE,
    unidad_de_medida   VARCHAR(20) NOT NULL,
    stock              INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE empleado (
    idempleado   SERIAL PRIMARY KEY,
    nombre       VARCHAR(20) NOT NULL,
    apellido     VARCHAR(20) NOT NULL,
    telefono     VARCHAR(11) NULL,
    correo       VARCHAR(254) NOT NULL UNIQUE,
    cedula       VARCHAR(16) NOT NULL UNIQUE,
    rol          VARCHAR(50) NOT NULL,
    usuario      VARCHAR(50) NOT NULL UNIQUE,
    password     VARCHAR(128) NOT NULL,
    last_login   TIMESTAMPTZ NULL,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    is_staff     BOOLEAN NOT NULL DEFAULT FALSE,
    is_superuser BOOLEAN NOT NULL DEFAULT FALSE,
    date_joined  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


-- Tablas Intermedias (Hijos)
CREATE TABLE pedido (
    idpedido      SERIAL PRIMARY KEY,
    fecha         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    montototal    NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    metodopago    VARCHAR(50) NULL,
    idcliente_id  INTEGER NOT NULL,
    idmesa_id     INTEGER NULL,

    FOREIGN KEY (idcliente_id) REFERENCES cliente(idcliente) ON DELETE CASCADE,
    FOREIGN KEY (idmesa_id) REFERENCES mesa(idmesa) ON DELETE SET NULL
);

CREATE TABLE pedido_platillo (
    idpedido_platillo SERIAL PRIMARY KEY,
    estado            VARCHAR(20) NOT NULL DEFAULT 'Registrado',
    cantidad          INTEGER NOT NULL DEFAULT 1,
    idpedido_id       INTEGER NOT NULL,
    idplatillo_id     INTEGER NOT NULL,

    FOREIGN KEY (idpedido_id) REFERENCES pedido(idpedido) ON DELETE CASCADE,
    FOREIGN KEY (idplatillo_id) REFERENCES platillo(idplatillo) ON DELETE RESTRICT
);

CREATE TABLE empleado_pedido (
    idempleado_pedido SERIAL PRIMARY KEY,
    fechaasignacion   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    idempleado_id     INTEGER NOT NULL,
    idpedido_id       INTEGER NOT NULL,

    FOREIGN KEY (idempleado_id) REFERENCES empleado(idempleado) ON DELETE RESTRICT,
    FOREIGN KEY (idpedido_id) REFERENCES pedido(idpedido) ON DELETE CASCADE,
    UNIQUE (idempleado_id, idpedido_id)
);

CREATE TABLE platillo_ingrediente (
    idplatillo_ingrediente SERIAL PRIMARY KEY,
    cantidad_usada         NUMERIC(10, 2) NOT NULL,
    idplatillo_id          INTEGER NOT NULL,
    idingrediente_id       INTEGER NOT NULL,
    
    FOREIGN KEY (idplatillo_id) REFERENCES platillo(idplatillo) ON DELETE CASCADE,
    FOREIGN KEY (idingrediente_id) REFERENCES ingrediente(idingrediente) ON DELETE RESTRICT,
    UNIQUE (idplatillo_id, idingrediente_id)
);

CREATE TABLE ingrediente_proveedor (
    idingrediente_proveedor SERIAL PRIMARY KEY,
    idingrediente_id        INTEGER NOT NULL,
    idproveedor_id          INTEGER NOT NULL,
    
    FOREIGN KEY (idingrediente_id) REFERENCES ingrediente(idingrediente) ON DELETE CASCADE,
    FOREIGN KEY (idproveedor_id) REFERENCES proveedor(idproveedor) ON DELETE CASCADE,
    UNIQUE (idingrediente_id, idproveedor_id)
);
