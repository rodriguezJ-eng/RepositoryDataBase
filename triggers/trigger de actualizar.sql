CREATE TRIGGER Tr_ActualizarLibro
ON Libro
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaLibro(Accion, Fecha, IDLibro, Usuario)
    SELECT 'UPDATE', GETDATE(), IDLibro, USER_NAME() FROM inserted;
END;


--usar un usuario para registrar
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- actualizamos un libro a traves del usuario
UPDATE Libro
SET Titulo = 'Redes de Computadoras: Un Enfoque Descendente',
    Editorial = 'Pearson'
WHERE ISBN = '978-6071514029';

-- comprobamos nuestros registros
SELECT * FROM AuditoriaLibro;
SELECT * FROM Libro;
--