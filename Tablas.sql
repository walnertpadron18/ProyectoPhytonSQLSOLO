CREATE DATABASE IF NOT EXISTS ProyectoSoloSQL;
USE ProyectoSoloSQL;

CREATE TABLE territorio (
    id_territorio INT AUTO_INCREMENT PRIMARY KEY,
    territorio    VARCHAR(20) NOT NULL UNIQUE,
    latitud       DECIMAL(9,6) NULL,                 
    longitud      DECIMAL(9,6) NULL
);

CREATE TABLE residencia (
    codigo_residencia VARCHAR(100)  PRIMARY KEY,     
    residencia        VARCHAR(100) NOT NULL,
    ciudad_clima      VARCHAR(20)  NULL,          
    latitud           DECIMAL(9,6) NULL,
    longitud          DECIMAL(9,6) NULL
);

CREATE TABLE tipo_viajero (
    id_tipo_viajero INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_viajero VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE turismo (
    id_turismo        INT AUTO_INCREMENT PRIMARY KEY,
    periodo           DATE          NOT NULL,        
    id_territorio     INT           NOT NULL,
    codigo_residencia VARCHAR(100)   NOT NULL,
    id_tipo_viajero   INT           NOT NULL,
    turistas          DECIMAL(14,2) NULL,        
        FOREIGN KEY (id_territorio)     REFERENCES territorio (id_territorio),
        FOREIGN KEY (codigo_residencia) REFERENCES residencia (codigo_residencia),
        FOREIGN KEY (id_tipo_viajero)   REFERENCES tipo_viajero (id_tipo_viajero)
);

CREATE TABLE clima_destino_mensual (
    id_territorio INT          NOT NULL,
    periodo       DATE         NOT NULL,
    temp_media    DECIMAL(5,2) NULL,
    lluvia_total  DECIMAL(8,2) NULL,
    PRIMARY KEY (id_territorio, periodo),          
	FOREIGN KEY (id_territorio) REFERENCES territorio (id_territorio)
);

CREATE TABLE clima_origen_mensual (
    codigo_residencia VARCHAR(20)  NOT NULL,
    periodo           DATE         NOT NULL,
    temp_media        DECIMAL(5,2) NULL,
    lluvia_total      DECIMAL(8,2) NULL,
    PRIMARY KEY (codigo_residencia, periodo),      
	FOREIGN KEY (codigo_residencia) REFERENCES residencia (codigo_residencia)
);