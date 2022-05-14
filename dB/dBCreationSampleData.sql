-- -----------------------------------------------------------------------------
-- Base de datos de YACIMIENTO ARQUEOL�GICO - Fco Veragua Cabrera
-- -----------------------------------------------------------------------------
-- SCRIPT de Creaci�n de la base de datos
-- -----------------------------------------------------------------------------
-- �RGANO_FINANCIERO (DNI_NIF, Nombre, Descripci�n, Tipo)
-- TURISTA (DNI, Nombre, Nacionalidad)
-- EXCAVACI�N (C�digo, Nombre, Provincia, N�_Arque�logos, Fecha_Comienzo, Permite_Visita)
-- Financiaci�n (DNI_NIF, C�digo_Excav)
-- Visita (C�digo_Excav, DNI_Turista)
-- CAMPAMENTOS (N�Campamento, Nombre)
-- TIENDAS (N�Campamento, N�Tienda, Capacidad)
-- ARQUE�LOGO (DNI, Nom_Apell, Edad, C�digo_ExcavTRABAJA, C�digo_ExcavDIRIGE, N�Campamento, N�Tienda)
-- MAQUETA (C�digo, Nombre, Tama�o)
-- ESC�NER_3D (C�digo, Precio)
-- Construyen (DNI, C�digo, C�digo_Esc�ner)
-- PROGRAMA (C�digo, Nombre, Descripci�n)
-- Usan (C�digo_Esc�ner, C�digo_Programa)
-- INFORM�TICO (DNI, Nombre, Edad, A�os_Exp)
-- Crean (C�digo_Programa, DNI_Inform�tico)
-- -----------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI';
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- BORRADO DE TABLAS ANTIGUAS
-- -----------------------------------------------------------------------------
DROP TABLE �RGANO_FINANCIERO CASCADE CONSTRAINTS;
DROP TABLE TURISTA CASCADE CONSTRAINTS;
DROP TABLE EXCAVACI�N CASCADE CONSTRAINTS;
DROP TABLE Financiaci�n CASCADE CONSTRAINTS;
DROP TABLE Visita CASCADE CONSTRAINTS;
DROP TABLE CAMPAMENTOS CASCADE CONSTRAINTS;
DROP TABLE TIENDAS CASCADE CONSTRAINTS;
DROP TABLE ARQUE�LOGO CASCADE CONSTRAINTS;
DROP TABLE MAQUETA CASCADE CONSTRAINTS;
DROP TABLE ESC�NER_3D CASCADE CONSTRAINTS;
DROP TABLE Construyen CASCADE CONSTRAINTS;
DROP TABLE PROGRAMA CASCADE CONSTRAINTS;
DROP TABLE Usan CASCADE CONSTRAINTS;
DROP TABLE INFORM�TICO CASCADE CONSTRAINTS;
DROP TABLE Crean CASCADE CONSTRAINTS;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- CREAR TABLAS
-- -----------------------------------------------------------------------------
-- �RGANO_FINANCIERO (DNI_NIF, Nombre, Descripci�n, Tipo)
-- Tipo -> E : EMPRESA PRIVADA - P : PARTICULAR
CREATE TABLE �RGANO_FINANCIERO (
    DNI_NIF     CHAR(9), 
    Nombre      VARCHAR2(100), 
    Descripci�n VARCHAR2(100), 
    Tipo CHAR,
    CONSTRAINT PK_�RGANO_FINANCIERO PRIMARY KEY (DNI_NIF),
    CONSTRAINT CK1_�RGANO_FINANCIERO CHECK ( Tipo IN ('E', 'P') )
); 

-- TURISTA (DNI, Nombre, Nacionalidad)
CREATE TABLE TURISTA (
    DNI             CHAR(9), 
    Nombre          VARCHAR2(100), 
    Nacionalidad    VARCHAR2(50),
    CONSTRAINT PK_TURISTA PRIMARY KEY (DNI)
);

-- EXCAVACI�N (C�digo, Nombre, Provincia, N�_Arque�logos, Fecha_Comienzo, Permite_Visita)
-- Permite_Visita -> S� : S - NO : N
CREATE TABLE EXCAVACI�N (
    C�digo          NUMBER, 
    Nombre          VARCHAR2(100), 
    Provincia       VARCHAR2(100), 
    N�_Arque�logos  NUMBER, 
    Fecha_Comienzo  DATE, 
    Permite_Visita  CHAR,
    CONSTRAINT PK_EXCAVACI�N PRIMARY KEY (C�digo),
    CONSTRAINT CK1_EXCAVACI�N CHECK ( Permite_Visita IN ('S', 'N') )
);

-- Financiaci�n (DNI_NIF, C�digo_Excav)
CREATE TABLE Financiaci�n (
    DNI_NIF         CHAR(9), 
    C�digo_Excav    NUMBER,
    CONSTRAINT PK_Financiaci�n PRIMARY KEY (DNI_NIF, C�digo_Excav),
    CONSTRAINT FK1_Financiaci�n FOREIGN KEY (DNI_NIF) REFERENCES �RGANO_FINANCIERO (DNI_NIF) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Financiaci�n FOREIGN KEY (C�digo_Excav) REFERENCES EXCAVACI�N (C�digo) 
        ON DELETE CASCADE
);

-- Visita (C�digo_Excav, DNI_Turista)
CREATE TABLE Visita (
    C�digo_Excav    NUMBER, 
    DNI_Turista     CHAR(9),
    CONSTRAINT PK_Visita PRIMARY KEY (C�digo_Excav, DNI_Turista),
    CONSTRAINT FK1_Visita FOREIGN KEY (C�digo_Excav) REFERENCES EXCAVACI�N (C�digo) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Visita FOREIGN KEY (DNI_Turista) REFERENCES TURISTA (DNI) 
        ON DELETE CASCADE
);

-- CAMPAMENTOS (N�Campamento, Nombre)
CREATE TABLE CAMPAMENTOS (
    N�Campamento    NUMBER, 
    Nombre          VARCHAR(100),
    CONSTRAINT PK_CAMPAMENTOS PRIMARY KEY (N�Campamento)
);

-- TIENDAS (N�Campamento, N�Tienda, Capacidad)
CREATE TABLE TIENDAS (
    N�Campamento    NUMBER, 
    N�Tienda        NUMBER, 
    Capacidad       NUMBER,
    CONSTRAINT PK_TIENDAS PRIMARY KEY (N�Campamento, N�Tienda),
    CONSTRAINT FK1_TIENDAS FOREIGN KEY (N�Campamento) REFERENCES CAMPAMENTOS (N�Campamento) 
        ON DELETE CASCADE
);

-- ARQUE�LOGO (DNI, Nom_Apell, Edad, C�digo_ExcavTRABAJA, C�digo_ExcavDIRIGE, N�Campamento, N�Tienda)
CREATE TABLE ARQUE�LOGO (
    DNI                     CHAR(9), 
    Nom_Apell               VARCHAR2(100), 
    Edad                    NUMBER, 
    C�digo_ExcavTRABAJA     NUMBER, 
    C�digo_ExcavDIRIGE      NUMBER, 
    N�Campamento            NUMBER, 
    N�Tienda                NUMBER,
    CONSTRAINT PK_ARQUE�LOGO PRIMARY KEY (DNI),
    CONSTRAINT FK1_ARQUE�LOGO FOREIGN KEY (N�Campamento, N�Tienda) REFERENCES TIENDAS (N�Campamento, N�Tienda) 
        ON DELETE CASCADE
);

-- MAQUETA (C�digo, Nombre, Tama�o)
CREATE TABLE MAQUETA (
    C�digo  NUMBER, 
    Nombre  VARCHAR2(100), 
    Tama�o  NUMBER,
    CONSTRAINT PK_MAQUETA PRIMARY KEY (C�digo)
);

-- ESC�NER_3D (C�digo, Precio)
CREATE TABLE ESC�NER_3D (
    C�digo  NUMBER, 
    Precio  NUMBER,
    CONSTRAINT PK_ESC�NER_3D PRIMARY KEY (C�digo)
);

-- Construyen (DNI, C�digo, C�digo_Esc�ner)
CREATE TABLE Construyen (
    DNI             CHAR(9), 
    C�digo          NUMBER, 
    C�digo_Esc�ner  NUMBER,
    CONSTRAINT PK_Construyen PRIMARY KEY (DNI, C�digo),
    CONSTRAINT FK1_Construyen FOREIGN KEY (DNI) REFERENCES ARQUE�LOGO (DNI) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Construyen FOREIGN KEY (C�digo) REFERENCES MAQUETA (C�digo) 
        ON DELETE CASCADE,
    CONSTRAINT FK3_Construyen FOREIGN KEY (C�digo_Esc�ner) REFERENCES ESC�NER_3D (C�digo) 
        ON DELETE CASCADE
);

-- PROGRAMA (C�digo, Nombre, Descripci�n)
CREATE TABLE PROGRAMA (
    C�digo          NUMBER, 
    Nombre          VARCHAR2(100), 
    Descripci�n     VARCHAR2(100),
    CONSTRAINT PK_PROGRAMA PRIMARY KEY (C�digo)
);

-- Usan (C�digo_Esc�ner, C�digo_Programa)
CREATE TABLE Usan (
    C�digo_Esc�ner  NUMBER, 
    C�digo_Programa NUMBER,
    CONSTRAINT PK_Usan PRIMARY KEY (C�digo_Esc�ner, C�digo_Programa),
    CONSTRAINT FK1_Usan FOREIGN KEY (C�digo_Esc�ner) REFERENCES ESC�NER_3D (C�digo) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Usan FOREIGN KEY (C�digo_Programa) REFERENCES PROGRAMA (C�digo) 
        ON DELETE CASCADE  
);

-- INFORM�TICO (DNI, Nombre, Edad, A�os_Exp)
CREATE TABLE INFORM�TICO (
    DNI         CHAR(9), 
    Nombre      VARCHAR2(100), 
    Edad        NUMBER, 
    A�os_Exp    NUMBER,
    CONSTRAINT PK_INFORM�TICO PRIMARY KEY (DNI)
);

-- Crean (C�digo_Programa, DNI_Inform�tico)
CREATE TABLE Crean (
    C�digo_Programa NUMBER, 
    DNI_Inform�tico CHAR(9),
    CONSTRAINT PK_Crean PRIMARY KEY (C�digo_Programa, DNI_Inform�tico),
    CONSTRAINT FK1_Crean FOREIGN KEY (C�digo_Programa) REFERENCES PROGRAMA (C�digo) 
        ON DELETE CASCADE,
    CONSTRAINT FK2_Crean FOREIGN KEY (DNI_Inform�tico) REFERENCES INFORM�TICO (DNI) 
        ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- INSERTAR DATOS
-- -----------------------------------------------------------------------------
-- �RGANO_FINANCIERO (DNI_NIF, Nombre, Descripci�n, Tipo)
INSERT INTO �RGANO_FINANCIERO VALUES ('11000000X', 'CAJA RURAL SUR', 'Preservar la esencia de nuestra historia', 'E');
INSERT INTO �RGANO_FINANCIERO VALUES ('12000000X', 'Gal Gadot', 'Maravillas del mundo antiguo', 'P');
INSERT INTO �RGANO_FINANCIERO VALUES ('13000000X', 'Amador Rivas', 'No cabe duda de la importancia del arte rupestre', 'P');
INSERT INTO �RGANO_FINANCIERO VALUES ('14000000X', 'SPACE X', 'Ni bitcoins ni cohetes, con los yacimientos a tope', 'E');
INSERT INTO �RGANO_FINANCIERO VALUES ('15000000X', 'APPLE', 'Lo mismo encuentran grafeno ...', 'E');

-- TURISTA (DNI, Nombre, Nacionalidad)
INSERT INTO TURISTA VALUES ('21000000X', 'Jaden', 'Rumana');
INSERT INTO TURISTA VALUES ('22000000X', 'Grigor', 'Rusa');
INSERT INTO TURISTA VALUES ('23000000X', 'Joan', 'Espa�ola');
INSERT INTO TURISTA VALUES ('24000000X', 'Carla', 'Espa�ola');
INSERT INTO TURISTA VALUES ('25000000X', 'Tommy', 'Francesa');

-- EXCAVACI�N (C�digo, Nombre, Provincia, N�_Arque�logos, Fecha_Comienzo, Permite_Visita)
INSERT INTO EXCAVACI�N VALUES (1111, 'New Altamira', 'Sevilla', 12, '15/02/2021', 'S');
INSERT INTO EXCAVACI�N VALUES (2222, 'Atapuercos', 'M�laga', 23, '12/03/2021', 'S');
INSERT INTO EXCAVACI�N VALUES (3333, 'D�lmen Tumbao', 'Huelva', 15, '23/03/2021', 'S');
INSERT INTO EXCAVACI�N VALUES (4444, 'Los Centenares', 'Almer�a', 18, '28/04/2021', 'N');
INSERT INTO EXCAVACI�N VALUES (5555, 'Rec�polis', 'Granada', 19, '15/06/2021', 'N');

-- Financiaci�n (DNI_NIF, C�digo_Excav)
INSERT INTO Financiaci�n VALUES ('11000000X', '5555');
INSERT INTO Financiaci�n VALUES ('12000000X', '4444');
INSERT INTO Financiaci�n VALUES ('13000000X', '3333');
INSERT INTO Financiaci�n VALUES ('14000000X', '2222');
INSERT INTO Financiaci�n VALUES ('15000000X', '1111');

-- Visita (C�digo_Excav, DNI_Turista)
INSERT INTO Visita VALUES ('1111', '25000000X');
INSERT INTO Visita VALUES ('2222', '24000000X');
INSERT INTO Visita VALUES ('3333', '23000000X');
INSERT INTO Visita VALUES ('4444', '22000000X');
INSERT INTO Visita VALUES ('5555', '21000000X');

-- CAMPAMENTOS (N�Campamento, Nombre)
INSERT INTO CAMPAMENTOS VALUES (1, 'Campamento 1');
INSERT INTO CAMPAMENTOS VALUES (2, 'Campamento 2');
INSERT INTO CAMPAMENTOS VALUES (3, 'Campamento 3');
INSERT INTO CAMPAMENTOS VALUES (4, 'Campamento 4');
INSERT INTO CAMPAMENTOS VALUES (5, 'Campamento 5');

-- TIENDAS (N�Campamento, N�Tienda, Capacidad)
INSERT INTO TIENDAS VALUES (1, 1, 20);
INSERT INTO TIENDAS VALUES (2, 2, 26);
INSERT INTO TIENDAS VALUES (3, 3, 23);
INSERT INTO TIENDAS VALUES (4, 4, 18);
INSERT INTO TIENDAS VALUES (5, 5, 31);

-- ARQUE�LOGO (DNI, Nom_Apell, Edad, C�digo_ExcavTRABAJA, C�digo_ExcavDIRIGE, N�Campamento, N�Tienda)
INSERT INTO ARQUE�LOGO VALUES ('31000000X', 'Howard Carter',45, 1111, 1111, 1, 1);
INSERT INTO ARQUE�LOGO VALUES ('32000000X', 'Heinrich Schliemann', 36, 2222, null, 2, 2);
INSERT INTO ARQUE�LOGO VALUES ('33000000X', 'William Flinders Petrie', 51, 3333, 3333, 3, 3);
INSERT INTO ARQUE�LOGO VALUES ('34000000X', 'Henri Breuil', 29, 4444, 4444, 4, 4);
INSERT INTO ARQUE�LOGO VALUES ('35000000X', 'Kathleen Kenyon', 41, 5555, null, 5, 5);

-- MAQUETA (C�digo, Nombre, Tama�o)
INSERT INTO MAQUETA VALUES (1222, 'Maqueta 1', 55);
INSERT INTO MAQUETA VALUES (1333, 'Maqueta 2', 70);
INSERT INTO MAQUETA VALUES (1444, 'Maqueta 3', 67);
INSERT INTO MAQUETA VALUES (1555, 'Maqueta 4', 120);
INSERT INTO MAQUETA VALUES (1666, 'Maqueta 5', 90);

-- ESC�NER_3D (C�digo, Precio)
INSERT INTO ESC�NER_3D VALUES (0111, 340);
INSERT INTO ESC�NER_3D VALUES (0222, 220);
INSERT INTO ESC�NER_3D VALUES (0333, 510);
INSERT INTO ESC�NER_3D VALUES (0444, 320);
INSERT INTO ESC�NER_3D VALUES (0555, 250);

-- Construyen (DNI, C�digo, C�digo_Esc�ner)
INSERT INTO Construyen VALUES ('31000000X', 1222, 0111);
INSERT INTO Construyen VALUES ('32000000X', 1333, 0222);
INSERT INTO Construyen VALUES ('33000000X', 1444, 0333);
INSERT INTO Construyen VALUES ('34000000X', 1555, 0444);
INSERT INTO Construyen VALUES ('35000000X', 1666, 0555);

-- PROGRAMA (C�digo, Nombre, Descripci�n)
INSERT INTO PROGRAMA VALUES (0011, 'Model Artist', 'Redise�o de escenarios derruidos');
INSERT INTO PROGRAMA VALUES (0022, 'SELL', 'Representaci�n a escala de superficies rocosas');
INSERT INTO PROGRAMA VALUES (0033, 'StateOLD', 'Creaci�n de esquemas por capas');
INSERT INTO PROGRAMA VALUES (0044, 'SOS', 'Interfaz gr�fica para la creaci�n de maquetas en arcilla');
INSERT INTO PROGRAMA VALUES (0055, 'PHModel', 'Creaci�n de maquetas a partit de fotograf�a');

-- Usan (C�digo_Esc�ner, C�digo_Programa)
INSERT INTO Usan VALUES (0111, 0011);
INSERT INTO Usan VALUES (0222, 0022);
INSERT INTO Usan VALUES (0333, 0033);
INSERT INTO Usan VALUES (0444, 0044);
INSERT INTO Usan VALUES (0555, 0055);

-- INFORM�TICO (DNI, Nombre, Edad, A�os_Exp)
INSERT INTO INFORM�TICO VALUES ('41000000X', 'Chema Alonso', 34, 20);
INSERT INTO INFORM�TICO VALUES ('42000000X', 'Juli�n', 22, 8);
INSERT INTO INFORM�TICO VALUES ('43000000X', 'Carmen', 23, 12);
INSERT INTO INFORM�TICO VALUES ('44000000X', 'Luc�a', 32, 11);
INSERT INTO INFORM�TICO VALUES ('45000000X', 'Domingo', 41, 14);

-- Crean (C�digo_Programa, DNI_Inform�tico)
INSERT INTO Crean VALUES (0011, '41000000X');
INSERT INTO Crean VALUES (0022, '42000000X');
INSERT INTO Crean VALUES (0033, '43000000X');
INSERT INTO Crean VALUES (0044, '44000000X');
INSERT INTO Crean VALUES (0055, '45000000X');