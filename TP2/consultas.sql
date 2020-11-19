USE inmobiliaria;
-- a)
SELECT nombre, apellido FROM Propietario,Persona WHERE Propietario.codigo = Persona.codigo;

-- b)
SELECT codigo FROM Inmueble WHERE precio >= 600000 AND precio <= 700000; 

-- c)
 SELECT nombre FROM Persona WHERE codigo IN (
                    SELECT codigo_cliente 
                    FROM PrefiereZona 
                    WHERE nombre_zona = 'Norte' AND nombre_poblacion = 'Santa Fe');

-- d)
SELECT nombre FROM Persona WHERE codigo IN 
   (SELECT vendedor 
    FROM 
      (SELECT codigo_cliente FROM PrefiereZona WHERE nombre_zona = 'Centro' AND nombre_poblacion = 'Rosario') CentroRosario, Cliente
      WHERE Cliente.codigo = CentroRosario.codigo_cliente);

-- e)
SELECT nombre_zona, COUNT(Precio), AVG(Precio)  FROM Inmueble WHERE nombre_poblacion = 'Rosario' GROUP BY nombre_zona; 

-- f)
SELECT nombre FROM Persona WHERE codigo IN 
 (SELECT codigo_cliente FROM 
 (SELECT * FROM Zona WHERE nombre_poblacion = 'Santa Fe') Zonita, PrefiereZona
 WHERE PrefiereZona.nombre_poblacion = Zonita.nombre_poblacion AND PrefiereZona.nombre_zona = Zonita.nombre_zona -- sacamos los numeros de cliente
 GROUP BY codigo_cliente
 HAVING COUNT(PrefiereZona.nombre_poblacion) = (SELECT COUNT(nombre_zona) FROM Zona WHERE nombre_poblacion = 'Santa Fe')); -- nos fijamos que esten todas las zonas