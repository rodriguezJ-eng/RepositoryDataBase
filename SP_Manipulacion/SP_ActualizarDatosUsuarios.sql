-- SP_ActualizarDatosUsuario
-- Actualiza correo y teléfono de un usuario existente.
-- Acción: UPDATE en tabla Usuario
CREATE PROCEDURE SP_ActualizarDatosUsuario
    @IDUsuario INT,
    @NuevoCorreo VARCHAR(150),
    @NuevoTelefono VARCHAR(20)
AS
BEGIN

    DECLARE @Existe INT;
    DECLARE @CorreoEnUso INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT @Existe = COUNT(*)
        FROM Usuario
        WHERE IDUsuario = @IDUsuario;

        SELECT @CorreoEnUso = COUNT(*)
        FROM Usuario
        WHERE Correo = @NuevoCorreo AND IDUsuario <> @IDUsuario;

        IF @Existe = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: No existe un usuario con ese ID.';
            RETURN;
        END

        IF @CorreoEnUso > 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: El correo ya está registrado por otro usuario.';
            RETURN;
        END

        UPDATE Usuario
        SET Correo   = @NuevoCorreo,
            Telefono = @NuevoTelefono
        WHERE IDUsuario = @IDUsuario;

        COMMIT TRANSACTION;
        PRINT 'Usuario actualizado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'ERROR inesperado al actualizar el usuario.';
    END CATCH
END;
GO

-- Prueba de éxito
EXECUTE AS USER = 'RashelS';
SELECT USER_NAME() AS UsuarioActual;
EXEC SP_ActualizarDatosUsuario @IDUsuario = 3,
     @NuevoCorreo = 'sofia.nueva@unah.hn', @NuevoTelefono = '9999-0000';
REVERT;
GO

-- Prueba de error (usuario inexistente)
EXEC SP_ActualizarDatosUsuario @IDUsuario = 999,
     @NuevoCorreo = 'noexiste@unah.hn', @NuevoTelefono = '0000-0000';
GO