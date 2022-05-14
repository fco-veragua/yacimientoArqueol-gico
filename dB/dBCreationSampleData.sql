-- -----------------------------------------------------------------------------
-- Base de datos de YACIMIENTO ARQUEOLÓGICO - Fco Veragua Cabrera
-- -----------------------------------------------------------------------------
-- SCRIPT de Creación de la base de datos
-- -----------------------------------------------------------------------------
-- ÓRGANO_FINANCIERO (DNI_NIF, Nombre, Descripción, Tipo)
-- TURISTA (DNI, Nombre, Nacionalidad)
-- EXCAVACIÓN (Código, Nombre, Provincia, Nº_Arqueólogos, Fecha_Comienzo, Permite_Visita)
-- Financiación (DNI_NIF, Código_Excav)
-- Visita (Código_Excav, DNI_Turista)
-- CAMPAMENTOS (NºCampamento, Nombre)
-- TIENDAS (NºCampamento, NºTienda, Capacidad)
-- ARQUEÓLOGO (DNI, Nom_Apell, Edad, Código_ExcavTRABAJA, Código_ExcavDIRIGE, NºCampamento, NºTienda)
-- MAQUETA (Código, Nombre, Tamaño)
-- ESCÁNER_3D (Código, Precio)
-- Construyen (DNI, Código, Código_Escáner)
-- PROGRAMA (Código, Nombre, Descripción)
-- Usan (Código_Escáner, Código_Programa)
-- INFORMÁTICO (DNI, Nombre, Edad, Años_Exp)
-- Crean (Código_Programa, DNI_Informático)
-- -----------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI';
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- BORRADO DE TABLAS ANTIGUAS
-- -----------------------------------------------------------------------------
DROP TABLE ÓRGANO_FINANCIERO CASCADE CONSTRAINTS;
DROP TABLE TURISTA CASCADE CONSTRAINTS;
DROP TABLE EXCAVACIÓN CASCADE CONSTRAINTS;
DROP TABLE Financiación CASCADE CONSTRAINTS;
DROP TABLE Visita CASCADE CONSTRAINTS;
DROP TABLE CAMPAMENTOS CASCADE CONSTRAINTS;
DROP TABLE TIENDAS CASCADE CONSTRAINTS;
DROP TABLE ARQUEÓLOGO CASCADE CONSTRAINTS;
DROP TABLE MAQUETA CASCADE CONSTRAINTS;
DROP TABLE ESCÁNER_3D CASCADE CONSTRAINTS;
DROP TABLE Construyen CASCADE CONSTRAINTS;
DROP TABLE PROGRAMA CASCADE CONSTRAINTS;
DROP TABLE Usan CASCADE CONSTRAINTS;
DROP TABLE INFORMÁTICO CASCADE CONSTRAINTS;
DROP TABLE Crean CASCADE CONSTRAINTS;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- CREAR TABLAS
-- -----------------------------------------------------------------------------
-- ÓRGANO_FINANCIERO (DNI_NIF, Nombre, Descripción, Tipo)
-- Tipo -> E : EMPRESA PRIVADA - P : PARTICULAR
CREATE TABLE ÓRGANO_FINANCIERO (
    DNI_NIF     CHAR(9), 
    Nombre      VARCHAR2(100), 
    Descripción VARCHAR2(100), 
    Tipo CHAR,
    CONSTRAINT PK_ÓRGANO_FINANCIERO PRIMARY KEY (DNI_NIF),
    CONSTRAINT CK1_ÓRGANO_FINANCIERO CHECK ( Tipo IN ('E', 'P') )
); 

-- TURISTA (DNI, Nombre, Nacionalidad)
CREATE TABLE TURISTA (
    DNI             CHAR(9), 
    Nombre          VARCHAR2(100), 
    Nacionalidad    VARCHAR2(50),
    CONSTRAINT PK_TURISTA PRIMARY KEY (DNI)
);

-- EXCAVACIÓN (Código, Nombre, Provincia, Nº_Arqueólogos, Fecha_Comienzo, Permite_Visita)
-- Permite_Visita -> SÍ : S - NO : N
CREATE TABLE EXCAVACIÓN (
    Código          NUMBER, 
    Nombre          VARCHAR2(100), 
    Provincia       VARCHAR2(100), 
    Nº_Arqueólogos  NUMBER, 
    Fecha_Comienzo  DATE, 
    Permite_Visita  CHAR,
    CONSTRAINT PK_EXCAVACIÓN PRIMARY KEY (Código),
    CONSTRAINT CK1_EXCAVACIÓN CHECK ( Permite_Visita IN ('S', 'N') )
);

-- Financiación (DNI_NIF, Código_Excav)
CREATE TABLE Financiación (
    DNI_NIF         CHAR(9), 
    Código_Excav    NUMBER,
    CONSTRAINT PK_Financiación PRIMARY KEY (DNI_NIF, Código_Excav),
    CONSTRAINT FK1_Financiación FOREIGN KEY (DNI_NIF) REFERENCES ÓRGANO_FINANCIERO (DNI_NIF) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Financiación FOREIGN KEY (Código_Excav) REFERENCES EXCAVACIÓN (Código) 
        ON DELETE CASCADE
);

-- Visita (Código_Excav, DNI_Turista)
CREATE TABLE Visita (
    Código_Excav    NUMBER, 
    DNI_Turista     CHAR(9),
    CONSTRAINT PK_Visita PRIMARY KEY (Código_Excav, DNI_Turista),
    CONSTRAINT FK1_Visita FOREIGN KEY (Código_Excav) REFERENCES EXCAVACIÓN (Código) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Visita FOREIGN KEY (DNI_Turista) REFERENCES TURISTA (DNI) 
        ON DELETE CASCADE
);

-- CAMPAMENTOS (NºCampamento, Nombre)
CREATE TABLE CAMPAMENTOS (
    NºCampamento    NUMBER, 
    Nombre          VARCHAR(100),
    CONSTRAINT PK_CAMPAMENTOS PRIMARY KEY (NºCampamento)
);

-- TIENDAS (NºCampamento, NºTienda, Capacidad)
CREATE TABLE TIENDAS (
    NºCampamento    NUMBER, 
    NºTienda        NUMBER, 
    Capacidad       NUMBER,
    CONSTRAINT PK_TIENDAS PRIMARY KEY (NºCampamento, NºTienda),
    CONSTRAINT FK1_TIENDAS FOREIGN KEY (NºCampamento) REFERENCES CAMPAMENTOS (NºCampamento) 
        ON DELETE CASCADE
);

-- ARQUEÓLOGO (DNI, Nom_Apell, Edad, Código_ExcavTRABAJA, Código_ExcavDIRIGE, NºCampamento, NºTienda)
CREATE TABLE ARQUEÓLOGO (
    DNI                     CHAR(9), 
    Nom_Apell               VARCHAR2(100), 
    Edad                    NUMBER, 
    Código_ExcavTRABAJA     NUMBER, 
    Código_ExcavDIRIGE      NUMBER, 
    NºCampamento            NUMBER, 
    NºTienda                NUMBER,
    CONSTRAINT PK_ARQUEÓLOGO PRIMARY KEY (DNI),
    CONSTRAINT FK1_ARQUEÓLOGO FOREIGN KEY (NºCampamento, NºTienda) REFERENCES TIENDAS (NºCampamento, NºTienda) 
        ON DELETE CASCADE
);

-- MAQUETA (Código, Nombre, Tamaño)
CREATE TABLE MAQUETA (
    Código  NUMBER, 
    Nombre  VARCHAR2(100), 
    Tamaño  NUMBER,
    CONSTRAINT PK_MAQUETA PRIMARY KEY (Código)
);

-- ESCÁNER_3D (Código, Precio)
CREATE TABLE ESCÁNER_3D (
    Código  NUMBER, 
    Precio  NUMBER,
    CONSTRAINT PK_ESCÁNER_3D PRIMARY KEY (Código)
);

-- Construyen (DNI, Código, Código_Escáner)
CREATE TABLE Construyen (
    DNI             CHAR(9), 
    Código          NUMBER, 
    Código_Escáner  NUMBER,
    CONSTRAINT PK_Construyen PRIMARY KEY (DNI, Código),
    CONSTRAINT FK1_Construyen FOREIGN KEY (DNI) REFERENCES ARQUEÓLOGO (DNI) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Construyen FOREIGN KEY (Código) REFERENCES MAQUETA (Código) 
        ON DELETE CASCADE,
    CONSTRAINT FK3_Construyen FOREIGN KEY (Código_Escáner) REFERENCES ESCÁNER_3D (Código) 
        ON DELETE CASCADE
);

-- PROGRAMA (Código, Nombre, Descripción)
CREATE TABLE PROGRAMA (
    Código          NUMBER, 
    Nombre          VARCHAR2(100), 
    Descripción     VARCHAR2(100),
    CONSTRAINT PK_PROGRAMA PRIMARY KEY (Código)
);

-- Usan (Código_Escáner, Código_Programa)
CREATE TABLE Usan (
    Código_Escáner  NUMBER, 
    Código_Programa NUMBER,
    CONSTRAINT PK_Usan PRIMARY KEY (Código_Escáner, Código_Programa),
    CONSTRAINT FK1_Usan FOREIGN KEY (Código_Escáner) REFERENCES ESCÁNER_3D (Código) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Usan FOREIGN KEY (Código_Programa) REFERENCES PROGRAMA (Código) 
        ON DELETE CASCADE  
);

-- INFORMÁTICO (DNI, Nombre, Edad, Años_Exp)
CREATE TABLE INFORMÁTICO (
    DNI         CHAR(9), 
    Nombre      VARCHAR2(100), 
    Edad        NUMBER, 
    Años_Exp    NUMBER,
    CONSTRAINT PK_INFORMÁTICO PRIMARY KEY (DNI)
);

-- Crean (Código_Programa, DNI_Informático)
CREATE TABLE Crean (
    Código_Programa NUMBER, 
    DNI_Informático CHAR(9),
    CONSTRAINT PK_Crean PRIMARY KEY (Código_Programa, DNI_Informático),
    CONSTRAINT FK1_Crean FOREIGN KEY (Código_Programa) REFERENCES PROGRAMA (Código) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Crean FOREIGN KEY (DNI_Informático) REFERENCES INFORMÁTICO (DNI) 
        ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- INSERTAR DATOS
-- -----------------------------------------------------------------------------
-- ÓRGANO_FINANCIERO (DNI_NIF, Nombre, Descripción, Tipo)
INSERT INTO ÓRGANO_FINANCIERO VALUES ('11000000X', 'CAJA RURAL SUR', 'Preservar la esencia de nuestra historia', 'E');
INSERT INTO ÓRGANO_FINANCIERO VALUES ('12000000X', 'Gal Gadot', 'Maravillas del mundo antiguo', 'P');
INSERT INTO ÓRGANO_FINANCIERO VALUES ('13000000X', 'Amador Rivas', 'No cabe duda de la importancia del arte rupestre', 'P');
INSERT INTO ÓRGANO_FINANCIERO VALUES ('14000000X', 'SPACE X', 'Ni bitcoins ni cohetes, con los yacimientos a tope', 'E');
INSERT INTO ÓRGANO_FINANCIERO VALUES ('15000000X', 'APPLE', 'Lo mismo encuentran grafeno ...', 'E');

-- TURISTA (DNI, Nombre, Nacionalidad)
INSERT INTO TURISTA VALUES ('21000000X', 'Jaden', 'Rumana');
INSERT INTO TURISTA VALUES ('22000000X', 'Grigor', 'Rusa');
INSERT INTO TURISTA VALUES ('23000000X', 'Joan', 'Española');
INSERT INTO TURISTA VALUES ('24000000X', 'Carla', 'Española');
INSERT INTO TURISTA VALUES ('25000000X', 'Tommy', 'Francesa');

-- EXCAVACIÓN (Código, Nombre, Provincia, Nº_Arqueólogos, Fecha_Comienzo, Permite_Visita)
INSERT INTO EXCAVACIÓN VALUES (1111, 'New Altamira', 'Sevilla', 12, '15/02/2021', 'S');
INSERT INTO EXCAVACIÓN VALUES (2222, 'Atapuercos', 'Málaga', 23, '12/03/2021', 'S');
INSERT INTO EXCAVACIÓN VALUES (3333, 'Dólmen Tumbao', 'Huelva', 15, '23/03/2021', 'S');
INSERT INTO EXCAVACIÓN VALUES (4444, 'Los Centenares', 'Almería', 18, '28/04/2021', 'N');
INSERT INTO EXCAVACIÓN VALUES (5555, 'Recópolis', 'Granada', 19, '15/06/2021', 'N');

-- Financiación (DNI_NIF, Código_Excav)
INSERT INTO Financiación VALUES ('11000000X', '5555');
INSERT INTO Financiación VALUES ('12000000X', '4444');
INSERT INTO Financiación VALUES ('13000000X', '3333');
INSERT INTO Financiación VALUES ('14000000X', '2222');
INSERT INTO Financiación VALUES ('15000000X', '1111');

-- Visita (Código_Excav, DNI_Turista)
INSERT INTO Visita VALUES ('1111', '25000000X');
INSERT INTO Visita VALUES ('2222', '24000000X');
INSERT INTO Visita VALUES ('3333', '23000000X');
INSERT INTO Visita VALUES ('4444', '22000000X');
INSERT INTO Visita VALUES ('5555', '21000000X');

-- CAMPAMENTOS (NºCampamento, Nombre)
INSERT INTO CAMPAMENTOS VALUES (1, 'Campamento 1');
INSERT INTO CAMPAMENTOS VALUES (2, 'Campamento 2');
INSERT INTO CAMPAMENTOS VALUES (3, 'Campamento 3');
INSERT INTO CAMPAMENTOS VALUES (4, 'Campamento 4');
INSERT INTO CAMPAMENTOS VALUES (5, 'Campamento 5');

-- TIENDAS (NºCampamento, NºTienda, Capacidad)
INSERT INTO TIENDAS VALUES (1, 1, 20);
INSERT INTO TIENDAS VALUES (2, 2, 26);
INSERT INTO TIENDAS VALUES (3, 3, 23);
INSERT INTO TIENDAS VALUES (4, 4, 18);
INSERT INTO TIENDAS VALUES (5, 5, 31);

-- ARQUEÓLOGO (DNI, Nom_Apell, Edad, Código_ExcavTRABAJA, Código_ExcavDIRIGE, NºCampamento, NºTienda)
INSERT INTO ARQUEÓLOGO VALUES ('31000000X', 'Howard Carter',45, 1111, 1111, 1, 1);
INSERT INTO ARQUEÓLOGO VALUES ('32000000X', 'Heinrich Schliemann', 36, 2222, null, 2, 2);
INSERT INTO ARQUEÓLOGO VALUES ('33000000X', 'William Flinders Petrie', 51, 3333, 3333, 3, 3);
INSERT INTO ARQUEÓLOGO VALUES ('34000000X', 'Henri Breuil', 29, 4444, 4444, 4, 4);
INSERT INTO ARQUEÓLOGO VALUES ('35000000X', 'Kathleen Kenyon', 41, 5555, null, 5, 5);

-- MAQUETA (Código, Nombre, Tamaño)
INSERT INTO MAQUETA VALUES (1222, 'Maqueta 1', 55);
INSERT INTO MAQUETA VALUES (1333, 'Maqueta 2', 70);
INSERT INTO MAQUETA VALUES (1444, 'Maqueta 3', 67);
INSERT INTO MAQUETA VALUES (1555, 'Maqueta 4', 120);
INSERT INTO MAQUETA VALUES (1666, 'Maqueta 5', 90);

-- ESCÁNER_3D (Código, Precio)
INSERT INTO ESCÁNER_3D VALUES (0111, 340);
INSERT INTO ESCÁNER_3D VALUES (0222, 220);
INSERT INTO ESCÁNER_3D VALUES (0333, 510);
INSERT INTO ESCÁNER_3D VALUES (0444, 320);
INSERT INTO ESCÁNER_3D VALUES (0555, 250);

-- Construyen (DNI, Código, Código_Escáner)
INSERT INTO Construyen VALUES ('31000000X', 1222, 0111);
INSERT INTO Construyen VALUES ('32000000X', 1333, 0222);
INSERT INTO Construyen VALUES ('33000000X', 1444, 0333);
INSERT INTO Construyen VALUES ('34000000X', 1555, 0444);
INSERT INTO Construyen VALUES ('35000000X', 1666, 0555);

-- PROGRAMA (Código, Nombre, Descripción)
INSERT INTO PROGRAMA VALUES (0011, 'Model Artist', 'Rediseño de escenarios derruidos');
INSERT INTO PROGRAMA VALUES (0022, 'SELL', 'Representación a escala de superficies rocosas');
INSERT INTO PROGRAMA VALUES (0033, 'StateOLD', 'Creación de esquemas por capas');
INSERT INTO PROGRAMA VALUES (0044, 'SOS', 'Interfaz gráfica para la creación de maquetas en arcilla');
INSERT INTO PROGRAMA VALUES (0055, 'PHModel', 'Creación de maquetas a partit de fotografía');

-- Usan (Código_Escáner, Código_Programa)
INSERT INTO Usan VALUES (0111, 0011);
INSERT INTO Usan VALUES (0222, 0022);
INSERT INTO Usan VALUES (0333, 0033);
INSERT INTO Usan VALUES (0444, 0044);
INSERT INTO Usan VALUES (0555, 0055);

-- INFORMÁTICO (DNI, Nombre, Edad, Años_Exp)
INSERT INTO INFORMÁTICO VALUES ('41000000X', 'Chema Alonso', 34, 20);
INSERT INTO INFORMÁTICO VALUES ('42000000X', 'Julián', 22, 8);
INSERT INTO INFORMÁTICO VALUES ('43000000X', 'Carmen', 23, 12);
INSERT INTO INFORMÁTICO VALUES ('44000000X', 'Lucía', 32, 11);
INSERT INTO INFORMÁTICO VALUES ('45000000X', 'Domingo', 41, 14);

-- Crean (Código_Programa, DNI_Informático)
INSERT INTO Crean VALUES (0011, '41000000X');
INSERT INTO Crean VALUES (0022, '42000000X');
INSERT INTO Crean VALUES (0033, '43000000X');
INSERT INTO Crean VALUES (0044, '44000000X');
INSERT INTO Crean VALUES (0055, '45000000X');