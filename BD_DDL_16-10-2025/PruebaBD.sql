-- 1) crear una base de datos
CREATE DATABASE UNI
GO

USE UNI
GO

-- 2) se crean 3 tablas relacionadas
CREATE TABLE estudiante(
	Carnet VARCHAR(10) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Fecha_nac DATE
);
GO

CREATE TABLE carrera(
	Id_carrera INT PRIMARY KEY NOT NULL,
	Nombre_carrera VARCHAR(20),
	Facultad VARCHAR(30)
);
GO

CREATE TABLE curso(
	Id_curso INT PRIMARY KEY NOT NULL,
	Nombre_curso VARCHAR(20),
	Creditos INT
);
GO

CREATE TABLE carreracurso(
	Id_carrera INT NOT NULL,
	Id_curso INT NOT NULL,
	PRIMARY KEY (Id_carrera, Id_curso), 
	FOREIGN KEY (Id_carrera) REFERENCES carrera(Id_carrera),
	FOREIGN KEY (Id_curso) REFERENCES curso(Id_curso)
);
GO

CREATE TABLE inscripcion(
	Id_estudiante_carnet VARCHAR(10) NOT NULL,
	Id_curso_inscrito INT NOT NULL,
	PRIMARY KEY (Id_estudiante_carnet, Id_curso_inscrito),
	FOREIGN KEY (Id_estudiante_carnet) REFERENCES estudiante(Carnet),
	FOREIGN KEY (Id_curso_inscrito) REFERENCES curso(Id_curso)
);
GO

-- 3) Insertar algunos datos de ejemplo
INSERT INTO estudiante VALUES
('2023-0615U', 'Angel', 'Jarquin','2005-01-12'),
('2023-0650U', 'Aracelly', 'Castillo', '2004-02-13'),
('2023-0676U', 'Donald', 'Reyes', '2005-11-28'),
('2023-0660U', 'Kamila', 'Reyes', '1995-05-06')
GO

INSERT INTO	curso VALUES
(1, 'Bases de Datos', 5),
(2, 'Economia', 1),
(3, 'Hardware', 3),
(4, 'SOR', 5),
(5, 'Cultura de paz', 1),
(6, 'Filosofia', 1);
GO

INSERT INTO carrera VALUES
(1, 'Computacion','ACTI'),
(2, 'Electronica', 'ACTI'),
(3, 'Quimica', 'FAQ');
GO

INSERT INTO carreracurso (Id_carrera, Id_curso) VALUES
(1, 1),
(1, 3),
(1, 4),
(2, 3), 
(1, 2), 
(2, 2), 
(3, 2), 
(2, 5), 
(3, 5), 
(1, 6), 
(3, 6); 
GO

INSERT INTO inscripcion (Id_estudiante_carnet, Id_curso_inscrito) VALUES
('2023-0615U', 1),
('2023-0615U', 4), 
('2023-0615U', 6), 
('2023-0650U', 1),
('2023-0650U', 2), 
('2023-0650U', 5),
('2023-0676U', 3), 
('2023-0676U', 4),
('2023-0660U', 2),
('2023-0660U', 5),
('2023-0660U', 6);
GO

-- 4) 4.1 Realiza una consulta con SELECT
SELECT Nombre FROM estudiante; --Normal
SELECT Nombre, DATEDIFF(year, Fecha_nac, GETDATE()) AS Edad
FROM estudiante; --Calculando edad (prueba)
GO

-- 4.2 Filtrar con WHERE
SELECT * FROM carrera WHERE Id_carrera > 2;

-- 4.3 Utilizar un método de ordenamiento
SELECT * FROM curso ORDER BY Creditos ASC
SELECT * FROM curso ORDER BY Id_curso ASC
GO

-- 4.4 Unir 2 tablas
SELECT e.Nombre, e.Apellido, c.Nombre_curso
FROM estudiante e
JOIN inscripcion i ON i.Id_estudiante_carnet = e.Carnet
JOIN curso c ON i.Id_curso_inscrito = c.Id_curso
GO

SELECT e.Nombre, e.Apellido
FROM estudiante e
JOIN inscripcion i ON i.Id_estudiante_carnet = e.Carnet
JOIN curso c ON c.Id_curso = i.Id_curso_inscrito
WHERE c.Nombre_curso = 'Bases de Datos';
GO

SELECT c.Nombre_curso, COUNT(*) AS Total_Inscritos
FROM curso c
JOIN inscripcion i ON i.Id_curso_inscrito = c.Id_curso
GROUP BY c.Nombre_curso
HAVING COUNT(*) >= 2;
GO

-- 4.5 Crear una vista
CREATE VIEW E_C AS
SELECT e.Nombre, e.Apellido, c.Nombre_curso
FROM estudiante e
JOIN inscripcion i ON i.Id_estudiante_carnet = e.Carnet
JOIN curso c ON i.Id_curso_inscrito = c.Id_curso;
GO

--Usar la vista
SELECT Nombre_curso FROM E_C WHERE Nombre = 'Angel'
GO