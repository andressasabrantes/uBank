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