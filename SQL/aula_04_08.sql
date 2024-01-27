CREATE DATABASE exercicio_04_08
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_bin;

USE exercicio_04_08;

CREATE TABLE profissao(
cod_profissao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome_profissao VARCHAR(60) NOT NULL
);

CREATE TABLE cliente(
cod_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome_cliente VARCHAR(45) NOT NULL,
data_nascimento DATE,
telefone INT,
cod_profissao INT NOT NULL,
FOREIGN KEY(cod_profissao) REFERENCES profissao(cod_profissao)
);

ALTER TABLE cliente
MODIFY COLUMN cod_profissao INT;

INSERT INTO profissao(nome_profissao) VALUES
('Programador'),
('Analista de Banco de Dados'),
('Suporte'),
('Estagiário');

INSERT INTO cliente(nome_cliente, data_nascimento, telefone, cod_profissao) VALUES
('João Pereira','1989-09-20','34567890','1'),
('Maria Barros','1972-01-22','34567891','2'),
('José Mendes','1983-04-29','34567892','2'),
('Rogério Cavalcante','1990-01-12','34567894','4');

INSERT INTO cliente(nome_cliente, data_nascimento, telefone) VALUES
('Janaina Pereira','1994-05-01','34656734');

CREATE TABLE pedido(
numero_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cod_cliente INT,
total_pedido DECIMAL(10,2),
FOREIGN KEY(cod_cliente) REFERENCES cliente(cod_cliente)
);

INSERT INTO pedido(cod_cliente, total_pedido) VALUES
('1','800'),
('2','900'),
('3','1200');

/* INNER JOIN */
SELECT c.nome_cliente, p.cod_cliente, p.numero_pedido
FROM cliente c INNER JOIN pedido p
ON c.cod_cliente = p.cod_cliente;

/* LEFT OUTER JOIN */
SELECT DISTINCT *
FROM cliente c LEFT OUTER JOIN profissao p
ON c.cod_profissao = p.cod_profissao;

/* RIGHT OUTER JOIN */
SELECT *
FROM cliente c RIGHT OUTER JOIN profissao p
ON c.cod_profissao = p.cod_profissao;

/* FULL OUTER JOIN */
SELECT DISTINCT *
FROM cliente c LEFT OUTER JOIN profissao p
ON c.cod_profissao = p.cod_profissao
UNION
SELECT *
FROM cliente c RIGHT OUTER JOIN profissao p
ON c.cod_profissao = p.cod_profissao;