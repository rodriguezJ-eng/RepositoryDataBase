CREATE TRIGGER TR_EliminarLibro
ON Libro
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaLibro(Accion, Fecha, IDLibro, Usuario)
    SELECT 'DELETE', GETDATE(), IDLibro, USER_NAME() FROM deleted;
END;

-- usamos un usuario para hacer el registro
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- eliminamos un libro a traves del usuario sql
DELETE FROM Libro
WHERE IDLibro = 11;

-- comprobamos nuestros registros
SELECT * FROM AuditoriaLibro;
SELECT * FROM Libro;
--