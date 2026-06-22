CREATE OR ALTER TRIGGER TR_AgregarLibros
ON Libro
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaLibro(Accion, Fecha, IDLibro, Usuario)
    SELECT 'INSERT', GETDATE(), IDLibro, USER_NAME() FROM inserted;
END;


-- usamos un usuario para hacer el registro
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';


-- insertamos un nuevo libro a traves del usuario
INSERT INTO Libro (ISBN, Titulo, Anio, IDCategoria, Editorial, Edicion) VALUES
('978-0136086208', 'Sistemas de Bases de Datos', 2024, 1, 'Pearson', 1);

INSERT INTO Libro (ISBN, Titulo, Anio, IDCategoria, Editorial, Edicion) VALUES
('978-6071514029', 'Redes de Computadoras: Un Enfoque Top-Down', 2017, 2, 'Pearson', 7);

INSERT INTO Libro (ISBN, Titulo, Anio, IDCategoria, Editorial, Edicion) VALUES
('978-6073244121', 'Matemáticas Discretas y sus Aplicaciones', 2019, 4, 'Pearson', 7);

-- comprobamos nuestros registros
SELECT * FROM AuditoriaLibro;
SELECT * FROM Libro;
--