CREATE DATABASE exercicio_22_08
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_bin;

USE exercicio_22_08;

CREATE TABLE cliente(
cod_cliente INT NOT NULL PRIMARY KEY,
nome VARCHAR(50),
data_nascimento DATE,
cpf BIGINT
);

CREATE TABLE pedido(
cod_pedido INT PRIMARY KEY,
cod_cliente INT,
data_pedido DATE,
nf VARCHAR(25),
valor_total DECIMAL(10,2),
FOREIGN KEY (cod_cliente) REFERENCES cliente(cod_cliente)
);

CREATE TABLE produto(
cod_produto INT NOT NULL PRIMARY KEY,
descricao VARCHAR(100)
);

CREATE TABLE item_pedido(
cod_pedido INT,
numero_item INT,
valor_unitario DECIMAL(10,2),
quantidade INT,
cod_produto INT,
PRIMARY KEY (cod_pedido, numero_item),
FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto),
FOREIGN KEY (cod_pedido) REFERENCES pedido(cod_pedido)
);

INSERT INTO cliente VALUES
('1','Sylvio Barbon','1984-12-05','12315541212'),
('2','Antonio Carlos da Silva','1970-11-01','12313345512'),
('3','Thiago Ribeiro','1964-11-15','12315544411'),
('4','Carlos Eduardo','1964-10-25','42515541212'),
('5','Maria Cristina Goes','1981-11-03','67715541212'),
('6','Ruan Manoel Fanjo','1983-12-06','32415541212'),
('7','Antônia Dias','2005-02-19','12312641212');

INSERT INTO pedido VALUES
('1','1','2012-04-01','00001','400.00'),
('2','2','2012-04-01','00002','10.90'),
('3','2','2012-04-01','00003','21.80'),
('4','3','2012-05-01','00004','169.10'),
('5','4','2012-05-01','00005','100.90'),
('6','6','2012-05-02','00006','51.35');

INSERT INTO produto VALUES
('1','Mouse'),
('2','Teclado'),
('3','Monitor LCD'),
('4','Caixas Acústicas'),
('5','Scanner de Mesa'),
('6','Notebook');

INSERT INTO item_pedido VALUES
('1','1','10.90','1','1'),
('1','2','389.10','1','3'),
('2','1','10.90','1','1'),
('3','1','10.90','1','1'),
('4','1','10.90','1','1'),
('4','2','15.90','2','2'),
('4','3','25.50','1','4'),
('4','4','100.90','1','5'),
('5','1','100.90','1','5'),
('6','1','25.50','2','4');

/*Exercício 1*/
CREATE VIEW clientes_maiores_view AS
SELECT c.nome nome, timestampdiff(YEAR,c.data_nascimento,NOW()) idade
FROM cliente c
WHERE timestampdiff(YEAR,c.data_nascimento,NOW()) > 18;

SELECT *
FROM clientes_maiores_view;

DROP VIEW clientes_maiores_view;

/*Exercício 2*/
CREATE VIEW ultimo_pedido_view AS
	SELECT c.nome, MAX(p.data_pedido) ultimo_pedido
	FROM cliente c, pedido p
	WHERE c.cod_cliente = p.cod_cliente
	GROUP BY c.nome;

SELECT *
FROM ultimo_pedido_view;

DROP VIEW ultimo_pedido_view;

/*Exercício 3*/
CREATE VIEW tabela_produto_view AS
	SELECT i.cod_produto produto, valor_unitario valor
	FROM pedido p, item_pedido i
	WHERE p.cod_pedido = i.cod_pedido
	GROUP BY i.cod_produto
	HAVING MAX(p.data_pedido);

SELECT *
FROM tabela_produto_view
ORDER BY produto;

/*Exercício 4*/
CREATE VIEW lista_nova_view AS
	SELECT MONTH(p.data_pedido) dt, p.nf nota_fiscal
	FROM pedido p
	WHERE YEAR(data_pedido) = '2012';

SELECT *
FROM lista_nova_view;

/*Exercício 5*/
CREATE VIEW produto_favorito_view AS
	SELECT p.cod_cliente cliente, i.cod_produto produto, SUM(i.quantidade) quantidade_vendida
	FROM pedido p, item_pedido i
	WHERE p.cod_pedido = i.cod_pedido
	GROUP BY produto, cliente;

SELECT cliente, produto, MAX(quantidade_vendida) produto_mais_vendido
FROM produto_favorito_view
GROUP BY cliente;

/*Exercício 6*/
CREATE VIEW produtos_defasados_view AS
	SELECT pr.descricao
	FROM produto pr
	WHERE pr.cod_produto NOT IN (SELECT DISTINCT i.cod_produto
									FROM pedido p, item_pedido i
									WHERE p.cod_pedido = i.cod_pedido
									AND p.data_pedido < (NOW()-90));
                                
SELECT *
FROM produtos_defasados_view;