-- criando views
-- mostrando todos os pedidos que um cliente realizou
CREATE OR REPLACE VIEW loja01.situacao_cliente AS 
SELECT pedido.id_pedido, pedido.id_cliente, (SELECT nome FROM loja01.tb_cliente cliente WHERE cliente.id_cliente = pedido.id_cliente), 
(SELECT SUM(item_pedido.quantidade * item.preco_venda) AS "Total Pedido"
FROM loja01.tb_item_pedido item_pedido, loja01.tb_item item WHERE item_pedido.id_item = item.id_item 
AND pedido.id_pedido = item_pedido.id_pedido GROUP BY item_pedido.id_pedido 
ORDER BY item_pedido.id_pedido) FROM loja01.tb_pedido pedido;

SELECT * FROM loja01.situacao_cliente;
SELECT nome, "Total Pedido" FROM loja01.situacao_cliente;

CREATE OR REPLACE VIEW loja01.situacao_cliente_join AS 
SELECT pedido.id_pedido, cliente.id_cliente, cliente.nome, item_pedido.id_item, 
item.ds_item, item_pedido.quantidade, 
item.preco_venda * item_pedido.quantidade AS Valor_Total
FROM loja01.tb_pedido pedido INNER JOIN loja01.tb_item_pedido item_pedido 
ON pedido.id_pedido = item_pedido.id_pedido
INNER JOIN loja01.tb_cliente cliente ON pedido.id_cliente = cliente.id_cliente 
INNER JOIN loja01.tb_item item ON item_pedido.id_item = item.id_item 

-- criando tabelas apartir de outras(copia)

CREATE TABLE loja01.tb_cliente_filial (LIKE loja01.tb_cliente);
--caso haja algum campo para acresentar
--CREATE TABLE loja01.tb_cliente_filial (novo campo), (LIKE loja01.tb_cliente);

-- tabela temporaria
CREATE TEMP TABLE tb_teste(
	chave1 int,
	chave2 int);

CREATE TABLE loja01.tb_cidades(
	nome VARCHAR(50),
	populacao FLOAT,
	altitude INT);

CREATE TABLE loja01.tb_cidades_estado (
	UF VARCHAR(2),
	LIKE loja01.tb_cidades
)

DROP TABLE loja01.tb_cidades;
CREATE TABLE loja01.tb_cidades_estados_inh(
uf CHAR(2)
)INHERITS (loja01.tb_cidades);

ALTER TABLE loja01.tb_cidades ADD COLUMN longitude NUMERIC(10,2); 

SELECT * FROM loja01.tb_cidades;
SELECT * FROM loja01.tb_cidades_estados_inh
SELECT * FROM loja01.tb_cidades_estado;

CREATE TEMP TABLE tb_audidoria_cliente AS 
SELECT * FROM loja01.tb_cliente;

SELECT * FROM tb_audidoria_cliente;

CREATE TEMP TABLE tb_auditoria_vendas_cliente AS 
SELECT pedido.id_pedido, cliente.id_cliente, cliente.nome, item_pedido.id_item, 
item.ds_item, item_pedido.quantidade, 
item.preco_venda * item_pedido.quantidade AS Valor_Total
FROM loja01.tb_pedido pedido INNER JOIN loja01.tb_item_pedido item_pedido 
ON pedido.id_pedido = item_pedido.id_pedido
INNER JOIN loja01.tb_cliente cliente ON pedido.id_cliente = cliente.id_cliente 
INNER JOIN loja01.tb_item item ON item_pedido.id_item = item.id_item 

SELECT * FROM tb_auditoria_vendas_cliente
