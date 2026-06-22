-- ============================================================
-- SISTEMA DE GESTIÓN DE BIBLIOTECA UNIVERSITARIA
-- Script: Creación de Base de Datos y Estructura (DDL)
-- Integrantes:
--   Rashel Sanchez Gonzalez
--   Jonathan Rodríguez López
--   Engel Josué Aburto
-- ============================================================
-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE BibliotecaUniversitaria;
USE BibliotecaUniversitaria;

-- 
-- TABLAS PRINCIPALES
-- 

-- Tabla: Categoria (catálogo de géneros/áreas)
CREATE TABLE Categoria (
IDCategoria INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL UNIQUE,
Descripcion VARCHAR(255) NOT NULL DEFAULT 'Sin descripción'
);

-- Tabla: Autor
CREATE TABLE Autor(
IDAutor INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL,
Apellido VARCHAR(100) NOT NULL,
Nacionalidad VARCHAR(80) NOT NULL DEFAULT 'Desconocida',
CONSTRAINT UQ_Autor UNIQUE (Nombre, Apellido)
);

-- Tabla: Libro
CREATE TABLE Libro(
IDLibro INT IDENTITY(1,1) PRIMARY KEY,
ISBN VARCHAR(20)  NOT NULL UNIQUE,
Titulo VARCHAR(200) NOT NULL,
Anio SMALLINT NOT NULL CHECK (Anio >= 1000 AND Anio <= 2100),
IDCategoria INT NOT NULL,
Editorial VARCHAR(150) NOT NULL DEFAULT 'Editorial Desconocida',
Edicion INT NOT NULL DEFAULT 1 CHECK (Edicion >= 1),
CONSTRAINT FK_Libro_Categoria FOREIGN KEY (IDCategoria) REFERENCES Categoria(IDCategoria)
);
GO

-- Tabla: Ejemplar (copia física de un libro) — relación 1:N con Libro
CREATE TABLE Ejemplar (
IDEjemplar INT IDENTITY(1,1) PRIMARY KEY,
IDLibro INT NOT NULL,
Codigo VARCHAR(30)  NOT NULL UNIQUE,
Estado VARCHAR(20)  NOT NULL DEFAULT 'Disponible'CHECK (Estado IN ('Disponible','Prestado','En reparación','Baja')),
CONSTRAINT FK_Ejemplar_Libro FOREIGN KEY (IDLibro) REFERENCES Libro(IDLibro)
);

-- Tabla: Carrera (para clasificar usuarios estudiantes)
CREATE TABLE Carrera (
IDCarrera INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(150) NOT NULL UNIQUE,
Facultad VARCHAR(150) NOT NULL
);

-- Tabla: Usuario (lectores de la biblioteca)
CREATE TABLE Usuario (
IDUsuario INT IDENTITY(1,1) PRIMARY KEY,
Cedula VARCHAR(20) NOT NULL UNIQUE,
Nombre VARCHAR(100) NOT NULL,
Apellido VARCHAR(100) NOT NULL,
Correo VARCHAR(150) NOT NULL UNIQUE,
Telefono VARCHAR(20) NOT NULL DEFAULT 'Sin registro',
Tipo VARCHAR(20)  NOT NULL DEFAULT 'Estudiante' CHECK (Tipo IN ('Estudiante','Docente','Externo')),
IDCarrera INT NULL,
CONSTRAINT FK_Usuario_Carrera FOREIGN KEY (IDCarrera) REFERENCES Carrera(IDCarrera)
);

-- Tabla: TarjetaBiblioteca (relación 1:1 con Usuario)
-- Cada usuario tiene exactamente una tarjeta de membresía
CREATE TABLE TarjetaBiblioteca (
IDTarjeta INT IDENTITY(1,1) PRIMARY KEY,
IDUsuario INT NOT NULL UNIQUE,   -- UNIQUE garantiza 1:1
NumeroTarjeta VARCHAR(30) NOT NULL UNIQUE,
FechaEmision DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
FechaVence DATE NOT NULL,
Activa BIT NOT NULL DEFAULT 1,
CONSTRAINT FK_Tarjeta_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
CONSTRAINT CK_Tarjeta_Vigencia CHECK (FechaVence > FechaEmision)
);


-- Tabla: Prestamo (relación 1:N con Usuario y Ejemplar)
CREATE TABLE Prestamo (
IDPrestamo INT IDENTITY(1,1) PRIMARY KEY,
IDUsuario  INT NOT NULL,
IDEjemplar INT NOT NULL,
FechaPrestamo DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
FechaDevolucion DATE NOT NULL,
FechaDevReal  DATE NULL,
Estado VARCHAR(20) NOT NULL DEFAULT 'Activo' CHECK (Estado IN ('Activo','Devuelto','Vencido')),
CONSTRAINT FK_Prestamo_Usuario  FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
CONSTRAINT FK_Prestamo_Ejemplar FOREIGN KEY (IDEjemplar) REFERENCES Ejemplar(IDEjemplar),
CONSTRAINT CK_Prestamo_Fechas   CHECK (FechaDevolucion > FechaPrestamo)
);


-- Tabla: Multa (relación 1:N con Prestamo)
CREATE TABLE Multa (
IDMulta INT IDENTITY(1,1) PRIMARY KEY,
IDPrestamo INT NOT NULL UNIQUE,  -- 1 multa por préstamo máximo
Monto DECIMAL(8,2) NOT NULL CHECK (Monto > 0),
Pagada BIT NOT NULL DEFAULT 0,
FechaMulta DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
CONSTRAINT FK_Multa_Prestamo FOREIGN KEY (IDPrestamo) REFERENCES Prestamo(IDPrestamo)
);

-- Tabla: LibroAutor (relación M:M entre Libro y Autor)
CREATE TABLE LibroAutor(
IDLibro INT NOT NULL,
IDAutor INT NOT NULL,
CONSTRAINT PK_LibroAutor PRIMARY KEY (IDLibro, IDAutor),
CONSTRAINT FK_LA_Libro  FOREIGN KEY (IDLibro)  REFERENCES Libro(IDLibro),
CONSTRAINT FK_LA_Autor  FOREIGN KEY (IDAutor)  REFERENCES Autor(IDAutor)
);

-- USUARIOS SQL
CREATE USER RashelS    WITHOUT LOGIN;
CREATE USER JonathanR  WITHOUT LOGIN;
CREATE USER EngelA WITHOUT LOGIN;
CREATE USER EstudianteB WITHOUT LOGIN;


ALTER ROLE db_owner ADD MEMBER RashelS;
ALTER ROLE db_owner ADD MEMBER JonathanR;
ALTER ROLE db_owner ADD MEMBER EngelA;
ALTER ROLE db_owner ADD MEMBER EstudianteB;