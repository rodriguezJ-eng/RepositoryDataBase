CREATE TRIGGER Tr_AgregarPrestamo
ON Prestamo
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaPrestamo(Accion, Fecha, IDPrestamo, Usuario)
    SELECT 'INSERT', GETDATE(), IDPrestamo, USER_NAME() FROM inserted;
END;
GO

-- usamos un usuario para hacer el registro
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- Insertamos un préstamo de prueba usando el( IDUsuario=1 e IDEjemplar=1)
INSERT INTO Prestamo (IDUsuario, IDEjemplar, FechaPrestamo, FechaDevolucion, Estado) 
VALUES (1, 1, GETDATE(), DATEADD(day, 7, GETDATE()), 'Activo');
GO

-- comprobamos nuestros registros
SELECT * FROM AuditoriaPrestamo;
SELECT * FROM Prestamo;