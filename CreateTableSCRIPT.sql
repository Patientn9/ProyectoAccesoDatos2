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
