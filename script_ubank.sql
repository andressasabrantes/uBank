CREATE DATABASE Banco;
USE Banco;

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
	nome VARCHAR(60),
	sobrenome VARCHAR(100),
	CPF BIGINT NOT NULL UNIQUE,
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
	CONSTRAINT fk_endereco_tipo_contato FOREIGN KEY (id_tipo_contato) REFERENCES tipo_contato(id)
);

CREATE TABLE tipo_conta(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(50),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE status(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(20)
);

CREATE TABLE conta(
	id INT PRIMARY KEY IDENTITY,
	id_cliente INT NOT NULL,
	id_status TINYINT NOT NULL,
	id_tipo_conta TINYINT NOT NULL,
	saldo MONEY NOT NULL,
	agencia SMALLINT NOT NULL,
	numero_conta INT NOT NULL UNIQUE,
	emprestimos_quitados SMALLINT NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_conta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	CONSTRAINT fk_conta_status FOREIGN KEY (id_status) REFERENCES status(id),
	CONSTRAINT fk_conta_tipo_conta FOREIGN KEY (id_tipo_conta) REFERENCES tipo_conta(id)
);

CREATE TABLE emprestimo(
	id INT PRIMARY KEY IDENTITY,
	id_conta INT NOT NULL,
	valor MONEY NOT NULL,
	quantidade_parcelas TINYINT NOT NULL,
	valor_parcela MONEY NOT NULL,
	fechamento_parcela DATE NOT NULL,
	data_pagamento DATE DEFAULT(NULL),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_emprestimo_conta FOREIGN KEY (id_conta) REFERENCES conta(id)
);

CREATE TABLE tipo_movimentacao(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(20),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
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

INSERT INTO tipo_usuario VALUES 
(1,'administrador',1,'20220211 12:08:12'),
(2,'cliente',1,'20220212 07:30:16'),
(3,'funcionario',1,'20220212 07:30:20');

INSERT INTO usuario VALUES 
(1, 'jose.gabriel@smn.com.br', 'fh4MCB1213', 1, '20220215 17:33:56', NULL, NULL),
(3, 'guilherme.neves@smn.com.br', 'jKDGSNbAJs', 1, '20220218 10:27:00', NULL, NULL),
(3, 'andressa.abrantes@smn.com.br', 'Jn927fuhad', 1, '20220219 04:09:00', NULL, NULL),
(3, 'jorge.neto@smn.com.br', '2987fh2FDS', 3, '20220222 15:45:00', NULL, NULL),
(3, 'mateus.dom@smn.com.br', 'asSFDSV#318d', 3, '20220222 15:45:00', NULL, NULL),
(2, 'joaosilva@outlook.com', 'MsasfSD341G', 6, '20220226 14:34:00', NULL, NULL),
(2, 'marianetneves@hotmail.com', 'N37914TF3GYB', 7, '20220228 16:01:00', NULL, NULL),
(2, 'andrealves@yahoo.com.br', 'nuivjd348i0DF', 8, '20220301 12:30:00', NULL, NULL),
(2, 'cleide_ane@hotmail.com', ',csoaikdds492', 9, '20220306 09:08:00', NULL, NULL),
(2, 'mariajose@bol.com.br', 'senha123', 10, '20220513 12:26:00', NULL, NULL),
(2, 'joanasocorro@outlook.com', 'jans1298hAS', 11, '20220630 15:25:00', NULL, NULL),
(2, 'pedrodantas@outlook.com', 'pqkd129e-asd', 12, '20220829 12:39:00', NULL, NULL),
(2, 'paulorabelo@yahoo.com.br', 'nsaa2173afj', 13, '20221218 11:35:00', NULL, NULL),
(2, 'jeffersondias@gmail.com', 'ehdue18!54', 14, '20230104 06:32:00', NULL, NULL),
(2, 'dexterpsy@gmail.com', 'FYTybGfh38', 15, '20230124 10:23:00', NULL, NULL),
(3, 'mari.azevedo@ubank.com.br', 'gFDC@vsg@', 1, '20220109 13:00:00', NULL, NULL),
(2, 'biel.azevedo@ubank.com.br', 'fhs#asd@', 1, '20220607 14:00:00', NULL, NULL),
(2, 'amanda.santos@gmail.com.br', 'hdg$csfa2@@gfd', 1, '20220607 11:05:03', NULL, NULL),
(2, 'paulo.galvao@gmail.com.br', 'jkdh!@gadf@', 1, '20221005 09:45:00', NULL, NULL),
(2, 'samara.davila@gmail.com.br', 'fg$eS@#sds', 1, '20221202 08:45:00', NULL, NULL),
(2, 'bruna.santos@gmail.com.br', 'nD@#csg#$#HVSgs', 1, '20221206 09:45:00', NULL, NULL),
(2, 'bruno.azevedo@gmail.com.br', 'bFsvY2546##$nsb', 1, '20221212 08:03:00', NULL, NULL),
(3, 'tadeu.santos@gmail.com.br', 'nbh&vaf#', 1, '20221006 09:10:00', NULL, NULL),
(3, 'matheus.santos@gmail.com.br', 'vc@vasf#s644', 1, '20221012 08:00:00', NULL, NULL),
(3, 'gabriela.silva@gmail.com.br', 'dhasb#csrf@', 1, '20221010 08:30:00', NULL, NULL),
(3, 'kamila.santos@ubank.com.br', 'db$hsfa@#vcsca', 1, '20220605 09:00:00', NULL, NULL),
(2, 'camila.silva@gmail.com.br', 'd$vha@af254', 1, '20220406 12:00:00', NULL, NULL),
(3, 'luiz.santos@ubank.com.br', 'dgaj265@!hads', 1, '20220406 11:00:30', NULL, NULL),
(3, 'andrew.silva@ubank.com.br', 'fbkjs&3463Bnbd#', 1, '20220910 12:00:34', NULL, NULL),
(3, 'andreza.alves@ubank.com.br', 'hfg#ahsg!@', 1, '20220509 11:00:49', NULL, NULL),
(3, 'rafael.alves@ubank.com.br', 'sdg#sgfa!@32GH', 1, '20220609 09:00:49', NULL, NULL),
(3, 'renato.andrade@ubank.com.br', 'dsfj@af!', 1, '20221212 09:00:34', NULL, NULL),
(2, 'enzo.andrade@gmail.com.br', 'hs@3sfcd!@vd', 1, '20221010 09:09:59', NULL, NULL);


INSERT INTO cliente VALUES 
('Joao', 'Silva Neto', 81389302153, '19980115', 6, '20220226 14:34:00', NULL, NULL),
('Mariane', 'Travassos Neves', 92817398297, '19950115', 7, '20220228 16:01:00', NULL, NULL),
('Andre', 'Alves Dias', 12984612909, '19870115', 8, '20220301 12:30:00', NULL, NULL),
('Cleideane', 'Anne Gouveia Santos', 27813768276, '19940115', 9, '20220306 09:08:00', NULL, NULL),
('Maria', 'Jose da Silva', 82394729833, '19940115', 10, '20220513 12:26:00', NULL, NULL),
('Joana', 'Socorro Aparecida', 28304732893, '19850115', 11, '20220630 15:25:00', NULL, NULL),
('Pedro', 'Dantas Filho', 19823692843, '19960115', 12, '20220829 12:39:00', NULL, NULL),
('Paulo', 'Rabelo', 01298739218, '19930115', 13, '20221218 11:35:00', NULL, NULL),
('Jefferson', 'Dias Melo', 28913809732, '19780115', 14, '20230104 06:32:00', NULL, NULL),
('Dexter', 'Smith', 65043987649, '19580115', 15, '20230124 10:23:00', NULL, NULL),
('Jose', 'Marcos de Oliveira', 13645217894, '19960224', 2, '20221010 08:40:00', NULL, NULL),
('Maria', 'Dos Santos', 33625987412, '19960212', 2, '20220506 08:10:25', NULL, NULL),
('João', 'Dos Santos', 33698852012, '19950202', 2, '20221212 09:04:00', NULL, NULL),
('Marcos', 'De Lima', 63258944123, '19980203', 2, '20221002 08:00:00', NULL, NULL),
('Mariana', 'Azevedo', 36120045874, '19970202', 2, '20220102 08:40:29', NULL, NULL),
('Gabriel', 'Azevedo', 63215978532, '19980605', 2, '20221010 09:00:23', NULL, NULL),
('Bruna', 'Galvão', 45631200987, '19940605', 2, '20221010 10:30:09', NULL, NULL),
('Gustavo', 'Almeida de Lima', 25987412305, '19980505', 2, '20220225 14:05:05', NULL, NULL),
('Bruno', 'Gonçalves', 32569874123, '19980605', 2, '20220225 14:05:05', NULL, NULL),
('Rayssa', 'Gomes de Oliveira', 69331124478, '19960202', 2, '20220202 14:05:20', NULL, NULL),
('Laura', 'Silva de Mendonça', 36698741250, '19950202', 2, '20221212 13:00:00', NULL, NULL),
('Matheus', 'Domingos da Silva', 36251478962, '19920205', 2, '20220606 12:15:00', NULL, NULL),
('Philipe', 'Santos Azevedo', 13625452914, '19930202', 2, '20220303 12:00:23', NULL, NULL),
('Jorge', 'De Neto', 36251489632, '19920202', 2, '20220505 13:00:00', NULL, NULL),
('Sabrina', 'Almeida', 13205647890, '19960203', 2, '20220202 14:00:00', NULL, NULL),
('Gabriel', 'De Oliveira', 32651478962, '19960203', 2, '20220306 13:00:00', NULL, NULL),
('Gabriela', 'Almeida', 32658965230, '19990303', 2, '20220303 13:00:00', NULL, NULL),
('Paola', 'Santos Azevedo', 36251478965, '19960203', 2, '20220606 13:00:00', NULL, NULL),
('John', 'Santos', 36952014789, '20000606', 2, '20220203 16:00:24', NULL, NULL),
('Cristal', 'Galvão de Lima', 36124578962, '20000904', 2, '20220908 12:00:00', NULL, NULL),
('João', 'Silva', 12345678901, '19800520', 1, '20220101 14:05:20', 2, '20220101 14:06:20'),
('Maria', 'Santos', 23456789012, '19950715', 1, '20220102 14:07:20', 2, '20220102 14:07:50'),
('Pedro', 'Oliveira', 34567890123, '20000310', 1, '20220103 14:08:20', NULL, NULL),
('Julia', 'Pereira', 45678901234, '19851130', 1, '20220104 14:09:20', NULL, NULL),
('Lucas', 'Rodrigues', 56789012345, '19780205', 1, '20220105 14:10:20', NULL, NULL),
('Ana', 'Gonçalves', 67890123456, '19900822', 1, '20220106 14:10:20', 2, '20220106 14:10:50'),
('Marcos', 'Ferreira', 78901234567, '20020618', 1, '20220107 14:11:50', NULL, NULL),
('Carla', 'Almeida', 89012345678, '19720925', 1, '20220108 14:12:50', NULL, NULL),
('Rafael', 'Mendes', 90123456789, '19981212', 1, '20220109 14:13:50', 2, '20220109 14:14:00'),
('Mariana', 'Costa', 01234567890, '19870408', 1, '20220110 14:15:00', NULL, NULL),
('Marcelo', 'Souza', 12345678912, '19920912', 1, '20220111 14:16:00', 2, '20220111 14:16:50'),
('Caroline', 'Lima', 23456789023, '19841118', 1, '20220112 14:17:50', NULL, NULL),
('Roberto', 'Barbosa', 34567890134, '19760223', 1, '20220113 14:19:50', NULL, NULL),
('Luciana', 'Rocha', 45678901245, '19990707', 1, '20220114 14:20:50', 2, '20220114 14:21:50'),
('Amanda', 'Fernandes', 56789012356, '20010130', 1, '20220115 14:22:50', NULL, NULL),
('Thiago', 'Alves', 67890123467, '19880424', 1, '20220116 14:23:50', NULL, NULL),
('Fernanda', 'Garcia', 78901234578, '19790814', 1, '20220117 14:24:50', 2, '20220117 14:25:50'),
('Vinicius', 'Nascimento', 89012345689, '20030501', 1, '20220118 14:27:50', NULL, NULL),
('Isabella', 'Cardoso', 90123456790, '19961103', 1, '20220119 14:28:50', NULL, NULL),
('Gustavo', 'Cruz', 01234567801, '19741231', 1, '20220120 14:29:59', 2, '20220120 14:30:59'),
('Julia', 'Santos', 25456789002, '19910302', 1, '20220121 14:31:59', NULL, NULL),
('Leonardo', 'Oliveira', 34560800123, '19850615', 1, '20220122 14:32:59', NULL, NULL),
('Aline', 'Mendes', 45670901234, '20001225', 1, '20220123 14:33:59', 2, '20220123 14:34:59'),
('Gabriel', 'Ferreira', 56781012305, '19971011', 1, '20220124 14:35:59', NULL, NULL),
('Pedro', 'Vieira', 67890120056, '19820927', 1, '20220125 14:36:59', NULL, NULL),
('Maria', 'Silva', 78901234007, '19780709', 1, '20220126 14:37:59', 2, '20220126 14:39:09'),
('José', 'Costa', 89012345118, '20020417', 1, '20220127 14:41:12', NULL, NULL),
('Fábio', 'Pereira', 90123456719, '19950122', 1, '20220128 14:42:12', NULL, NULL),
('Larissa', 'Ribeiro', 01234567190, '19890803', 1, '20220129 14:43:12', 2, '20220129 14:44:13'),
('Marina', 'Moraes', 12345678101, '19721128', 1, '20220130 14:45:13', NULL, NULL);

INSERT INTO uf VALUES 
(1, 'AC', 'Acre'),
(2, 'AL', 'Alagoas' ),
(3, 'AP', 'Amapa' ),
(4, 'AM', 'Amazonas' ),
(5, 'BA', 'Bahia' ),
(6, 'CE', 'Ceara' ),
(7, 'ES', 'Espirito Santo' ),
(8, 'GO', 'Goias' ),
(9, 'MA', 'Maranhao' ),
(10, 'MT', 'Mato Grosso' ),
(11, 'MS', 'Mato Grosso do Sul' ),
(12, 'MG', 'Minas Gerais' ),
(13, 'PA', 'Para' ),
(14, 'PB', 'Paraiba' ),
(15, 'PR', 'Parana' ),
(16, 'PE', 'Pernambuco' ),
(17, 'PI', 'Piaui' ),
(18, 'RJ', 'Rio de Janeiro' ),
(19, 'RN', 'Rio Grande do Norte' ),
(20, 'RS', 'Rio Grande do Sul' ),
(21, 'RO', 'Rondonia' ),
(22, 'RR', 'Roraima' ),
(23, 'SC', 'Santa Catarina' ),
(24, 'SP', 'Sao Paulo' ),
(25, 'SE', 'Sergipe' ),
(26, 'TO', 'Tocantins' ),
(27, 'DF', 'Distrito Federal');

INSERT INTO cidade VALUES 
(1,'Rio Branco'),
(1,'Cruzeiro do Sul'),
(2,'Maceio'),
(2,'Maragogi'),
(3,'Macapa'),
(3,'Santana'),
(4,'Manaus'),
(4,'Paratins'),
(5,'Salvador'),
(5,'Porto Seguro'),
(6,'Fortaleza'),
(6,'Eusebio'),
(7,'Vitoria'),
(7,'Vila Velha'),
(8,'Goiania'),
(8,'Anapolis'),
(9,'Sao Luiz'),
(9,'Imperatriz'),
(10,'Cuiaba'),
(10,'Rondonopolis'),
(11,'Campo Grande'),
(11,'Dourados'),
(12,'Belo Horizonte'),
(12,'Uberlendia'),
(13,'Santarem'),
(13,'Belem'),
(14,'Joao Pessoa'),
(14,'Capina Grande'),
(15,'Curitiba'),
(15,'Londrina'),
(16,'Recife'),
(16,'Caruaru'),
(17,'Teresina'),
(17,'Pico'),
(18,'Rio de Janeiro'),
(18,'Niteroi'),
(19,'Natal'),
(19,'Mossoro'),
(20,'Porto Alegre'),
(20,'Rio Grande'),
(21,'Porto Velho'),
(21,'Vilhena'),
(22,'Boa Vista'),
(22,'Pacaraima'),
(23,'Florianopolis'),
(23,'Joinville'),
(24,'Sao Paulo'),
(24,'Campinas'),
(25,'Aracaju'),
(25,'Lagarto'),
(26,'Palmas'),
(26,'Araguaina'),
(27,'Brasilia'),
(27,'Ceilândia');


/*
CPF - 11 numeros
CEP - 8 numeros
NUMERO - DDD+9+NUMERO
AGENCIA - 4 numeros
NUMERO(da conta) - 8 numeros

Id Usuario Funcionarios: 1 ao 5
id Usuario Clientes: 6 ao 15 (nao confundir com cliente(id))
*/
INSERT INTO endereco VALUES 
(14, 1, 'Rua José de Alencar', '123', 'Centro', 58400275, 'Apartamento 101', 1, '20220220 10:35:40', NULL, NULL),
(14, 2, 'Rua Vigário Calixto', '456', 'Prata', 58400340, 'Apartamento 303', 6, '20220222 14:50:12', NULL, NULL),
(14, 3, 'Avenida Manoel Tavares', '789', 'Bodocongó', 58429020, 'Casa 2', 7, '20220302 08:20:30', NULL, NULL),
(14, 4, 'Rua Lino Gomes da Silva', '1001', 'Santo Antônio', 58406262, 'Sala 202', 8, '20220310 15:40:25', NULL, NULL),
(14, 5, 'Rua Padre Azevedo', '1111', 'Catolé', 58410035, 'Residencial Ilha da Madeira, Apartamento 104', 9, '20220315 18:05:00', NULL, NULL),
(14, 6, 'Avenida Assis Chateaubriand', '2222', 'José Pinheiro', 58407355, 'Residencial Do Porto, apartamento 001', 10, '20220320 11:55:35', NULL, NULL),
(14, 7, 'Rua Treze de Maio', '123', 'Centro', 58013150, 'Apartamento 101', 11, '20220325 14:30:10', NULL, NULL),
(14, 8, 'Rua das Trincheiras', '456', 'Centro', 58010290, 'Comercial Alves Santos, Sala 102', 12, '20220402 09:15:00', NULL, NULL),
(14, 9, 'Rua Eutécia Vital Ribeiro', '789', 'Jardim Oceania', 58037640, 'Casa 2', 13, '20220410 16:55:20', NULL, NULL),
(14, 10, 'Rua Luiz Augusto Crispim', '1001', 'Tambaú', 58039090, 'Sala 202', 14, '20220415 12:40:15', NULL, NULL),
(1, 11, 'Rua Andrelino Alves de Gonçalves', '123', 'Centro', 69900000, 'Ap. 101', 15, '20220420 08:30:30', NULL, NULL),
(1, 12, 'Rua Beatriz de Lima Silveira', '456', 'Bosque', 69901000, 'Residencial Mar Vermelho, apartamento 805', 16, '20220501 13:25:05', NULL, NULL),
(1, 13, 'Avenida Corais do Litoral', '789', 'Floresta', 69902000, 'Casa 2', 1, '20220201 09:00:00', NULL, NULL),
(1, 14, 'Rua Diego Holanda de Meira', '234', 'Bairro Novo', 69903000, 'Sala 10', 1, '20220202 10:00:00', NULL, NULL),
(1, 15, 'Rua Henrique domingos da Franca', '567', 'Estação Experimental', 69904000, 'Apartamento 108', 2, '20220203 11:00:00', NULL, NULL),
(1, 16, 'Avenida Fernandes Almeida de Lima', '890', 'Jardim Europa', 69905000, 'Fundos', 2, '20220204 12:00:00', NULL, NULL),
(24, 17, 'Rua Augusta', '1234', 'Consolação', 01305100, 'Apto. 101', 3, '20220205 13:00:00', NULL, NULL),
(24, 18, 'Avenida Paulista', '456', 'Bela Vista', 01310100, 'Residencial Álvaro de Oliveira, Apartamento 801', 3, '20220206 14:00:00', NULL, NULL),
(24, 19, 'Rua Oscar Freire', '789', 'Jardim Paulista', 01426001, 'Casa 2', 4, '20220207 15:00:00', NULL, NULL),
(24, 20, 'Rua 25 de Março', '234', 'Centro', 01021200, 'Sala 10', 4, '20220208 16:00:00', NULL, NULL),
(24, 21, 'Rua José Bonifácio', '567', 'Sé', 01003001, 'Residencial Ilha Canária, apartamento 107', 5, '20220209 17:00:00', NULL, NULL),
(18, 22, 'Rua das Flores', '123', 'Copacabana', 22031080, 'Apt. 101', 5, '20220210 18:00:00', NULL, NULL),
(18, 23, 'Avenida Atlântica', '456', 'Leme', 22010010, 'Casa 2', 6, '20220211 19:00:00', NULL, NULL),
(18, 24, 'Rua da Lapa', '789', 'Lapa', 20021180, 'Sala 301', 6, '20220212 20:00:00', NULL, NULL),
(18, 25, 'Rua Barata Ribeiro', '246', 'Copacabana', 22011000, 'Loja 3', 7, '20220213 21:00:00', NULL, NULL),
(18, 26, 'Rua Visconde de Pirajá', '135', 'Ipanema', 22410001, 'Andar 12', 7, '20220214 22:00:00', NULL, NULL),
(18, 27, 'Rua das Palmeiras', '35', 'Tijuca', 20510000, NULL, 8, '20220215 23:00:00', NULL, NULL),
(18, 28, 'Rua do Ouvidor', '765', 'Centro', 20040030, 'Sala 501', 8, '20220216 00:00:00', NULL, NULL),
(18, 29, 'Avenida Niemeyer', '6789', 'São Conrado', 22450220, 'Cobertura 3A', 9, '20220217 01:00:00', NULL, NULL),
(18, 30, 'Rua Marquês de São Vicente', '223', 'Gávea', 22451041, 'Sala 102', 1, '20220812 10:00:00', NULL, NULL),
(18, 31, 'Avenida Presidente Vargas', '1500', 'Centro', 20071004, 'Loja 7A',  2, '20220903 15:20:00', NULL, NULL),
(18, 32, 'Rua São João', '123', 'Centro', 24020100, 'Apt. 301', 1, '20220910 11:45:00', NULL, NULL),
(18, 33, 'Avenida Amaral Peixoto', '456', 'Centro', 24020073, 'Sala 2A', 2, '20220918 16:30:00', NULL, NULL),
(18, 34, 'Rua Dr. Paulo César', '789', 'Santa Rosa', 24240020, 'Casa 1', 1, '20221002 09:00:00', NULL, NULL),
(18, 35, 'Rua Gavião Peixoto', '246', 'Icaraí', 24230101, 'Loja 5', 2, '20221008 14:15:00', NULL, NULL),
(18, 36, 'Rua Professor Otávio Kelly', '135', 'Ingá', 24210330, 'Andar 10', 1, '20221101 08:30:00', NULL, NULL),
(18, 37, 'Rua Domingues de Sá', '35', 'São Domingos', 24210240, NULL, 2, '20221112 17:45:00', NULL, NULL),
(18, 38, 'Rua da Conceição', '765', 'Centro', 24020082, 'Sala 201', 1, '20221205 11:00:00', NULL, NULL),
(18, 39, 'Rua Lopes Trovão', '6789', 'Icaraí', 24220070, 'Cobertura 1A', 1, '20220101', 1, '20220101'),
(18, 40, 'Rua Presidente Backer', '223', 'Icaraí', 24220011, 'Sala 103', 1, '20220102', 1, '20220102'),
(18, 41, 'Rua Marquês do Paraná', '1500', 'Centro', 24030005, 'Loja 3B', 1, '20220103', 1, '20220103'),
(23, 42, 'Rua São Jorge', '123', 'Centro', 88015320, 'Apt. 301', 1, '20220104', 1, '20220104'),
(23, 43, 'Avenida Rio Branco', '456', 'Centro', 88015200, 'Sala 2A', 1, '20220105', 1, '20220105'),
(23, 44, 'Rua Deputado Antônio Edu Vieira', '789', 'Santa Mônica', 88035250, 'Casa 1', 1, '20220106', 1, '20220106'),
(23, 45, 'Rua Professor Acelon Pacheco da Costa', '246', 'Trindade', 88036350, 'Loja 5', 1, '20220107', 1, '20220107'),
(23, 46, 'Rua João Pio Duarte Silva', '135', 'Cacupé', 88053430, 'Andar 10', 1, '20220108', 1, '20220108'),
(23, 47, 'Rua Prefeito Dib Cherem', '35', 'Capoeiras', 88070660, NULL, 1, '20220109', 1, '20220109'),
(23, 48, 'Rua Bocaiúva', '765', 'Centro', 88015530, 'Sala 201', 1, '20220110', 1, '20220110'),
(23, 49, 'Rua João Pacheco da Costa', '6789', 'Itacorubi', 88034010, 'Cobertura 1A', 1, '20220101 10:00:00', NULL, NULL),
(23, 50, 'Rua Henrique Valgas', '223', 'Centro', 88015200, 'Sala 103', 1, '20220102 11:00:00', NULL, NULL);

INSERT INTO tipo_contato VALUES 
(1, 'Celular'),
(2, 'Telefone Residencial');

INSERT INTO contato VALUES 
(1, 1, 83987283746, 1, 6, '20220226 14:34:00', NULL, NULL),
(2, 2, 8897328467, 1, 7, '20220228 16:01:00', NULL, NULL),
(3, 2, 8348976348, 1, 8, '20220301 12:30:00', NULL, NULL),
(4, 1, 83980394237, 0, 9, '20220306 09:08:00', NULL, NULL),
(5, 1, 85990378264, 0, 10, '20220513 12:26:00', NULL, NULL),
(6, 2, 8330784632, 1, 11, '20220630 15:25:00', NULL, NULL),
(7, 1, 11994839283, 1, 12, '20220829 12:39:00', NULL, NULL),
(8, 2, 6998372488, 1, 13, '20221218 11:35:00', NULL, NULL),
(9, 2, 8580384692, 1, 14, '20230104 06:32:00', NULL, NULL),
(10, 1, 83984034008, 0, 15, '20230124 10:23:00', NULL, NULL),
(11, 2, 21966666666, 0, 3, '20220402 08:15:00', NULL, NULL),
(12, 2, 11987654321, 0, 1, '20220801 14:30:00', NULL, NULL),
(13, 2, 21999887766, 1, 1, '20220802 10:45:00', NULL, NULL),
(14, 1, 11999998888, 1, 1, '20220803 15:20:00', NULL, NULL),
(15, 2, 21988887777, 0, 2, '20220804 11:00:00', NULL, NULL),
(16, 1, 11977776666, 0, 2, '20220805 13:30:00', NULL, NULL),
(17, 1, 21966665555, 1, 2, '20220806 09:15:00', NULL, NULL),
(18, 2, 11955554444, 1, 3, '20220807 16:45:00', NULL, NULL),
(19, 2, 21944443333, 0, 3, '20220808 12:10:00', NULL, NULL),
(20, 1, 11933332222, 0, 3, '20220809 14:00:00', NULL, NULL),
(21, 2, 21922221111, 1, 4, '20220810 10:30:00', NULL, NULL),
(22, 1, 9876543210, 1, 1, '20220101 11:30:00', 1, '20220101 11:30:00'),
(23, 2, 998765432, 1, 1, '20220102 16:45:00', 1, '20220102 16:45:00'),
(24, 1, 123456789, 0, 4, '20220103 12:10:00', 4, '20220103 12:10:00'),
(25, 2, 987654321, 1, 4, '20220104 12:11:00', 4, '20220104 12:11:00'),
(26, 1, 876543219, 1, 1, '20220105 12:12:00', 1, '20220105 12:12:00'),
(27, 2, 987654321, 0, 3, '20220106 12:14:00', 3, '20220106 12:14:00'),
(28, 1, 198765432, 1, 1, '20220107 12:15:00', 1, '20220107 12:15:00'),
(29, 2, 219876543, 0, 3, '20220108 12:16:00', 3, '20220108 12:17:00'),
(30, 1, 321987654, 1, 1, '20220109 12:18:00', 1, '20220109 12:19:00'),
(31, 2, 432198765, 0, 1, '20220110 12:20:00', 1, '20220110 12:21:00'),
(32, 1, 543219876, 0, 3, '20220111 12:22:00', 3, '20220111 12:23:00'),
(33, 2, 654321987, 1, 1, '20220112 12:24:00', 1, '20220112 12:24:00'),
(34, 1, 543219876, 1, 4, '20220113 12:25:00', 4, '20220113 12:26:00'),
(35, 2, 432198765, 0, 1, '20220114 12:27:00', 1, '20220114 12:28:00'),
(36, 1, 321987654, 1, 3, '20220115 12:29:00', 3, '20220115 12:30:00'),
(37, 2, 219876543, 0, 1, '20220116 12:31:00', 1, '20220116 12:32:00'),
(38, 1, 198765432, 0, 1, '20220117 12:33:00', 1, '20220117 12:34:00'),
(39, 2, 987654321, 1, 3, '20220118 12:35:00', 3, '20220118 12:35:00'),
(40, 1, 876543219, 0, 1, '20220119 12:36:00', 1, '20220119 12:37:00'),
(41, 1, 5551987654321, 1, 1, '20220515 12:30:00', NULL, NULL),
(42, 2, 5551987654322, 1, 1, '20220602 14:25:00', NULL, NULL),
(43, 1, 5551987654323, 1, 1, '20220920 18:50:00', NULL, NULL),
(44, 2, 5551987654324, 0, 1, '20220810 08:00:00', NULL, NULL),
(45, 1, 5551987654325, 0, 1, '20220530 10:15:00', NULL, NULL),
(46, 1, 5551987654326, 1, 1, '20220712 13:45:00', NULL, NULL),
(47, 2, 5551987654327, 1, 1, '20221125 09:10:00', NULL, NULL),
(48, 2, 5551987654328, 0, 1, '20220405 16:20:00', NULL, NULL),
(49, 1, 5551987654329, 1, 1, '20220218 11:30:00', NULL, NULL),
(50, 2, 5551987654330, 1, 1, '20221022 15:40:00', NULL, NULL);

INSERT INTO tipo_conta VALUES 
(1,'Conta Corrente', 2, '20220222 15:45:00'),
(2,'Conta Poupanca', 3, '20220222 15:45:00'),
(3,'Conta Corrente e Poupanca', 4, '20220222 15:45:00');

INSERT INTO status VALUES 
(1,'Ativo'),
(2,'Inativo'),
(3,'Suspensa');

INSERT INTO conta VALUES 
(1, 1, 1, 1000.00, 1004, 500890, 0, 2, '20220505 15:00:59', NULL, NULL),
(2, 2, 1, 5000.00, 1003, 901204, 1, 3, '20220102 16:00:00', NULL, NULL),
(3, 1, 2, 2500.00, 1001, 678900, 3, 4, '20220103 17:50:00', NULL, NULL),
(4, 3, 2, 800.00, 1001, 789172, 0, 5, '20220104 14:00:00', NULL, NULL),
(5, 2, 2, 3000.00, 1002, 800103, 2, 6, '20220105 15:00:00', NULL, NULL),
(6, 1, 3, 10000.00, 1002, 123496, 0, 2, '20220106 15:50:00', NULL, NULL),
(7, 3, 2, 1500.00, 1003, 231567, 1, 3, '20220107 16:00:00', NULL, NULL),
(8, 2, 3, 6000.00, 1003, 345608, 0, 4, '20220108 14:00:00', NULL, NULL),
(9, 1, 2, 2000.00, 1004, 056789, 2, 5, '20220109 11:00:00', NULL, NULL),
(10, 3, 1, 400.00, 1003, 567840, 0, 6, '20220110 12:00:00', NULL, NULL),
(11, 2, 2, 5500.00, 1002, 678921, 1, 2, '20220111 15:50:00', NULL, NULL),
(12, 1, 3, 12000.00, 1001, 785012, 0, 3, '20220112 16:50:25', NULL, NULL),
(13, 3, 2, 4000.00, 1004, 898123, 1, 4, '20220113 11:00:05', NULL, NULL),
(14, 2, 1, 800.00, 1004, 123356, 0, 5, '20220114 14:00:00', NULL, NULL),
(15, 1, 2, 1500.00, 1006, 238567, 2, 6, '20220115 09:00:25', NULL, NULL),
(16, 3, 2, 250.00, 1003, 345288, 0, 2, '20220116 10:00:00', NULL, NULL),
(17, 1, 1, 1000.00, 1001, 126456, 2, 1, '20220101 15:00:59', NULL, NULL),
(18, 2, 2, 5000.00, 1002, 876543, 3, 1, '20220102 15:10:59', NULL, NULL),
(19, 3, 2, 20000.00, 1003, 135790, 1, 2, '20220103 15:20:59', NULL, NULL),
(20, 1, 2, 2500.00, 1001, 240813, 2, 2, '20220104 15:30:59', NULL, NULL),
(21, 2, 3, 4000.00, 1002, 864249, 1, 3, '20220105 15:20:59', NULL, NULL),
(22, 3, 2, 15000.00, 1003, 975380, 3, 3, '20220106 12:10:59', NULL, NULL),
(23, 1, 3, 3000.00, 1001, 513627, 2, 4, '20220107 12:20:59', NULL, NULL),
(24, 2, 1, 6000.00, 1002, 624850, 1, 4, '20220108 12:25:59', NULL, NULL),
(25, 3, 2, 18000.00, 1003, 425896, 3, 5, '20220109 12:30:59', NULL, NULL),
(26, 1, 2, 500.00, 1001, 987654, 2, 5, '20220110 12:15:59', NULL, NULL),
(27, 2, 3, 7000.00, 1002, 234567, 1, 6, '20220111 10:10:59', NULL, NULL),
(28, 3, 2, 12000.00, 1003, 543216, 3, 6, '20220112 11:10:59', NULL, NULL),
(29, 1, 3, 10000.00, 1001, 135792, 2, 7, '20220113 11:10:59', NULL, NULL),
(30, 2, 1, 8000.00, 1002, 975310, 1, 7, '20220114 12:10:59', NULL, NULL),
(31, 3, 2, 15000.00, 1003, 864209, 3, 8, '20220115 12:10:59', NULL, NULL),
(32, 1, 2, 3000.00, 1001, 515627, 2, 8, '20220116 10:10:59', NULL, NULL),
(33, 2, 3, 10000.00, 1002, 249813, 1, 9, '20220117 11:10:59', NULL, NULL),
(34, 3, 2, 20000.00, 1003, 624859, 3, 9, '20220118 12:10:59', NULL, NULL),
(35, 2, 1, 8000.00, 1003, 236974, 0, 9, '20220208 13:00:59', NULL, NULL),
(36, 1, 1, 2000.00, 1003, 236987, 0, 7, '20220602 12:00:59', NULL, NULL),
(37, 1, 3, 850.00, 1004, 264789, 0, 9, '20220405 11:00:00', NULL, NULL),
(38, 1, 1, 8000.00, 1004, 236978, 1, 7, '20220403 12:00:00', NULL, NULL),
(39, 1, 1, 5000.00, 1001, 123456, 2, 1, '20220101 11:00:00', NULL, NULL),
(40, 2, 2, 7500.00, 1002, 234067, 1, 2, '20220102 12:00:00', NULL, NULL),
(41, 1, 1, 10000.00, 1001, 345678, 0, 1, '20220103 13:00:00', NULL, NULL),
(42, 2, 2, 15000.00, 1002, 456789, 0, 3, '20220104 12:00:00', NULL, NULL),
(43, 3, 2, 500.00, 1003, 567890, 3, 4, '20220105 11:45:00', NULL, NULL),
(44, 2, 1, 1000.00, 1004, 678901, 2, 2, '20220106 14:00:59', NULL, NULL),
(45, 1, 2, 2500.00, 1005, 789012, 1, 5, '20220107 10:00:00', NULL, NULL),
(46, 3, 2, 8000.00, 1001, 890123, 0, 3, '20220108 09:45:00', NULL, NULL),
(47, 1, 3, 3500.00, 1002, 901234, 4, 4, '20220109 10:00:00', NULL, NULL),
(48, 2, 1, 900.00, 1003, 123450, 1, 2, '20220110 09:55:52', NULL, NULL),
(49, 3, 2, 6000.00, 1004, 234561, 0, 5, '20220111 10:00:00', NULL, NULL),
(50, 1, 1, 300.00, 1005, 345672, 5, 3, '20220112 11:00:00', NULL, NULL);

INSERT INTO emprestimo VALUES 
(1, 1000.00, 12, 100.00, '20220131', NULL, 1, '20220101', NULL, NULL),
(2, 5000.00, 12, 416.66, '20220228', NULL, 1, '20220102', NULL, NULL),
(3, 2000.00, 6, 333.33, '20230331', NULL, 1, '20220103', NULL, NULL),
(4, 3000.00, 12, 250.00, '20220430', NULL, 1, '20220104', NULL, NULL),
(5, 2000.00, 10, 200.00, '20220531', NULL, 1, '20220105', NULL, NULL),
(6, 4000.00, 6, 666.67, '20220630', NULL, 1, '20220106', NULL, NULL),
(7, 8000.00, 12, 666.66, '20220731', NULL, 1, '20220107', NULL, NULL),
(8, 1500.00, 12, 125.00, '20220831', NULL, 1, '20220108', NULL, NULL),
(9, 2500.00, 6, 416.67, '20220930', NULL, 1, '20220109', NULL, NULL),
(10, 9000.00, 12, 750.00, '20221031', NULL, 1, '20220110', NULL, NULL),
(11, 5000.00, 12, 416.67, '20221130', NULL, 1, '20220111', NULL, NULL),
(12, 10000.00, 12, 833.33, '20221231', NULL, 1, '20220112', NULL, NULL),
(13, 3000.00, 6, 500.00, '20230131', NULL, 1, '20230131', NULL, NULL),
(14, 4000.00, 12, 333.33, '20230228', NULL, 1, '20230228', NULL, NULL),
(15, 9000.00, 10, 900.00, '20230220', '20230220', 1, '20230220', NULL, NULL),
(16, 6000.00, 6, 1000.00, '20230430', NULL, 1, '20230430', NULL, NULL),
(18, 1500.00, 6, 250.00, '20220301', NULL, 1, '20220301', NULL, NULL),
(19, 2000.00, 6, 333.33, '20220305', '20220305', 1, '20220305', NULL, NULL),
(22, 3500.00, 12, 291.67, '20220410', NULL, 1, '20220410', NULL, NULL),
(25, 1000.00, 3, 333.33, '20220501', '20220501', 1, '20220501', NULL, NULL),
(27, 2500.00, 6, 416.67, '20220507', NULL, 1, '20220507', NULL, NULL),
(29, 2000.00, 6, 333.33, '20220601', NULL, 1, '20220601', NULL, NULL),
(31, 3000.00, 12, 250.00, '20220615', NULL, 1, '20220615', NULL, NULL),
(34, 4000.00, 12, 333.33, '20220705', NULL, 1, '20220705', NULL, NULL),
(37, 5000.00, 12, 416.67, '20220801', NULL, 1, '20220801', NULL, NULL),
(39, 2000.00, 6, 333.33, '20220810', '20220810', 1, '20220810', NULL, NULL),
(42, 1500.00, 3, 500.00, '20220905', NULL, 1, '20220905', NULL, NULL),
(44, 3000.00, 6, 500.00, '20221001', NULL, 1, '20221001', NULL, NULL),
(45, 2500.00, 12, 208.33, '20221101', '20221101', 1, '20221101', NULL, NULL),
(47, 4000.00, 6, 666.67, '20221115', '20221115', 1, '20221115', NULL, NULL),
(50, 1500.00, 6, 250.00, '20221201', NULL, 1, '20221201', NULL, NULL);

INSERT INTO tipo_movimentacao VALUES 
(1, 'deposito', 1, '20220215 17:33:56'),
(2, 'saque', 1, '20220215 17:33:56'),
(3, 'transferencia', 1, '20220215 17:33:56');

INSERT INTO extrato VALUES 
(1, 1, '20220502 17:35:00', 50.00, NULL, 1, '20220502 17:35:00', NULL, NULL),
(2, 2, '20220602 14:00:00', 100.00, 3, 1, '20220503 14:00:00', NULL, NULL),
(3, 2, '20220506 15:00:00', 100.00, NULL, 1, '20220506 15:00:00', NULL, NULL),
(4, 2, '20220502 16:00:00', 100.00, NULL, 1, '20220502 16:00:00', NULL, NULL),
(5, 1, '20220502 17:35:00', 150.00, NULL, 1, '20220502 17:35:00', NULL, NULL),
(6, 2, '20220502 16:00:00', 190.00, NULL, 1, '20220502 16:00:00', NULL, NULL),
(7, 1, '20220502 17:35:00', 1500.00, NULL, 1, '20220502 17:35:00', NULL, NULL),
(8, 1, '20220502 17:59:00', 1200.00, NULL, 1, '20220502 17:59:00', NULL, NULL),
(9, 2, '20220502 18:25:00', 150.00, NULL, 1, '20220502 18:25:00', NULL, NULL),
(10, 1, '20220502 14:00:00', 2500.00, NULL, 1, '20220502 14:00:00', NULL, NULL),
(11, 3, '20220502 16:00:00', 89.00, 2, 1, '20220509 14:25:00', NULL, NULL),
(12, 3, '20220502 16:01:00', 1500.00, 9, 1, '20220608 10:00:59', NULL, NULL),
(13, 3, '20220602 09:45:00', 55.00, 4, 1, '20220609 12:00:00', NULL, NULL),
(14, 1, '20220502 16:00:00', 150.00, NULL, 1, '20220502 16:00:00', NULL, NULL),
(15, 1, '20220502 17:35:00', 150.00, NULL, 1, '20220502 17:35:00', NULL, NULL),
(16, 1, '20220502 17:59:00', 1200.00, NULL, 1, '20220502 17:36:00', NULL, NULL),
(17, 2, '20220503 18:00:00', 550.00, NULL, 1, '20220502 18:00:00', NULL, NULL),
(18, 2, '20220506 10:00:00', 180.00, NULL, 1, '20220502 10:00:35', NULL, NULL),
(19, 3, '20220508 12:05:20', 1100.00, 13, 1, '20220508 12:05:20', NULL, NULL),
(20, 2, '20220601 10:00:00', 130.00, NULL, 1, '20220601 10:00:35', NULL, NULL),
(21, 1, '20220602 09:00:00', 880.00, NULL, 1, '20220602 09:00:35', NULL, NULL),
(22, 2, '20220603 08:45:00', 500.00, NULL, 1, '20220603 08:45:00', NULL, NULL),
(23, 1, '20220603 09:00:00', 350.00, NULL, 1, '20220603 09:00:00', NULL, NULL),
(24, 1, '20220604 10:00:00', 180.00, NULL, 1, '20220604 08:45:00', NULL, NULL),
(25, 1, '20220201 10:00:00', 500.00, NULL, 1, '20220201 10:00:00', NULL, NULL),
(26, 1, '20220202 11:00:00', 1000.00, NULL, 1, '20220202 11:00:00', NULL, NULL),
(27, 1, '20220203 12:00:00', 750.00, NULL, 1, '20220203 12:00:00', NULL, NULL),
(28, 1, '20220203 12:45:00', 750.00, NULL, 1, '20220203 12:46:00', NULL, NULL),
(29, 2, '20220204 13:00:00', 2500.00, NULL, 1, '20220204 13:00:00', NULL, NULL),
(30, 2, '20220205 14:00:00', 1600.00, NULL, 1, '20220205 14:00:00', NULL, NULL),
(31, 2, '20220206 15:00:00', 200.00, NULL, 1, '20220206 15:00:00', NULL, NULL),
(32, 3, '20220208 17:00:00', 30.00, 16, 1, '20220208 17:00:00', 1, '20220208 17:00:00'),
(33, 3, '20220209 18:00:00', 500.00, 13, 1, '20220209 18:00:00', 1, '20220209 18:00:00'),
(34, 3, '20220210 19:00:00', 1800.00, 10, 1, '20220210 19:00:00', 1, '20220210 19:00:00'),
(35, 1, '20220201 10:30:00', 100.00, NULL, 2, '20220201 10:30:00', NULL, NULL),
(36, 2, '20220203 15:45:00', 50.00, NULL, 2, '20220203 15:45:00', NULL, NULL),
(37, 1, '20220204 09:15:00', 250.00, NULL, 2, '20220204 09:15:00', NULL, NULL),
(38, 2, '20220205 14:20:00', 75.00, NULL, 2, '20220205 14:20:00', NULL, NULL),
(39, 1, '20220206 11:30:00', 350.00, NULL, 2, '20220206 11:30:00', NULL, NULL),
(40, 2, '20220208 13:15:00', 100.00, NULL, 2, '20220208 13:15:00', NULL, NULL),
(41, 1, '20220210 16:45:00', 50.00, NULL, 2, '20220210 16:45:00', NULL, NULL),
(42, 2, '20220211 12:30:00', 20.00, NULL, 2, '20220211 12:30:00', NULL, NULL),
(43, 1, '20220212 09:00:00', 150.00, NULL, 2, '20220212 09:00:00', NULL, NULL),
(44, 2, '20220215 10:30:00', 75.00, NULL, 2, '20220215 10:30:00', NULL, NULL),
(45, 1, '20230215 10:00:00', 100.00, NULL, 2, '20230215 10:00:00', NULL, NULL),
(46, 2, '20230215 12:00:00', 50.00, NULL, 2, '20230215 12:00:00', NULL, NULL),
(47, 1, '20230215 13:00:00', 500.00, NULL, 2, '20230215 13:00:00', NULL, NULL),
(48, 2, '20230215 14:00:00', 300.00, NULL, 2, '20230215 14:00:00', NULL, NULL),
(49, 1, '20230215 15:00:00', 1000.00, NULL, 2, '20230215 15:00:00', NULL, NULL),
(50, 2, '20230215 17:00:00', 289.00, NULL, 2, '20230215 17:00:00', NULL, NULL);










---------------------------------------SP INSERT CLIENTE BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.InsCliente]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.InsCliente]	

GO

CREATE PROCEDURE [SP.InsCliente]
	@nome		varchar(60),
	@sobrenome		varchar(100),
	@CPF		BIGINT,
	@data_nascimento DATE,
	@usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Insere um novo cliente na tabela Cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.InsCliente] @nome = 'Matias', @sobrenome = 'Santos', @CPF = 89258014738, @data_nascimento = '19670518', @usuario = 1
	Códigos de retorno: 0 - excução ok
	*/

	BEGIN 
		INSERT INTO cliente
		VALUES (@nome,@sobrenome,@CPF,@data_nascimento,@usuario, GETDATE(),NULL,NULL)
		RETURN 0
	END
GO










---------------------------------------SP UPDATE STATUS CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.UpStatus]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.UpStatus]	

GO

CREATE PROCEDURE [SP.UpStatus]
	@status TINYINT,
	@id_cliente INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Ativa, inativa ou suspende uma conta de um cliente
							return 0 - execuçao ok
							@status: 1 = Ativo
									 2 = Inativo
									 3 = Suspensa

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.UpStatus] @status = 3, @id_cliente = 10, @id_usuario = 1
	*/

	BEGIN 
		UPDATE conta SET id_status = @status, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id_cliente = @id_cliente 
		RETURN 0
	END
GO










---------------------------------------SP DEPOSITO CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.DepositoConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.DepositoConta]	

GO

CREATE PROCEDURE [SP.DepositoConta]
	@valor MONEY,
	@id_conta INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Faz o deposito de dinheiro em uma conta de um cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.DepositoConta] @valor = 100.00, @id_conta = 1, @id_usuario = 3
	*/

	BEGIN 
		UPDATE conta SET saldo = saldo + @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @id_conta;
		INSERT INTO extrato VALUES (@id_conta, 1, GETDATE(), @valor, NULL, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		RETURN 0
	END
GO










---------------------------------------SP SAQUE CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.SaqueConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.SaqueConta]	

GO

CREATE PROCEDURE [SP.SaqueConta]
	@valor MONEY,
	@id_conta INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Faz o saque de dinheiro em uma conta de um cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.SaqueConta] @valor = 100.00, @id_conta = 1, @id_usuario = 3
	*/

	BEGIN 
		UPDATE conta SET saldo = saldo - @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @id_conta;
		INSERT INTO extrato VALUES (@id_conta, 2, GETDATE(), @valor, NULL, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		RETURN 0
	END
GO










---------------------------------------SP TRANSFERENCIA CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.TransfConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.TransfConta]	

GO

CREATE PROCEDURE [SP.TransfConta]
	@valor MONEY,
	@id_conta INT,
	@conta_transferencia INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Faz a transferencia de dinheiro em uma conta e outra de clientes
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.TransfConta] @valor = 100.00, @id_conta = 1, @conta_transferencia = 2, @id_usuario = 3
	*/

	BEGIN 
		UPDATE conta SET saldo = saldo - @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @id_conta;
		UPDATE conta SET saldo = saldo + @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @conta_transferencia;
		INSERT INTO extrato VALUES (@id_conta, 3, GETDATE(), -@valor, @conta_transferencia, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		INSERT INTO extrato VALUES (@conta_transferencia, 3, GETDATE(), +@valor, @id_conta, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		RETURN 0
	END
GO










---------------------------------------SP EXTRATO CLIENTE BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.ExtratoConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.ExtratoConta]	

GO

CREATE PROCEDURE [SP.ExtratoConta]
	@id_cliente INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Apresenta o relatorio com todo o extrato de transacoes de um cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.ExtratoConta] @id_cliente = 1
	*/

	BEGIN 
		SELECT CONCAT(cl.nome,' ' ,cl.sobrenome) AS 'Nome Completo', 
		tm.descricao AS 'Tipo Movimentacao',
		ex.valor AS Valor, 
		ex.data AS 'Data Transacao', 
		ex.usuario_transferido AS 'Usuario Transferencia'
		FROM extrato ex WITH(NOLOCK)
		INNER JOIN conta ct WITH(NOLOCK)
		ON ex.id_conta = ct.id 
		INNER JOIN cliente cl WITH(NOLOCK)
		ON ct.id_cliente = cl.id
		INNER JOIN tipo_movimentacao tm WITH(NOLOCK)
		ON tm.id = ex.id_tipo_movimentacao
		WHERE cl.id = @id_cliente;
		RETURN 0
	END
GO










---------------------------------------SP INADIMPLENCIA CLIENTE BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.Inadimplencia]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.Inadimplencia]	

GO

CREATE PROCEDURE [SP.Inadimplencia]
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Apresenta o relatorio com todos os clientes com alguma inadimplencia de pagamentos de emprestimos
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.Inadimplencia]
	*/

	BEGIN 
		SELECT CONCAT(cl.nome,' ' ,cl.sobrenome) AS 'Nome Completo',
		ct.id_cliente AS 'Id Cliente',
		em.valor AS 'Valor Emprestimo', 
		CONCAT('Dia ',DAY(em.fechamento_parcela)) AS 'Fechamento Parcela',
		CONCAT(DAY(GETDATE()) - DAY(em.fechamento_parcela), ' Dias') AS 'Dias Atraso'
		FROM emprestimo em WITH(NOLOCK)
		INNER JOIN conta ct WITH(NOLOCK)
		ON em.id_conta = ct.id
		INNER JOIN cliente cl WITH(NOLOCK)
		ON ct.id_cliente = cl.id
		WHERE em.valor > 0 AND DAY(GETDATE()) - DAY(em.fechamento_parcela) > 0 AND em.data_pagamento IS NULL
		ORDER BY [Nome Completo] ASC;
		RETURN 0
	END
GO










---------------------------------------SP DIVIDA CLIENTE BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.DividaCliente]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.DividaCliente]	

GO

CREATE PROCEDURE [SP.DividaCliente]
	@id_cliente INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Apresenta o relatorio de quanto um determinado cliente deve ao banco de acordo com suas dividas e taxas
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia, Andressa, Mateus, Guilherme, Jorge
	Data ...............: 22/02/2023
	Ex .................: EXEC [SP.DividaCliente] @id_cliente = 31
	*/

	BEGIN 
		SELECT CONCAT(cl.nome,' ' ,cl.sobrenome) AS 'Nome Completo', 
		em.valor AS 'Valor Emprestimo', 
		CONCAT('Dia ',DAY(em.fechamento_parcela)) AS 'Fechamento Parcela',
		CONCAT(DAY(GETDATE()) - DAY(em.fechamento_parcela), ' Dias') AS 'Dias Atraso',
		em.valor_parcela AS 'Valor Parcela', 
		CAST(em.valor_parcela * (((DAY(GETDATE()) - DAY(em.fechamento_parcela)) * 0.059)) AS MONEY) AS 'Valor Juros', 
		CAST(em.valor_parcela + (em.valor_parcela * (((DAY(GETDATE()) - DAY(em.fechamento_parcela)) * 0.059))) AS MONEY) AS 'Valor Parcela + Juros'
		FROM emprestimo em WITH(NOLOCK)
		INNER JOIN conta ct WITH(NOLOCK)
		ON em.id_conta = ct.id
		INNER JOIN cliente cl WITH(NOLOCK)
		ON ct.id_cliente = cl.id
		WHERE cl.id = @id_cliente AND em.valor > 0 AND DAY(GETDATE()) - DAY(em.fechamento_parcela) > 0 AND em.data_pagamento IS NULL
		ORDER BY [Nome Completo] ASC;
		RETURN 0
	END
GO