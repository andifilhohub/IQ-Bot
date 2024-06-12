-- INNER JOIN
SELECT item.id_item, item.ds_item, estoque.quantidade
FROM loja01.tb_item item INNER JOIN loja01.tb_estoque estoque 
ON item.id_item = estoque.id_item;

-- Itens que nao possuem estoque -- COM FULL
SELECT item.id_item, item.ds_item, estoque.quantidade
FROM loja01.tb_item item FULL OUTER JOIN loja01.tb_estoque estoque 
ON item.id_item = estoque.id_item 
WHERE item.id_item IS NULL OR estoque.id_item IS NULL

-- Itens que nao possuem estoque -- COM LEFT
SELECT item.id_item, item.ds_item, estoque.quantidade
FROM loja01.tb_item item LEFT JOIN loja01.tb_estoque estoque 
ON item.id_item = estoque.id_item 
WHERE item.id_item IS NULL OR estoque.id_item IS NULL

-- Listar todos os clientes que realizaram algum tipo de pedido.
SELECT cliente.id_cliente, cliente.nome, pedido.id_pedido
FROM loja01.tb_cliente cliente INNER JOIN loja01.tb_pedido pedido 
ON cliente.id_cliente = pedido.id_cliente 

-- Listar a quantidade de pedidos de todos os clientes que realizaram algum tipo de pedido.
SELECT pedido.id_cliente, cliente.nome, COUNT(*) FROM loja01.tb_cliente cliente
INNER JOIN loja01.tb_pedido pedido ON pedido.id_cliente = cliente.id_cliente 
GROUP BY (pedido.id_cliente, cliente.nome)

-- Listar todos os clientes que não realizaram algum tipo de pedido.
SELECT cliente.id_cliente, cliente.nome, pedido.id_pedido
FROM loja01.tb_cliente cliente LEFT JOIN loja01.tb_pedido pedido 
ON cliente.id_cliente = pedido.id_cliente 
WHERE pedido.id_pedido IS NULL ORDER BY cliente.id_cliente 

-- mostrando todos os pedidos que um cliente realizou
SELECT cliente.id_cliente, cliente.nome,  
SUM(item.preco_venda * item_pedido.quantidade) AS Valor_Total, COUNT(pedido.id_pedido)
FROM loja01.tb_pedido pedido INNER JOIN loja01.tb_item_pedido item_pedido ON pedido.id_pedido = item_pedido.id_pedido
INNER JOIN loja01.tb_cliente cliente ON pedido.id_cliente = cliente.id_cliente 
INNER JOIN loja01.tb_item item ON item_pedido.id_item = item.id_item GROUP BY cliente.id_cliente


SELECT cliente.id_cliente, cliente.nome, COUNT(item_pedido.quantidade) FROM loja01.tb_cliente cliente
INNER JOIN loja01.tb_pedido pedido ON pedido.id_cliente = cliente.id_cliente 
INNER JOIN loja01.tb_item_pedido item_pedido ON item_pedido.id_pedido = pedido.id_pedido GROUP BY cliente.id_cliente 
ORDER BY id_cliente;
