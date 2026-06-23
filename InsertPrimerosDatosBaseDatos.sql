-- ============================================================
-- SISTEMA DE GESTIÓN DE BIBLIOTECA UNIVERSITARIA
-- Script 02: Carga de Datos Iniciales (DML - INSERT)
-- Integrantes:
--   Rashel Sánchez González
--   Jonathan Rodríguez López
--   Engel Josue Aburto Zeledón
--   EstudianteB
-- ============================================================

USE BibliotecaUniversitaria;
GO

EXECUTE AS USER = 'RashelS';
SELECT USER_NAME() AS UsuarioActual; -- Verifica que el usuario está activo
REVERT; -- Regresa al usuario original 

-- CATEGORIAS
INSERT INTO Categoria (Nombre, Descripcion) VALUES
('Ingeniería de Software','Libros sobre desarrollo, diseño y arquitectura de software'),
('Bases de Datos','Fundamentos y avanzados de BD relacionales y NoSQL'),
('Redes y Telecomunicaciones','Protocolos, infraestructura y comunicaciones'),
('Matemáticas','Álgebra, cálculo, estadística y matemática discreta'),
('Literatura Universal','Obras clásicas y contemporáneas de todo el mundo'),
('Administración','Gestión empresarial y recursos humanos'),
('Ciencias Básicas','Física, química y biología general');
go

-- AUTORES
INSERT INTO Autor (Nombre, Apellido, Nacionalidad) VALUES
('Abraham','Silberschatz','Estadounidense'),
('Henry F.','Korth','Estadounidense'),
('S.','Sudarshan','India'),
('Ramez','Elmasri','Estadounidense'),
('Ian','Sommerville','Británico'),
('Andrew S.','Tanenbaum','Estadounidense'),
('Gabriel','García Márquez','Colombiano'),
('James','Stewart','Canadiense'),
('Fred','Brooks','Estadounidense'),
('Brian W', 'Kernighan','Canadiense'),
('Dennis M','Ritchie','Estadounidense'),
('William','Stallings','Estadounidense');

-- LIBROS

INSERT INTO Libro VALUES
('978-0-07-352332-3','Database System Concepts',2019, 2, 'McGraw-Hill', 7),
('978-0-13-213080-3','Fundamentals of Database Systems',2015, 2, 'Pearson', 7),
('978-0-13-468599-1','Software Engineering',2015, 1, 'Pearson',10),
('978-0-13-349945-6','Computer Networks', 2010, 3, 'Prentice Hall', 5),
('978-9-58-420448-6','Cien Años de Soledad',1967, 5, 'Sudamericana',1),
('978-0-53-849790-0','Calculus: Early Transcendentals',2015, 4, 'Cengage',8),
('978-0-20-135953-4','The Mythical Man-Month',1995, 1, 'Addison-Wesley',2),
('978-0-13-337288-0','Operating Systems: Internals & Design',2017, 1, 'Pearson',10),
('978-0-13-110362-7','The C Programming Language',1988, 1, 'Prentice Hall', 2),
('978-0-07-661638-3','Redes de Computadoras',2012, 3, 'McGraw-Hill', 4);


-- RELACIÓN M:M — LIBRO-AUTOR

-- Database System Concepts -> Silberschatz, Korth, Sudarshan
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (1, 1), (1, 2), (1, 3);
-- Fundamentals of Database Systems -> Elmasri
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (2, 4);
-- Software Engineering -> Sommerville
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (3, 5);
-- Computer Networks -> Tanenbaum
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (4, 6);
-- Cien Años de Soledad -> García Márquez
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (5, 7);
-- Calculus -> Stewart
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (6, 8);
-- Mythical Man-Month -> Brooks
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (7, 9);
-- OS Internals -> Stallings
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (8, 12);
-- C Programming -> (Kernighan & Ritchie)
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (9, 10), (9, 11);
-- Redes -> Tanenbaum
INSERT INTO LibroAutor (IDLibro, IDAutor) VALUES (10, 6);

SELECT * FROM AuditoriaLibro;







-- EJEMPLARES (2 por libro aprox.)
EXECUTE AS USER = 'JonathanR';
SELECT USER_NAME() AS UsuarioActual; -- Verifica que el usuario está activo
REVERT; -- Regresa al usuario original 

INSERT INTO Ejemplar (IDLibro, Codigo, Estado) VALUES
(1,  'EJ-001', 'Disponible'),
(1,  'EJ-002', 'Prestado'),
(2,  'EJ-003', 'Disponible'),
(3,  'EJ-004', 'Disponible'),
(3,  'EJ-005', 'En reparación'),
(4,  'EJ-006', 'Disponible'),
(5,  'EJ-007', 'Disponible'),
(6,  'EJ-008', 'Prestado'),
(7,  'EJ-009', 'Disponible'),
(8,  'EJ-010', 'Disponible'),
(9,  'EJ-011', 'Disponible'),
(10, 'EJ-012', 'Baja');

-- CARRERAS
INSERT INTO Carrera (Nombre, Facultad) VALUES
('Ingeniería en Sistemas','Facultad de Tecnología'),
('Ingeniería en Telecomunicaciones','Facultad de Tecnología'),
('Administración de Empresas','Facultad de Ciencias Económicas'),
('Medicina','Facultad de Ciencias de la Salud'),
('Derecho','Facultad de Ciencias Jurídicas');

EXECUTE AS USER = 'EngelA';
SELECT USER_NAME() AS UsuarioActual; -- Verifica que el usuario está activo
REVERT; -- Regresa al usuario original 
-- USUARIOS
INSERT INTO Usuario (Cedula, Nombre, Apellido, Correo, Telefono, Tipo, IDCarrera) VALUES
('0801-1990-12345', 'María','López','mlopez@gmail.com','9876-5432','Estudiante', 1),
('0801-1988-67890', 'Carlos','Reyes','creyes@gmail.com','9765-4321','Docente',NULL),
('0501-2001-11111', 'Sofía','Martínez','smartinez@gmail.com','9654-3210', 'Estudiante',2),
('0801-1995-22222', 'Diego','Fuentes','dfuentes@gmail.com','9543-2109','Estudiante',3),
('0301-2000-33333', 'Valeria','Cruz','vcruz@gmail.com','9432-1098','Estudiante', 1),
('0801-1975-44444', 'Roberto','Zelaya','rzelaya@gmail.com','9321-0987','Docente',NULL),
('0101-2002-55555', 'Andrea','Sosa','asosa@gmail.com','9210-9876','Estudiante',4),
('0801-1999-66666', 'Fernando','Paz','fpaz@gmail.com','9109-8765','Externo',NULL);


-- TARJETAS DE BIBLIOTECA (1:1 con Usuario)
INSERT INTO TarjetaBiblioteca (IDUsuario, NumeroTarjeta, FechaEmision, FechaVence, Activa) VALUES
(1, 'TB-2024-001', '2024-01-15', '2026-01-15', 1),
(2, 'TB-2024-002', '2024-02-01', '2026-02-01', 1),
(3, 'TB-2024-003', '2024-02-15', '2026-02-15', 1),
(4, 'TB-2024-004', '2024-03-01', '2026-03-01', 1),
(5, 'TB-2024-005', '2024-03-15', '2026-03-15', 0),
(6, 'TB-2024-006', '2024-04-01', '2026-04-01', 1),
(7, 'TB-2024-007', '2024-04-15', '2026-04-15', 1),
(8, 'TB-2024-008', '2024-05-01', '2026-05-01', 1);

EXECUTE AS USER = 'JonathanR';
SELECT USER_NAME() AS UsuarioActual; -- Verifica que el usuario está activo
REVERT; -- Regresa al usuario original 
-- PRÉSTAMOS
INSERT INTO Prestamo (IDUsuario, IDEjemplar, FechaPrestamo, FechaDevolucion, FechaDevReal, Estado) VALUES
(1, 2,  '2026-05-01', '2026-05-15', '2026-05-14', 'Devuelto'),
(3, 8,  '2026-05-10', '2026-05-24', NULL,'Vencido'),
(4, 1,  '2026-06-01', '2026-06-15', NULL,'Activo'),
(2, 6,  '2026-06-05', '2026-06-19', '2026-06-18','Devuelto'),
(5, 9,  '2026-06-10', '2026-06-24', NULL,'Activo'),
(6, 3,  '2026-06-12', '2026-06-26', NULL,'Activo'),
(7, 11, '2026-06-15', '2026-06-29', NULL,'Activo'),
(1, 4,  '2026-04-01', '2026-04-15', NULL,'Vencido');


-- MULTAS (para préstamos vencidos)
INSERT INTO Multa (IDPrestamo, Monto, Pagada, FechaMulta) VALUES
(2, 50.00, 0, '2026-05-25'),
(8, 75.00, 1, '2026-04-16');




SELECT * FROM AuditoriaPrestamo;