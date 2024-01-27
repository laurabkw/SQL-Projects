CREATE DATABASE mat_30_08
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_bin;

USE mat_30_08;

CREATE TABLE editora(
id_editora SMALLINT PRIMARY KEY AUTO_INCREMENT,
nome_editora VARCHAR(40) NOT NULL
);

CREATE INDEX idx_nome_editora ON editora(nome_editora);

SHOW INDEX FROM editora;

DROP TABLE editora;

CREATE TABLE editora(
id_editora SMALLINT PRIMARY KEY AUTO_INCREMENT,
nome_editora VARCHAR(40) NOT NULL,
INDEX(nome_editora)
);

INSERT INTO editora (nome_editora) VALUES
('Mc Graw-Hill'),
('Apress'),
('Bookman'),
('Bookboon'),
('Packtpub'),
('O´Reilly'),
('Springer'),
('Érica'),
('For Dummies'),
('Navatec'),
('Microsoft Press'),
('Cisco Press'),
('Addison-Wesley'),
('Compainha das Letras'),
('Artech House'),
('CRC Press'),
('Manning'),
('Penguin Book'),
('Sage Publishing');

SELECT *
FROM editora;

SELECT *
FROM editora
WHERE nome_editora = 'Springer';

EXPLAIN
SELECT *
FROM editora
WHERE nome_editora = 'Springer';

DROP INDEX nome_editora ON editora;

CREATE USER laura
IDENTIFIED BY '123456';

SHOW GRANTS FOR laura;

GRANT SELECT, INSERT, UPDATE, DELETE
ON mat_30_08.*
TO laura;

GRANT SELECT, INSERT, UPDATE
ON mat_30_08.editora
TO laura;

GRANT SELECT(id_editora), UPDATE(nome_editora)
ON mat_30_08.editora
TO laura;

REVOKE DELETE
ON mat_30_08.editora
FROM laura;

REVOKE ALL, GRANT OPTION FROM laura;

DROP USER laura;