CREATE DATABASE exercicio_09_08
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_bin;

USE exercicio_09_08;

CREATE TABLE cidade(
cidade_id VARCHAR(5) NOT NULL PRIMARY KEY,
nome_cidade VARCHAR(50)
);

CREATE TABLE trajeto(
trajeto_id VARCHAR(5) NOT NULL PRIMARY KEY,
cidade_origem VARCHAR(15) NOT NULL,
cidade_destino VARCHAR(15) NOT NULL,
FOREIGN KEY (cidade_origem) REFERENCES cidade(cidade_id),
FOREIGN KEY (cidade_destino) REFERENCES cidade(cidade_id)
);

CREATE TABLE estrada(
estrada_id VARCHAR(5) NOT NULL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
cidade_origem VARCHAR(15) NOT NULL,
cidade_destino VARCHAR(15) NOT NULL,
extensao_km INT,
FOREIGN KEY (cidade_origem) REFERENCES cidade(cidade_id),
FOREIGN KEY (cidade_destino) REFERENCES cidade(cidade_id)
);

CREATE TABLE segmento(
trajeto_id VARCHAR(5) NOT NULL,
estrada_id VARCHAR(5) NOT NULL,
ordem VARCHAR(100),
PRIMARY KEY (trajeto_id,estrada_id),
FOREIGN KEY (trajeto_id) REFERENCES trajeto(trajeto_id),
FOREIGN KEY (estrada_id) REFERENCES estrada(estrada_id)
);

INSERT INTO cidade VALUES
('C1','Santa Cruz do Sul'),
('C2','Porto Alegre'),
('C3','Venâncio Aires'),
('C4','Canoas');

INSERT INTO trajeto VALUES
('T1','C1','C2'),
('T2','C2','C4'),
('T3','C1','C3'),
('T4','C3','C2');

INSERT INTO estrada VALUES
('E1','AA','C1','C3','2000'),
('E2','AB','C1','C3','200'),
('E3','AC','C1','C3','350'),
('E4','AA','C1','C2','100'),
('E5','AB','C1','C2','900'),
('E6','AC','C1','C2','700');

INSERT INTO segmento VALUES
('T1','E1','1'),
('T1','E2','2'),
('T1','E3','3'),
('T2','E4','1'),
('T2','E5','2'),
('T2','E6','3');

/*Exercício A*/
SELECT t.trajeto_id, SUM(e.extensao_km)
FROM trajeto t, segmento s, estrada e
WHERE t.trajeto_id = s.trajeto_id
AND s.estrada_id = e.estrada_id
GROUP BY t.trajeto_id;

/*Exercício B*/
SELECT t.trajeto_id
FROM trajeto t, segmento s, estrada e
WHERE t.trajeto_id = s.trajeto_id
AND s.estrada_id = e.estrada_id
AND t.cidade_origem <> e.cidade_origem
AND s.ordem = '1';

/*Exercício C (usando VIEW)*/
CREATE VIEW trajetonumseg AS
SELECT t.trajeto_id, t.cidade_destino, MAX(s.ordem) AS numseg
FROM trajeto t, segmento s
WHERE t.trajeto_id = s.trajeto_id
GROUP BY t.trajeto_id;

SELECT t.trajeto_id
FROM trajetonumseg t, segmento s, estrada e
WHERE t.trajeto_id = s.trajeto_id
AND s.estrada_id = e.estrada_id
AND t.cidade_destino <> e.cidade_destino
AND s.ordem = t.numseg;

/*Exercício D*/
CREATE VIEW total_trajeto AS
SELECT t.trajeto_id trajid, t.cidade_origem	origem, t.cidade_destino destino, SUM(e.extensao_km) extensao
FROM trajeto t, segmento s, estrada e
WHERE t.trajeto_id = s.trajeto_id
AND s.estrada_id = e.estrada_id
GROUP BY t.trajeto_id, t.cidade_origem, t.cidade_destino;

SELECT origem, destino, MIN(extensao)
FROM total_trajeto
GROUP BY origem, destino;

/*Exercício E*/
ALTER TABLE trajeto
ADD COLUMN extensao_km_total DOUBLE;

UPDATE trajeto t
SET t.extensao_km_total = (SELECT SUM(e.extensao_km)
							FROM segmento s, estrada e
                            WHERE t.trajeto_id = s.trajeto_id
                            AND s.estrada_id = e.estrada_id);
                            
SELECT *
FROM trajeto;

/*Exercício F*/
SELECT c.nome_cidade
FROM cidade c
WHERE c.cidade_id NOT IN (SELECT DISTINCT c.cidade_id
							FROM cidade c, trajeto t
                            WHERE c.cidade_id = t.cidade_origem);