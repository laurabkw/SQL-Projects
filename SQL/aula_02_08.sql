CREATE DATABASE exercicio_02_08
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_bin;

USE exercicio_02_08;

CREATE TABLE filme (
cod_filme INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
titulo_filme VARCHAR(45),
genero_filme varchar(25)
);

CREATE TABLE cliente (
cod_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome_cliente VARCHAR(45),
idade INT,
cidade VARCHAR(45),
cod_pai_cliente INT
);

CREATE TABLE assistido (
cod_filme INT NOT NULL ,
cod_cliente INT NOT NULL,
data_assistido DATE,
FOREIGN KEY (cod_filme) REFERENCES filme(cod_filme),
FOREIGN KEY (cod_cliente) REFERENCES cliente(cod_cliente),
PRIMARY KEY (cod_filme,cod_cliente)
);

CREATE TABLE produtor (
cod_produtor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
razao_social VARCHAR(50),
cidade VARCHAR(45)
); 

INSERT INTO filme (titulo_filme, genero_filme) VALUES
('Coração Valente','Aventura'),
('Mont Python','Comédia'),
('A Lagoa Azul','Romance'),
('Se Beber, Não Case','Comédia');

INSERT INTO cliente (nome_cliente, idade, cidade, cod_pai_cliente) VALUES
('João','31','Vitória','2'),
('José','28','Vitória','4'),
('Luís','25','Belo Horizonte','2'),
('Sílvio','43','Vitória','1');

INSERT INTO assistido VALUES
('1','1','2018-01-01'),
('2','3','2018-01-05'),
('3','1','2018-02-01'),
('2','2','2018-01-03');

INSERT INTO produtor (razao_social, cidade) VALUES
('Sol & Mar Ltda.','Rio de Janeiro'),
('Multpel','São Paulo'),
('Oficina das Máquinas','Vitória'),
('Brinquedo & Cia. Ltda.','Belo Horizonte');

SELECT *
FROM filme;

SELECT *
FROM filme
WHERE genero_filme = 'Comédia';

SELECT *
FROM cliente
WHERE cidade = 'Vitória'
AND idade >= '30';

SELECT genero_filme
FROM filme;

SELECT cod_filme, titulo_filme
FROM filme
WHERE genero_filme = 'Comédia';

ALTER TABLE filme_romance
RENAME TO filme;

SELECT DISTINCT cidade
FROM cliente;

SELECT cidade
FROM produtor
UNION
SELECT cidade
FROM cliente;

SELECT *
FROM filme f, assistido a
WHERE f.cod_filme = a.cod_filme;

SELECT c.nome_cliente, c2.nome_cliente
FROM cliente c, cliente c2
WHERE c.cod_cliente = c2.cod_cliente;

SELECT c.nome_cliente, a.cod_filme, f.titulo_filme
FROM cliente c, assistido a, filme f
WHERE c.cod_cliente = a.cod_cliente
AND a.cod_filme = f.cod_filme;

SELECT DISTINCT cidade
FROM cliente INNER JOIN produtor USING(cidade);

SELECT DISTINCT titulo_filme
FROM filme INNER JOIN assistido USING(cod_filme);