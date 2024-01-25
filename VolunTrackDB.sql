CREATE DATABASE VolunTrackDB
USE VolunTrackDB

CREATE TABLE Usuario (
    idUsuario INT IDENTITY (1, 1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
	NombreUsuario VARCHAR(50) NOT NULL,
	Contrasenia VARCHAR(50) NOT NULL,    
	FechaNacimiento DATE NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,

    CONSTRAINT PK_ID_Usuario PRIMARY KEY (idUsuario), 
	CONSTRAINT UK_NombreUsuario UNIQUE (nombreUsuario),
    CONSTRAINT CK_Email_Valido CHECK (Correo LIKE '%_@__%.__%'),
    CONSTRAINT CK_Dominio_Valido CHECK (Correo LIKE '%_@__%.com' OR Correo LIKE '%_@__%.net'),
    CONSTRAINT CK_Longitud_Email CHECK (LEN(Correo) >= 5 AND LEN(Correo) <= 50)
);

CREATE TABLE Evento (
    idEvento INT IDENTITY (1, 1) NOT NULL,
    Título VARCHAR(100) NOT NULL,
    Fecha DATE NOT NULL,
    Lugar VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(5000) NOT NULL,
    Hora TIME,

    CONSTRAINT PK_ID_Evento PRIMARY KEY (idEvento), 
);


CREATE TABLE Voluntariado (
    idVoluntariado INT IDENTITY (1, 1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    DuracionMeses INT CHECK (DuracionMeses > 0) NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    Lugar VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(5000) NOT NULL,

    CONSTRAINT PK_ID_Voluntariado PRIMARY KEY (idVoluntariado),
    CONSTRAINT CK_Fechas_Validas CHECK (FechaInicio <= FechaFin)
);

CREATE TABLE Recompensa (
    idRecompensa INT IDENTITY (1, 1) NOT NULL,
    Título VARCHAR(100) NOT NULL,
    Detalle VARCHAR(2000) NOT NULL,

    CONSTRAINT PK_ID_Recompensa PRIMARY KEY (idRecompensa), 
);

CREATE TABLE EstanteRecompensas (
    id_EstanteRecompensas INT IDENTITY(1, 1),
    idRecompensa INT,
    idUsuario INT,
    CONSTRAINT PK_EstanteRecompensas PRIMARY KEY (id_EstanteRecompensas),
    CONSTRAINT FK_EstanteRecompensas_Recompensa FOREIGN KEY (idRecompensa) REFERENCES Recompensa(idRecompensa),
    CONSTRAINT FK_EstanteRecompensas_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE OportunidadesVoluntariado (
    OportunidadesVoluntariado INT IDENTITY(1, 1),
    idVoluntariado INT,
    idUsuario INT,
    CONSTRAINT PK_OportunidadesVoluntariado PRIMARY KEY (OportunidadesVoluntariado),
    CONSTRAINT FK_OportunidadesVoluntariado_idVoluntariado FOREIGN KEY (idVoluntariado) REFERENCES Voluntariado(idVoluntariado),
    CONSTRAINT FK_OportunidadesVoluntariado_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE RegistroEventos (
    RegistroEventos INT IDENTITY(1, 1),
    idEvento INT,
    idUsuario INT,
    CONSTRAINT PK_RegistroEventos PRIMARY KEY (RegistroEventos),
    CONSTRAINT FK_RegistroEventos_idEvento FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
    CONSTRAINT FK_RegistroEventos_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

INSERT INTO Usuario VALUES ('Ariel Raura', 'ariel123', 'ariel123', '05/30/2002', 'arielrauradiaz@gmail.com', '0983483425', 'La Villaflora');
INSERT INTO Voluntariado VALUES ('Proyecto "Brilla Quito"', 5, '2024-01-23 14:30:00', '2024-01-25 14:30:00', 'Parque Inglés', 'Únete a nuestro emocionante proyecto "Brilla Quito" y contribuye a mejorar la calidad de vida de las comunidades locales. Estamos buscando voluntarios apasionados y comprometidos que deseen marcar la diferencia en la ciudad. Este proyecto se centra en diversas áreas, como la educación, el medio ambiente, y el bienestar comunitario.');
INSERT INTO Evento VALUES ('"Día de Cuidar Quito"', '2024-01-23', 'La Villaflora', '¡Únete a nosotros en el "Día de Cuidar Quito", un evento de voluntariado que transformará nuestra ciudad! Este día especial está dedicado a la comunidad y al medio ambiente, reuniendo a voluntarios comprometidos para realizar actividades significativas.', '14:30:00');
INSERT INTO Recompensa VALUES ('Estrella Solidaria', '¡Conviértete en nuestra "Estrella Solidaria" y brilla aún más por tu increíble contribución! Este premio exclusivo te ofrece una experiencia única que va más allá de las recompensas convencionales. ');
