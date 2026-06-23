USE BibliotecaUniversitaria;
GO
CREATE TRIGGER Tr_EliminarUsuario
ON Usuario
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaUsuario(Accion, Fecha, IDUsuario, Usuario)
    SELECT 'DELETE', GETDATE(), IDUsuario, USER_NAME() FROM deleted;
END;
GO


















-- Verificamos el usuario actual administrador antes REGISTRAR
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';


-- ELIMINAMOS EL USUARIO 
DELETE FROM Usuario
WHERE IDUsuario = 2;
GO


-- Comprobamos los registros finales 
SELECT * FROM AuditoriaUsuario;
SELECT * FROM Usuario;
GO