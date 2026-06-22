USE BibliotecaUniversitaria;
GO
CREATE TRIGGER Tr_ActualizarUsuario
ON Usuario
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaUsuario(Accion, Fecha, IDUsuario, Usuario)
    SELECT 'UPDATE', GETDATE(), IDUsuario, USER_NAME() FROM inserted;
END;
GO
-- Verificamos el usuario actual administrador antes REGISTRAR
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- Actualizamos el teléfono o correo del usuario usando su IDUsuario
-- (Usamos el IDUsuario que se acaba de generar, por ejemplo el 2 o el que se tenga libre)
UPDATE Usuario
SET Telefono = '8888-9999',
    Correo = 'maria.nueva@test.com'
WHERE IDUsuario = 2; 
GO

-- Comprobamos los registros del UPDATE
SELECT * FROM AuditoriaUsuario;
SELECT * FROM Usuario;
GO
