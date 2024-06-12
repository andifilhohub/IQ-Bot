## 05/02 ##
CREATE SEQUENCE loja01.sq_pk_tb_cliente START 1;
CREATE TABLE loja01.tb_cliente (
  id_cliente 	INTEGER DEFAULT nextval('loja01.sq_pk_tb_cliente'),
  titulo 		CHAR(4),
  nome 			VARCHAR(32) CONSTRAINT nn_nome 		 NOT NULL,
  sobrenome 	VARCHAR(32) CONSTRAINT nn_sobrenome  NOT NULL,
  endereco		VARCHAR(62) CONSTRAINT nn_endereco 	 NOT NULL,
  numero		VARCHAR(5)  CONSTRAINT nn_numero 	 NOT NULL, 
  complemento	VARCHAR(62),
  cep			VARCHAR(10),
  cidade		VARCHAR(62) CONSTRAINT nn_cidade 	 NOT NULL,
  estado		CHAR(2)     CONSTRAINT nn_estado 	 NOT NULL,
  fone_fixo		VARCHAR(15) CONSTRAINT nn_fone_fixo  NOT NULL,
  fone_movel	VARCHAR(15) CONSTRAINT nn_fone_movel NOT NULL,
  fg_ativo 		INTEGER,
  CONSTRAINT pk_id_cliente PRIMARY KEY(id_cliente)
);


INSERT INTO loja01.tb_cliente(titulo, nome, sobrenome, endereco, numero, complemento, 
							 cep, cidade, estado, fone_fixo, fone_movel, fg_ativo) 
VALUES
('Sra', 'Jessica', 'Mendes', 'Avenida Acelino de Leao', '89', NULL, '68900 300', 'Macapá', 'AP', '3565 1243', '8765 8999' ,1),
('Sr', 'Andrei', 'Junqueira', 'Rua Tabaiares', '1024', NULL, '30150 040', 'Belo Horizonte', 'BH', '3676 1209', '8876 4543', 1),
('Sr', 'Alex', 'Matheus', 'Rua Eva Terpins', 's/n', NULL, '05327 030', 'São Paulo', 'SP', '6576 0099', '9358 7676', 1),
('Sr', 'Andre', 'Lopes', 'Rua Fortaleza', '552', NULL, '11436 360', 'Guarujá', 'SP', '5654 4343', '9821 4321', 1),
('Sr', 'Vitor', 'Silva', 'Estrada Aguá Chata', 's/n', 'Rodovia 356', '07251 000', 'Guarulhos', 'SP', '4343 6712', '831 3411', 1),
('Sr', 'Claudinei', 'Safra', 'Avenida José Osvaldo Marques', '1562', NULL, '14173 010', 'Sertãozinho', 'SP', '3698 8100', '8131 6409', 1),
('Sr', 'Ricardo', 'Ferreira', 'Alameda Assunta Barizani Tienghi', '88', NULL, '18046 705', 'Sorocaba', 'SP', '6534 7099', '9988 1251', 1);


INSERT INTO aulas.tb_cliente(id_cliente, titulo, nome, sobrenome, endereco, numero, complemento, cep, cidade, estado, fone_fixo, fone_movel, fg_ativo) 
VALUES
(8, 'Sra', 'Anna', 'Kelly', 'Rua das Acacias', '1089', NULL, '13187 042', 'Hortolândia', 'SP', '6432 440043', '9465 0023' ,1),
(9, 'Sra', 'Cristiane', 'Hickman', 'Rua Agenir Martinhon Scachetti', '300', NULL, '13341 633', 'Indaiatuba', 'SP', '3512 1243', '9987 0001' ,1),
(10, 'Sr', 'Marcos', 'Augusto', 'Avenida Australia', 's/n', NULL, '06852 100', 'Itapecerica da Serra', 'SP', '3623 8821', '8891 2333' ,1),
(11, 'Sr', 'David', 'Silva', 'Rua Arcy Prestes Ruggeri', '24', 'Esquina do Mercado', '18201 720', 'Itapetininga', 'SP', '4565 9240', '7765 4029' ,1),
(12, 'Sr', 'Ricardo', 'Cunha', 'Rua Jose Fortunato de Godoy', '889', NULL, '13976 121', 'Itapira', 'SP', '5467 1959', '9244 9584' ,1),
(13, 'Sra', 'Laura', 'Batista', 'Rua Villa Lobos', '76', NULL, '13976 018', 'Ribeirão Preto', 'SP', '2111 8710', '9991 2324' ,1),
(14, 'Sr', 'Valmil', 'Feliciano', 'Rua Professor Emilton Amaral', '961', 'Loteamento Novo Horizonte', '58053 223', 'João Pessoa', 'PB', '4431 8740', '9766 0033' ,1),
(15, 'Sr', 'Agnaldo', 'Aparecido', 'Rua Soldado Celio Tonelli', '778', NULL, '09240 320', 'Santo André', 'SP', '2386 8092', '99625 3683' ,1);

-- Aula de SELECT
SELECT NOW();
SELECT * FROM generate_series(1,5);
SELECT 10*2;
SELECT DATE(generate_series(now(),now()+'1 month','1 day'));
SELECT (random()* (3*10))::INTEGER
SELECT (random()* (2*10^3))::BIGINT;
SELECT (random()* (2*10^1))::FLOAT;
SELECT (random()* 100)::NUMERIC(4,2);

SELECT substr('abcdefghijklmnopqrstuvwxyz',1,(random()*26)::INTEGER);

SELECT * FROM loja01.tb_cliente;
SELECT COUNT(*) FROM loja01.tb_cliente;
SELECT COUNT(*) FROM loja01.tb_cliente WHERE cidade = 'Sertãozinho'; -- quantos
SELECT nome FROM loja01.tb_cliente WHERE cidade = 'Sertãozinho'; -- quem
SELECT COUNT(*) FROM loja01.tb_cliente WHERE estado = 'SP'; -- quantos
SELECT nome FROM loja01.tb_cliente WHERE estado = 'SP'; -- quem
SELECT SUM(fg_ativo) FROM loja01.tb_cliente;
SELECT COUNT(*),cidade FROM loja01.tb_cliente GROUP BY cidade ORDER BY cidade DESC;
UPDATE loja01.tb_cliente SET cidade = 'São Paulo' WHERE id_cliente = 4;
SELECT COUNT(*),cidade FROM loja01.tb_cliente GROUP BY cidade HAVING COUNT(*) > 1;
SELECT sobrenome from loja01.tb_cliente;
SELECT DISTINCT (sobrenome) from loja01.tb_cliente;
SELECT sobrenome from loja01.tb_cliente;

SELECT COUNT(DISTINCT (sobrenome)) AS sobrenomes_unicos, 
COUNT(sobrenome) AS  sobrenomes_com_duplicidade
 from loja01.tb_cliente;


 -- Aula 19/02/2024
 -- Criar a o sequence das tabelas tb_item, tb_pedido
CREATE SEQUENCE loja01.sq_pk_tb_item START 1;
CREATE SEQUENCE loja01.sq_pk_tb_pedido START 1;
CREATE SEQUENCE loja01.sq_pk_tb_estoque START 1;

 -- Criar as tabelas 
 -- Criação da tb_item
CREATE TABLE loja01.tb_item (
  id_item 	    INTEGER DEFAULT nextval('loja01.sq_pk_tb_item'),
  ds_item 	    VARCHAR(64) CONSTRAINT nn_ds_item NOT NULL,
  preco_custo 	NUMERIC(7,2),
  preco_venda 	NUMERIC(7,2),
  fg_ativo 	    INTEGER,
  CONSTRAINT pk_id_item PRIMARY KEY(id_item)
);

-- Criação da tb_pedido
CREATE TABLE loja01.tb_pedido (
  id_pedido 	INTEGER DEFAULT nextval('loja01.sq_pk_tb_pedido'),
  id_cliente 	INTEGER CONSTRAINT nn_id_cliente NOT NULL,
  dt_compra 	TIMESTAMP,
  dt_entrega 	TIMESTAMP,
  valor 	    NUMERIC(7,2),
  fg_ativo 	    INTEGER ,
  CONSTRAINT pk_id_pedido PRIMARY KEY(id_pedido),
  CONSTRAINT fk_ped_id_cliente FOREIGN KEY(id_cliente) 
             REFERENCES loja01.tb_cliente(id_cliente));

CREATE TABLE loja01.tb_item_pedido (
  id_item 	  INTEGER,
  id_pedido 	INTEGER,  
  quantidade 	INTEGER,
  CONSTRAINT pk_item_pedido PRIMARY KEY(id_item, id_pedido),
  CONSTRAINT fk_ped_id_item FOREIGN KEY(id_item) 
             REFERENCES loja01.tb_item(id_item),
  CONSTRAINT fk_ped_id_pedido FOREIGN KEY(id_pedido) 
             REFERENCES loja01.tb_pedido(id_pedido));

-- Criação da tb_codigo_barras
CREATE TABLE loja01.tb_codigo_barras (
  codigo_barras 	INTEGER CONSTRAINT nn_codigo_barras NOT NULL,
  id_item 		    INTEGER CONSTRAINT nn_id_item NOT NULL,
  CONSTRAINT fk_cod_id_item FOREIGN KEY(id_item) 
             REFERENCES loja01.tb_item(id_item)
);

-- Criação da tb_estoque
CREATE TABLE loja01.tb_estoque (
  id_item 	    INTEGER DEFAULT nextval('loja01.sq_pk_tb_estoque'),,
  quantidade 	INTEGER,
  CONSTRAINT pk_est_id_item PRIMARY KEY(id_item),
  CONSTRAINT fk_est_id_item FOREIGN KEY(id_item) 
             REFERENCES loja01.tb_item(id_item)
);

-- Inserindo os dados
-- Inserindo tuplas: tb_cliente
INSERT INTO loja01.tb_cliente(titulo, nome, sobrenome, endereco, numero, complemento, cep, cidade, estado, fone_fixo, fone_movel, fg_ativo) 
VALUES
('Sra', 'Jessica', 'Mendes', 'Avenida Acelino de Leao', '89', NULL, '68900 300', 'Macapá', 'AP', '3565 1243', '8765 8999' ,1),
('Sr', 'Andrei', 'Junqueira', 'Rua Tabaiares', '1024', NULL, '30150 040', 'Belo Horizonte', 'BH', '3676 1209', '8876 4543', 1),
('Sr', 'Alex', 'Matheus', 'Rua Eva Terpins', 's/n', NULL, '05327 030', 'São Paulo', 'SP', '6576 0099', '9358 7676', 1),
('Sr', 'Andre', 'Lopes', 'Rua Fortaleza', '552', NULL, '11436 360', 'Guarujá', 'SP', '5654 4343', '9821 4321', 1),
('Sr', 'Vitor', 'Silva', 'Estrada Aguá Chata', 's/n', 'Rodovia 356', '07251 000', 'Guarulhos', 'SP', '4343 6712', '831 3411', 1),
('Sr', 'Claudinei', 'Safra', 'Avenida José Osvaldo Marques', '1562', NULL, '14173 010', 'Sertãozinho', 'SP', '3698 8100', '8131 6409', 1),
('Sr', 'Ricardo', 'Ferreira', 'Alameda Assunta Barizani Tienghi', '88', NULL, '18046 705', 'Sorocaba', 'SP', '6534 7099', '9988 1251', 1);

INSERT INTO loja01.tb_cliente(titulo, nome, sobrenome, endereco, numero, complemento, cep, cidade, estado, fone_fixo, fone_movel, fg_ativo) 
VALUES
('Sra', 'Anna', 'Kelly', 'Rua das Acacias', '1089', NULL, '13187 042', 'Hortolândia', 'SP', '6432 440043', '9465 0023' ,1),
('Sra', 'Cristiane', 'Hickman', 'Rua Agenir Martinhon Scachetti', '300', NULL, '13341 633', 'Indaiatuba', 'SP', '3512 1243', '9987 0001' ,1),
('Sr', 'Marcos', 'Augusto', 'Avenida Australia', 's/n', NULL, '06852 100', 'Itapecerica da Serra', 'SP', '3623 8821', '8891 2333' ,1),
('Sr', 'David', 'Silva', 'Rua Arcy Prestes Ruggeri', '24', 'Esquina do Mercado', '18201 720', 'Itapetininga', 'SP', '4565 9240', '7765 4029' ,1),
('Sr', 'Ricardo', 'Cunha', 'Rua Jose Fortunato de Godoy', '889', NULL, '13976 121', 'Itapira', 'SP', '5467 1959', '9244 9584' ,1),
('Sra', 'Laura', 'Batista', 'Rua Villa Lobos', '76', NULL, '13976 018', 'Ribeirão Preto', 'SP', '2111 8710', '9991 2324' ,1),
('Sr', 'Valmil', 'Feliciano', 'Rua Professor Emilton Amaral', '961', 'Loteamento Novo Horizonte', '58053 223', 'João Pessoa', 'PB', '4431 8740', '9766 0033' ,1),
('Sr', 'Agnaldo', 'Aparecido', 'Rua Soldado Celio Tonelli', '778', NULL, '09240 320', 'Santo André', 'SP', '2386 8092', '99625 3683' ,1);


-- Inserindo tuplas: tb_item
INSERT INTO loja01.tb_item(ds_item, preco_custo, preco_venda, fg_ativo) 
VALUES
('Quebra-cabeça de Madeira', 15.23, 21.95, 1),
('Cubo X', 7.45, 11.49, 1),
('CD Linux', 1.99, 2.49, 1),
('Tecidos', 2.11, 3.99, 1),
('Moldura', 7.54, 9.95, 1),
('Ventilador Pequeno', 9.23, 15.75, 1);

INSERT INTO loja01.tb_item(ds_item, preco_custo, preco_venda, fg_ativo) 
VALUES
('Ventilador Grande', 13.36, 19.95, 1),
('Escova de Dentes', 0.75, 1.45, 1),
('Papel A4', 2.34, 2.45, 1),
('Saco de Transporte', 0.01, 0.0, 1),
('Alto-Falantes', 19.73, 25.32, 1);

-- Inserindo tuplas: tb_pedido
INSERT INTO loja01.tb_pedido(id_cliente, dt_compra, dt_entrega, valor, fg_ativo)
VALUES
(3,'03-12-2013','03-17-2013', 2.99, 1),
(8,'06-23-2013','06-24-2013', 0.00, 1),
(15,'02-09-2013','12-09-2013', 3.99, 1),
(13,'03-09-2013','10-09-2013', 2.99, 1),
(8,'07-21-2013','07-21-2013', 0.00, 1);

-- Inserindo tuplas: tb_item_pedido
INSERT INTO aulas.tb_item_pedido(id_pedido, id_item, quantidade) 
VALUES
(1, 4, 1),
(1, 7, 1),
(1, 9, 1),
(2, 1, 1),
(2, 10, 1),
(2, 7, 2),
(2, 4, 2),
(3, 2, 1),
(3, 1, 1),
(4, 5, 2),
(5, 1, 1),
(5, 3, 1);