CREATE DATABASE ubank;
USE ubank;
drop database ubank;

CREATE TABLE tipo_usuario(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE usuario(
	id INT PRIMARY KEY IDENTITY,
	id_tipo_usuario TINYINT,
	email VARCHAR(100) UNIQUE NOT NULL,
	senha VARCHAR(64) NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_usuario_tipo_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id)
);

CREATE TABLE cliente(
	id INT PRIMARY KEY IDENTITY,
	nome VARCHAR(60) NOT NULL,
	sobrenome VARCHAR(100) NOT NULL,
	CPF BIGINT UNIQUE NOT NULL,
	data_nascimento DATETIME NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME
);

CREATE TABLE uf(
	id TINYINT PRIMARY KEY,
	uf CHAR(2) NOT NULL,
	nome VARCHAR(35) NOT NULL
);

CREATE TABLE cidade(
	id SMALLINT PRIMARY KEY IDENTITY,
	id_uf TINYINT NOT NULL,
	nome VARCHAR(35) NOT NULL,
	CONSTRAINT fk_cidade_uf FOREIGN KEY (id_uf) REFERENCES uf(id)
);

CREATE TABLE endereco(
	id INT PRIMARY KEY IDENTITY,
	id_cidade SMALLINT NOT NULL,
	id_cliente INT NOT NULL,
	logradouro VARCHAR(100) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	bairro VARCHAR(60) NOT NULL,
	CEP INT NOT NULL,
	complemento VARCHAR(100),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_endereco_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id),
	CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE tipo_contato(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(30) NOT NULL
);

CREATE TABLE contato(
	id INT PRIMARY KEY IDENTITY,
	id_cliente INT NOT NULL,
	id_tipo_contato TINYINT NOT NULL,
	numero BIGINT NOT NULL,
	whatsapp BIT NOT NULL,
	usuario_cadastro INT NOT NULL, 
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_contato_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	CONSTRAINT fk_contato_tipo_contato FOREIGN KEY (id_tipo_contato) REFERENCES tipo_contato(id)
);

CREATE TABLE tipo_conta(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(50),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE status(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(20) NOT NULL
);

CREATE TABLE tipo_movimentacao(
	id TINYINT PRIMARY KEY, 
	descricao VARCHAR(50) NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE conta(
	id INT PRIMARY KEY IDENTITY,
	id_cliente INT NOT NULL,
	id_status TINYINT NOT NULL,
	id_tipo_conta TINYINT NOT NULL,
	saldo MONEY NOT NULL,
	agencia SMALLINT NOT NULL,
	numero_conta INT NOT NULL,
	emprestimos_quitados SMALLINT NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME, 
	CONSTRAINT fk_conta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	CONSTRAINT fk_conta_status FOREIGN KEY (id_status) REFERENCES status(id),
	CONSTRAINT fk_conta_tipo_conta FOREIGN KEY (id_tipo_conta) REFERENCES tipo_conta(id)
);

CREATE TABLE extrato(
	id INT PRIMARY KEY IDENTITY,
	id_conta INT NOT NULL,
	id_tipo_movimentacao TINYINT NOT NULL,
	data DATETIME NOT NULL,
	valor MONEY NOT NULL,
	usuario_transferido INT,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_extrato_conta FOREIGN KEY (id_conta) REFERENCES conta(id),
	CONSTRAINT fk_extrato_tipo_movimentacao FOREIGN KEY (id_tipo_movimentacao) REFERENCES tipo_movimentacao(id)
);

CREATE TABLE emprestimo(
	id INT PRIMARY KEY IDENTITY,
	id_conta INT NOT NULL,
	valor MONEY NOT NULL,
	quantidade_parcelas TINYINT NOT NULL,
	valor_parcela MONEY NOT NULL,
	fechamento_parcela DATETIME NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_emprestimo_conta FOREIGN KEY (id_conta) REFERENCES conta(id)
);