-- SP_EliminarMulta
-- Elimina una multa solo si ya fue pagada.
-- Acción: DELETE en tabla Multa
CREATE PROCEDURE SP_EliminarMulta
    @IDMulta INT
AS
BEGIN

    DECLARE @Pagada BIT;
    DECLARE @Existe INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT @Existe = COUNT(*)
        FROM Multa
        WHERE IDMulta = @IDMulta;

        SELECT @Pagada = Pagada
        FROM Multa
        WHERE IDMulta = @IDMulta;

        IF @Existe = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: No existe una multa con ese ID.';
            RETURN;
        END

        IF @Pagada = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: No se puede eliminar una multa pendiente de pago.';
            RETURN;
        END

        DELETE FROM Multa WHERE IDMulta = @IDMulta;

        COMMIT TRANSACTION;
        PRINT 'Multa eliminada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'ERROR inesperado al eliminar la multa.';
    END CATCH
END;
GO

-- Prueba de éxito (IDMulta = 2 está pagada)
EXECUTE AS USER = 'JonathanR';
SELECT USER_NAME() AS UsuarioActual;
EXEC SP_EliminarMulta @IDMulta = 2;
REVERT;
GO

-- Prueba de error (multa no pagada)
EXEC SP_EliminarMulta @IDMulta = 1;
GO
