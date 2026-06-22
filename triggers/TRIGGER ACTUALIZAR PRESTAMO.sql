USE BibliotecaUniversitaria;
GO

CREATE TRIGGER Tr_ActualizarPrestamo
ON Prestamo
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaPrestamo(Accion, Fecha, IDPrestamo, Usuario)
    SELECT 'UPDATE', GETDATE(), IDPrestamo, USER_NAME() FROM inserted;
END;
GO

-- elegimos el usuario para hacer el registro
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- Actualizamos el préstamo 
UPDATE Prestamo
SET Estado = 'Devuelto',
    FechaDevReal = GETDATE()
WHERE IDPrestamo = 2;
GO

-- Comprobamos que el registro se hizo completamente
SELECT * FROM AuditoriaPrestamo;
SELECT * FROM Prestamo;
GO