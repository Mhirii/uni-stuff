BEGIN TRANSACTION;

INSERT INTO "PlaneType" (id, name, wieght, capacity, radius)
VALUES (1, 'Type1', '1000', '100', '1000');

INSERT INTO "TypeLocation" (id, name)
VALUES (1, 'Location1');

INSERT INTO "Avion" (NumMatricule, typeLocationId, planeType)
VALUES (1, 1, 1);

COMMIT;
