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
(1, N'Ana', N'Gómez', 'F', 1),
(2, N'Carlos', N'Ramírez', 'M', 1),
(3, N'Lucía', N'Fernández', 'F', 0),
(4, N'Javier', N'Pérez', 'M', 1),
(5, N'María', N'Lozano', 'F', 1),
(6, N'Andrés', N'Morales', 'M', 0),
(7, N'Sofía', N'Hernández', 'F', 1),
(8, N'Raúl', N'Serrano', 'M', 1),
(9, N'Daniela', N'Castro', 'F', 0),
(10, N'Felipe', N'Navarro', 'M', 1);
GO

SELECT * FROM Juez

SELECT * FROM Juez WHERE Nombres = 'Ana'
