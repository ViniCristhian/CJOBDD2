-- Criação do Banco de Dados do CRM
CREATE DATABASE CRM_Database;
GO

USE CRM_Database;
GO

-- 1. Criação da Tabela de Contas (Empresas)
CREATE TABLE CONTAS (
    id_conta INT PRIMARY KEY IDENTITY(1, 1),
    nome_empresa VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    setor VARCHAR(50) NOT NULL,
    data_cadastro DATETIME DEFAULT GETDATE(),
);

-- 2. Criação da Tabela de Contatos
CREATE TABLE CONTATOS (
    id_contato INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    cargo VARCHAR(50),
    id_conta INT NOT NULL FOREIGN KEY REFERENCES CONTAS(id_conta)
);

-- 3. Criação da Tabela de Oportunidades
CREATE TABLE OPORTUNIDADES (
    id_oportunidade INT PRIMARY KEY IDENTITY(1,1),
    nome_negocio VARCHAR(100) NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    estagio VARCHAR(50) NOT NULL,
    data_criacao DATE NOT NULL,
    data_fechamento DATE,
    id_conta INT NOT NULL FOREIGN KEY REFERENCES CONTAS(id_conta)
);

-- 4. Criação da Tabela de Interações
CREATE TABLE INTERACOES (
    id_interacao INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(50) NOT NULL,
    data_interacao DATETIME NOT NULL,
    descricao TEXT NOT NULL,
    id_contato INT NOT NULL FOREIGN KEY REFERENCES CONTATOS(id_contato)
);

-- 5. Criação da Tabela de Tarefas
CREATE TABLE TAREFAS (
    id_tarefa INT PRIMARY KEY IDENTITY(1,1),
    titulo VARCHAR(100) NOT NULL,
    data_vencimento DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Pendente',
    id_oportunidade INT NOT NULL FOREIGN KEY REFERENCES OPORTUNIDADES(id_oportunidade)
);
GO


-- INSERÇÃO DE DADOS --

-- Inserindo Dados na Tabela Contas
INSERT INTO Contas (nome_empresa, cnpj, setor, data_cadastro) VALUES
('Tech Inovações LTDA', '12.345.678/0001-90', 'Tecnologia', '2025-01-10'),
('Global Logística S.A.', '98.765.432/0001-10', 'Logística', '2025-01-15'),
('Alfa Alimentos', '45.678.901/0001-22', 'Alimentício', '2025-02-01'),
('Beta Construções', '23.456.789/0001-33', 'Construção Civil', '2025-02-15'),
('Delta Saúde', '34.567.890/0001-44', 'Saúde', '2025-03-01');

-- Inserindo Dados na Tabela Contatos
INSERT INTO Contatos (id_conta, nome, email, telefone, cargo) VALUES
(1, 'Carlos Silva', 'carlos@techinova.com', '(11) 99999-1111', 'Diretor de TI'),
(1, 'Ana Costa', 'ana@techinova.com', '(11) 99999-2222', 'Gerente de Projetos'),
(2, 'Marcos Souza', 'marcos@globallog.com', '(21) 98888-3333', 'Diretor de Operações'),
(3, 'Patricia Lima', 'patricia@alfa.com', '(31) 97777-4444', 'Compradora Sênior'),
(4, 'Roberto Junior', 'roberto@beta.com', '(11) 96666-5555', 'Engenheiro Chefe'),
(5, 'Fernanda Mello', 'fernanda@deltasaude.com', '(19) 95555-6666', 'Diretora Médica');

-- Inserindo Dados na Tabela Oportunidades
INSERT INTO Oportunidades (id_conta, nome_negocio, valor, estagio, data_criacao, data_fechamento) VALUES
(1, 'Migração para Cloud', 150000.00, 'Fechado Ganho', '2025-01-12', '2025-02-20'),
(1, 'Licenciamento Anual BI', 45000.00, 'Proposta', '2025-05-10', NULL),
(2, 'Otimização de Roteamento ERP', 85000.00, 'Negociação', '2025-01-20', NULL),
(3, 'Expansão de Servidores', 120000.00, 'Fechado Perdido', '2025-02-05', '2025-03-10'),
(4, 'Módulo de Gestão de Obras', 65000.00, 'Qualificação', '2025-02-20', NULL),
(5, 'Suporte Técnico Premium', 30000.00, 'Fechado Ganho', '2025-03-05', '2025-04-01');

-- Inserindo Dados na Tabela Interações
INSERT INTO Interacoes (id_contato, tipo, data_interacao, descricao) VALUES
(1, 'Reunião', '2025-01-11 10:00:00', 'Alinhamento inicial escopo migração nuvem.'),
(1, 'E-mail', '2025-01-15 14:30:00', 'Envio da proposta comercial técnica.'),
(3, 'Chamada', '2025-01-22 09:15:00', 'Follow-up da proposta do módulo ERP; cliente solicitou desconto.'),
(4, 'E-mail', '2025-02-06 16:00:00', 'Envio de cotação para expansão de servidores.'),
(1, 'Chamada', '2025-05-12 11:00:00', 'Apresentação do escopo do Licenciamento de BI.');

-- Inserindo Dados na Tabela Tarefas
INSERT INTO Tarefas (id_oportunidade, titulo, data_vencimento, status) VALUES
(1, 'Configurar ambiente produtivo cloud', '2025-03-01', 'Concluída'),
(2, 'Ajustar valores da proposta comercial', '2025-05-25', 'Pendente'),
(3, 'Agendar reunião com diretoria global', '2025-02-05', 'Concluída'),
(5, 'Ligar para validar nível de satisfação', '2025-04-15', 'Concluída'),
(5, 'Revisar termos de renovação contratual', '2026-06-01', 'Pendente');
GO


-- CONSULTAS --

-- Consulta 1
SELECT c.nome_empresa, o.nome_negocio, o.valor
FROM OPORTUNIDADES o
JOIN CONTAS c ON o.id_conta = c.id_conta
WHERE o.valor > (SELECT AVG(valor) FROM OPORTUNIDADES);

-- Consulta 2
SELECT c.setor, COUNT(o.id_oportunidade) AS total_oportunidades, SUM(o.valor) AS valor_total
FROM CONTAS c
LEFT JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta
GROUP BY c.setor
ORDER BY valor_total DESC;

-- Consultas 3
SELECT c.nome_empresa, COUNT(co.id_contato) AS total_contatos
FROM CONTAS c
JOIN CONTATOS co ON c.id_conta = co.id_conta
GROUP BY c.nome_empresa
HAVING COUNT(co.id_contato) > 1;

-- Cosulta 4
SELECT nome_negocio, valor, estagio,
       RANK() OVER (ORDER BY valor DESC) AS ranking_valor
FROM OPORTUNIDADES;

-- Consulta 5
SELECT estagio, AVG(DATEDIFF(day, data_criacao, data_fechamento)) AS media_dias_fechamento
FROM OPORTUNIDADES
WHERE data_fechamento IS NOT NULL
GROUP BY estagio;

-- Consulta 6
SELECT c.nome, i.tipo, i.data_interacao, CAST(i.descricao AS VARCHAR(100)) AS resumo
FROM CONTATOS c
JOIN INTERACOES i ON c.id_contato = i.id_contato
WHERE i.tipo = 'Reunião';

-- Consulta 7 
SELECT c.nome_empresa, c.setor
FROM CONTAS c
LEFT JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta
WHERE o.id_oportunidade IS NULL;

-- Consulta 8
SELECT t.titulo, t.data_vencimento, o.nome_negocio
FROM TAREFAS t
JOIN OPORTUNIDADES o ON t.id_oportunidade = o.id_oportunidade
WHERE t.status = 'Pendente' AND t.data_vencimento < GETDATE();

-- Consulta 9
SELECT nome_negocio, valor,
       ROUND((valor / SUM(valor) OVER()) * 100, 2) AS 'percentual do total'
FROM OPORTUNIDADES o;

-- Consulta 10
SELECT nome, email, cargo 
FROM CONTATOS c
WHERE cargo LIKE 'Diretor%' OR cargo LIKE 'Diretora%';

-- Consulta 11
SELECT c.nome_empresa, MAX(o.valor) AS valor_maximo, MIN(o.valor) AS valor_minimo, AVG(o.valor) AS valor_medio
FROM CONTAS c
JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta
GROUP BY c.nome_empresa;

-- Consulta 12
SELECT ct.nome_empresa, co.nome AS nome_contato, i.tipo, i.data_interacao
FROM INTERACOES i
JOIN CONTATOS co ON i.id_contato = co.id_contato
JOIN CONTAS ct ON co.id_conta = ct.id_conta;

-- Consulta 13
SELECT DISTINCT tipo 
FROM INTERACOES i
WHERE data_interacao BETWEEN '2025-01-01' AND '2025-01-31 23:59:59';

-- Consulta 14
SELECT nome_negocio, valor,
       CASE 
            WHEN valor >= 100000.00 THEN 'Strategic Account (Enterprise)'
            WHEN valor >= 50000.00 THEN 'Mid-Market Account'
            ELSE 'SMB Account'
       END AS classificacao_conta
FROM OPORTUNIDADES;

-- Consulta 15
SELECT o.estagio, COUNT(t.id_tarefa) AS total_tarefas
FROM OPORTUNIDADES o
LEFT JOIN TAREFAS t ON o.id_oportunidade = t.id_oportunidade
GROUP BY o.estagio;

-- Consuulta 16
SELECT nome_empresa, data_cadastro 
FROM CONTAS
WHERE DATEPART(quarter, data_cadastro) = 1 AND YEAR(data_cadastro) = 2025;

-- Consulta 17
SELECT c.nome_empresa, c.cnpj
FROM CONTAS c
WHERE EXISTS (
    SELECT 1 FROM OPORTUNIDADES o 
    WHERE o.id_conta = c.id_conta AND o.estagio = 'Fechado Ganho'
);

-- Consulta 18
SELECT c.nome, c.email, i.data_interacao
FROM CONTATOS c
JOIN INTERACOES i ON c.id_contato = i.id_contato
WHERE i.data_interacao = (SELECT MAX(data_interacao) FROM INTERACOES);

-- Consulta 19
SELECT c.nome_empresa, 
       CONCAT('R$ ', CONVERT(VARCHAR, SUM(o.valor), 1)) AS pipeline_financeiro
FROM CONTAS c
JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta
GROUP BY c.nome_empresa;

-- Consulta 20
SELECT nome_negocio, valor, estagio 
FROM OPORTUNIDADES
WHERE valor BETWEEN 50000.00 AND 100000.00;

-- Consulta 21
SELECT titulo, data_vencimento, status 
FROM TAREFAS
ORDER BY data_vencimento ASC;

-- Consulta 22
SELECT DATENAME(weekday, data_interacao) AS dia_da_semana,
		COUNT(id_interacao) AS volume_atendimentos
FROM INTERACOES
GROUP BY DATENAME(weekday, data_interacao), DATEPART(weekday, data_interacao)
ORDER BY DATEPART(weekday, data_interacao);

-- Consulta 23
SELECT DISTINCT c.setor,
       MAX(o.valor) OVER(PARTITION BY c.setor) AS teto_setorial
FROM CONTAS c
JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta;

-- Consulta 24
SELECT nome_negocio, valor,
       LEAD(valor, 1) OVER (ORDER BY valor DESC) AS proximo_valor_abaixo
FROM OPORTUNIDADES;

-- Consulta 25
SELECT DISTINCT SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS dominio_corporativo
FROM Contatos;

-- Consulta 26
SELECT c.nome_empresa, COUNT(o.id_oportunidade) AS vendas_ganhas
FROM CONTAS c
JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta
WHERE o.estagio = 'Fechado Ganho'
GROUP BY c.nome_empresa;

-- Consulta 27
SELECT id_oportunidade, nome_negocio, data_criacao, valor,
       SUM(valor) OVER(ORDER BY data_criacao) AS saldo_acumulado_pipeline
FROM OPORTUNIDADES;

-- Consulta 28
SELECT co.nome, co.cargo, c.setor
FROM CONTATOS co
JOIN CONTAS c ON co.id_conta = c.id_conta
WHERE c.setor <> 'Tecnologia';

-- Consultas 29
SELECT o1.id_conta, o1.nome_negocio, o1.valor
FROM OPORTUNIDADES o1
WHERE o1.valor = (
    SELECT MAX(o2.valor) 
    FROM OPORTUNIDADES o2 
    WHERE o2.id_conta = o1.id_conta
);

-- Consulta 30
SELECT c.setor, SUM(o.valor) AS faturamento_real
FROM CONTAS c
JOIN OPORTUNIDADES o ON c.id_conta = o.id_conta
WHERE o.estagio = 'Fechado Ganho'
GROUP BY c.setor
HAVING SUM(o.valor) > 50000.00;


