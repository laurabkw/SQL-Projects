CREATE DATABASE exercicio1_04_08
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_bin;

USE exercicio1_04_08;

CREATE TABLE departamento(
codigoDepartamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nomeDepartamento VARCHAR(30),
localizacao VARCHAR(20),
codigoFuncionario INT NOT NULL
);

CREATE TABLE funcionario(
codigoFuncionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
primeiroNome VARCHAR(15),
segundoNome VARCHAR(15),
ultimoNome VARCHAR(20),
dataNascimento DATE,
cpf BIGINT,
rg BIGINT,
endereco VARCHAR(50),
cep INT,
cidade VARCHAR(50),
telefone INT,
codigoDepartamento INT NOT NULL,
funcao VARCHAR(50),
salario DECIMAL(6,2),
FOREIGN KEY (codigoDepartamento) REFERENCES departamento(codigoDepartamento)
);

INSERT INTO departamento(nomeDepartamento, localizacao, codigoFuncionario) VALUES
('Contábeis','Andar 1','1'),
('Estoque','Andar 2','2'),
('Marketing','Andar 2','3'),
('Marketing','Andar 3','3');

INSERT INTO funcionario(primeiroNome, segundoNome, ultimoNome, dataNascimento, cpf, rg, endereco, cep, cidade, telefone, codigoDepartamento, funcao, salario) VALUES
('Carlos','Augusto','Gomes','1990-05-03','047301490','1234567','Rua Paraíso','12345','Santa Rosa','995161492','1','Estagiário','1000.00'),
('Felipe','','Almeida','1992-08-01','578632197','7654321','Rua Cabo Verde','54321','Santa Maria','968420137','2','Pessoal','1500.00'),
('Ana','','Cavalcante','2000-11-28','712036941','3217564','Rua Tenente Coronel Brito','35241','Rio Pardo','985304761','3','Supervisor','2400.00'),
('Sofia','Fernanda','Cunha','1999-04-09','684179261','7534261','Rua Ipê Amarelo','58967','Recife','984201367','4','Telefonista','1500.00');

/*Exercício 1*/
SELECT primeiroNome, ultimoNome
FROM funcionario
ORDER BY ultimoNome;

/*Exercício 2*/
SELECT *
FROM funcionario
ORDER BY cidade;

/*Exercício 3*/
SELECT primeiroNome ,segundoNome ,ultimoNome ,salario
FROM funcionario
WHERE salario > '1000.00'
ORDER BY primeiroNome, segundoNome, ultimoNome;	

/*Exercício 4*/
SELECT primeiroNome, dataNascimento
FROM funcionario
ORDER BY dataNascimento DESC, primeiroNome;

/*Exercício 5*/
SELECT primeiroNome ,segundoNome ,ultimoNome ,telefone, endereco, cidade
FROM funcionario
ORDER BY primeiroNome ,segundoNome ,ultimoNome;

/*Exercício 6*/
SELECT SUM(salario) AS folhaPagamento
FROM funcionario;

/*Exercício 7*/
/*SELECT com JOIN*/
SELECT f.primeiroNome, d.nomeDepartamento, f.funcao
FROM funcionario f JOIN departamento d ON f.codigoDepartamento = d.codigoDepartamento
ORDER BY f.primeiroNome;

/*SELECT sem JOIN*/
SELECT f.primeiroNome, d.nomeDepartamento, f.funcao
FROM funcionario f, departamento d
WHERE f.codigoDepartamento = d.codigoDepartamento
ORDER BY f.primeiroNome;

/*Exercício 8*/
SELECT d.nomeDepartamento, f.primeiroNome
FROM departamento d JOIN funcionario f ON d.codigoFuncionario = f.codigoFuncionario
ORDER BY d.nomeDepartamento;

/*Exercício 9*/
SELECT SUM(f.salario) AS totalDepartamento, d.nomeDepartamento
FROM funcionario f, departamento d
WHERE f.codigoDepartamento = d.codigoDepartamento
GROUP BY d.nomeDepartamento;

/*Exercício 10*/
SELECT DISTINCT  f.primeiroNome, d.nomeDepartamento, f.funcao
FROM departamento d, funcionario f
WHERE f.funcao = 'Supervisor'
AND
f.codigoDepartamento = d.codigoDepartamento
ORDER BY f.primeiroNome;

/*Exercício 11*/
SELECT COUNT(primeiroNome) AS quantidadeFuncionarios
FROM funcionario;

/*Exercício 12*/
SELECT ROUND(AVG(salario),2) AS mediaSalario
FROM funcionario;

/*Exercício 13*/
SELECT d.nomeDepartamento, MIN(f.salario)
FROM funcionario f JOIN departamento d ON f.codigoDepartamento = d.codigoDepartamento
GROUP BY d.nomeDepartamento;

/*Exercício 14*/
SELECT primeiroNome, segundoNome, ultimoNome
FROM funcionario
WHERE segundoNome = '';

/*Exercício 15*/
SELECT f.primeiroNome, d.nomeDepartamento
FROM funcionario f JOIN departamento d ON f.codigoDepartamento = d.codigoDepartamento
ORDER BY d.nomeDepartamento;

/*Exercício 16*/
SELECT primeiroNome, cidade, funcao
FROM funcionario
WHERE cidade = 'Recife'
AND funcao = 'Telefonista';

/*Exercício 17*/
SELECT DISTINCT primeiroNome, funcao
FROM funcionario
WHERE funcao = 'Pessoal';

/*Exercício 18*/
SELECT f.primeiroNome, d.nomeDepartamento
FROM funcionario f JOIN departamento d ON f.codigoDepartamento = d.codigoDepartamento
WHERE f.salario > (
	SELECT salario
	FROM funcionario
	WHERE funcao = 'Gerente');
    
/*Extra: uso do LIKE*/
SELECT *
FROM funcionario
WHERE cidade LIKE '%Santa%';