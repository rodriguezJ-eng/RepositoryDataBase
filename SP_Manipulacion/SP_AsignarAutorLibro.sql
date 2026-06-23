
-- SP_AsignarAutorALibro
-- Registra la relación M:M entre Libro y Autor en LibroAutor.
-- Acción: INSERT en tabla intermedia LibroAutor
CREATE PROCEDURE SP_AsignarAutorALibro
    @IDLibro INT,
    @IDAutor INT
AS
BEGIN

    DECLARE @LibroExiste INT;
    DECLARE @AutorExiste INT;
    DECLARE @RelacionExiste INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT @LibroExiste = COUNT(*)
        FROM Libro
        WHERE IDLibro = @IDLibro;

        SELECT @AutorExiste = COUNT(*)
        FROM Autor
        WHERE IDAutor = @IDAutor;

        SELECT @RelacionExiste = COUNT(*)
        FROM LibroAutor
        WHERE IDLibro = @IDLibro AND IDAutor = @IDAutor;

        IF @LibroExiste = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: No existe el libro con ese ID.';
            RETURN;
        END

        IF @AutorExiste = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: No existe el autor con ese ID.';
            RETURN;
        END

        IF @RelacionExiste > 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'ERROR: El autor ya está asociado a este libro.';
            RETURN;
        END

        INSERT INTO LibroAutor (IDLibro, IDAutor)
        VALUES (@IDLibro, @IDAutor);

        COMMIT TRANSACTION;
        PRINT 'Relación Libro-Autor registrada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'ERROR inesperado al asignar el autor.';
    END CATCH
END;
GO

-- Prueba de éxito
EXECUTE AS USER = 'EstudianteB';
SELECT USER_NAME() AS UsuarioActual;
EXEC SP_AsignarAutorALibro @IDLibro = 1, @IDAutor = 8;
REVERT;
GO

-- Prueba de error (relación duplicada)
EXEC SP_AsignarAutorALibro @IDLibro = 1, @IDAutor = 1;
GO

-- Verificar tabla intermedia
SELECT
    la.IDLibro,
    l.Titulo,
    la.IDAutor,
    a.Nombre + ' ' + a.Apellido AS Autor
FROM LibroAutor la
JOIN Libro l ON la.IDLibro = l.IDLibro
JOIN Autor a ON la.IDAutor = a.IDAutor
ORDER BY la.IDLibro;
GO