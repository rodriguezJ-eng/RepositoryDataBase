USE BibliotecaUniversitaria;
GO

CREATE TRIGGER TR_AgregarUsuarios
ON Usuario
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaUsuario(Accion, Fecha, IDUsuario, Usuario)
    SELECT 'INSERT', GETDATE(), IDUsuario, USER_NAME() FROM inserted;
END;
GO

-- Verificamos el usuario actual administrador antes REGISTRAR
SELECT USER_NAME() AS UsuarioActual;
EXECUTE AS USER = 'RashelS';

-- Insertamos un nuevo usuario de prueba firmado por el usuari sql que se elija
INSERT INTO Usuario (Cedula, Nombre, Apellido, Correo, Telefono, Tipo, IDCarrera)
VALUES ('001-220626-0001A', 'María', 'López', 'maria.lopez@test.com', '7777-7777', 'Estudiante', 1);
GO

-- Comprobamos los registros del INSERT
SELECT * FROM AuditoriaUsuario;
SELECT * FROM Usuario;
GO





