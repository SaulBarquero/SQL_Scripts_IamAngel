CREATE DATABASE IamAngel
GO

USE IamAngel
GO

CREATE TABLE Juez
(
    CodigoJuez INT,
    Nombres NVARCHAR(30) COLLATE Modern_Spanish_CS_AI NOT NULL,
    Apellidos NVARCHAR(30) COLLATE Modern_Spanish_CS_AI NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Estado CHAR(1) NOT NULL,
    CONSTRAINT PK_Juez PRIMARY KEY CLUSTERED (CodigoJuez ASC),
    CONSTRAINT CK_Juez_Sexo CHECK (Sexo IN ('F','M')),
    CONSTRAINT CK_Juez_Estado CHECK (Estado IN ('0','1'))
)
GO

--Para alterar la tabla primero eliminamos las dependencias
ALTER TABLE Juez DROP CONSTRAINT CK_Juez_Estado
GO

--Cambiamos el tipo de columna
ALTER TABLE Juez ALTER COLUMN Estado bit
GO

--Creación de INDEX
CREATE INDEX IX_Juez_Nombre ON Juez (Nombres, Apellidos)
GO

--Inserciones de ejemplo
INSERT INTO Juez (CodigoJuez, Nombres, Apellidos, Sexo, Estado) VALUES
(8, 'Angel Gabriel', 'Morales', 'F', 1),
(10, 'Martha Maria', 'Lopez Ruiz', 'F', 1),
(88, 'Lucas Mateo', 'Guianni Vallecillo', 'M', 0),
(26, 'Emma', N'Castro Martinez', 'F', 1);
GO


-- Select con where en nombre
SELECT * FROM Juez WHERE Nombres = 'Ana'

-- Actualizar sexp de un juez
UPDATE Juez SET Sexo = 'M' WHERE CodigoJuez = 8;

-- Seleccionar y ordenar por Codigo descendentemente
SELECT Nombres, Apellidos, CodigoJuez
FROM Juez 
WHERE CodigoJuez > 10 
GROUP BY CodigoJuez, Nombres, Apellidos 
ORDER BY CodigoJuez DESC;

-- Seleccion simple de Nombres y Apellidos
SELECT Nombres, Apellidos FROM Juez

-- Seleccion de Juez mediante el sexo
SELECT * FROM Juez WHERE Sexo = 'M';

-- Concatenacion de los nombres
SELECT Nombres + ' ' + Apellidos AS NombreCompleto FROM Juez WHERE Nombres Like 'L%'


-- ////////////////////////// TABLA CASO //////////////////////////////// --
CREATE TABLE Caso (
    CasoNum INT PRIMARY KEY,
    Fecha DATE,
    Estado BIT,
    CodigoJuez INT,
    CodigoCausa INT
);

INSERT INTO Caso (CasoNum, Fecha, Estado, CodigoJuez, CodigoCausa) VALUES
(57, '2018-11-16', 0, 46, 10),
(108, '2018-12-02', 1, 578, 7),
(125, '2019-01-07', 1, 578, 1),
(145, '2020-01-08', 1, 46, 2),
(155, '2019-01-15', 0, 145, 5),
(157, '2019-04-15', 1, 8, 7),
(160, '2019-04-15', 1, 8, 2),
(177, '2019-10-27', 1, 145, 1),
(210, '2020-01-12', 1, 46, 10),
(212, '2020-01-12', 0, 8, 2),
(222, '2020-05-23', 1, 46, 10);

SELECT CasoNum, Fecha, Estado, CodigoCausa FROM Caso WHERE CodigoCausa IN (5,6,7,8)

SELECT CasoNum, Fecha, Estado, CodigoCausa FROM Caso WHERE CodigoCausa = 5 OR CodigoCausa = 6 OR CodigoCausa = 7 OR CodigoCausa = 8

SELECT Sexo, COUNT(*) AS Cant_x_Sexo FROM Juez GROUP BY Sexo

SELECT CodigoJuez, COUNT(*) AS Casos_Juez_Activos FROM Caso WHERE Estado = 1 GROUP BY CodigoJuez

SELECT CodigoJuez, COUNT(*) AS Casos_Juez FROM Caso GROUP BY CodigoJuez ORDER BY Casos_Juez DESC

SELECT CodigoJuez, COUNT(*) AS Casos_Juez FROM Caso GROUP BY CodigoJuez HAVING COUNT(*) > 2 ORDER BY Casos_Juez

CREATE VIEW CasosJueces 
AS SELECT CodigoJuez, COUNT(*) AS CasosJuez FROM Caso GROUP BY CodigoJuez 

SELECT CodigoJuez, CasosJuez
FROM CasosJueces
WHERE CasosJuez > 2
ORDER BY CasosJuez
