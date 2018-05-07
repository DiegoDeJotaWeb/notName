drop database if exists notnamec_db;
create database notnamec_db;
use notnamec_db;

CREATE TABLE CLIENTE (
CLI_nCOD BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
CLI_cNOME VARCHAR(70),
CLI_cRG VARCHAR(15),
CLI_nCPF BIGINT(11) UNSIGNED UNIQUE,
CLI_dDTNASC DATE,
CLI_cGENERO CHAR(1),
CLI_nTRESIDENCIAL INT(10) UNSIGNED,
CLI_nTCELULAR INT(11) UNSIGNED,
CLI_nTCOMERCIAL INT(10) UNSIGNED,
CLI_cEMAIL VARCHAR(100) UNIQUE,
CLI_cLOGIN VARCHAR(20) UNIQUE,
CLI_cSENHA VARCHAR(20),
CLI_dDTULTIMO_ACESSO TIMESTAMP NULL DEFAULT NULL,
CLI_cSTATUS TINYINT UNSIGNED,
CLI_tPREFERENCIA TEXT DEFAULT NULL
)ENGINE = INNODB;

CREATE TABLE CLIENTE_VENDA (
CLI_VENDA_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CLI_nCOD BIGINT UNSIGNED,
VENDA_nID BIGINT UNSIGNED,
FOREIGN KEY(CLI_nCOD) REFERENCES CLIENTE (CLI_nCOD)
)ENGINE = INNODB;

CREATE TABLE VENDA (
VENDA_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
VENDA_nVLRTOTALVENDA DOUBLE(8,2) UNSIGNED,

VENDA_dtDTCOMPRA TIMESTAMP NULL DEFAULT NULL ,
VENDA_cCODRASTREIO VARCHAR(15)
)ENGINE = INNODB;

CREATE TABLE ENDERECO (
END_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
END_nCEP INT(8) UNSIGNED,
END_cLOGRADOURO VARCHAR(250),
END_cCIDADE VARCHAR(150),
END_cBAIRRO VARCHAR(150),
END_nNUMERO VARCHAR(7),
END_cCOMPLEMENTO VARCHAR(150),
END_cTIPO VARCHAR(30),
UF_nID INT UNSIGNED
)ENGINE = INNODB;

CREATE TABLE UF (
UF_nID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
UF_cUF CHAR(2),
UF_cDESCRICAO VARCHAR(30)
)ENGINE = INNODB;

CREATE TABLE PRODUTO (
PRODUTO_nID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
PRODUTO_cDESC VARCHAR(50),
PRODUTO_cDESCCOMPLETA TEXT,
PRODUTO_nSTATUS TINYINT UNSIGNED,
MARCA_nID INT UNSIGNED,
MODELO_nID BIGINT UNSIGNED
)ENGINE = INNODB;

CREATE TABLE MARCA (
MARCA_nID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
MARCA_cDESC VARCHAR(250),
MARCA_nSTATUS TINYINT UNSIGNED
)ENGINE = INNODB;

CREATE TABLE MODELO (
MODELO_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
MODELO_cNOME VARCHAR(150),
MODELO_cTAMANHO VARCHAR(10),
MODELO_cCOR VARCHAR(20),
MODELO_nVLR_VENDA DOUBLE(8,2) UNSIGNED,
MODELO_nSTATUS TINYINT,
MODELO_nVLR_COMPRA DOUBLE(8,2) UNSIGNED,
MODELO_dDATA_COMPRA DATE,
MODELO_nDESCONTO DOUBLE(8,2) UNSIGNED,
MODELO_nQTD_ESTOQUE FLOAT UNSIGNED
)ENGINE = INNODB;

CREATE TABLE PRODUTO_CATEGORIA (
PRODUTO_CATEGORIA_nID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CATEGORIA_nID INT UNSIGNED,
PRODUTO_nID INT UNSIGNED,
FOREIGN KEY(PRODUTO_nID) REFERENCES PRODUTO (PRODUTO_nID)
)ENGINE = INNODB;

CREATE TABLE COMPRA_ESTOQUE (
COMPRA_ESTOQUE_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
COMPRA_ESTOQUE_nVALORTOTAL DOUBLE(8,2) UNSIGNED,
COMPRA_ESTOQUE_dDATA DATE
)ENGINE = INNODB;

CREATE TABLE MODELO_COMPRA_ESTOQUE (
MOD_COMP_ESTOQUE_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
MODELO_COMPRA_ESTOQUE_nQTD FLOAT UNSIGNED,
MODELO_nID BIGINT UNSIGNED,
COMPRA_ESTOQUE_nID BIGINT UNSIGNED,
FOREIGN KEY(MODELO_nID) REFERENCES MODELO (MODELO_nID),
FOREIGN KEY(COMPRA_ESTOQUE_nID) REFERENCES COMPRA_ESTOQUE (COMPRA_ESTOQUE_nID)
)ENGINE = INNODB;

CREATE TABLE USUARIO (
USR_nCOD INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
USR_cSTATUS TINYINT UNSIGNED,
USR_cLOGIN VARCHAR(20) UNIQUE,
USR_cSENHA VARCHAR(20),
USR_cNOME VARCHAR(100),
USR_nPERMISSAO TINYINT UNSIGNED,
USR_EMAIL VARCHAR(100)
)ENGINE = INNODB;

CREATE TABLE PREFERENCIAS_SISTEMA (
ID_PREF_SISTEMA INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
NUM_CLIQUES BIGINT UNSIGNED,
PADRAO_SISTEMA TEXT
)ENGINE = INNODB;

CREATE TABLE VENDA_PRODUTO (
VENDA_PRODUTO_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
VENDA_nID BIGINT UNSIGNED,
VENDA_PRODUTO_tsDT_SEPARACAO TIMESTAMP NULL DEFAULT NULL ,
PRODUTO_nID INT UNSIGNED,
COMPRA_PRODUTO_QDTE FLOAT UNSIGNED,
FOREIGN KEY(VENDA_nID) REFERENCES VENDA (VENDA_nID),
FOREIGN KEY(PRODUTO_nID) REFERENCES PRODUTO (PRODUTO_nID)
)ENGINE = INNODB;

CREATE TABLE CATEGORIA (
CATEGORIA_nID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CATEGORIA_cDESC VARCHAR(99)
)ENGINE = INNODB;

CREATE TABLE CLIENTE_ENDERECO (
CLI_END_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
END_nID BIGINT UNSIGNED,
CLI_nCOD BIGINT UNSIGNED,
FOREIGN KEY(END_nID) REFERENCES ENDERECO (END_nID),
FOREIGN KEY(CLI_nCOD) REFERENCES CLIENTE (CLI_nCOD)
)ENGINE = INNODB;

CREATE TABLE VENDA_STATUS (
VENDA_STA_nID BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
STATUS_nID INT UNSIGNED,
VENDA_nID BIGINT UNSIGNED,
VENDA_STATUS_dDT_ATUALIZACAO TIMESTAMP NULL DEFAULT NULL,
FOREIGN KEY(VENDA_nID) REFERENCES VENDA (VENDA_nID)
)ENGINE = INNODB;

CREATE TABLE STATUS_VENDA (
STATUS_nID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
STATUS_cDESC VARCHAR(250)
)ENGINE = INNODB;

ALTER TABLE CLIENTE_VENDA ADD FOREIGN KEY(VENDA_nID) REFERENCES VENDA (VENDA_nID);
ALTER TABLE ENDERECO ADD FOREIGN KEY(UF_nID) REFERENCES UF (UF_nID);
ALTER TABLE PRODUTO ADD FOREIGN KEY(MARCA_nID) REFERENCES MARCA (MARCA_nID);
ALTER TABLE PRODUTO ADD FOREIGN KEY(MODELO_nID) REFERENCES MODELO (MODELO_nID);
ALTER TABLE PRODUTO_CATEGORIA ADD FOREIGN KEY(CATEGORIA_nID) REFERENCES CATEGORIA (CATEGORIA_nID);
ALTER TABLE VENDA_STATUS ADD FOREIGN KEY(STATUS_nID) REFERENCES STATUS_VENDA (STATUS_nID);


INSERT INTO USUARIO VALUES (0, 1, 'gabriela', '123', 'Gabriela Bransford', 1, 'gabriela_bransford@icloud.com.br');
UPDATE USUARIO SET USR_cSTATUS = 1 WHERE USR_nCOD = 1;


call USP_LOGIN('gabriela', '123');

DROP PROCEDURE USP_LOGIN;

DELIMITER $$
	CREATE PROCEDURE USP_LOGIN(IN LOGIN VARCHAR(20), IN SENHA VARCHAR(20))
	BEGIN

	IF EXISTS(SELECT * FROM USUARIO WHERE USR_cLOGIN = LOGIN)
	THEN
		IF EXISTS(SELECT * FROM USUARIO WHERE USR_cLOGIN = LOGIN AND USR_cSENHA = SENHA)
		THEN
			IF EXISTS(SELECT * FROM USUARIO WHERE USR_cLOGIN = LOGIN AND USR_cSENHA = SENHA AND USR_cSTATUS = 1)
				THEN
					SELECT * FROM USUARIO WHERE USR_cLOGIN = LOGIN AND USR_cSENHA = SENHA;
				ELSE
					SELECT 'Usuário desativado';
				END IF;
		ELSE
			SELECT 'Senha Inválida';
		END IF;
	ELSE
		SELECT 'Login Inválido';
	END IF;

	END $$
DELIMITER ;
