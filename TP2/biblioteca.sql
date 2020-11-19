CREATE DATABASE IF NOT EXISTS biblioteca;

USE biblioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

-- Ejercicio 1
CREATE TABLE Autor (
    ID              INT             NOT NULL    AUTO_INCREMENT,
    Nombre          VARCHAR(30)     NOT NULL,
    Apellido        VARCHAR(30)     NOT NULL,
    Nacionalidad    VARCHAR(30)     NOT NULL,
    Residencia      VARCHAR(30)     NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE Libro (
    ISBN            VARCHAR(13)     NOT NULL,
    Titulo          VARCHAR(40)     NOT NULL,
    Editorial       VARCHAR(20)     NOT NULL,
    Precio	        FLOAT(10,2)     NOT NULL,
    PRIMARY KEY(ISBN)
);

CREATE TABLE Escribe(
    Año             YEAR             NOT NULL,
    ID              INT              NOT NULL,
    ISBN            VARCHAR(13)      NOT NULL,
    PRIMARY KEY(ID,ISBN),
    FOREIGN KEY (ID) REFERENCES Autor(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Libro(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Ejercicio 2
CREATE INDEX busqueda_apellido ON Autor(Apellido);
CREATE INDEX busqueda_titulo ON Libro(Titulo);

-- Ejercicio 3
INSERT INTO Autor(ID, Nombre,Apellido, Nacionalidad, Residencia) VALUES (DEFAULT, 'Isaac', 'Asimov', 'Rusia', 'Nueva York');
INSERT INTO Autor(ID, Nombre,Apellido, Nacionalidad, Residencia) VALUES (DEFAULT, 'George', 'Orwell', 'India', 'Londres');
INSERT INTO Autor(ID, Nombre,Apellido, Nacionalidad, Residencia) VALUES (DEFAULT, 'Douglas', 'Adams', 'Reino Unido', 'Montecito');
INSERT INTO Autor(ID, Nombre,Apellido, Nacionalidad, Residencia) VALUES (DEFAULT, 'Abelardo', 'Castillo', 'Argentina', 'Cordoba');


INSERT INTO Libro(ISBN, Titulo, Editorial, Precio) VALUES ('9789875666733', 'Trilogía de la fundación', 'Debolsillo', 2500);
INSERT INTO Libro(ISBN, Titulo, Editorial, Precio) VALUES ('9974793130', '1984', 'Dusa', 200);
INSERT INTO Libro(ISBN, Titulo, Editorial, Precio) VALUES ('9788433973108', 'Guía del autoestopista galáctico', 'Anagrama', 600);
INSERT INTO Libro(ISBN, Titulo, Editorial, Precio) VALUES ('123456789', 'Libro falso', 'UNR', 600);


INSERT INTO Escribe(ID,ISBN,Año) VALUES ((SELECT ID FROM Autor WHERE Nombre = 'Isaac' AND Apellido = 'Asimov'), '9789875666733', '1986');
INSERT INTO Escribe(ID,ISBN,Año) VALUES ((SELECT ID FROM Autor WHERE Nombre = 'George' AND Apellido = 'Orwell'), '9974793130', '1949');
INSERT INTO Escribe(ID,ISBN,Año) VALUES ((SELECT ID FROM Autor WHERE Nombre = 'Douglas' AND Apellido = 'Adams'), '9788433973108', '1979');
INSERT INTO Escribe(ID,ISBN,Año) VALUES ((SELECT ID FROM Autor WHERE Nombre = 'Abelardo' AND Apellido = 'Castillo'), '123456789', '1998');

-- Ejercicio 4
-- a)
UPDATE Autor SET Residencia = 'Buenos Aires' WHERE Nombre = 'Abelardo' AND Apellido = 'Castillo';

-- b)
UPDATE Libro SET Precio = Precio * 1.1 WHERE Editorial = 'UNR';

-- c)
-- UPDATE Libro IF Precio > 200 THEN SET Precio = Precio * 1.1 WHERE ISBN IN (SELECT ISBN FROM Escribe,Autor WHERE Escribe.ID = Autor.ID AND Nacionalidad <> 'Argentina') ELSE SET Precio = Precio * 1.2 WHERE ISBN IN (SELECT ISBN FROM Escribe,Autor WHERE Escribe.ID = Autor.ID AND Nacionalidad <> 'Argentina');
-- UPDATE Libro IF Precio > 200 THEN SET Precio = Precio * 1.1 ELSE SET Precio = Precio * 1.2 WHERE ISBN IN (SELECT ISBN FROM Escribe,Autor WHERE Escribe.ID = Autor.ID AND Nacionalidad <> 'Argentina');
-- GURVICH QUIERE HACERLO CON IF - PERO NO SABE. COMO SIEMPRE
-- ojo con el orden de los dos update que siguen
UPDATE Libro SET Precio = Precio * 1.1 WHERE ISBN IN (SELECT ISBN FROM Escribe,Autor WHERE Escribe.ID = Autor.ID AND Nacionalidad <> 'Argentina') AND Precio > 200 ;
UPDATE Libro SET Precio = Precio * 1.2 WHERE ISBN IN (SELECT ISBN FROM Escribe,Autor WHERE Escribe.ID = Autor.ID AND Nacionalidad <> 'Argentina') AND Precio <= 200 ;
-- d)
DELETE FROM Libro WHERE ISBN IN (SELECT ISBN FROM Escribe WHERE Año = '1998');
