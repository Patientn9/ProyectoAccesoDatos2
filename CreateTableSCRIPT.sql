CREATE TABLE Familia (
	nombreID 	VARCHAR(50) PRIMARY KEY,
	habitad 	VARCHAR(50),
    	clase 		VARCHAR(50),
    	alimento 	VARCHAR(50)

);


CREATE TABLE Seta (
	nomCient 	VARCHAR(50) PRIMARY KEY,
    	nomComun 	VARCHAR(50),
    	colorCuerpo VARCHAR(50),
    	colorEspora VARCHAR(50),
    
    	nombreIDFamilia VARCHAR(50) ,
    	FOREIGN KEY (nombreIDFamilia) REFERENCES Familia(nombreID),
    
	toxicidad 	BOOLEAN

);

INSERT INTO Familia VALUES ("Mycenaceae", "general",	"Basidiomycota", "saprofito");
INSERT INTO Familia VALUES ("Hericiaceae", "templada", "Agaricomycetes", "saprofito");


INSERT INTO Seta VALUES ("Panellus stipticus", "Ostra agria", "Verde", "Marron", "Mycenaceae", false);
INSERT INTO Seta VALUES ("Panellus mitis ", "desconocido", "Blanco", "Blanco", "Mycenaceae", true); 
INSERT INTO Seta VALUES ("Hericium erinaceus", "Melena de leon", "Blanco", "Blanco", "Hericiaceae", false);
INSERT INTO Seta VALUES ("Hericium americanum", "Diente de oso", "Blanco", "Blanco", "Hericiaceae", false);



#Funcion para calcular el porcentaje de setas toxicas es una clase de setas
#Recordar para poder crear funciones
# set global log_bin_trust_function_creators = true;

	
DELIMITER $$
CREATE FUNCTION getPorcSetasToxicClase (familiaClase VARCHAR(50) ) RETURNS INT
BEGIN

	DECLARE totalSetas INT;
    DECLARE totalSetasToxic INT;
    
    SELECT count(*) INTO totalSetas FROM Seta WHERE nomCient IN (
		SELECT nomCient FROM Seta WHERE nombreIDFamilia = (
			SELECT nombreID FROM Familia WHERE clase = familiaClase 
        )
    );
    
    SELECT count(*) INTO totalSetasToxic FROM Seta WHERE 
    toxicidad = true AND
    nomCient IN (
		SELECT nomCient FROM Seta WHERE nombreIDFamilia = (
			SELECT nombreID FROM Familia WHERE clase = familiaClase 
        )
    );
    
    
   IF (totalSetas = 0 OR totalSetasToxic = 0) THEN
        RETURN 0;
    ELSE
        RETURN totalSetasToxic / totalSetas * 100;
    END IF;

END$$
DELIMITER ;



#SELECT getPorcSetasToxicClase('Basidiomycota') AS porcentaje_toxicidad;
