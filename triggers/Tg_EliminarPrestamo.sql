USE BibliotecaUniversitaria;
GO

CREATE TRIGGER TR_EliminarPrestamo
ON Prestamo
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaPrestamo(Accion, Fecha, IDPrestamo, Usuario)
    SELECT 'DELETE', GETDATE(), IDPrestamo, USER_NAME() FROM deleted;
END;
GO
-- elegimos el usuario para hacer el registro
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- eliminamos el prestamo a traves del usuario elegido
DELETE FROM Prestamo
WHERE IDPrestamo = 2;


-- Comprobamos los registros hechos con el usuario
SELECT * FROM AuditoriaPrestamo;
SELECT * FROM Prestamo;
GO