/* Físico - Lista 02 */

-- Criação do banco de dados
CREATE SCHEMA BDFIGP715;

-- Tabela Cliente
CREATE TABLE CUSTOMER (
    CUS_CODE INT PRIMARY KEY,
    CUS_LNAME VARCHAR(30),
    CUS_FNAME VARCHAR(30),
    CUS_INITIAL CHAR(1),
    CUS_AREACODE CHAR(3),
    CUS_PHONE CHAR(8),
    CUS_BALANCE DECIMAL(10, 2)
);

-- Tabela Fatura
CREATE TABLE INVOICE (
    INV_NUMBER INT PRIMARY KEY,
    INV_DATE DATE,
    CUS_CODE INT, 
    FOREIGN KEY(CUS_CODE) REFERENCES CUSTOMER(CUS_CODE)
);

-- Tabela Linha
CREATE TABLE LINE (
    INV_NUMBER INT,
    LINE_NUMBER INT,
    LINE_PRICE DECIMAL(10, 2),
    LINE_UNITS INT,
    P_CODE CHAR(8),
    PRIMARY KEY (INV_NUMBER, LINE_NUMBER),
    FOREIGN KEY(INV_NUMBER) REFERENCES INVOICE(INV_NUMBER),
    FOREIGN KEY(P_CODE) REFERENCES PRODUCT(P_CODE)
);

-- Tabela Produto
CREATE TABLE PRODUCT (
    P_CODE CHAR(8) PRIMARY KEY,
    P_DESCRIPT VARCHAR(260),
    P_INDATE DATE,
    P_QOH INT,
    P_MIN INT,
    P_PRICE DECIMAL(10,2),
    P_DISCOUNT FLOAT,
    V_CODE INT,
    FOREIGN KEY(V_CODE) REFERENCES VENDOR(V_CODE)
);

-- Tabela Fornecedor
CREATE TABLE VENDOR (
    V_CODE INT PRIMARY KEY,
    V_NAME VARCHAR(90),
    V_CONTACT VARCHAR(60),
    V_AREACODE CHAR(3),
    V_PHONE CHAR(8),
    V_STATE CHAR(2),
    V_ORDER CHAR(1)
);


/* Inserção dos dados nas tabelas */

-- Dados de cliente
INSERT INTO CUSTOMER (CUS_CODE, CUS_LNAME, CUS_FNAME, CUS_INITIAL, CUS_AREACODE, CUS_PHONE, CUS_BALANCE) VALUES
	(10010, 'Ramas', 'Alfred', 'A', '615', '844-2573', 0.00),
	(10011, 'Dunne', 'Leona', 'K', '713', '894-1238', 0.00),
	(10012, 'Smith', 'Kathy', 'W', '615', '894-2285', 345.86),
	(10013, 'Olowski', 'Paul', 'F', '615', '894-2180', 536.75),
	(10014, 'Orlando', 'Myron', NULL, '615', '222-1672', 0.00),
	(10015, 'O''Brian', 'Amy', 'B', '713', '442-3381', 0.00),
	(10016, 'Brown', 'James', 'G', '615', '297-1228', 221.19),
	(10017, 'Williams', 'George', NULL, '615', '290-2556', 768.93),
	(10018, 'Farriss', 'Anne', 'G', '713', '382-7185', 216.55),
	(10019, 'Smith', 'Olette', 'K', '615', '297-3809', 0.00);


-- Dados de fatura
INSERT INTO INVOICE (INV_NUMBER, CUS_CODE, INV_DATE) VALUES
	(1001, 10014, '2008-03-16'),
	(1002, 10011, '2008-03-16'),
	(1003, 10012, '2008-03-16'),
	(1004, 10011, '2008-03-17'),
	(1005, 10018, '2008-03-17'),
	(1006, 10014, '2008-03-17'),
	(1007, 10015, '2008-03-17'),
	(1008, 10011, '2008-03-17');


-- Dados de Fornecedore
INSERT INTO VENDOR (V_CODE, V_NAME, V_CONTACT, V_AREACODE, V_PHONE, V_STATE, V_ORDER) VALUES
	(21225, 'Bryson, Inc.', 'Smithson', '615', '223-3234', 'TN', 'Y'),
	(21226, 'SuperLoo, Inc.', 'Flushing', '904', '215-8995', 'FL', 'N'),
	(21231, 'D&E Supply', 'Singh', '615', '228-3245', 'TN', 'Y'),
	(21344, 'Gomez Bros.', 'Ortega', '615', '889-2546', 'KY', 'N'),
	(22567, 'Dome Supply', 'Smith', '901', '678-1419', 'GA', 'N'),
	(23119, 'Randsets Ltd.', 'Anderson', '901', '678-3998', 'GA', 'Y'),
	(24004, 'Brackman Bros.', 'Browning', '615', '228-1410', 'TN', 'N'),
	(24288, 'ORDVA, Inc.', 'Hakford', '615', '898-1234', 'TN', 'Y'),
	(25443, 'B&K, Inc.', 'Smith', '904', '227-0093', 'FL', 'N'),
	(25501, 'Damal Supplies', 'Smythe', '615', '890-3529', 'TN', 'N'),
	(25595, 'Rubicon Systems', 'Orton', '904', '456-0092', 'FL', 'Y');


-- Dados de Produto
INSERT INTO PRODUCT (P_CODE, P_DESCRIPT, P_INDATE, P_QOH, P_MIN, P_PRICE, P_DISCOUNT, V_CODE) VALUES
	('11QER/31', 'Power painter, 15 psi., 3-nozzle', '2007-11-03', 8, 5, 109.99, 0.00, 25595),
	('13-Q2/P2', '7.25-in. pwr. saw blade', '2007-12-13', 32, 15, 14.99, 0.05, 21344),
	('14-Q1/L3', '9.00-in. pwr. saw blade', '2007-11-13', 18, 12, 17.49, 0.00, 21344),
	('1546-QQ2', 'Hrd. cloth, 1/4-in., 2x50', '2008-01-15', 15, 8, 39.95, 0.00, 23119),
	('1558-QW1', 'Hrd. cloth, 1/2-in., 3x50', '2008-01-15', 23, 5, 43.99, 0.00, 23119),
	('2232/QTY', 'B&D jigsaw, 12-in. blade', '2007-12-30', 8, 5, 109.92, 0.05, 24288),
	('2232/QWE', 'B&D jigsaw, 8-in. blade', '2007-12-24', 6, 5, 99.87, 0.05, 24288),
	('2238/QPD', 'B&D cordless drill, 1/2-in.', '2008-01-20', 12, 5, 38.95, 0.05, 25595),
	('23109-HB', 'Claw hammer', '2008-01-20', 23, 10, 9.95, 0.10, 21225),
	('23114-AA', 'Sledge hammer, 12 lb.', '2008-01-02', 8, 5, 14.40, 0.05, NULL),
	('54778-2T', 'Rat-tail file, 1/8-in. fine', '2007-12-15', 43, 20, 4.99, 0.00, 21344),
	('89-WRE-Q', 'Hicut chain saw, 16 in.', '2008-02-07', 11, 5, 256.99, 0.05, 24288),
	('PVC23DRT', 'PVC pipe, 3.5-in., 8-ft', '2008-02-20', 188, 75, 5.87, 0.00, NULL),
	('SM-18277', '1.25-in. metal screw, 25', '2008-03-01', 172, 75, 6.99, 0.00, 21225),
	('SW-23116', '2.5-in. wd. screw, 50', '2008-02-24', 237, 100, 8.45, 0.00, 21231),
	('WR3/TT3', 'Steel matting, 4''x8''x1/6'', .5" mesh', '2008-01-17', 18, 5, 119.95, 0.10, 25595);


-- Dados de Linhas
INSERT INTO LINE (INV_NUMBER, LINE_NUMBER, P_CODE, LINE_UNITS, LINE_PRICE) VALUES
	(1001, 1, '13-Q2/P2', 1, 14.99),
	(1001, 2, '23109-HB', 1, 9.95),
	(1002, 1, '54778-2T', 2, 4.99),
	(1003, 1, '2238/QPD', 1, 38.95),
	(1003, 2, '1546-QQ2', 1, 39.95),
	(1003, 3, '13-Q2/P2', 5, 14.99),
	(1004, 1, '54778-2T', 3, 4.99),
	(1004, 2, '23109-HB', 2, 9.95),
	(1005, 1, 'PVC23DRT', 12, 5.87),
	(1006, 1, 'SM-18277', 3, 6.99),
	(1006, 2, '2232/QTY', 1, 109.92),
	(1006, 3, '23109-HB', 1, 9.95),
	(1006, 4, '89-WRE-Q', 1, 256.99),
	(1007, 1, '13-Q2/P2', 2, 14.99),
	(1007, 2, '54778-2T', 1, 4.99),
	(1008, 1, 'PVC23DRT', 5, 5.87),
	(1008, 2, 'WR3/TT3', 3, 119.95),
	(1008, 3, '23109-HB', 1, 9.95);


/* Exercícios (Consultas) */

-- 16) Escreva uma consulta que conte o número de faturas.
SELECT COUNT(INV_NUMBER) AS 'Total de Faturas' FROM INVOICE;


-- 17) Escreva uma consulta que conte o número de clientes com saldo superior a US$ 500.
SELECT COUNT(CUS_CODE) AS 'Total de Clientes' FROM CUSTOMER WHERE CUS_BALANCE > 500;


-- 18) Gere uma listagem de todas as compras feitas por clientes, utilizando como orientação o resulta-do apresentado na Figura P7.16.
-- (Sugestão: Utilize a cláusula ORDER BY para ordenar as linhas resultantes apresentadas na Figura P7.16.)
SELECT C.CUS_CODE, I.INV_NUMBER, I.INV_DATE, P.P_DESCRIPT, L.LINE_UNITS, L.LINE_PRICE 
FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE JOIN LINE L ON I.INV_NUMBER = L.INV_NUMBER JOIN PRODUCT P ON L.P_CODE = P.P_CODE
ORDER BY C.CUS_CODE, I.INV_NUMBER;


-- 19) Utilizando como orientação o resultado apresentado na Figura P7.17, gere uma lista de compras de clientes, incluindo os subtotais de cada número de linha de fatura. 
-- (Sugestão: Modifique o formato da consulta utilizada para produzir a lista de compras de clientes do Problema 18, exclua a coluna INV_DATE e adicione o atributo 
-- derivado (computado) LINE_UNITS LINE_PRICE para calcular os subtotais.)
SELECT C.CUS_CODE, I.INV_NUMBER, P.P_DESCRIPT,  L.LINE_UNITS AS 'Units Bought', L.LINE_PRICE AS 'Unit Price', (L.LINE_UNITS * L.LINE_PRICE) AS 'Subtotal'  
FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER JOIN PRODUCT P ON L.P_CODE = P.P_CODE
ORDER BY C.CUS_CODE, I.INV_NUMBER;


-- 20) Modifique a consulta utilizada no Problema 19 para produzir o resumo apresentado na Figura P7.18.
SELECT C.CUS_CODE, C.CUS_BALANCE, SUM(L.LINE_PRICE * L.LINE_UNITS) AS 'Total Purchases'
FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER 
GROUP BY C.CUS_CODE;


-- 21) Modifique a consulta do Problema 20 de modo a incluir o número de compras individuais de produtos feitas por cliente. 
-- (Em outras palavras, se a fatura do cliente basear-se em très produtos, um por número de linha (LINE NUMBER), deve-se contar três compras de produtos.
-- Observe que, nos dados da fatura original, o cliente 10011 gerou très faturas que continham um total de seis linhas, cada uma represen tando a compra de um produto.)
-- Os valores de seus resul-tados devem coincidir com os apresentados na Figura P7.19.
SELECT C.CUS_CODE, C.CUS_BALANCE, SUM(L.LINE_PRICE * L.LINE_UNITS) AS 'Total Purchases', COUNT(L.LINE_NUMBER) AS 'Number of Purchases'
FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER
GROUP BY C.CUS_CODE;

-- 22) Utilize uma consulta para computar a quantia média de compras por produto feita por cliente.
-- (Sugestão: Utilize os resultados do Problema 21 como base desta consulta). Os valores de seus resultados devem coincidir com os apresentados na Figura P7.20.
-- Observe que a quantia média de compras é igual ao total de compras dividido pelo número de compras.
SELECT C.CUS_CODE, C.CUS_BALANCE, 
		SUM(L.LINE_PRICE * L.LINE_UNITS) AS 'Total Purchases',
		COUNT(L.LINE_NUMBER) AS 'Number of Purchases',
		ROUND(SUM(L.LINE_PRICE * L.LINE_UNITS) / COUNT(L.LINE_NUMBER), 2) AS 'Average Purchases Amount'
FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE
	JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER
GROUP BY C.CUS_CODE;


-- 23) Crie uma consulta para produzir as compras totais por fatura, gerando os resultados apresentados na Figura P7.21.
-- O total da fatura é a soma das compras de produtos em LINE que correspondem à fatura (INVOICE).
SELECT I.INV_NUMBER, 
       SUM(L.LINE_UNITS * P.P_PRICE) AS 'Invoice Total'
FROM INVOICE I  JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER
	JOIN PRODUCT P ON L.P_CODE = P.P_CODE
GROUP BY L.INV_NUMBER
ORDER BY L.INV_NUMBER;


-- 24) Utilize uma consulta para mostrar as faturas e totais de faturas conforme apresentado na Figura P7.22. (Sugestão: Agrupe por CUS_CODE.)	
SELECT C.CUS_CODE, I.INV_NUMBER,
       SUM(L.LINE_UNITS * L.LINE_PRICE) AS 'Invoice Total'
FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE
	JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER
GROUP BY C.CUS_CODE, I.INV_NUMBER;


-- 25) Escreva uma consulta que produza o número de faturas e as quantias totais de compras por cliente, utilizando como orientação o resultado da Figura P7.23.
-- (Compare esse resumo aos resultados apresentados no Problema 24.)
SELECT I.CUS_CODE, 
       COUNT(DISTINCT I.INV_NUMBER) AS 'Number of Invoices',
       SUM(L.LINE_UNITS * L.LINE_PRICE) AS 'Total Customer Purchases'
FROM INVOICE I JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER
GROUP BY I.CUS_CODE;


-- 26) Utilizando os resultados do Problema 25 como base, escreva uma consulta que gere o número total de faturas,
-- o total de todas as faturas, o menor e maior valor de fatura, e o valor medio de todas as faturas.
-- (Sugestão, Verifique o resultado da figura do Problema 25.) Seu resultado deve corresponder à Figura P7.24.
SELECT SUM(NumberInvoices) AS 'Total Invoices',
	   SUM(TotalCusPurch) AS 'Total Sale',
	   MIN(TotalCusPurch) AS 'Minimum Sale',
	   MAX(TotalCusPurch) AS 'Largest Sale',
	   ROUND(AVG(TotalCusPurch), 2) AS 'Average Sale'
FROM (
	SELECT COUNT(DISTINCT I.INV_NUMBER) AS NumberInvoices,
		   SUM(L.LINE_UNITS * L.LINE_PRICE) AS TotalCusPurch
	FROM INVOICE I JOIN LINE L ON I.INV_NUMBER  = L.INV_NUMBER
	GROUP BY I.CUS_CODE
) AS SubQuery;


-- 27) Liste as caracteristicas dos saldos dos clientes que fizeram compras durante o ciclo atual de faturas - ou seja, dos clientes que aparecem na tabela INVOICE.
-- Os resultados dessa consulta são ras apresentados na Figura P7.25.
SELECT C.CUS_CODE,
		C.CUS_BALANCE
FROM CUSTOMER C JOIN INVOICE I 
	ON C.CUS_CODE = I.CUS_CODE
GROUP BY C.CUS_CODE;


-- 28) Utilizando os resultados da consulta criada no Problema 27, forneça um resumo das caracteristi cas dos saldos de clientes, conforme a Figura P7.26.
SELECT MIN(CusBalance) AS 'Minimum Balance',
		MAX(CusBalance) AS 'Maximum Balance',
		ROUND(SUM(CusBalance) / COUNT(CusCode), 2) AS 'Average Balance'
FROM (
	SELECT C.CUS_CODE AS CusCode,
			C.CUS_BALANCE AS CusBalance
	FROM CUSTOMER C JOIN INVOICE I 
		ON C.CUS_CODE = I.CUS_CODE
	GROUP BY C.CUS_CODE
) AS SubQuery;


-- 29) Crie uma consulta que encontre as características de saldos de todos os clientes, incluindo o total de saldos a receber.
-- Os resultados dessa consulta são apresentados na Figura P7.27.
SELECT SUM(C.CUS_BALANCE) AS 'Total Balances',
		MIN(C.CUS_BALANCE) AS 'Minimum Balance',
		MAX(C.CUS_BALANCE) AS 'Maximum Balance',
		ROUND(SUM(C.CUS_BALANCE) / COUNT(C.CUS_CODE), 2) AS 'Average Balance'
FROM CUSTOMER C;


-- 30) Obtenha a listagem de clientes que não fizeram compras durante o período de faturamento.
-- Seus resultados devem coincidir com os apresentados na Figura P7.28.
SELECT C.CUS_CODE,
	C.CUS_BALANCE
FROM CUSTOMER C 
WHERE C.CUS_CODE NOT IN (SELECT I.CUS_CODE FROM INVOICE I)
GROUP BY C.CUS_CODE;


-- 31) Obtenha o resumo dos saldos de todos os clientes que não fizeram compras durante o periodo atual de faturamento.
-- Os resultados são apresentados na Figura P7.29.
SELECT SUM(CusBalance) AS 'Total Balance',
		MIN(CusBalance) AS 'Minimum Balance',
		MAX(CusBalance) AS 'Maximum Balance',
		ROUND(SUM(CusBalance) / COUNT(CusCode), 2) AS 'Average Balance'
FROM (
	SELECT C.CUS_CODE AS CusCode,
		C.CUS_BALANCE AS CusBalance
	FROM CUSTOMER C 
	WHERE C.CUS_CODE NOT IN (SELECT I.CUS_CODE FROM INVOICE I)
	GROUP BY C.CUS_CODE
) AS SubQuery;


-- 32) Crie uma consulta para produzir o resumo do valor dos produtos atualmente em estoque.
-- Observe que o valor de cada produto é obtido pela multiplicação das unidades atualmente em estoque pelo preço unitário.
-- Utilize a cláusula ORDER BY para obter a ordem apresentada na Figura P7.30.
SELECT P.P_DESCRIPT,
		P.P_QOH,
		P.P_PRICE,
		ROUND(P.P_QOH * P.P_PRICE, 2) AS 'Subtotal'
FROM PRODUCT P
ORDER BY '';


-- 33) Utilizando os resultados da consulta criada no Problema 32, obtenha o valor total do estoque de produtos. Os resultados são apresentados na Figura P7.31.
SELECT SUM(TotalValueInventure)
FROM (
	SELECT ROUND(P.P_QOH * P.P_PRICE, 2) AS TotalValueInventure
	FROM PRODUCT P
) AS SubQuery;


