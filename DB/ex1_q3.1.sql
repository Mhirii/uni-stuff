CREATE TABLE IF NOT EXISTS PlaneType (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    weight INT NOT NULL,
    capacity INT NOT NULL,
    radius INT NOT NULL
);

CREATE TABLE IF NOT EXISTS TypeLocation (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Avion (
		NumMatricule VARCHAR PRIMARY KEY,
    typeLocationId INT,
    planeType INT,
    FOREIGN KEY (typeLocationId) REFERENCES TypeLocation(id),
    FOREIGN KEY (planeType) REFERENCES PlaneType(id)
);

CREATE TABLE IF NOT EXISTS Address (
    id SERIAL PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Localisation (
    id SERIAL PRIMARY KEY,
    villeAer VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Technician (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    addrId INT,
    telNumber VARCHAR(255) NOT NULL,
    salary FLOAT NOT NULL,
    FOREIGN KEY (addrId) REFERENCES Address(id)
);

CREATE TABLE IF NOT EXISTS TechnicianPlaneType (
    technicianId INT,
    planeTypeId INT,
    dateStart TIMESTAMP NOT NULL,
    dateFinish TIMESTAMP,
    PRIMARY KEY (technicianId, planeTypeId),
    FOREIGN KEY (technicianId) REFERENCES Technician(id),
    FOREIGN KEY (planeTypeId) REFERENCES PlaneType(id)
);

CREATE TABLE IF NOT EXISTS Pilot (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    addrId INT,
    telNumber VARCHAR(255) NOT NULL,
    salary FLOAT NOT NULL,
    FOREIGN KEY (addrId) REFERENCES Address(id)
);

CREATE TABLE IF NOT EXISTS MedicalTest (
    id SERIAL PRIMARY KEY,
    pilotId INT,
    doneAt TIMESTAMP NOT NULL,
    FOREIGN KEY (pilotId) REFERENCES Pilot(id)
);

CREATE TABLE IF NOT EXISTS Test (
    id SERIAL PRIMARY KEY,
    planeId VarChar(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    doneAt TIMESTAMP NOT NULL,
    etat VARCHAR(255) NOT NULL,
    minValue FLOAT NOT NULL,
    FOREIGN KEY (planeId) REFERENCES Avion(NumMatricule)
);

CREATE TABLE IF NOT EXISTS Vol (
    id SERIAL PRIMARY KEY,
		avionId VARCHAR NOT NULL,
    pilotId INT,
    villeDep VARCHAR(255) NOT NULL,
    villeArr VARCHAR(255) NOT NULL,
    hDep VARCHAR(255) NOT NULL,
    hArr VARCHAR(255) NOT NULL,
    FOREIGN KEY (pilotId) REFERENCES Pilot(id)
);


-- seed 

-- Insert data into Address table
INSERT INTO Address (id, country, city, street) VALUES
	(1 , 'France', 'Paris', 'Rue de Paris'),
	(2 , 'France', 'Nice', 'Rue de Nice'),
	(3 , 'France', 'Lyon', 'Rue de Lyon'),
	(4 , 'France', 'Marseille', 'Rue de Marseille');

-- Insert data into Pilot table
INSERT INTO Pilot (id, name, addrId) VALUES
(1, 'John Doe', 1),
(2, 'Jane Smith', 1),
(3, 'Alice Johnson', 2);

-- Insert data into PlaneType table
INSERT INTO PlaneType (id, name, weight, capacity, radius) VALUES
(1, 'A380', 1000, 100, 1000),
(2, 'Boeing 747', 800, 80, 900);

-- Insert data into Avion table
INSERT INTO Avion (NumMatricule, typeLocationId, planeType) VALUES
('A380', 1, 1),
('B747', 1, 2);

-- Insert data into Vol table
INSERT INTO Vol (id, pilotId, avionId, villeDep, volleArr, hDep, hArr) VALUES
(1, 1, 'A380', 'Nice', 'Paris', '12:00', '14:00'),
(2, 2, 'A380', 'Nice', 'Paris', '12:00', '14:00'),
(3, 3, 'B747', 'Paris', 'Nice', '12:00', '14:00'),
(4, 1, 'B747', 'Paris', 'Nice', '12:00', '14:00'),
(5, 2, 'A380', 'Paris', 'Nice', '12:00', '14:00'),
(6, 3, 'A380', 'Paris', 'Nice', '12:00', '14:00'),
(7, 1, 'A380', 'Nice', 'Paris', '12:00', '14:00'),
(8, 2, 'A380', 'Nice', 'Paris', '12:00', '14:00'),
(9, 3, 'B747', 'Paris', 'Nice', '12:00', '14:00'),
(10, 1, 'B747', 'Paris', 'Nice', '12:00', '14:00'),
(11, 2, 'A380', 'Paris', 'Nice', '12:00', '14:00'),
(12, 3, 'A380', 'Paris', 'Nice', '12:00', '14:00');

BEGIN TRANSACTION;

INSERT INTO PlaneType (id, name, weight, capacity, radius)
VALUES (10, 'Type1', 1000, 100, 1000);

INSERT INTO TypeLocation (id, name)
VALUES (10, 'Location1');

INSERT INTO Avion (NumMatricule, typeLocationId, planeType)
VALUES ('10', 10, 10);

COMMIT;


-- les pilots a paris vol de nice avec un A380
SELECT Pilot.name FROM Pilot 
JOIN Address ON Pilot.addrId = Address.id 
JOIN Vol ON Pilot.id = Vol.pilotId 
JOIN Avion ON Vol.avionId = Avion.NumMatricule 
JOIN PlaneType ON Avion.planeType = PlaneType.id 
WHERE Address.city = 'Paris' AND Vol.villeDep = 'Nice' AND Avion.NumMatricule = 'A380';


-- les vols par les pilotes id 100 et 204
SELECT * FROM Vol WHERE pilotId = 100 OR pilotId = 204;

-- par type davion le nbr de vols au departs de Paris
SELECT PlaneType.name, COUNT(*) FROM PlaneType
JOIN Avion ON PlaneType.id = Avion.planeType
JOIN Vol ON Avion.NumMatricule = Vol.avionId
JOIN Address ON Vol.villeDep = Address.city
WHERE Address.city = 'Paris'
GROUP BY PlaneType.name;
