-- ============================================================
-- SISTEMA DE GESTIÓN DE BIBLIOTECA UNIVERSITARIA
-- Script 05: Procedimientos Almacenados de Manipulación (4 SP)
-- Integrantes:
--   Rashel Sanchez Gonzalez
--   Jonathan Rodríguez López
--   Engel Josué Aburto Zeledón
-- ============================================================

USE BibliotecaUniversitaria;
GO

-- SP_RegistrarPrestamo
-- Inserta un nuevo préstamo validando disponibilidad del
-- ejemplar y que el usuario tenga tarjeta activa.
-- Acción: INSERT en tabla Prestamo
CREATE PROCEDURE SP_RegistrarPrestamo
    @IDUsuario    INT,
    @IDEjemplar   INT,
    @DiasCredito  INT = 14
AS
BEGIN
    DECLARE @FechaPrestamo DATE = CAST(GETDATE() AS DATE);
    DECLARE @FechaDevolucion DATE = DATEADD(DAY, @DiasCredito, @FechaPrestamo);
    DECLARE @EstadoEjemplar VARCHAR(20);
    DECLARE @TarjetaActiva BIT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT @EstadoEjemplar = Estado
        FROM Ejemplar
        WHERE IDEjemplar = @IDEjemplar;

        SELECT @TarjetaActiva = Activa
        FROM TarjetaBiblioteca
        WHERE IDUsuario = @IDUsuario;

        IF @EstadoEjemplar IS NULL OR @EstadoEjemplar <> 'Disponible'
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: El ejemplar no existe o no está disponible.';
            RETURN;
        END

        IF @TarjetaActiva IS NULL OR @TarjetaActiva = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: El usuario no tiene tarjeta de biblioteca activa.';
            RETURN;
        END

        IF @DiasCredito <= 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: Los días de crédito deben ser mayores a 0.';
            RETURN;
        END

        INSERT INTO Prestamo (IDUsuario, IDEjemplar, FechaPrestamo, FechaDevolucion, Estado)
        VALUES (@IDUsuario, @IDEjemplar, @FechaPrestamo, @FechaDevolucion, 'Activo');

        UPDATE Ejemplar SET Estado = 'Prestado' WHERE IDEjemplar = @IDEjemplar;

        COMMIT TRANSACTION;
        PRINT 'Préstamo registrado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'ERROR inesperado al registrar el préstamo.';
    END CATCH
END;
GO

-- Prueba de éxito
EXECUTE AS USER = 'EstudianteA';
SELECT USER_NAME() AS UsuarioActual;
EXEC SP_RegistrarPrestamo @IDUsuario = 2, @IDEjemplar = 7, @DiasCredito = 14;
REVERT;
GO

-- Prueba de error (ejemplar no disponible)
EXEC SP_RegistrarPrestamo @IDUsuario = 1, @IDEjemplar = 2, @DiasCredito = 14;
GO





