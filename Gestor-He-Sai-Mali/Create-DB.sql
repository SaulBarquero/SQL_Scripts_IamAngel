/*
================================================================
 Archivo: Create-DB.sql
 Desc:    Crea la base de datos principal "Gestor-He"
 Autor:   Angel Jarquin, Aracelly Castillo, Erick Zúniga
 Fecha:   09/11/2025
================================================================
*/
-- Crea la base de datos
CREATE DATABASE "Gestor-He"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
